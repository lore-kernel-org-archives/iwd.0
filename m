Content-Type: multipart/mixed; boundary="===============7648192161646629709=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/9] eapol: fix incorrect increment appending OCI
Date: Tue, 28 Sep 2021 08:46:51 -0700
Message-ID: <20210928154658.2382597-2-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============7648192161646629709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was addign an extra byte to the buffer which hostapd accepted
unless there was additional data, like the RSNXE.
---
 src/eapol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index 8498fdb6..3127e066 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1256,7 +1256,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 		ies[ies_len++] =3D 4 + 3;
 		l_put_be32(HANDSHAKE_KDE_OCI, ies + ies_len);
 		ies_len +=3D 4;
-		oci_from_chandef(sm->handshake->chandef, ies + ies_len++);
+		oci_from_chandef(sm->handshake->chandef, ies + ies_len);
 		ies_len +=3D 3;
 	}
 =

-- =

2.31.1

--===============7648192161646629709==--

