Content-Type: multipart/mixed; boundary="===============8172608498853452947=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] dpp: zero nonces/keys on dpp_reset
Date: Wed, 22 Dec 2021 15:00:16 -0800
Message-ID: <20211222230017.12587-1-prestwoj@gmail.com>

--===============8172608498853452947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 48343445..941c3f07 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -163,6 +163,12 @@ static void dpp_reset(struct dpp_sm *dpp)
 =

 	dpp->state =3D DPP_STATE_NOTHING;
 =

+	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
+	explicit_bzero(dpp->ke, dpp->key_len);
+	explicit_bzero(dpp->k2, dpp->key_len);
+
 	dpp_free_auth_data(dpp);
 }
 =

-- =

2.31.1

--===============8172608498853452947==--

