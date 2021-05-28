Content-Type: multipart/mixed; boundary="===============5246035116907161656=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] ap: Save AP address as l_rtnl_address
Date: Fri, 28 May 2021 02:47:35 +0200
Message-ID: <20210528004737.2878442-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210528004737.2878442-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5246035116907161656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change the char *addr_str and uint8_t prefix_len pair to an
l_rtnl_address object and use ell/rtnl.h utilities that use that
directly.  Extend broadcast_from_ip to handle prefix_len.
---
 src/ap.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 430fdfa3..dc067352 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -90,8 +90,7 @@ struct ap_state {
 	struct l_queue *sta_states;
 =

 	struct l_dhcp_server *netconfig_dhcp;
-	char *netconfig_addr4_str;
-	uint8_t netconfig_prefix_len4;
+	struct l_rtnl_address *netconfig_addr4;
 	uint32_t rtnl_add_cmd;
 =

 	bool started : 1;
@@ -132,20 +131,15 @@ static char **global_addr4_strs;
 static uint32_t netdev_watch;
 static struct l_netlink *rtnl;
 =

-static const char *broadcast_from_ip(const char *ip)
+static const char *broadcast_from_ip(const char *ip, uint8_t prefix_len)
 {
 	struct in_addr ia;
-	uint32_t bcast;
+	uint32_t netmask =3D util_netmask_from_prefix(prefix_len);
 =

 	if (inet_aton(ip, &ia) !=3D 1)
 		return NULL;
 =

-	bcast =3D ntohl(ia.s_addr);
-	bcast &=3D 0xffffff00;
-	bcast |=3D 0x000000ff;
-
-	ia.s_addr =3D htonl(bcast);
-
+	ia.s_addr |=3D htonl(~netmask);
 	return inet_ntoa(ia);
 }
 =

@@ -234,16 +228,12 @@ static void ap_reset(struct ap_state *ap)
 =

 	/* Delete IP if one was set by IWD */
 	if (ap->netconfig_set_addr4) {
-		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
-				ap->netconfig_prefix_len4,
-				ap->netconfig_addr4_str,
-				broadcast_from_ip(ap->netconfig_addr4_str),
-				NULL, NULL, NULL);
+		l_rtnl_ifaddr_delete(rtnl, netdev_get_ifindex(netdev),
+					ap->netconfig_addr4, NULL, NULL, NULL);
 		ap->netconfig_set_addr4 =3D false;
 	}
 =

-	l_free(ap->netconfig_addr4_str);
-	ap->netconfig_addr4_str =3D NULL;
+	l_rtnl_address_free(l_steal_ptr(ap->netconfig_addr4));
 =

 	if (ap->netconfig_dhcp) {
 		l_dhcp_server_destroy(ap->netconfig_dhcp);
@@ -2454,6 +2444,13 @@ static int ap_setup_netconfig4(struct ap_state *ap, =
const char **addr_str_list,
 		}
 =

 		new_addr =3D l_rtnl_address_new(addr_str_buf, prefix_len);
+
+		if (!l_rtnl_address_set_broadcast(new_addr,
+				broadcast_from_ip(addr_str_buf, prefix_len))) {
+			ret =3D -EIO;
+			goto cleanup;
+		}
+
 		ret =3D 0;
 	} else {
 		if (!prefix_len)
@@ -2516,9 +2513,8 @@ static int ap_setup_netconfig4(struct ap_state *ap, c=
onst char **addr_str_list,
 		goto cleanup;
 	}
 =

-	ap->netconfig_addr4_str =3D l_strdup(addr_str_buf);
-	ap->netconfig_prefix_len4 =3D prefix_len;
 	ap->netconfig_set_addr4 =3D true;
+	ap->netconfig_addr4 =3D l_steal_ptr(new_addr);
 	ap->netconfig_dhcp =3D l_steal_ptr(dhcp);
 	ret =3D 0;
 =

@@ -2952,14 +2948,9 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct l_settings *config,
 		l_error("Registering for MLME notification failed");
 =

 	if (ap->netconfig_set_addr4) {
-		const char *broadcast_str =3D
-			broadcast_from_ip(ap->netconfig_addr4_str);
-
-		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl,
+		ap->rtnl_add_cmd =3D l_rtnl_ifaddr_add(rtnl,
 						netdev_get_ifindex(netdev),
-						ap->netconfig_prefix_len4,
-						ap->netconfig_addr4_str,
-						broadcast_str,
+						ap->netconfig_addr4,
 						ap_ifaddr4_added_cb, ap, NULL);
 		if (!ap->rtnl_add_cmd) {
 			l_error("Failed to add the IPv4 address");
-- =

2.27.0

--===============5246035116907161656==--

