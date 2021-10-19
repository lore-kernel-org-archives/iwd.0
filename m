Content-Type: multipart/mixed; boundary="===============3195692729183611914=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: don't enable OCV unless MFPC is supported
Date: Tue, 19 Oct 2021 13:11:17 -0700
Message-ID: <20211019201117.564803-1-prestwoj@gmail.com>

--===============3195692729183611914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 1b9215d8..a972b4fa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1087,7 +1087,7 @@ build_ie:
 					&disable_ocv))
 		disable_ocv =3D false;
 =

-	info.ocvc =3D !disable_ocv && bss_info.ocvc;
+	info.ocvc =3D !disable_ocv && bss_info.ocvc && info.mfpc;
 =

 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- =

2.31.1

--===============3195692729183611914==--

