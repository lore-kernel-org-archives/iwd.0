Content-Type: multipart/mixed; boundary="===============5325025538652083175=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/2] netdev: add check for running work item in
 netdev_disconnect
Date: Mon, 05 Apr 2021 15:18:35 -0700
Message-ID: <20210405221836.1049804-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5325025538652083175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The send_disconnect flag was being improperly set based only
on connect_cmd_id being zero. This does not take into account
the case of CMD_CONNECT having finished but not EAPoL. In this
case we do need to send a disconnect.
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index e7ffb635..0e517468 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3214,7 +3214,8 @@ int netdev_disconnect(struct netdev *netdev,
 		if (netdev->connect_cmd_id) {
 			l_genl_family_cancel(nl80211, netdev->connect_cmd_id);
 			netdev->connect_cmd_id =3D 0;
-		} else
+		} else if (!wiphy_radio_work_is_running(netdev->wiphy,
+							netdev->work.id))
 			send_disconnect =3D false;
 =

 		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-- =

2.26.2

--===============5325025538652083175==--

