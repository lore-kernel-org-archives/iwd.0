Content-Type: multipart/mixed; boundary="===============3912774604518644201=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] netdev: handle non-fatal auth-proto returns
Date: Wed, 08 Sep 2021 13:48:04 -0700
Message-ID: <20210908204805.92005-3-prestwoj@gmail.com>
In-Reply-To: <20210908204805.92005-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3912774604518644201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds -EBADMSG/-ENOMSG to be handled specially by allowing the
frame to be dropped, similar to 0 or -EAGAIN. The difference though
is that a non-zero authenticate status will result in the kernel
not re-transmitting which ultimately could leave IWD in a connecting
state with no way of leaving. Because of this we handle a non-zero
status for these two returns as a failed connection.
---
 src/netdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

v3:
 * Only drop the message if the status was successful.

diff --git a/src/netdev.c b/src/netdev.c
index 7909c37e..fc4613e6 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2717,7 +2717,17 @@ static void netdev_authenticate_event(struct l_genl_=
msg *msg,
 		ret =3D auth_proto_rx_authenticate(netdev->ap, frame, frame_len);
 		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN)
 			return;
-		else if (ret > 0)
+		else if (ret =3D=3D -EBADMSG || ret =3D=3D -ENOMSG) {
+			/*
+			 * Only drop if the status is success. Otherwise
+			 * dropping the message here would prevent the kernel
+			 * from re-transmitting, leaving IWD in this connecting
+			 * state. If this happens the only option is to fail the
+			 * connection here.
+			 */
+			if (status_code =3D=3D 0)
+				return;
+		} else if (ret > 0)
 			status_code =3D (uint16_t)ret;
 	}
 =

-- =

2.31.1

--===============3912774604518644201==--

