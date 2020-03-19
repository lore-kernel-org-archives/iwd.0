Content-Type: multipart/mixed; boundary="===============0396893577637537861=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 9/9] eap-tls: Print a hint about IWD_TLS_DEBUG on TLS errors
Date: Thu, 19 Mar 2020 22:12:18 +0100
Message-ID: <20200319211218.32083-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0396893577637537861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-tls-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index a6125969..28febaf0 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -255,6 +255,13 @@ static void eap_tls_tunnel_ready(const char *peer_iden=
tity, void *user_data)
 		l_tls_close(eap_tls->tunnel);
 }
 =

+static void eap_tls_debug_hint(void)
+{
+	if (!getenv("IWD_TLS_DEBUG"))
+		l_debug("set the IWD_TLS_DEBUG environment variable to see "
+			"more information");
+}
+
 static void eap_tls_tunnel_disconnected(enum l_tls_alert_desc reason,
 						bool remote, void *user_data)
 {
@@ -592,6 +599,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 =

 			l_error("%s: Failed to set auth data.",
 					eap_get_method_name(eap));
+			eap_tls_debug_hint();
 			return false;
 		}
 =

@@ -606,6 +614,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 			eap_tls->ca_cert =3D NULL;
 			l_error("%s: Error settings CA certificates.",
 					eap_get_method_name(eap));
+			eap_tls_debug_hint();
 			return false;
 		}
 =

@@ -618,6 +627,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (!l_tls_start(eap_tls->tunnel)) {
 		l_error("%s: Failed to start the TLS client",
 						eap_get_method_name(eap));
+		eap_tls_debug_hint();
 		return false;
 	}
 =

-- =

2.20.1

--===============0396893577637537861==--

