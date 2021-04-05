Content-Type: multipart/mixed; boundary="===============2486451099539203341=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: fix spelling error
Date: Mon, 05 Apr 2021 11:44:02 -0700
Message-ID: <20210405184402.1024641-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2486451099539203341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index e7ffb635..18f041b3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2338,7 +2338,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 		} else if (ret =3D=3D -EAGAIN) {
 			/*
 			 * Here to support OWE retries. OWE will retry
-			 * internally, but a connect even will still be emitted.
+			 * internally, but a connect event will still be emitted
 			 */
 			netdev->ignore_connect_event =3D true;
 			return;
-- =

2.26.2

--===============2486451099539203341==--

