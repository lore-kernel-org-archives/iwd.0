Content-Type: multipart/mixed; boundary="===============6059882981724354612=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 08/11] band: keep 6GHz frequencies out of 40mhz special case
Date: Fri, 25 Feb 2022 09:58:07 -0800
Message-ID: <20220225175810.2914413-8-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============6059882981724354612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no 40MHz upper/lower concept for 6GHz so avoid this special
handling.
---
 src/band.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/band.c b/src/band.c
index 87b70d42..984bc15d 100644
--- a/src/band.c
+++ b/src/band.c
@@ -902,8 +902,12 @@ int oci_verify(const uint8_t oci[static 3], const stru=
ct band_chandef *own)
 	 * on 40 Mhz channels.  If the STA is operating on 40 Mhz while the
 	 * peer is operating on 80 or 160 Mhz wide channels, then only the
 	 * primary channel validation is performed
+	 *
+	 * With 6GHz operating classes there is no concept of upper/lower 40mhz
+	 * channels, therefore this special handling list not needed.
 	 */
-	if (own_bandwidth =3D=3D 40 && oci_bandwidth =3D=3D 40) {
+	if (own_bandwidth =3D=3D 40 && oci_bandwidth =3D=3D 40 &&
+						info->operating_class < 131) {
 		uint32_t behavior;
 =

 		/*
-- =

2.34.1

--===============6059882981724354612==--

