Content-Type: multipart/mixed; boundary="===============2027169014254799489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/8] frame-xchg: iftype changes to be managed by netdev
Date: Tue, 20 Apr 2021 11:35:13 -0500
Message-ID: <20210420163519.12375-2-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2027169014254799489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since netdev now keeps track of iftype changes, let it call
frame_watch_wdev_remove on netdevs that it manages to clear frame
registrations that should be cleared due to an iftype change.

Note that P2P_DEVICE wdevs are not managed by any netdev object, but
since their iftype cannot be changed, they should not be affected
by this change.
---
 src/frame-xchg.c | 7 +------
 src/netdev.c     | 3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index e01747326fc5..85f55f2bf941 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1312,7 +1312,6 @@ static void frame_xchg_config_notify(struct l_genl_ms=
g *msg, void *user_data)
 		if (!wdev) {
 			wdev =3D l_new(struct wdev_info, 1);
 			wdev->id =3D wdev_id;
-			wdev->iftype =3D iftype;
 =

 			if (!wdevs)
 				wdevs =3D l_queue_new();
@@ -1321,11 +1320,7 @@ static void frame_xchg_config_notify(struct l_genl_m=
sg *msg, void *user_data)
 			break;
 		}
 =

-		if (wdev->iftype !=3D iftype) {
-			wdev->iftype =3D iftype;
-			frame_watch_wdev_remove(wdev_id);
-		}
-
+		wdev->iftype =3D iftype;
 		break;
 =

 	case NL80211_CMD_DEL_INTERFACE:
diff --git a/src/netdev.c b/src/netdev.c
index 05e22148e495..f4877bbd6fbb 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4871,8 +4871,10 @@ static void netdev_set_interface_event(struct l_genl=
_msg *msg,
 							struct netdev *netdev)
 {
 	uint32_t iftype;
+	uint64_t wdev_id;
 =

 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFTYPE, &iftype,
+					NL80211_ATTR_WDEV, &wdev_id,
 					NL80211_ATTR_UNSPEC) < 0)
 		return;
 =

@@ -4883,6 +4885,7 @@ static void netdev_set_interface_event(struct l_genl_=
msg *msg,
 			netdev_iftype_to_string(netdev->type),
 			netdev_iftype_to_string(iftype));
 	netdev->type =3D iftype;
+	frame_watch_wdev_remove(wdev_id);
 =

 	/* Set RSSI threshold for CQM notifications */
 	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
-- =

2.26.3

--===============2027169014254799489==--

