Content-Type: multipart/mixed; boundary="===============3914796104914217414=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] eap-tls-common: update to new ELL TLS APIs
Date: Tue, 01 Oct 2019 14:32:50 -0700
Message-ID: <20191001213251.2536-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3914796104914217414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-tls-common.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index b069fcfd..d5b72963 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -523,6 +523,9 @@ static int eap_tls_handle_fragmented_request(struct eap=
_state *eap,
 static bool eap_tls_tunnel_init(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
+	struct l_certchain *client_cert;
+	struct l_key *client_key;
+	struct l_queue *ca_cert;
 =

 	if (eap_tls->tunnel)
 		return false;
@@ -543,14 +546,20 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 		l_tls_set_debug(eap_tls->tunnel, eap_tls_tunnel_debug, eap,
 									NULL);
 =

-	if (!l_tls_set_auth_data(eap_tls->tunnel, eap_tls->client_cert,
-							eap_tls->client_key,
-							eap_tls->passphrase) ||
-			(eap_tls->ca_cert &&
-				!l_tls_set_cacert(eap_tls->tunnel,
-							eap_tls->ca_cert))) {
+	client_cert =3D l_pem_load_certificate_chain(eap_tls->client_cert);
+	client_key =3D l_pem_load_private_key(eap_tls->client_key,
+						eap_tls->passphrase, NULL);
+	ca_cert =3D l_pem_load_certificate_list(eap_tls->ca_cert);
+
+	if (!l_tls_set_auth_data(eap_tls->tunnel, client_cert, client_key) ||
+			(ca_cert &&
+				!l_tls_set_cacert(eap_tls->tunnel, ca_cert))) {
 		l_error("%s: Error loading TLS keys or certificates.",
 						eap_get_method_name(eap));
+		l_certchain_free(client_cert);
+		l_key_free(client_key);
+		l_queue_destroy(ca_cert,
+				(l_queue_destroy_func_t)l_certchain_free);
 		return false;
 	}
 =

-- =

2.17.1

--===============3914796104914217414==--

