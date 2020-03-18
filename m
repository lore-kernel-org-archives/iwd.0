Content-Type: multipart/mixed; boundary="===============7606124172496224284=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/12] frame-xchg: Allow calling frame_xchg_stop from the
 callback
Date: Wed, 18 Mar 2020 15:45:25 +0100
Message-ID: <20200318144531.30613-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7606124172496224284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't crash if the user calls frame_xchg_stop(wdev) from inside the
frame exchange's final callback.  That call is going to be redundant but
it's convenient to do this inside a cleanup function for a given wdev
without having to check whether any frame exchange was actually running.
---
 src/frame-xchg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 7b45ebb6..7b66cb6d 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1268,9 +1268,10 @@ error:
 static void frame_xchg_exit(void)
 {
 	struct l_queue *groups =3D watch_groups;
+	struct l_queue *xchgs =3D frame_xchgs;
 =

-	l_queue_destroy(frame_xchgs, frame_xchg_cancel);
 	frame_xchgs =3D NULL;
+	l_queue_destroy(xchgs, frame_xchg_cancel);
 =

 	watch_groups =3D NULL;
 	l_queue_destroy(groups, frame_watch_group_destroy);
-- =

2.20.1

--===============7606124172496224284==--

