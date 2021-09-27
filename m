Content-Type: multipart/mixed; boundary="===============1700750956773413352=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/9] ft: sent OCI in Reassociate
Date: Mon, 27 Sep 2021 10:03:59 -0700
Message-ID: <20210927170404.1292107-4-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============1700750956773413352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ft.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index cff1d759..6897f6d7 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -32,6 +32,7 @@
 #include "src/ft.h"
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
+#include "src/band.h"
 =

 struct ft_sm {
 	struct auth_proto ap;
@@ -273,6 +274,22 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		memcpy(ft_info.anonce, hs->anonce, 32);
 		memcpy(ft_info.snonce, hs->snonce, 32);
 =

+		/*
+		 * IEEE 802.11-2020 Section 13.7.1 FT reassociation in an RSN
+		 *
+		 * "If dot11RSNAOperatingChannelValidationActivated is true and
+		 *  the FTO indicates OCVC capability, the target AP shall
+		 *  ensure that OCI subelement of the FTE matches by ensuring
+		 *  that all of the following are true:
+		 *      - OCI subelement is present
+		 *      - Channel information in the OCI matches current
+		 *        operating channel parameters (see 12.2.9)"
+		 */
+		if (hs->supplicant_ocvc && hs->chandef) {
+			oci_from_chandef(hs->chandef, ft_info.oci);
+			ft_info.oci_present =3D true;
+		}
+
 		fte =3D alloca(256);
 		ie_build_fast_bss_transition(&ft_info, kck_len, fte);
 =

-- =

2.31.1

--===============1700750956773413352==--

