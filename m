Content-Type: multipart/mixed; boundary="===============7583312753054226975=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 04/12] handshake: add callback for extended key IDs
Date: Mon, 04 Oct 2021 09:48:54 -0700
Message-ID: <20211004164902.2274318-4-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============7583312753054226975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The procedure for setting extended key IDs is different from the
single PTK key. The key ID is toggled between 0 and 1 and the new
key is set as RX only, then set to RX/TX after message 4/4 goes
out.

Since netdev needs to set this new key before message 4/4 a new
callback has been added to accomplish this. The callback itself
takes a callback so netdev can signal back to eapol that NEW_KEY
finished and message 4/4 can be sent.
---
 src/handshake.c | 21 +++++++++++++++++++++
 src/handshake.h | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 642a25a7..aa48c19d 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -76,6 +76,7 @@ static handshake_get_nonce_func_t get_nonce =3D handshake=
_get_nonce;
 static handshake_install_tk_func_t install_tk =3D NULL;
 static handshake_install_gtk_func_t install_gtk =3D NULL;
 static handshake_install_igtk_func_t install_igtk =3D NULL;
+static handshake_install_rx_tk_func_t install_rx_tk =3D NULL;
 =

 void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func)
 {
@@ -97,6 +98,11 @@ void __handshake_set_install_igtk_func(handshake_install=
_igtk_func_t func)
 	install_igtk =3D func;
 }
 =

+void __handshake_set_install_rx_tk_func(handshake_install_rx_tk_func_t fun=
c)
+{
+	install_rx_tk =3D func;
+}
+
 void handshake_state_free(struct handshake_state *s)
 {
 	__typeof__(s->free) destroy =3D s->free;
@@ -663,6 +669,21 @@ void handshake_state_install_ptk(struct handshake_stat=
e *s)
 	}
 }
 =

+void handshake_state_install_rx_ptk(struct handshake_state *s,
+				uint8_t key_idx,
+				handshake_install_rx_tk_cb_t callback,
+				void *user_data)
+{
+	if (install_rx_tk) {
+		uint32_t cipher =3D
+			ie_rsn_cipher_suite_to_cipher(s->pairwise_cipher);
+
+		install_rx_tk(s, key_idx, handshake_get_tk(s), cipher,
+				callback, user_data);
+	}
+}
+
+
 void handshake_state_install_gtk(struct handshake_state *s,
 					uint16_t gtk_key_index,
 					const uint8_t *gtk, size_t gtk_len,
diff --git a/src/handshake.h b/src/handshake.h
index e67e2c20..303cffbf 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -78,11 +78,19 @@ typedef void (*handshake_install_igtk_func_t)(struct ha=
ndshake_state *hs,
 					const uint8_t *igtk, uint8_t igtk_len,
 					const uint8_t *ipn, uint8_t ipn_len,
 					uint32_t cipher);
+typedef void (*handshake_install_rx_tk_cb_t)(bool success, void *user_data=
);
+typedef void (*handshake_install_rx_tk_func_t)(struct handshake_state *hs,
+					uint8_t key_idx,
+					const uint8_t *tk,
+					uint32_t cipher,
+					handshake_install_rx_tk_cb_t callback,
+					void *user_data);
 =

 void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func);
 void __handshake_set_install_tk_func(handshake_install_tk_func_t func);
 void __handshake_set_install_gtk_func(handshake_install_gtk_func_t func);
 void __handshake_set_install_igtk_func(handshake_install_igtk_func_t func);
+void __handshake_set_install_rx_tk_func(handshake_install_rx_tk_func_t fun=
c);
 =

 struct handshake_state {
 	uint32_t ifindex;
@@ -227,6 +235,10 @@ size_t handshake_state_get_kek_len(struct handshake_st=
ate *s);
 const uint8_t *handshake_state_get_kek(struct handshake_state *s);
 void handshake_state_install_ptk(struct handshake_state *s);
 =

+void handshake_state_install_rx_ptk(struct handshake_state *s,
+					uint8_t key_idx,
+					handshake_install_rx_tk_cb_t callback,
+					void *user_data);
 void handshake_state_install_gtk(struct handshake_state *s,
 					uint16_t gtk_key_index,
 					const uint8_t *gtk, size_t gtk_len,
-- =

2.31.1

--===============7583312753054226975==--

