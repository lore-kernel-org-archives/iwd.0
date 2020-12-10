Content-Type: multipart/mixed; boundary="===============0796739237743399531=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] netconfig: add ACD client for static configuration
Date: Thu, 10 Dec 2020 13:22:09 -0800
Message-ID: <20201210212210.880245-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0796739237743399531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the IP is configured to be static we can now use ACD in
order to check that the IP is available and not already in
use. If a conflict is found netconfig will be reset and no IP
will be set on the interface. The ACD client is left with
the default 'defend once' policy, and probes are not turned
off. This will increase connection time, but for static IP's
it is the best approach.
---
 src/netconfig.c | 94 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 18 deletions(-)

v2:
 * Added netconfig_reset_v4 to allow a failed ACD attempt to =

   reset only the IPv4 data.
 * Distinguish between CONFLICT/LOST events. For conflicts
   no IP was ever set in the kernel, so we can just clean up
   the rtnl address directly. For LOST events an address was
   set, so it would need to be deleted.

diff --git a/src/netconfig.c b/src/netconfig.c
index f48a789a..e7a6a402 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -64,6 +64,8 @@ struct netconfig {
 	void *user_data;
 =

 	struct resolve *resolve;
+
+	struct l_acd *acd;
 };
 =

 static struct l_netlink *rtnl;
@@ -804,15 +806,87 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 	}
 }
 =

+static void netconfig_reset_v4(struct netconfig *netconfig)
+{
+	if (netconfig->rtm_protocol) {
+		if (netconfig->v4_address) {
+			L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl,
+						netconfig->ifindex,
+						netconfig->v4_address,
+						netconfig_ifaddr_del_cmd_cb,
+						netconfig, NULL));
+			l_rtnl_address_free(netconfig->v4_address);
+			netconfig->v4_address =3D NULL;
+		}
+
+		l_strfreev(netconfig->dns4_overrides);
+		netconfig->dns4_overrides =3D NULL;
+
+		l_dhcp_client_stop(netconfig->dhcp_client);
+		netconfig->rtm_protocol =3D 0;
+	}
+}
+
+static void netconfig_ipv4_acd_event(enum l_acd_event event, void *user_da=
ta)
+{
+	struct netconfig *netconfig =3D user_data;
+
+	switch (event) {
+	case L_ACD_EVENT_AVAILABLE:
+		L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+					netconfig->v4_address,
+					netconfig_ipv4_ifaddr_add_cmd_cb,
+					netconfig, NULL));
+		return;
+	case L_ACD_EVENT_CONFLICT:
+		/*
+		 * Conflict found, no IP was actually set so just free/unset
+		 * anything we set prior to starting ACD.
+		 */
+		l_error("netconfig: statically configured address conflict!");
+		l_rtnl_address_free(netconfig->v4_address);
+		netconfig->v4_address =3D NULL;
+		netconfig->rtm_protocol =3D 0;
+		break;
+	case L_ACD_EVENT_LOST:
+		/*
+		 * Set IP but lost it some time after. Full (IPv4) reset in this
+		 * case.
+		 */
+		l_error("netconfig: statically configured address was lost");
+		netconfig_reset_v4(netconfig);
+		break;
+	}
+}
+
 static void netconfig_ipv4_select_and_install(struct netconfig *netconfig)
 {
 	netconfig->v4_address =3D netconfig_get_static4_address(netconfig);
 	if (netconfig->v4_address) {
+		char ip[INET6_ADDRSTRLEN];
+
 		netconfig->rtm_protocol =3D RTPROT_STATIC;
-		L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
+		netconfig->acd =3D l_acd_new(netconfig->ifindex);
+		l_acd_set_event_handler(netconfig->acd,
+					netconfig_ipv4_acd_event, netconfig,
+					NULL);
+		if (getenv("IWD_ACD_DEBUG"))
+			l_acd_set_debug(netconfig->acd, do_debug,
+					"[ACD] ", NULL);
+
+		l_rtnl_address_get_address(netconfig->v4_address, ip);
+
+		if (!l_acd_start(netconfig->acd, ip)) {
+			l_error("failed to start ACD, continuing anyways");
+			l_acd_destroy(netconfig->acd);
+			netconfig->acd =3D NULL;
+
+			L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
 					netconfig->v4_address,
 					netconfig_ipv4_ifaddr_add_cmd_cb,
 					netconfig, NULL));
+		}
+
 		return;
 	}
 =

@@ -955,23 +1029,7 @@ bool netconfig_reset(struct netconfig *netconfig)
 	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol)
 		resolve_revert(netconfig->resolve);
 =

-	if (netconfig->rtm_protocol) {
-		if (netconfig->v4_address) {
-			L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl,
-						netconfig->ifindex,
-						netconfig->v4_address,
-						netconfig_ifaddr_del_cmd_cb,
-						netconfig, NULL));
-			l_rtnl_address_free(netconfig->v4_address);
-			netconfig->v4_address =3D NULL;
-		}
-
-		l_strfreev(netconfig->dns4_overrides);
-		netconfig->dns4_overrides =3D NULL;
-
-		l_dhcp_client_stop(netconfig->dhcp_client);
-		netconfig->rtm_protocol =3D 0;
-	}
+	netconfig_reset_v4(netconfig);
 =

 	if (netconfig->rtm_v6_protocol) {
 		l_strfreev(netconfig->dns6_overrides);
-- =

2.26.2

--===============0796739237743399531==--

