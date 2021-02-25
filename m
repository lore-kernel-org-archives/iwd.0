Content-Type: multipart/mixed; boundary="===============8430359387939874466=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/7] ap: Print error messages in dhcp_load_settings
Date: Thu, 25 Feb 2021 22:27:21 +0100
Message-ID: <20210225212725.656746-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210225212725.656746-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8430359387939874466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index d9443097..78df3355 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2397,7 +2397,6 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
 static bool dhcp_load_settings(struct ap_state *ap, struct l_settings *set=
tings)
 {
 	struct l_dhcp_server *server =3D ap->server;
-	struct in_addr ia;
 =

 	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
 							"IPv4", "Netmask");
@@ -2413,33 +2412,42 @@ static bool dhcp_load_settings(struct ap_state *ap,=
 struct l_settings *settings)
 	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_time))
 		lease_time =3D 0;
 =

-	if (ip_range && l_strv_length(ip_range) !=3D 2)
-		goto parse_error;
-
-	if (netmask && !l_dhcp_server_set_netmask(server, netmask))
-		goto parse_error;
+	if (gateway && !l_dhcp_server_set_gateway(server, gateway)) {
+		l_error("[IPv4].Gateway value error");
+		goto error;
+	}
 =

-	if (gateway && !l_dhcp_server_set_gateway(server, gateway))
-		goto parse_error;
+	if (dns && !l_dhcp_server_set_dns(server, dns)) {
+		l_error("[IPv4].DNSList value error");
+		goto error;
+	}
 =

-	if (dns && !l_dhcp_server_set_dns(server, dns))
-		goto parse_error;
+	if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
+		l_error("[IPv4].Netmask value error");
+		goto error;
+	}
 =

-	if (ip_range && !l_dhcp_server_set_ip_range(server, ip_range[0],
-							ip_range[1]))
-		goto parse_error;
+	if (ip_range) {
+		if (l_strv_length(ip_range) !=3D 2) {
+			l_error("Two addresses expected in [IPv4].IPRange");
+			goto error;
+		}
 =

-	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time))
-		goto parse_error;
+		if (!l_dhcp_server_set_ip_range(server, ip_range[0],
+							ip_range[1])) {
+			l_error("Error setting IP range from [IPv4].IPRange");
+			goto error;
+		}
+	}
 =

-	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
-		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
-	else
-		ap->ip_prefix =3D 24;
+	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time)) {
+		l_error("[IPv4].LeaseTime value error");
+		goto error;
+	}
 =

 	ret =3D true;
 =

-parse_error:
+error:
 	l_strv_free(dns);
 	l_strv_free(ip_range);
 	return ret;
-- =

2.27.0

--===============8430359387939874466==--

