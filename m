Content-Type: multipart/mixed; boundary="===============0195065234530940079=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/13] frame-xchg: Improve search for current frame in MLME
 notify
Date: Fri, 31 Jul 2020 03:31:25 +0200
Message-ID: <20200731013136.65057-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0195065234530940079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since there may now be multiple frames-xchg record for each wdev, when
we receive the TX Status event, make sure we find the record who's radio
work has started, as indicated by fx->retry_cnt > 0.  Otherwise we're
relying on the ordering of the frames in the "frame_xchgs" queue and
constant priority.
---
 src/frame-xchg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index dfe08f6a..8abcc8a7 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1057,12 +1057,12 @@ static void frame_xchg_resp_cb(const struct mmpdu_h=
eader *mpdu,
 	frame_xchg_resp_handle(mpdu, body, body_len, rssi, user_data);
 }
 =

-static bool frame_xchg_match(const void *a, const void *b)
+static bool frame_xchg_match_running(const void *a, const void *b)
 {
 	const struct frame_xchg_data *fx =3D a;
 	const uint64_t *wdev_id =3D b;
 =

-	return fx->wdev_id =3D=3D *wdev_id;
+	return fx->retry_cnt > 0 && fx->wdev_id =3D=3D *wdev_id;
 }
 =

 /*
@@ -1225,7 +1225,8 @@ static void frame_xchg_mlme_notify(struct l_genl_msg =
*msg, void *user_data)
 =

 		l_debug("Received %s", ack ? "an ACK" : "no ACK");
 =

-		fx =3D l_queue_find(frame_xchgs, frame_xchg_match, &wdev_id);
+		fx =3D l_queue_find(frame_xchgs, frame_xchg_match_running,
+					&wdev_id);
 		if (!fx)
 			return;
 =

-- =

2.25.1

--===============0195065234530940079==--

