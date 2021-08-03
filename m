Content-Type: multipart/mixed; boundary="===============7379298995807045333=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] fils: isolate ERP cache into fils.c
Date: Tue, 03 Aug 2021 10:27:54 -0700
Message-ID: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7379298995807045333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This removes the need for the handshake_state to hold a reference
to the ERP cache. Really the handshake_state was merely holding a
pointer between station and fils and never needed to reference it
beyond fils_sm_new.
---
 src/fils.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/fils.c b/src/fils.c
index 7fffefb3..4e67d8df 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -567,6 +567,8 @@ struct auth_proto *fils_sm_new(struct handshake_state *=
hs,
 				void *user_data)
 {
 	struct fils_sm *fils;
+	struct erp_cache_entry *erp;
+	char ssid[33];
 =

 	fils =3D l_new(struct fils_sm, 1);
 =

@@ -580,7 +582,17 @@ struct auth_proto *fils_sm_new(struct handshake_state =
*hs,
 	fils->ap.rx_authenticate =3D fils_rx_authenticate;
 	fils->ap.rx_associate =3D fils_rx_associate;
 =

-	fils->erp =3D erp_new(hs->erp_cache, fils_erp_tx_func, fils);
+	memcpy(ssid, hs->ssid, hs->ssid_len);
+	ssid[hs->ssid_len] =3D '\0';
+
+	/*
+	 * If FILS was chosen the ERP identity is known to exist, checked by
+	 * network_has_erp_identity. erp_new takes ownership of the cache and
+	 * will free it upon erp_free.
+	 */
+	erp =3D erp_cache_get(ssid);
+
+	fils->erp =3D erp_new(erp, fils_erp_tx_func, fils);
 =

 	return &fils->ap;
 }
-- =

2.31.1

--===============7379298995807045333==--

