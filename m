Content-Type: multipart/mixed; boundary="===============6775038804225196247=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] handshake: fix OWE PTK derivation
Date: Tue, 24 Mar 2020 12:07:57 -0700
Message-ID: <20200324190757.24072-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6775038804225196247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This bug has been in here since OWE was written, but a similar bug also
existed in hostapd which allowed the PTK derivation to be identical.
In January 2020 hostapd fixed this bug, which now makes IWD incompatible
when using group 20 or 21.

This patch fixes the bug for IWD, so now OWE should be compatible with
recent hostapd version. This will break compatibility with old hostapd
versions which still have this bug.
---
 src/handshake.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index bb376441..1cab48f1 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -410,14 +410,22 @@ bool handshake_state_derive_ptk(struct handshake_stat=
e *s)
 =

 	s->ptk_complete =3D false;
 =

-	if (s->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA384 |
+	if (s->akm_suite & IE_RSN_AKM_SUITE_OWE) {
+		if (s->pmk_len =3D=3D 32)
+			type =3D L_CHECKSUM_SHA256;
+		else if (s->pmk_len =3D=3D 48)
+			type =3D L_CHECKSUM_SHA384;
+		else if (s->pmk_len =3D=3D 64)
+			type =3D L_CHECKSUM_SHA512;
+		else
+			return false;
+	} else if (s->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA384 |
 			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 		type =3D L_CHECKSUM_SHA384;
 	else if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
 			IE_RSN_AKM_SUITE_PSK_SHA256 |
 			IE_RSN_AKM_SUITE_SAE_SHA256 |
 			IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
-			IE_RSN_AKM_SUITE_OWE |
 			IE_RSN_AKM_SUITE_FILS_SHA256 |
 			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
 			IE_RSN_AKM_SUITE_OSEN))
-- =

2.21.1

--===============6775038804225196247==--

