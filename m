Content-Type: multipart/mixed; boundary="===============8868687749770456396=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 03/13] handshake: add callback for extended key IDs
Date: Thu, 07 Oct 2021 13:49:47 -0700
Message-ID: <20211007204957.3745985-3-prestwoj@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============8868687749770456396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The procedure for setting extended key IDs is different from the
single PTK key. The key ID is toggled between 0 and 1 and the new
key is set as RX only, then set to RX/TX after message 4/4 goes
out.

Since netdev needs to set this new key before sending message 4,
eapol can include a built message which netdev will store if
required (i.e. using PAE).
---
 src/handshake.c | 23 +++++++++++++++++++++++
 src/handshake.h | 12 ++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 642a25a7..58326dcd 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -76,6 +76,7 @@ static handshake_get_nonce_func_t get_nonce =3D handshake=
_get_nonce;
 static handshake_install_tk_func_t install_tk =3D NULL;
 static handshake_install_gtk_func_t install_gtk =3D NULL;
 static handshake_install_igtk_func_t install_igtk =3D NULL;
+static handshake_install_ext_tk_func_t install_ext_tk =3D NULL;
 =

 void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func)
 {
@@ -97,6 +98,11 @@ void __handshake_set_install_igtk_func(handshake_install=
_igtk_func_t func)
 	install_igtk =3D func;
 }
 =

+void __handshake_set_install_ext_tk_func(handshake_install_ext_tk_func_t f=
unc)
+{
+	install_ext_tk =3D func;
+}
+
 void handshake_state_free(struct handshake_state *s)
 {
 	__typeof__(s->free) destroy =3D s->free;
@@ -663,6 +669,23 @@ void handshake_state_install_ptk(struct handshake_stat=
e *s)
 	}
 }
 =

+void handshake_state_install_ext_ptk(struct handshake_state *s,
+				uint8_t key_idx,
+				struct eapol_frame *ek, uint16_t proto,
+				bool noencrypt)
+{
+	s->ptk_complete =3D true;
+
+	if (install_ext_tk) {
+		uint32_t cipher =3D
+			ie_rsn_cipher_suite_to_cipher(s->pairwise_cipher);
+
+		install_ext_tk(s, key_idx, handshake_get_tk(s), cipher, ek,
+				proto, noencrypt);
+	}
+}
+
+
 void handshake_state_install_gtk(struct handshake_state *s,
 					uint16_t gtk_key_index,
 					const uint8_t *gtk, size_t gtk_len,
diff --git a/src/handshake.h b/src/handshake.h
index d57a3794..4cf2ec63 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -27,6 +27,7 @@
 =

 struct handshake_state;
 enum crypto_cipher;
+struct eapol_frame;
 =

 enum handshake_kde {
 	/* 802.11-2020 Table 12-9 in section 12.7.2 */
@@ -78,11 +79,17 @@ typedef void (*handshake_install_igtk_func_t)(struct ha=
ndshake_state *hs,
 					const uint8_t *igtk, uint8_t igtk_len,
 					const uint8_t *ipn, uint8_t ipn_len,
 					uint32_t cipher);
+typedef void (*handshake_install_ext_tk_func_t)(struct handshake_state *hs,
+					uint8_t key_idx, const uint8_t *tk,
+					uint32_t cipher,
+					const struct eapol_frame *step4,
+					uint16_t proto, bool noencrypt);
 =

 void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func);
 void __handshake_set_install_tk_func(handshake_install_tk_func_t func);
 void __handshake_set_install_gtk_func(handshake_install_gtk_func_t func);
 void __handshake_set_install_igtk_func(handshake_install_igtk_func_t func);
+void __handshake_set_install_ext_tk_func(handshake_install_ext_tk_func_t f=
unc);
 =

 struct handshake_state {
 	uint32_t ifindex;
@@ -226,6 +233,11 @@ size_t handshake_state_get_kek_len(struct handshake_st=
ate *s);
 const uint8_t *handshake_state_get_kek(struct handshake_state *s);
 void handshake_state_install_ptk(struct handshake_state *s);
 =

+void handshake_state_install_ext_ptk(struct handshake_state *s,
+				uint8_t key_idx,
+				struct eapol_frame *ek, uint16_t proto,
+				bool noencrypt);
+
 void handshake_state_install_gtk(struct handshake_state *s,
 					uint16_t gtk_key_index,
 					const uint8_t *gtk, size_t gtk_len,
-- =

2.31.1

--===============8868687749770456396==--

