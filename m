Content-Type: multipart/mixed; boundary="===============2020207447956838386=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 07/12] station: set extended key capability
Date: Mon, 04 Oct 2021 09:48:57 -0700
Message-ID: <20211004164902.2274318-7-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============2020207447956838386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If wiphy and the AP suppor it, set the Extended Key ID capability
bit in the RSN info and set the handshake to use it.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index f12cdde5..5605142d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1087,6 +1087,12 @@ build_ie:
 =

 	info.ocvc =3D !disable_ocv;
 =

+	/* Extended Key IDs can only be used if supported by both AP and STA */
+	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id) {
+		info.extended_key_id =3D true;
+		hs->ext_key_id_capable =3D true;
+	}
+
 	/* RSN takes priority */
 	if (bss->rsne) {
 		ap_ie =3D bss->rsne;
-- =

2.31.1

--===============2020207447956838386==--

