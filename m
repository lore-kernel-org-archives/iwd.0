Content-Type: multipart/mixed; boundary="===============6670943725012284105=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] eap-tls: Keep l_tls instance for reauthentication
Date: Thu, 26 May 2022 18:01:53 +0200
Message-ID: <20220526160153.64175-1-andrew.zaborowski@intel.com>

--===============6670943725012284105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After one of the eap-tls-common-based methods succeeds keep the TLS
tunnel instance until the method is freed, rather than free it the
moment the method succeeds.  This fixes repeated method runs where until
now each next run would attempt to create a new TLS tunnel instance
but would have no authentication data (CA certificate, client
certificate, private key and private key passphrase) since those are
were by the old l_tls object from the moment of the l_tls_set_auth_data()
call.

Use l_tls_reset() to reset the TLS state after method success, followed
by a new l_tls_start() when the reauthentication starts.
---
Depends on the ell l_tls_reset patch.

 src/eap-tls-common.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 75d3aa33..acc5b387 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -131,10 +131,13 @@ static void __eap_tls_common_state_reset(struct eap_t=
ls_state *eap_tls)
 	eap_tls->expecting_frag_ack =3D false;
 	eap_tls->tunnel_ready =3D false;
 =

-	if (eap_tls->tunnel) {
-		l_tls_free(eap_tls->tunnel);
-		eap_tls->tunnel =3D NULL;
-	}
+	/*
+	 * Keep the tunnel instance to avoid losing the authentication
+	 * settings that we may have loaded with l_tls_set_auth_data()
+	 * since .reset_state is not supposed to clear settings.
+	 */
+	if (eap_tls->tunnel)
+		l_tls_reset(eap_tls->tunnel);
 =

 	eap_tls->tx_frag_offset =3D 0;
 	eap_tls->tx_frag_last_len =3D 0;
@@ -167,6 +170,10 @@ static void __eap_tls_common_state_free(struct eap_tls=
_state *eap_tls)
 		l_key_free(eap_tls->client_key);
 =

 	l_strv_free(eap_tls->domain_mask);
+
+	if (eap_tls->tunnel)
+		l_tls_free(eap_tls->tunnel);
+
 	l_free(eap_tls);
 }
 =

@@ -569,7 +576,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
 =

 	if (eap_tls->tunnel)
-		return false;
+		goto start;
 =

 	eap_tls->tunnel =3D l_tls_new(false, eap_tls_tunnel_data_received,
 					eap_tls_tunnel_data_send,
@@ -626,6 +633,7 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 =

+start:
 	if (!l_tls_start(eap_tls->tunnel)) {
 		l_error("%s: Failed to start the TLS client",
 						eap_get_method_name(eap));
-- =

2.32.0

--===============6670943725012284105==--

