Content-Type: multipart/mixed; boundary="===============8944061847819882074=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] netdev: print error if CMD_ASSOCIATE fails
Date: Tue, 07 Sep 2021 14:14:46 -0700
Message-ID: <20210907211450.27270-5-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8944061847819882074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index a5d1b8ed..b356cb01 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2712,9 +2712,10 @@ static void netdev_new_scan_results_event(struct l_g=
enl_msg *msg,
 static void netdev_assoc_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
 =

-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("Error sending CMD_ASSOCIATE");
+	if (err < 0) {
+		l_error("Error sending CMD_ASSOCIATE (%d)", err);
 =

 		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
-- =

2.31.1

--===============8944061847819882074==--

