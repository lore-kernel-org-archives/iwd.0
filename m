Content-Type: multipart/mixed; boundary="===============3211294640647980924=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] eap-wsc: Convert memsets to explicit_bzero
Date: Fri, 03 Apr 2020 18:45:12 +0200
Message-ID: <20200403164512.19008-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200403164512.19008-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3211294640647980924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-wsc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 9fa1405f..3e0433e3 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -843,11 +843,11 @@ static void eap_wsc_handle_m2(struct eap_state *eap,
 	l_checksum_get_digest(sha256, dhkey, sizeof(dhkey));
 	l_checksum_free(sha256);
 =

-	memset(shared_secret, 0, shared_secret_len);
+	explicit_bzero(shared_secret, shared_secret_len);
 =

 	hmac_sha256 =3D l_checksum_new_hmac(L_CHECKSUM_SHA256,
 							dhkey, sizeof(dhkey));
-	memset(dhkey, 0, sizeof(dhkey));
+	explicit_bzero(dhkey, sizeof(dhkey));
 =

 	if (!hmac_sha256)
 		return;
@@ -864,7 +864,7 @@ static void eap_wsc_handle_m2(struct eap_state *eap,
 	l_checksum_free(hmac_sha256);
 =

 	r =3D wsc_kdf(kdk, &keys, sizeof(keys));
-	memset(kdk, 0, sizeof(kdk));
+	explicit_bzero(kdk, sizeof(kdk));
 	if (!r)
 		return;
 =

@@ -888,7 +888,7 @@ static void eap_wsc_handle_m2(struct eap_state *eap,
 						sizeof(keys.keywrap_key));
 =

 clear_keys:
-	memset(&keys, 0, sizeof(keys));
+	explicit_bzero(&keys, sizeof(keys));
 }
 =

 static void eap_wsc_handle_nack(struct eap_state *eap,
@@ -1228,12 +1228,12 @@ static bool eap_wsc_load_settings(struct eap_state =
*eap,
 		if (!l_key_validate_dh_payload(private_key, 192,
 						crypto_dh5_prime,
 						crypto_dh5_prime_size)) {
-			memset(private_key, 0, 192);
+			explicit_bzero(private_key, 192);
 			goto err;
 		}
 =

 		wsc->private =3D l_key_new(L_KEY_RAW, private_key, 192);
-		memset(private_key, 0, 192);
+		explicit_bzero(private_key, 192);
 	} else
 		wsc->private =3D l_key_generate_dh_private(crypto_dh5_prime,
 							crypto_dh5_prime_size);
-- =

2.20.1

--===============3211294640647980924==--

