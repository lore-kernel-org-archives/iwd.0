Content-Type: multipart/mixed; boundary="===============6928139330422915866=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] station: record dependency on netconfig module
Date: Thu, 03 Oct 2019 11:50:31 -0500
Message-ID: <20191003115031.GC13162@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6928139330422915866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The netconfig module must be initialized (netconfig_list, for example)
before station module can be used, record this to ensure that happens.

---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 0666287..eed3a7f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3190,3 +3190,4 @@ static void station_exit(void)
 }
 =

 IWD_MODULE(station, station_init, station_exit)
+IWD_MODULE_DEPENDS(station, netconfig)
-- =

2.23.GIT

--===============6928139330422915866==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVHUDJWQTNxVlpm
Y0hzWG9yNjdEcVFTU0FuUUlGQWwyV0p0Y0FDZ2tRNjdEcVFTU0EKblFLOUZ4QUFoWmtZbTc2MGN2
VEV0bVNOZXl6ekJsbkQ5QU9abk15dG01Y3RvS0NSemYxLzZmWDlwYVU2d3BnRgoyT243YUtkTDNE
THpoNTBVWnJTS0dvd0dFM0VjSXIxQ3ZXcXdIcTBuRWpxZmp0M0RBS0NsVlJCU1VtMGJDOWFKCjB4
UzF2SUNBY3Y5TCtQY21ZN3VMT2FGdGF5VlNVYWt2UWY2SmFtTHg2YzBkd3l1YUlJTE5JY0pqSG1F
UDVKcEoKOTFkRnRrL0UxRnZwRGVUK29keFd2NFVDaDJtd05ML2luQVVIcVd5by9NTjFBTEdOa0VS
WllXeWdXcDdvZFlEdwpYWUZKdGdUZWxPSFcrK2lvUEdiQkI2UEFKL2kwQm05bDVFV2d3ajB2dHpq
MFJQOUVKWTB6T3lWVnZvN0xMcWsvCkhRcThPdFIzRytWTTR6ZG50MHArSjdsQjQrd1lHc2tIYU5q
QWR1VmxhV0NYK1d1amcybDBDanhkRE5UWHpsQm0KZ2JudXQ5RjE5Tk5RVjBVOXhZd0llNEFQcmxX
alZCVWNaS1FzN2c2S01MTUIzcXR1QmdEamZwU1hwMUdwRmhweQpMc0hYWWloY1B3bFdhaUFIakZw
V0lvWXhPOEJtNDM2ZzROdEY5MzA4VkIvQk81d1ZodU9pS3FXMzM2bXNRRkxPCmhQbHpjM0pYalpy
bWlZTi9STndlVFhROHdjR3N6TXc5bFA3ZjJzRC9jY1MxUzRHSUcyUGZHaldhZVdSZTJNRVAKMTFh
YmZMMVVjUVNoOUZYcTJ4N0JUbW1KTmFYOXBUamtDUWRMQ1htbEVrb3o0a1UxOE1lc3NoK0ZLTEU5
ZUNIegp0U1V6eFExc0ZwUUgvcjUvNS9VOEJCK3Jnc0FScGlTaUZBTFpmTUdIZEMwaXNuWXkyV2c9
Cj1HaktrCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============6928139330422915866==--

