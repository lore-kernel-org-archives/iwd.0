Content-Type: multipart/mixed; boundary="===============3935423592118698710=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/5] netconfig: Add netconfig event notifier
Date: Tue, 08 Oct 2019 14:48:22 -0700
Message-ID: <20191008214824.19466-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191008214824.19466-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3935423592118698710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The notifier allows to subscribe for the netconfig events such as =E2=80=98=
connected=E2=80=99.
---
 src/netconfig.c | 28 +++++++++++++++++++++-------
 src/netconfig.h | 11 ++++++++++-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 31cbeb2a..ec8d0af3 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -50,6 +50,9 @@ struct netconfig {
 	uint8_t rtm_v6_protocol;
 =

 	const struct l_settings *active_settings;
+
+	netconfig_notify_func_t notify;
+	void *user_data;
 };
 =

 struct netconfig_ifaddr {
@@ -595,11 +598,18 @@ static void netconfig_route_add_cmd_cb(int error, uin=
t16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
 {
-	if (!error)
-		return;
+	struct netconfig *netconfig =3D user_data;
 =

-	l_error("netconfig: Failed to add route. Error %d: %s",
+	if (error) {
+		l_error("netconfig: Failed to add route. Error %d: %s",
 						error, strerror(-error));
+		return;
+	}
+
+	if (!netconfig->notify)
+		return;
+
+	netconfig->notify(NETCONFIG_EVENT_CONNECTED, netconfig->user_data);
 }
 =

 static void netconfig_route_del_cmd_cb(int error, uint16_t type,
@@ -611,6 +621,7 @@ static void netconfig_route_del_cmd_cb(int error, uint1=
6_t type,
 =

 	l_error("netconfig: Failed to delete route. Error %d: %s",
 						error, strerror(-error));
+
 }
 =

 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig,
@@ -635,7 +646,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 						ifaddr->ip,
 						netconfig->rtm_protocol,
 						netconfig_route_add_cmd_cb,
-						NULL, NULL)) {
+						netconfig, NULL)) {
 		l_error("netconfig: Failed to add subnet route.");
 =

 		return false;
@@ -655,7 +666,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig,
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_protocol,
 						netconfig_route_add_cmd_cb,
-						NULL, NULL)) {
+						netconfig, NULL)) {
 		l_error("netconfig: Failed to add route for: %s gateway.",
 								gateway);
 =

@@ -723,7 +734,7 @@ static bool netconfig_ipv6_routes_install(struct netcon=
fig *netconfig)
 						ROUTE_PRIORITY_OFFSET,
 						netconfig->rtm_v6_protocol,
 						netconfig_route_add_cmd_cb,
-						NULL, NULL)) {
+						netconfig, NULL)) {
 		l_error("netconfig: Failed to add route for: %s gateway.",
 								gateway);
 =

@@ -1020,9 +1031,12 @@ static void netconfig_ipv6_select_and_uninstall(stru=
ct netconfig *netconfig)
 =

 bool netconfig_configure(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
-				const uint8_t *mac_address)
+				const uint8_t *mac_address,
+				netconfig_notify_func_t notify, void *user_data)
 {
 	netconfig->active_settings =3D active_settings;
+	netconfig->notify =3D notify;
+	netconfig->user_data =3D user_data;
 =

 	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
 							mac_address, ETH_ALEN);
diff --git a/src/netconfig.h b/src/netconfig.h
index cacd384a..5a527950 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -22,9 +22,18 @@
 =

 struct netconfig;
 =

+enum netconfig_event {
+	NETCONFIG_EVENT_CONNECTED,
+};
+
+typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
+							void *user_data);
+
 bool netconfig_configure(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
-				const uint8_t *mac_address);
+				const uint8_t *mac_address,
+				netconfig_notify_func_t notify,
+				void *user_data);
 bool netconfig_reconfigure(struct netconfig *netconfig);
 bool netconfig_reset(struct netconfig *netconfig);
 =

-- =

2.13.6

--===============3935423592118698710==--

