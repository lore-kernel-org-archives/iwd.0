Content-Type: multipart/mixed; boundary="===============4570281625706000456=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/8] netdev: Add new iftype change event
Date: Tue, 20 Apr 2021 11:35:16 -0500
Message-ID: <20210420163519.12375-5-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4570281625706000456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 3 +++
 src/netdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 4208deea35fa..a524a9feb88c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4933,6 +4933,9 @@ static void netdev_set_interface_event(struct l_genl_=
msg *msg,
 	frame_watch_wdev_remove(wdev_id);
 =

 	netdev_setup_interface(netdev);
+
+	WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
+				netdev, NETDEV_WATCH_EVENT_IFTYPE_CHANGE);
 }
 =

 static void netdev_config_notify(struct l_genl_msg *msg, void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 7b321bfb5bcc..0e09ae698260 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -57,6 +57,7 @@ enum netdev_watch_event {
 	NETDEV_WATCH_EVENT_DOWN,
 	NETDEV_WATCH_EVENT_NAME_CHANGE,
 	NETDEV_WATCH_EVENT_ADDRESS_CHANGE,
+	NETDEV_WATCH_EVENT_IFTYPE_CHANGE,
 };
 =

 /* Mirror definitions from nl80211.h to make conversions simpler */
-- =

2.26.3

--===============4570281625706000456==--

