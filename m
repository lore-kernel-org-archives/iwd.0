Content-Type: multipart/mixed; boundary="===============4437260067857117838=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/15] ap: Drop unneeded broadcast address calculation
Date: Fri, 04 Jun 2021 03:50:38 +0200
Message-ID: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4437260067857117838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's already done in l_rtnl_address_new().
---
 src/ap.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index dc067352..f0a38bb6 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -131,18 +131,6 @@ static char **global_addr4_strs;
 static uint32_t netdev_watch;
 static struct l_netlink *rtnl;
 =

-static const char *broadcast_from_ip(const char *ip, uint8_t prefix_len)
-{
-	struct in_addr ia;
-	uint32_t netmask =3D util_netmask_from_prefix(prefix_len);
-
-	if (inet_aton(ip, &ia) !=3D 1)
-		return NULL;
-
-	ia.s_addr |=3D htonl(~netmask);
-	return inet_ntoa(ia);
-}
-
 static void ap_stop_handshake(struct sta_state *sta)
 {
 	if (sta->sm) {
@@ -2444,13 +2432,6 @@ static int ap_setup_netconfig4(struct ap_state *ap, =
const char **addr_str_list,
 		}
 =

 		new_addr =3D l_rtnl_address_new(addr_str_buf, prefix_len);
-
-		if (!l_rtnl_address_set_broadcast(new_addr,
-				broadcast_from_ip(addr_str_buf, prefix_len))) {
-			ret =3D -EIO;
-			goto cleanup;
-		}
-
 		ret =3D 0;
 	} else {
 		if (!prefix_len)
-- =

2.30.2

--===============4437260067857117838==--

