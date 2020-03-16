Content-Type: multipart/mixed; boundary="===============1488250288989083119=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] netdev: fix auth protocols not setting ->connected
Date: Mon, 16 Mar 2020 12:22:42 -0700
Message-ID: <20200316192242.15588-4-prestwoj@gmail.com>
In-Reply-To: <20200316192242.15588-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1488250288989083119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This causes netdev to think another supplicant is running when it
recieves a connect event due to an auth protocol running.
---
 src/netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index a5071471..c11a483f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2413,7 +2413,9 @@ static int netdev_connect_common(struct netdev *netde=
v,
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
 =

-	auth_proto_start(netdev->ap);
+	/* set connected since the auth protocols cannot do so internally */
+	if (netdev->ap && auth_proto_start(netdev->ap))
+		netdev->connected =3D true;
 =

 	return 0;
 }
-- =

2.21.1

--===============1488250288989083119==--

