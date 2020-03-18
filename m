Content-Type: multipart/mixed; boundary="===============5834174619995456271=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/12] watchlist: Allow watch CBs to call watchlist_destroy
Date: Wed, 18 Mar 2020 15:45:27 +0100
Message-ID: <20200318144531.30613-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5834174619995456271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If during WATCHLIST_NOTIFY{,_MATCHES,_NO_ARGS} one of the watch
notify callback triggers a call to watchlist_destroy, give up calling
remaining watches and destroy the watchlist without crashing.  This is
useful in frame-xchg.c (P2P use case) where a frame watch may trigger
a move to a new state after receiving a specific frame, and remove one
group of frame watches (including its watchlist) to create a different
group.
---
 src/watchlist.c |  5 +++++
 src/watchlist.h | 22 ++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/watchlist.c b/src/watchlist.c
index 4f4d8259..a14476bd 100644
--- a/src/watchlist.c
+++ b/src/watchlist.c
@@ -127,6 +127,11 @@ static void __watchlist_clear(struct watchlist *watchl=
ist)
 =

 void watchlist_destroy(struct watchlist *watchlist)
 {
+	if (watchlist->in_notify) {
+		watchlist->pending_destroy =3D true;
+		return;
+	}
+
 	__watchlist_clear(watchlist);
 	l_queue_destroy(watchlist->items, NULL);
 	watchlist->items =3D NULL;
diff --git a/src/watchlist.h b/src/watchlist.h
index cd408ac8..c3632859 100644
--- a/src/watchlist.h
+++ b/src/watchlist.h
@@ -38,6 +38,7 @@ struct watchlist {
 	struct l_queue *items;
 	bool in_notify : 1;
 	bool stale_items : 1;
+	bool pending_destroy : 1;
 	const struct watchlist_ops *ops;
 };
 =

@@ -69,9 +70,13 @@ void __watchlist_prune_stale(struct watchlist *watchlist=
);
 			if (item->id =3D=3D 0)				\
 				continue;				\
 			t(args, item->notify_data);			\
+			if ((watchlist)->pending_destroy)		\
+				break;					\
 		}							\
 		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->stale_items)				\
+		if ((watchlist)->pending_destroy)			\
+			watchlist_destroy(watchlist);			\
+		else if ((watchlist)->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)							\
 =

@@ -91,9 +96,14 @@ void __watchlist_prune_stale(struct watchlist *watchlist=
);
 				continue;				\
 									\
 			t(args, item->notify_data);			\
+									\
+			if ((watchlist)->pending_destroy)		\
+				break;					\
 		}							\
 		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->stale_items)				\
+		if ((watchlist)->pending_destroy)			\
+			watchlist_destroy(watchlist);			\
+		else if ((watchlist)->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)
 =

@@ -108,9 +118,13 @@ void __watchlist_prune_stale(struct watchlist *watchli=
st);
 			type t =3D item->notify;				\
 			if (item->id =3D=3D 0)				\
 				continue;				\
-			t(item->notify_data);			\
+			t(item->notify_data);				\
+			if ((watchlist)->pending_destroy)		\
+				break;					\
 		}							\
 		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->stale_items)				\
+		if ((watchlist)->pending_destroy)			\
+			watchlist_destroy(watchlist);			\
+		else if ((watchlist)->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)
-- =

2.20.1

--===============5834174619995456271==--

