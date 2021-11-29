Content-Type: multipart/mixed; boundary="===============4537580932345512555=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/6] ie: add DPP configurator connectivity element
Date: Mon, 29 Nov 2021 15:12:55 -0800
Message-ID: <20211129231300.108873-1-prestwoj@gmail.com>

--===============4537580932345512555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ie.h b/src/ie.h
index 685350d6..d460a7cc 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -292,6 +292,7 @@ enum ie_vendor_wfa_oi_type {
 	IE_WFA_OI_OSEN =3D 0x12,
 	IE_WFA_OI_OWE_TRANSITION =3D 0x1c,
 	IE_WFA_OI_ROAMING_SELECTION =3D 0x1d,
+	IE_WFA_OI_CONFIGURATOR_CONNECTIVITY =3D 0x1e,
 };
 =

 enum ie_advertisement_id {
-- =

2.31.1

--===============4537580932345512555==--

