Content-Type: multipart/mixed; boundary="===============5354712432805029121=="
MIME-Version: 1.0
From: Joseph Benden <joe@benden.us>
Subject: [PATCH 1/1] eapol: Use constant-time comparison
Date: Sun, 13 Jun 2021 13:23:44 -0700
Message-ID: <20210613202344.4402-1-joe@benden.us>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5354712432805029121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This closes the possibility of a timing attack against PMKIDs.
---
 src/eapol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index f587e708..51fb3c92 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1142,7 +1142,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 			goto error_unspecified;
 =

 		for (i =3D 0; i < rsn_info.num_pmkids; i++)
-			if (!memcmp(rsn_info.pmkids + i * 16, pmkid, 16)) {
+			if (!l_secure_memcmp(rsn_info.pmkids + i * 16, pmkid, 16)) {
 				found =3D true;
 				break;
 			}
@@ -1155,7 +1155,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 		if (!handshake_state_get_pmkid(sm->handshake, own_pmkid))
 			goto error_unspecified;
 =

-		if (memcmp(pmkid, own_pmkid, 16)) {
+		if (l_secure_memcmp(pmkid, own_pmkid, 16)) {
 			l_debug("Authenticator sent a PMKID that didn't match");
 =

 			/*
-- =

2.32.0

--===============5354712432805029121==--

