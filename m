Content-Type: multipart/mixed; boundary="===============5435276361909254519=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] rrm: fix invalid IE tag when rejecting request
Date: Fri, 15 Nov 2019 09:01:03 -0800
Message-ID: <20191115170103.26164-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5435276361909254519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rejection report actually contained a request IE, not a report IE
---
 src/rrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rrm.c b/src/rrm.c
index b4c5655f..e451448b 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -196,7 +196,7 @@ static void rrm_reject_measurement_request(struct rrm_s=
tate *rrm,
 	frame[0] =3D 0x05; /* Category: Radio Measurement */
 	frame[1] =3D 0x01; /* Action: Radio Measurement Report */
 	frame[2] =3D info->dialog_token;
-	frame[3] =3D IE_TYPE_MEASUREMENT_REQUEST;
+	frame[3] =3D IE_TYPE_MEASUREMENT_REPORT;
 	frame[4] =3D 3;
 	frame[5] =3D info->mtoken;
 	frame[6] =3D mode;
-- =

2.17.1

--===============5435276361909254519==--

