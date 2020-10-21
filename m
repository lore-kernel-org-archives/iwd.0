Content-Type: multipart/mixed; boundary="===============0567263035508915015=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] ap: add support for DHCPv4 server
Date: Wed, 21 Oct 2020 11:44:26 -0700
Message-ID: <20201021184427.1730146-2-prestwoj@gmail.com>
In-Reply-To: <20201021184427.1730146-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0567263035508915015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DHCP server can be enabled by enabling network configuration
with [General].EnableNetworkConfiguration. For now, the default
DHCP settings will be used. The only requirement is that the
AP network interface must have an IP set prior to calling Start().
---
 src/ap.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 3c4ae907..132cc44c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -74,6 +74,8 @@ struct ap_state {
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

+	struct l_dhcp_server *server;
+
 	bool started : 1;
 	bool gtk_set : 1;
 };
@@ -192,6 +194,9 @@ static void ap_reset(struct ap_state *ap)
 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
 =

 	ap->started =3D false;
+
+	if (ap->server)
+		l_dhcp_server_stop(ap->server);
 }
 =

 static void ap_del_station(struct sta_state *sta, uint16_t reason,
@@ -1900,6 +1905,49 @@ static void ap_deauth_cb(const struct mmpdu_header *=
hdr, const void *body,
 	ap_sta_free(sta);
 }
 =

+static void do_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	l_info("%s%s", prefix, str);
+}
+
+static bool ap_start_dhcp(struct ap_state *ap)
+{
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	const struct l_settings *settings =3D iwd_get_config();
+	bool enabled =3D false;
+
+	/*
+	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
+	 * DHCP server. If no value is found or it is false do not create a
+	 * DHCP server.
+	 */
+	if (!l_settings_get_bool(settings, "General",
+					"EnableNetworkConfiguration", &enabled))
+		return true;
+
+	if (!enabled)
+		return true;
+
+	ap->server =3D l_dhcp_server_new(ifindex);
+	if (!ap->server) {
+		l_error("Failed to create DHCP server on %u", ifindex);
+		return false;
+	}
+
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(ap->server, do_debug,
+							"[DHCPv4 SERV] ", NULL);
+
+	/*
+	 * TODO: Add support for provisioning files where user could configure
+	 * specific DHCP sever settings.
+	 */
+
+	return l_dhcp_server_start(ap->server);
+}
+
 static void ap_start_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
@@ -1909,16 +1957,24 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
d *user_data)
 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
 =

-		ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
-					ap->user_data);
-		ap_reset(ap);
-		l_genl_family_free(ap->nl80211);
-		l_free(ap);
-		return;
+		goto failed;
+	}
+
+	if (!ap_start_dhcp(ap)) {
+		l_error("DHCP server failed to start");
+		goto failed;
 	}
 =

 	ap->started =3D true;
 	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
+
+	return;
+
+failed:
+	ap->ops->handle_event(AP_EVENT_START_FAILED, NULL, ap->user_data);
+	ap_reset(ap);
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -2255,6 +2311,8 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
+	if (ap->server)
+		l_dhcp_server_destroy(ap->server);
 	l_free(ap);
 }
 =

-- =

2.26.2

--===============0567263035508915015==--

