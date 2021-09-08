Content-Type: multipart/mixed; boundary="===============3049489435133313083=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] netdev: handle non-fatal auth-proto returns
Date: Wed, 08 Sep 2021 11:19:03 -0700
Message-ID: <20210908181904.84594-6-prestwoj@gmail.com>
In-Reply-To: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3049489435133313083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds -EBADMSG/-ENOMSG to returns which won't result in
a deauth/failed connection.
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7909c37e..8bbd5abb 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2715,7 +2715,8 @@ static void netdev_authenticate_event(struct l_genl_m=
sg *msg,
 		status_code =3D L_CPU_TO_LE16(auth->status);
 =

 		ret =3D auth_proto_rx_authenticate(netdev->ap, frame, frame_len);
-		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN)
+		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN || ret =3D=3D -EBADMSG ||
+						ret =3D=3D -ENOMSG)
 			return;
 		else if (ret > 0)
 			status_code =3D (uint16_t)ret;
-- =

2.31.1

--===============3049489435133313083==--

