Content-Type: multipart/mixed; boundary="===============1245710581028186667=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 04/13] scan: change ssid scan parameter to a list
Date: Wed, 15 Sep 2021 10:36:15 -0700
Message-ID: <20210915173624.11917-4-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============1245710581028186667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ssid parameter was used for direct probe responses for finding
hidden networks. OWE transition will be added which requires a
hidden OWE network. IWD will need to automatically hidden scan for
one or multiple of these networks and doing so in separate scans
would be hard to manage.

To prep for this the ssid scan parameter is being changed to a string
list which can contain many SSIDs to probe for.
---
 src/p2p.c     |  7 +++++--
 src/scan.c    | 12 ++++++++----
 src/scan.h    |  2 +-
 src/station.c | 11 ++++++++---
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 3328271b..dd78e044 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1977,10 +1977,11 @@ static void p2p_provision_scan_start(struct p2p_dev=
ice *dev)
 {
 	struct scan_parameters params =3D {};
 	uint8_t buf[256];
+	const char *ssids[2] =3D { dev->go_group_id.ssid, NULL };
 =

 	params.flush =3D true;
 	params.no_cck_rates =3D true;
-	params.ssid =3D dev->go_group_id.ssid;
+	params.ssids =3D ssids;
 	params.extra_ie =3D p2p_build_scan_ies(dev, buf, sizeof(buf),
 						&params.extra_ie_size);
 	L_WARN_ON(!params.extra_ie);
@@ -3773,6 +3774,7 @@ static bool p2p_device_scan_start(struct p2p_device *=
dev)
 	struct scan_parameters params =3D {};
 	uint8_t buf[256];
 	unsigned int i;
+	const char *ssids[2] =3D { 0 };
 =

 	wiphy_get_reg_domain_country(dev->wiphy, (char *) dev->listen_country);
 	dev->listen_country[2] =3D 4;	/* Table E-4 */
@@ -3783,7 +3785,8 @@ static bool p2p_device_scan_start(struct p2p_device *=
dev)
 	L_WARN_ON(!params.extra_ie);
 	params.flush =3D true;
 	/* P2P Wildcard SSID because we don't need legacy networks to reply */
-	params.ssid =3D "DIRECT-";
+	ssids[0] =3D "DIRECT-";
+	params.ssids =3D ssids;
 	/*
 	 * Must send probe requests at 6Mb/s, OFDM only.  The no-CCK rates
 	 * flag forces the drivers to do exactly this for 2.4GHz frames.
diff --git a/src/scan.c b/src/scan.c
index 5e31c308..e74874be 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -539,10 +539,14 @@ static void scan_cmds_add(struct l_queue *cmds, struc=
t scan_context *sc,
 =

 	l_genl_msg_enter_nested(cmd, NL80211_ATTR_SCAN_SSIDS);
 =

-	if (params->ssid) {
-		/* direct probe request scan */
-		l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID,
-					strlen(params->ssid), params->ssid);
+	/* direct probe request scan */
+	if (params->ssids) {
+		unsigned int i;
+
+		for (i =3D 0; i < l_strv_length((char **)params->ssids); i++)
+			l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID,
+						strlen(params->ssids[i]),
+						params->ssids[i]);
 		l_genl_msg_leave_nested(cmd);
 =

 		l_queue_push_tail(cmds, cmd);
diff --git a/src/scan.h b/src/scan.h
index 23de472b..dc14d3e0 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -99,7 +99,7 @@ struct scan_parameters {
 	bool randomize_mac_addr_hint : 1;
 	bool no_cck_rates : 1;
 	bool duration_mandatory : 1;
-	const char *ssid;	/* Used for direct probe request */
+	const char **ssids;	/* Used for direct probe requests */
 	const uint8_t *source_mac;
 };
 =

diff --git a/src/station.c b/src/station.c
index ac741f5a..a6140766 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2006,12 +2006,15 @@ static int station_roam_scan(struct station *statio=
n,
 				struct scan_freq_set *freq_set)
 {
 	struct scan_parameters params =3D { .freqs =3D freq_set, .flush =3D true =
};
+	const char *ssids[2] =3D { 0 };
 =

 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 =

-	if (station->connected_network)
+	if (station->connected_network) {
 		/* Use direct probe request */
-		params.ssid =3D network_get_ssid(station->connected_network);
+		ssids[0] =3D network_get_ssid(station->connected_network);
+		params.ssids =3D ssids;
+	}
 =

 	if (!freq_set)
 		station->roam_scan_full =3D true;
@@ -2870,6 +2873,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 		.randomize_mac_addr_hint =3D false,
 	};
 	const char *ssid;
+	const char *ssids[2] =3D { 0 };
 	struct network *network;
 =

 	l_debug("");
@@ -2916,7 +2920,8 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 		return dbus_error_not_hidden(message);
 	}
 =

-	params.ssid =3D ssid;
+	ssids[0] =3D ssid;
+	params.ssids =3D ssids;
 =

 	/* HW cannot randomize our MAC if connected */
 	if (!station->connected_bss)
-- =

2.31.1

--===============1245710581028186667==--

