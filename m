Content-Type: multipart/mixed; boundary="===============4543977371142348211=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: do not flush scan results
Date: Thu, 04 Feb 2021 15:03:18 -0800
Message-ID: <20210204230319.237085-2-prestwoj@gmail.com>
In-Reply-To: <20210204230319.237085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4543977371142348211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This causes issuse with CMD_AUTHENTICATE based protocols as
flushing removes the BSS's from the kernel which CMD_AUTHENTICATE
cannot handle as CMD_CONNECT does.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 06c4d75e..1f59e270 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1095,7 +1095,7 @@ static uint32_t station_scan_trigger(struct station *=
station,
 	struct scan_parameters params;
 =

 	memset(&params, 0, sizeof(params));
-	params.flush =3D true;
+	params.flush =3D false;
 	params.freqs =3D freqs;
 =

 	if (wiphy_can_randomize_mac_addr(station->wiphy) ||
-- =

2.26.2

--===============4543977371142348211==--

