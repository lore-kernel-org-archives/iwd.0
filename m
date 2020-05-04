Content-Type: multipart/mixed; boundary="===============9161507354049810051=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] scan: remove useless debug print
Date: Mon, 04 May 2020 08:24:18 -0700
Message-ID: <20200504152420.27210-2-prestwoj@gmail.com>
In-Reply-To: <20200504152420.27210-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9161507354049810051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Further on in the function we still print that the scan was triggered.
---
 src/scan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index c3ae3f8b..718f7497 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -204,8 +204,6 @@ static void scan_request_triggered(struct l_genl_msg *m=
sg, void *userdata)
 	struct scan_request *sr =3D l_queue_peek_head(sc->requests);
 	int err;
 =

-	l_debug("");
-
 	sc->start_cmd_id =3D 0;
 =

 	err =3D l_genl_msg_get_error(msg);
-- =

2.21.1

--===============9161507354049810051==--

