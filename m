Content-Type: multipart/mixed; boundary="===============5206204407328526741=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] netdev: Power P2P interfaces up like other interfaces
Date: Wed, 20 Nov 2019 23:23:45 +0100
Message-ID: <20191120222346.7881-5-andrew.zaborowski@intel.com>
In-Reply-To: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5206204407328526741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After all we will want to power these iftypes up on init just like
station, etc.
---
 src/netdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index bdd9dc77..eb8a7ce8 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4315,11 +4315,6 @@ static void netdev_getlink_cb(int error, uint16_t ty=
pe, const void *data,
 =

 	netdev_newlink_notify(ifi, bytes);
 =

-	/* Don't do anything automatically for P2P interfaces */
-	if (netdev->type =3D=3D NL80211_IFTYPE_P2P_CLIENT ||
-			netdev->type =3D=3D NL80211_IFTYPE_P2P_GO)
-		return;
-
 	/*
 	 * If the interface is UP, reset it to ensure a clean state.
 	 * Otherwise, if we need to set a random mac, do so.  If not, just
-- =

2.20.1

--===============5206204407328526741==--

