Content-Type: multipart/mixed; boundary="===============6404483354430427191=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] dpp: speed up connection after being configured
Date: Thu, 06 Jan 2022 15:02:05 -0800
Message-ID: <20220106230205.571804-2-prestwoj@gmail.com>
In-Reply-To: 20220106230205.571804-1-prestwoj@gmail.com

--===============6404483354430427191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the enrollee relied on autoconnect to handle connecting
to the newly configured network. This usually resulted in poor
performance since periodic scans are done at large intervals apart.

Instead first check if the newly configured network is already
in IWD's network queue. If so it can be connected to immediately.
If not, a full scan must be done and results given to station.
---
 src/dpp.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 12 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index dedbd3b2..54947193 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -114,6 +114,7 @@ struct dpp_sm {
 	struct l_timeout *timeout;
 =

 	struct dpp_configuration *config;
+	uint32_t connect_scan_id;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -161,6 +162,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->config =3D NULL;
 	}
 =

+	if (dpp->connect_scan_id) {
+		scan_cancel(dpp->wdev_id, dpp->connect_scan_id);
+		dpp->connect_scan_id =3D 0;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 =

 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
@@ -389,11 +395,14 @@ static void send_config_result(struct dpp_sm *dpp, co=
nst uint8_t *to)
 	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
 }
 =

-static void dpp_write_config(struct dpp_configuration *config)
+static void dpp_write_config(struct dpp_configuration *config,
+				struct network *network)
 {
 	_auto_(l_free) char *ssid =3D l_malloc(config->ssid_len + 1);
 	_auto_(l_settings_free) struct l_settings *settings =3D l_settings_new();
 	_auto_(l_free) char *path;
+	_auto_(l_free) uint8_t *psk =3D NULL;
+	size_t psk_len;
 =

 	memcpy(ssid, config->ssid, config->ssid_len);
 	ssid[config->ssid_len] =3D '\0';
@@ -405,18 +414,57 @@ static void dpp_write_config(struct dpp_configuration=
 *config)
 		l_settings_remove_group(settings, "Security");
 	}
 =

-	if (config->passphrase)
+	if (config->passphrase) {
 		l_settings_set_string(settings, "Security", "Passphrase",
 				config->passphrase);
-	else if (config->psk)
+		if (network)
+			network_set_passphrase(network, config->passphrase);
+
+	} else if (config->psk) {
 		l_settings_set_string(settings, "Security", "PreSharedKey",
 				config->psk);
 =

+		psk =3D l_util_from_hexstring(config->psk, &psk_len);
+
+		if (network)
+			network_set_psk(network, psk);
+	}
+
 	l_debug("Storing credential for '%s(%s)'", ssid,
 						security_to_str(SECURITY_PSK));
 	storage_network_sync(SECURITY_PSK, ssid, settings);
 }
 =

+static void dpp_scan_triggered(int err, void *user_data)
+{
+	/* Not much can be done in this case */
+	if (err < 0)
+		l_error("Failed to trigger DPP scan");
+}
+
+static bool dpp_scan_results(int err, struct l_queue *bss_list,
+				const struct scan_freq_set *freqs,
+				void *userdata)
+{
+	struct dpp_sm *dpp =3D userdata;
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
+
+	if (err < 0)
+		return false;
+
+	station_set_scan_results(station, bss_list, freqs, true);
+
+	return true;
+}
+
+static void dpp_scan_destroy(void *userdata)
+{
+	struct dpp_sm *dpp =3D userdata;
+
+	dpp->connect_scan_id =3D 0;
+	dpp_reset(dpp);
+}
+
 static void dpp_handle_config_response_frame(const struct mmpdu_header *fr=
ame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -441,6 +489,10 @@ static void dpp_handle_config_response_frame(const str=
uct mmpdu_header *frame,
 	size_t wrapped_len =3D 0;
 	_auto_(l_free) uint8_t *unwrapped =3D NULL;
 	struct dpp_configuration *config;
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
+	struct network *network;
+	struct scan_bss *bss =3D NULL;
+	_auto_(l_free) char *ssid =3D NULL;
 =

 	if (dpp->state !=3D DPP_STATE_CONFIGURING)
 		return;
@@ -564,19 +616,33 @@ static void dpp_handle_config_response_frame(const st=
ruct mmpdu_header *frame,
 		return;
 	}
 =

-	dpp_write_config(config);
-	/*
-	 * TODO: Depending on the info included in the configuration object a
-	 * limited scan could be issued to get autoconnect to trigger faster.
-	 * In addition this network may already be in past scan results and
-	 * could be joined immediately.
-	 *
-	 * For now just wait for autoconnect.
-	 */
+	ssid =3D l_malloc(config->ssid_len + 1);
+	memcpy(ssid, config->ssid, config->ssid_len);
+	ssid[config->ssid_len] =3D '\0';
+
+	network =3D station_network_find(station, ssid, SECURITY_PSK);
+	if (network)
+		bss =3D network_bss_select(network, true);
+
+	dpp_write_config(config, network);
+
+	if (network && bss)
+		__station_connect_network(station, network, bss);
+	else {
+		dpp->connect_scan_id =3D scan_active(dpp->wdev_id, NULL, 0,
+						dpp_scan_triggered,
+						dpp_scan_results, dpp,
+						dpp_scan_destroy);
+		if (!dpp->connect_scan_id)
+			goto scan_failed;
+	}
 =

 	dpp_configuration_free(config);
 =

 	send_config_result(dpp, dpp->auth_addr);
+
+scan_failed:
+	dpp_reset(dpp);
 }
 =

 static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
-- =

2.31.1

--===============6404483354430427191==--

