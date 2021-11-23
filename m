Content-Type: multipart/mixed; boundary="===============4427015120041668327=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] netdev: only set in_reassoc if using an auth-proto
Date: Tue, 23 Nov 2021 09:37:38 -0800
Message-ID: <20211123173739.3600218-1-prestwoj@gmail.com>

--===============4427015120041668327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel strangely sends a disconnect event when using auth/assoc
commands, but does not for CMD_CONNECT (only deauth). This wasn't
observed and IWD assumed a disconnect event comes unconditionally.
Because of this in_reassoc is checked in netdev_disconnect_event
and the event is ignored if set.

When CMD_CONNECT is used to reassociate this would cause disconnect
events to be ignored when they should not be, preventing IWD from
going into a disconnected state post-roam.

Now, in_reassoc is only set if an auth-proto is used.
---
 src/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 96e473a9..34ace286 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4144,13 +4144,14 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->connected =3D false;
-	netdev->in_reassoc =3D true;
 =

 	netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
 					event_filter, cb, user_data);
 =

-	if (netdev->ap)
+	if (netdev->ap) {
+		netdev->in_reassoc =3D true;
 		memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+	}
 =

 	netdev_rssi_polling_update(netdev);
 =

-- =

2.31.1

--===============4427015120041668327==--

