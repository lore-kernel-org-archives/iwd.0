Content-Type: multipart/mixed; boundary="===============1577178322019016515=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] netdev: only call connect_ok in station mode
Date: Tue, 27 Apr 2021 16:08:51 -0700
Message-ID: <20210427230852.94957-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1577178322019016515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

netdev_connect_ok is only for station mode but AP also
ends up on the same code path. Check the iftype before
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

--===============1577178322019016515==--

