Content-Type: multipart/mixed; boundary="===============5201991985285271210=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 06/12] netconfig: Convert netconfig_load_settings to use _auto_
Date: Thu, 21 Oct 2021 10:50:35 +0200
Message-ID: <20211021085041.294524-6-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============5201991985285271210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As requested do the cleanup in netconfig_load_settings using ell's
private _auto_() macro.
---
 src/netconfig.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index f4bf944e..7b4b7f8a 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1373,14 +1373,14 @@ static int validate_dns_list(int family, char **dns=
_list)
 bool netconfig_load_settings(struct netconfig *netconfig,
 				const struct l_settings *active_settings)
 {
-	char *mdns;
+	_auto_(l_free) char *mdns =3D NULL;
 	bool send_hostname;
 	bool v6_enabled;
 	char hostname[HOST_NAME_MAX + 1];
-	char **dns4_overrides =3D NULL;
-	char **dns6_overrides =3D NULL;
-	struct l_rtnl_address *v4_address =3D NULL;
-	struct l_rtnl_address *v6_address =3D NULL;
+	_auto_(l_strv_free) char **dns4_overrides =3D NULL;
+	_auto_(l_strv_free) char **dns6_overrides =3D NULL;
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *v4_address =3D NULL;
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *v6_address =3D NULL;
 =

 	dns4_overrides =3D l_settings_get_string_list(active_settings,
 							"IPv4", "DNS", ' ');
@@ -1392,7 +1392,7 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 			dns4_overrides =3D NULL;
 =

 			if (r < 0)
-				goto err_dns4;
+				return false;
 		}
 =

 		if (r =3D=3D 0)
@@ -1410,7 +1410,7 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 			dns6_overrides =3D NULL;
 =

 			if (r < 0)
-				goto err_dns6;
+				return false;
 		}
 =

 		if (r =3D=3D 0)
@@ -1437,7 +1437,7 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 =

 		if (unlikely(!v4_address)) {
 			l_error("netconfig: Can't parse IPv4 address");
-			goto err_v4_addr;
+			return false;
 		}
 	}
 =

@@ -1450,7 +1450,7 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 =

 		if (unlikely(!v6_address)) {
 			l_error("netconfig: Can't parse IPv6 address");
-			goto err_v6_addr;
+			return false;
 		}
 	}
 =

@@ -1470,26 +1470,16 @@ bool netconfig_load_settings(struct netconfig *netc=
onfig,
 	netconfig_free_settings(netconfig);
 =

 	if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC)
-		netconfig->v4_address =3D v4_address;
+		netconfig->v4_address =3D l_steal_ptr(v4_address);
 =

 	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
-		netconfig->v6_address =3D v6_address;
+		netconfig->v6_address =3D l_steal_ptr(v6_address);
 =

 	netconfig->active_settings =3D active_settings;
-	netconfig->dns4_overrides =3D dns4_overrides;
-	netconfig->dns6_overrides =3D dns6_overrides;
-	netconfig->mdns =3D mdns;
+	netconfig->dns4_overrides =3D l_steal_ptr(dns4_overrides);
+	netconfig->dns6_overrides =3D l_steal_ptr(dns6_overrides);
+	netconfig->mdns =3D l_steal_ptr(mdns);
 	return true;
-
-err_v6_addr:
-	l_rtnl_address_free(v4_address);
-err_v4_addr:
-	l_free(mdns);
-	l_strfreev(dns6_overrides);
-err_dns6:
-	l_strfreev(dns4_overrides);
-err_dns4:
-	return false;
 }
 =

 bool netconfig_configure(struct netconfig *netconfig,
-- =

2.32.0

--===============5201991985285271210==--

