Content-Type: multipart/mixed; boundary="===============2047051797995856857=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/13] ie: add WFA OWE Transition element type
Date: Wed, 15 Sep 2021 10:36:12 -0700
Message-ID: <20210915173624.11917-1-prestwoj@gmail.com>

--===============2047051797995856857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ie.h b/src/ie.h
index a2fdc2e3..4e1c5433 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -290,6 +290,7 @@ enum ie_type {
 enum ie_vendor_wfa_oi_type {
 	IE_WFA_OI_HS20_INDICATION =3D 0x10,
 	IE_WFA_OI_OSEN =3D 0x12,
+	IE_WFA_OI_OWE_TRANSITION =3D 0x1c,
 	IE_WFA_OI_ROAMING_SELECTION =3D 0x1d,
 };
 =

-- =

2.31.1

--===============2047051797995856857==--

