Content-Type: multipart/mixed; boundary="===============8828254678824717973=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: set connected to false in netdev_reassociate
Date: Fri, 30 Apr 2021 14:15:26 -0700
Message-ID: <20210430211526.291301-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8828254678824717973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 1fe5070 added a workaround for drivers which may send the
connect event prior to the connect callback/ack. This caused IWD
to fail to start eapol if reassociation was used due to
netdev_reassociate never setting netdev->connected =3D false.

netdev_reassociate uses the same code path as normal connections,
but when the connect callback came in connected was already set
to true which then prevents eapol from being registered. Then,
once the connect event comes in, there is no frame watch for
eapol and IWD doesn't respond to any handshake frames.
---
 src/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netdev.c b/src/netdev.c
index 7a3f15e3..4fbe813a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3449,6 +3449,7 @@ int netdev_reassociate(struct netdev *netdev, struct =
scan_bss *target_bss,
 =

 	netdev->associated =3D false;
 	netdev->operational =3D false;
+	netdev->connected =3D false;
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.26.2

--===============8828254678824717973==--

