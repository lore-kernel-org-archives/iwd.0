Content-Type: multipart/mixed; boundary="===============2730424552335555519=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/15] p2p: Also set a DHCP timeout in Group Owner role
Date: Fri, 04 Jun 2021 03:50:46 +0200
Message-ID: <20210604015052.163727-9-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2730424552335555519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the loading of the [P2P].DHCPTimeout setting to initialization and
set the timeout both in P2P Client and P2P GO roles.
---
 src/p2p.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index bc2d154d..22ce7042 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -170,6 +170,7 @@ struct p2p_wfd_properties {
 };
 =

 static struct l_queue *p2p_device_list;
+static unsigned int p2p_dhcp_timeout_val;
 static struct l_settings *p2p_dhcp_settings;
 static struct p2p_wfd_properties *p2p_own_wfd;
 static unsigned int p2p_wfd_disconnect_watch;
@@ -1175,6 +1176,22 @@ static const struct ap_ops p2p_go_ops =3D {
 	.write_extra_ies =3D p2p_group_write_ies,
 };
 =

+static void p2p_dhcp_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_debug("");
+
+	p2p_connect_failed(dev);
+}
+
+static void p2p_dhcp_timeout_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->conn_dhcp_timeout =3D NULL;
+}
+
 static void p2p_group_start(struct p2p_device *dev)
 {
 	struct l_settings *config =3D l_settings_new();
@@ -1233,8 +1250,15 @@ static void p2p_group_start(struct p2p_device *dev)
 	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, NULL, dev);
 	l_settings_free(config);
 =

-	if (!dev->group)
+	if (!dev->group) {
 		p2p_connect_failed(dev);
+		return;
+	}
+
+	/* Set timeout on client connecting and getting its IP */
+	dev->conn_dhcp_timeout =3D l_timeout_create(p2p_dhcp_timeout_val,
+						p2p_dhcp_timeout, dev,
+						p2p_dhcp_timeout_destroy);
 }
 =

 static void p2p_netconfig_event_handler(enum netconfig_event event,
@@ -1259,32 +1283,11 @@ static void p2p_netconfig_event_handler(enum netcon=
fig_event event,
 	}
 }
 =

-static void p2p_dhcp_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct p2p_device *dev =3D user_data;
-
-	l_debug("");
-
-	p2p_connect_failed(dev);
-}
-
-static void p2p_dhcp_timeout_destroy(void *user_data)
-{
-	struct p2p_device *dev =3D user_data;
-
-	dev->conn_dhcp_timeout =3D NULL;
-}
-
 static void p2p_start_client_netconfig(struct p2p_device *dev)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(dev->conn_netdev);
-	unsigned int dhcp_timeout_val;
 	struct l_settings *settings;
 =

-	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
-					&dhcp_timeout_val))
-		dhcp_timeout_val =3D 20;	/* 20s default */
-
 	if (!dev->conn_netconfig) {
 		dev->conn_netconfig =3D netconfig_new(ifindex);
 		if (!dev->conn_netconfig) {
@@ -1296,7 +1299,7 @@ static void p2p_start_client_netconfig(struct p2p_dev=
ice *dev)
 	settings =3D dev->conn_netconfig_settings ?: p2p_dhcp_settings;
 	netconfig_configure(dev->conn_netconfig, settings, dev->conn_addr,
 				p2p_netconfig_event_handler, dev);
-	dev->conn_dhcp_timeout =3D l_timeout_create(dhcp_timeout_val,
+	dev->conn_dhcp_timeout =3D l_timeout_create(p2p_dhcp_timeout_val,
 						p2p_dhcp_timeout, dev,
 						p2p_dhcp_timeout_destroy);
 }
@@ -5110,6 +5113,10 @@ static int p2p_init(void)
 					NULL))
 		l_error("Unable to register the P2P Service Manager object");
 =

+	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
+					&p2p_dhcp_timeout_val))
+		p2p_dhcp_timeout_val =3D 20;	/* 20s default */
+
 	return 0;
 }
 =

-- =

2.30.2

--===============2730424552335555519==--

