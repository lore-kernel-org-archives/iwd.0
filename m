Content-Type: multipart/mixed; boundary="===============8510116170382012075=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] netdev: only call connect_ok in station/p2p_client mode
Date: Tue, 27 Apr 2021 16:25:05 -0700
Message-ID: <20210427232505.96086-2-prestwoj@gmail.com>
In-Reply-To: <20210427232505.96086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8510116170382012075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

netdev_connect_ok is only for station/p2p_client modes but AP
also ends up on the same code path. Check the iftype before
calling netdev_connect_ok.
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 252ae78a..0feb9e66 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1337,7 +1337,8 @@ static void try_handshake_complete(struct netdev_hand=
shake_state *nhs)
 		nhs->complete =3D true;
 		handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE);
 =

-		netdev_connect_ok(nhs->netdev);
+		if (nhs->netdev->type =3D=3D NL80211_IFTYPE_STATION)
+			netdev_connect_ok(nhs->netdev);
 	}
 }
 =

-- =

2.26.2

--===============8510116170382012075==--

