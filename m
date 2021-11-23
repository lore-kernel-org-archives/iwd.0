Content-Type: multipart/mixed; boundary="===============5142529383988418038=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/2] netdev: always honor disconnect events if issued by AP
Date: Tue, 23 Nov 2021 10:17:31 -0800
Message-ID: <20211123181732.3617090-1-prestwoj@gmail.com>

--===============5142529383988418038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The disconnect event handler was mistakenly bailing out if FT or
reassociation was going on. This was done because a disconnect
event is sent by the kernel when CMD_AUTH/CMD_ASSOC is used.

The problem is an AP could also disconnect IWD which should never
be ignored.

To fix this always parse the disconnect event and, if issued by
the AP, always notify watchers of the disconnect.
---
 src/netdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 96e473a9..e35a8b82 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1165,8 +1165,7 @@ static void netdev_disconnect_event(struct l_genl_msg=
 *msg,
 =

 	l_debug("");
 =

-	if (!netdev->connected || netdev->disconnect_cmd_id > 0 ||
-			netdev->in_ft || netdev->in_reassoc)
+	if (!netdev->connected || netdev->disconnect_cmd_id > 0)
 		return;
 =

 	if (!l_genl_attr_init(&attr, msg)) {
@@ -1190,6 +1189,13 @@ static void netdev_disconnect_event(struct l_genl_ms=
g *msg,
 		}
 	}
 =

+	/*
+	 * Only ignore this event if issued by the kernel since this is
+	 * normal when using CMD_AUTH/ASSOC.
+	 */
+	if (!disconnect_by_ap && (netdev->in_ft || netdev->in_reassoc))
+		return;
+
 	l_info("Received Deauthentication event, reason: %hu, from_ap: %s",
 			reason_code, disconnect_by_ap ? "true" : "false");
 =

@@ -3171,6 +3177,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 =

 	if (!netdev->ap) {
 		netdev->associated =3D true;
+		netdev->in_reassoc =3D false;
 		return;
 	}
 =

-- =

2.31.1

--===============5142529383988418038==--

