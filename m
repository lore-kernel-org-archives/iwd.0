Content-Type: multipart/mixed; boundary="===============6821867304644360815=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] eapol: zero entire buffer when creating frame
Date: Mon, 28 Mar 2022 15:32:56 -0700
Message-ID: <20220328223256.1683289-1-prestwoj@gmail.com>

--===============6821867304644360815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since l_malloc is used the frame contents are not zero'ed automatically
which could result in random bytes being present in the frame which were
expected to be zero. This poses a problem when calculating the MIC as the
crypto operations are done on the entire frame with the expectation of
the MIC being zero.
---
 src/eapol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index 9f397d1d..e2c99991 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -706,7 +706,7 @@ static struct eapol_key *eapol_create_common(
 	struct eapol_key *out_frame =3D l_malloc(to_alloc + extra_len +
 						extra_key_len);
 =

-	memset(out_frame, 0, to_alloc + extra_len);
+	memset(out_frame, 0, to_alloc + extra_len + extra_key_len);
 =

 	out_frame->header.protocol_version =3D protocol;
 	out_frame->header.packet_type =3D 0x3;
-- =

2.34.1

--===============6821867304644360815==--

