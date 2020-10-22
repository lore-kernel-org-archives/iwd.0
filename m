Content-Type: multipart/mixed; boundary="===============8158711024118476521=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] ap: add support for DHCPv4 server
Date: Thu, 22 Oct 2020 09:38:56 -0700
Message-ID: <20201022163857.1836746-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8158711024118476521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DHCP server can be enabled by enabling network configuration
with [General].EnableNetworkConfiguration. For now, the default
DHCP settings will be used. If no address is set on the interface
a default IP and broadcast address will be used.
---
 src/ap.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 7 deletions(-)

v3:
 * Added support to set a default IP/broadcast address if one isn't
   already set on the interface.

diff --git a/src/ap.c b/src/ap.c
index 3c4ae907..866cbe58 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -26,6 +26,7 @@
 =

 #include <errno.h>
 #include <linux/if_ether.h>
+#include <netinet/in.h>
 =

 #include <ell/ell.h>
 =

@@ -74,6 +75,9 @@ struct ap_state {
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

+	struct l_dhcp_server *server;
+	uint32_t rtnl_add_cmd;
+
 	bool started : 1;
 	bool gtk_set : 1;
 };
@@ -105,6 +109,7 @@ struct ap_wsc_pbc_probe_record {
 };
 =

 static uint32_t netdev_watch;
+struct l_netlink *rtnl;
 =

 void ap_config_free(struct ap_config *config)
 {
@@ -181,6 +186,9 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->start_stop_cmd_id)
 		l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
 =

+	if (ap->rtnl_add_cmd)
+		l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
+
 	l_queue_destroy(ap->sta_states, ap_sta_free);
 =

 	if (ap->rates)
@@ -192,6 +200,9 @@ static void ap_reset(struct ap_state *ap)
 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
 =

 	ap->started =3D false;
+
+	if (ap->server)
+		l_dhcp_server_stop(ap->server);
 }
 =

 static void ap_del_station(struct sta_state *sta, uint16_t reason,
@@ -1900,25 +1911,116 @@ static void ap_deauth_cb(const struct mmpdu_header=
 *hdr, const void *body,
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
+static void ap_start_failed(struct ap_state *ap)
+{
+	ap->ops->handle_event(AP_EVENT_START_FAILED, NULL, ap->user_data);
+	ap_reset(ap);
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
+}
+
+static void ap_finish_setup(struct ap_state *ap, bool dhcp)
+{
+	if (dhcp && !l_dhcp_server_start(ap->server)) {
+		l_error("DHCP server failed to start");
+
+		ap_start_failed(ap);
+		return;
+	}
+
+	ap->started =3D true;
+	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
+}
+
+static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *data,
+				uint32_t len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	if (error) {
+		l_error("Failed to set IP address");
+		ap_start_failed(ap);
+		return;
+	}
+
+	ap_finish_setup(ap, true);
+}
+
 static void ap_start_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	const struct l_settings *settings =3D iwd_get_config();
+	bool enabled =3D false;
+	struct in_addr ia;
 =

 	ap->start_stop_cmd_id =3D 0;
 =

 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
 =

-		ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
-					ap->user_data);
-		ap_reset(ap);
-		l_genl_family_free(ap->nl80211);
-		l_free(ap);
+		goto failed;
+	}
+
+	/*
+	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
+	 * DHCP server. If no value is found or it is false do not create a
+	 * DHCP server.
+	 */
+	if (!l_settings_get_bool(settings, "General",
+					"EnableNetworkConfiguration", &enabled))
+		goto done;
+
+	if (!enabled)
+		goto done;
+
+	ap->server =3D l_dhcp_server_new(ifindex);
+	if (!ap->server) {
+		l_error("Failed to create DHCP server on %u", ifindex);
+		goto failed;
+	}
+
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(ap->server, do_debug,
+							"[DHCPv4 SERV] ", NULL);
+
+	if (!l_net_get_address(ifindex, &ia) || ia.s_addr =3D=3D 0) {
+		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex, 24,
+					"192.168.1.1", "255.255.255.0",
+					ap_ifaddr4_added_cb, ap, NULL);
+
+		if (!ap->rtnl_add_cmd) {
+			l_error("Failed to add IPv4 address");
+			goto failed;
+		}
+
+		/* Finish starting AP in added callback */
 		return;
 	}
 =

-	ap->started =3D true;
-	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
+	/*
+	 * TODO: Add support for provisioning files where user could configure
+	 * specific DHCP sever settings.
+	 */
+
+	if (!l_dhcp_server_start(ap->server)) {
+		l_error("DHCP server failed to start");
+		goto failed;
+	}
+
+done:
+	ap_finish_setup(ap, enabled);
+	return;
+
+failed:
+	ap_start_failed(ap);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -2255,6 +2357,8 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
+	if (ap->server)
+		l_dhcp_server_destroy(ap->server);
 	l_free(ap);
 }
 =

@@ -2535,6 +2639,8 @@ static int ap_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_AP_INTERFACE,
 			ap_setup_interface, ap_destroy_interface, false);
 =

+	rtnl =3D iwd_get_rtnl();
+
 	return 0;
 }
 =

-- =

2.26.2

--===============8158711024118476521==--

