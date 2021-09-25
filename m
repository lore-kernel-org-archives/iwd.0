Content-Type: multipart/mixed; boundary="===============4462644257279225285=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 3/8] netconfig: Set netconfig_get_static6_gateway out param on
 success
Date: Sat, 25 Sep 2021 03:11:48 +0200
Message-ID: <20210925011153.25195-3-andrew.zaborowski@intel.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============4462644257279225285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure to only set the netconfig_get_static6_gateway's out_mac
parameter on successful return and make sure to always set it, even if
to NULL.
---
 src/netconfig.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 493a5c13..30e56157 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -498,6 +498,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 {
 	L_AUTO_FREE_VAR(char *, gateway);
 	struct l_rtnl_route *ret;
+	const uint8_t *mac =3D NULL;
 =

 	gateway =3D l_settings_get_string(netconfig->active_settings,
 						"IPv6", "Gateway");
@@ -509,7 +510,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 					netconfig->fils_override->ipv6_gateway);
 =

 		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
-			*out_mac =3D netconfig->fils_override->ipv6_gateway_mac;
+			mac =3D netconfig->fils_override->ipv6_gateway_mac;
 	} else if (!gateway)
 		return NULL;
 =

@@ -523,6 +524,7 @@ static struct l_rtnl_route *netconfig_get_static6_gatew=
ay(
 =

 	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
 	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
+	*out_mac =3D mac;
 =

 	return ret;
 }
@@ -864,7 +866,7 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int error,=
 uint16_t type,
 {
 	struct netconfig *netconfig =3D user_data;
 	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac =3D NULL;
+	const uint8_t *gateway_mac;
 =

 	netconfig->addr6_add_cmd_id =3D 0;
 =

-- =

2.30.2

--===============4462644257279225285==--

