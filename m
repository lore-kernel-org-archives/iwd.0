Content-Type: multipart/mixed; boundary="===============1312279728539519034=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 1/4] netdev: better handle disconnect after FW scan
Date: Fri, 02 Apr 2021 15:06:14 -0700
Message-ID: <20210402220617.937790-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1312279728539519034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This should have been updated along with the connect and roam
event separation. Since netdev_connect_event is not being
re-used for CMD_ROAM the comment did not make sense anymore.
Still, there needs to be a check to ensure we were not disconnected
while waiting for GET_SCAN to come back.
---
 src/netdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 9f26ce68..db7f6bbc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4099,12 +4099,10 @@ static bool netdev_get_fw_scan_cb(int err, struct l=
_queue *bss_list,
 	struct scan_bss *bss =3D NULL;
 =

 	/*
-	 * If there was a failure in netdev_connect_event this would reset
-	 * the connect state (netdev_connect_free) causing the sm to be freed.
-	 * In this case we should just ignore this and allow the disconnect
-	 * logic to continue.
+	 * If we happened to be disconnected prior to  GET_SCAN coming back
+	 * just bail out now. This disconnect should already have been handled.
 	 */
-	if (!netdev->sm)
+	if (!netdev->connected)
 		return false;
 =

 	if (err < 0) {
-- =

2.26.2

--===============1312279728539519034==--

