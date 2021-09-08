Content-Type: multipart/mixed; boundary="===============8946727269214399036=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/5] mpdu: add MMPDU_STATUS_CODE_SAE_PK
Date: Wed, 08 Sep 2021 14:31:59 -0700
Message-ID: <20210908213201.97115-3-prestwoj@gmail.com>
In-Reply-To: <20210908213201.97115-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8946727269214399036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mpdu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mpdu.h b/src/mpdu.h
index 98c264f9..36fe2470 100644
--- a/src/mpdu.h
+++ b/src/mpdu.h
@@ -232,6 +232,7 @@ enum mmpdu_status_code {
 	MMPDU_STATUS_CODE_RESTRICT_AUTH_GDB =3D 106,
 	MMPDU_STATUS_CODE_AUTHORIZATION_DEENABLED =3D 107,
 	MMPDU_STATUS_CODE_SAE_HASH_TO_ELEMENT =3D 126,
+	MMPDU_STATUS_CODE_SAE_PK =3D 127,
 };
 =

 /* 802.11, Section 8.2.4.1.1, Figure 8-2 */
-- =

2.31.1

--===============8946727269214399036==--

