Content-Type: multipart/mixed; boundary="===============3559367798144616983=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/9] eapol: send OCI in handshake 2/4
Date: Mon, 27 Sep 2021 10:03:58 -0700
Message-ID: <20210927170404.1292107-3-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============3559367798144616983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 370ead7e..8498fdb6 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -43,6 +43,7 @@
 #include "src/watchlist.h"
 #include "src/erp.h"
 #include "src/iwd.h"
+#include "src/band.h"
 =

 static struct l_queue *state_machines;
 static struct l_queue *preauths;
@@ -1244,6 +1245,21 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm =
*sm,
 		ies[ies_len++] =3D 0x01;
 	}
 =

+	/*
+	 * IEEE 802.11-2020 Section 12.7.6.3
+	 * "Additionally, contains an OCI KDE when
+	 *  dot11RSNAOperatingChannelValidationActivated is true on the
+	 *  Supplicant."
+	 */
+	if (sm->handshake->supplicant_ocvc && sm->handshake->chandef) {
+		ies[ies_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
+		ies[ies_len++] =3D 4 + 3;
+		l_put_be32(HANDSHAKE_KDE_OCI, ies + ies_len);
+		ies_len +=3D 4;
+		oci_from_chandef(sm->handshake->chandef, ies + ies_len++);
+		ies_len +=3D 3;
+	}
+
 	/*
 	 * 802.11-2020, Section 12.7.6.3:
 	 * "The RSNXE that the Supplicant sent in its (Re)Association Request
-- =

2.31.1

--===============3559367798144616983==--

