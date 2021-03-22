Content-Type: multipart/mixed; boundary="===============5079865498626010503=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: prevent crash with open networks
Date: Mon, 22 Mar 2021 15:20:52 -0700
Message-ID: <20210322222052.424191-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5079865498626010503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SAE offload changes assumed a handshake object would
exist in netdev, which is not the case for open networks.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 0cd139c2..8d3f4a08 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1213,7 +1213,7 @@ static void netdev_connect_ok(struct netdev *netdev)
 	}
 =

 	/* Allow station to sync the PSK to disk */
-	if (netdev->handshake->offload)
+	if (netdev->handshake && netdev->handshake->offload)
 		handshake_event(netdev->handshake,
 				HANDSHAKE_EVENT_SETTING_KEYS);
 =

-- =

2.26.2

--===============5079865498626010503==--

