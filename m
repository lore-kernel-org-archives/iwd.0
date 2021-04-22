Content-Type: multipart/mixed; boundary="===============1754786800300862563=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] netdev: print error number on CMD_FRAME failure
Date: Thu, 22 Apr 2021 10:37:45 -0700
Message-ID: <20210422173746.2324850-6-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1754786800300862563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index bd002ed9..28076244 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3676,9 +3676,10 @@ static void prepare_ft(struct netdev *netdev, struct=
 scan_bss *target_bss)
 static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
 =

-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("Could not send CMD_FRAME");
+	if (err < 0) {
+		l_error("Could not send CMD_FRAME (%d)", err);
 		netdev_connect_failed(netdev,
 					NETDEV_RESULT_AUTHENTICATION_FAILED,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
-- =

2.26.2

--===============1754786800300862563==--

