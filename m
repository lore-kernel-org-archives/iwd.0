Content-Type: multipart/mixed; boundary="===============3048367124269508299=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] watchlist: Save the watchlist pointer in
 WATCHLIST_NOTIFY_*
Date: Thu, 30 Apr 2020 15:48:44 +0200
Message-ID: <20200430134847.62234-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200430134847.62234-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3048367124269508299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Save the value of the watchlist pointer at the beginning of the
WATCHLIST_NOTIFY_* macros as if it was a function.  This will fix a
frame-xchg.c scenario in which one of the watch callback removes the
frame watch group and the memory where the watchlist pointer was
becomes unallocated but the macro still needs to access it ones or
twice while it destroys the watchlist.  Another option would be for
the pointer to be copied in frame-xchg.c itself.
---
 src/watchlist.h | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/src/watchlist.h b/src/watchlist.h
index c3632859..7f5f557a 100644
--- a/src/watchlist.h
+++ b/src/watchlist.h
@@ -58,34 +58,36 @@ void watchlist_free(struct watchlist *watchlist);
 =

 void __watchlist_prune_stale(struct watchlist *watchlist);
 =

-#define WATCHLIST_NOTIFY(watchlist, type, args...)			\
+#define WATCHLIST_NOTIFY(list, type, args...)				\
 	do {								\
+		struct watchlist *watchlist =3D (list);			\
 		const struct l_queue_entry *entry =3D			\
-				l_queue_get_entries((watchlist)->items);\
+				l_queue_get_entries(watchlist->items);	\
 									\
-		(watchlist)->in_notify =3D true;				\
+		watchlist->in_notify =3D true;				\
 		for (; entry; entry =3D entry->next) {			\
 			struct watchlist_item *item =3D entry->data;	\
 			type t =3D item->notify;				\
 			if (item->id =3D=3D 0)				\
 				continue;				\
 			t(args, item->notify_data);			\
-			if ((watchlist)->pending_destroy)		\
+			if (watchlist->pending_destroy)			\
 				break;					\
 		}							\
-		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->pending_destroy)			\
+		watchlist->in_notify =3D false;				\
+		if (watchlist->pending_destroy)				\
 			watchlist_destroy(watchlist);			\
-		else if ((watchlist)->stale_items)			\
+		else if (watchlist->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)							\
 =

-#define WATCHLIST_NOTIFY_MATCHES(watchlist, match, match_data, type, args.=
..) \
+#define WATCHLIST_NOTIFY_MATCHES(list, match, match_data, type, args...) \
 	do {								\
+		struct watchlist *watchlist =3D (list);			\
 		const struct l_queue_entry *entry =3D			\
-				l_queue_get_entries((watchlist)->items);\
+				l_queue_get_entries(watchlist->items);	\
 									\
-		(watchlist)->in_notify =3D true;				\
+		watchlist->in_notify =3D true;				\
 		for (; entry; entry =3D entry->next) {			\
 			struct watchlist_item *item =3D entry->data;	\
 			type t =3D item->notify;				\
@@ -97,34 +99,35 @@ void __watchlist_prune_stale(struct watchlist *watchlis=
t);
 									\
 			t(args, item->notify_data);			\
 									\
-			if ((watchlist)->pending_destroy)		\
+			if (watchlist->pending_destroy)			\
 				break;					\
 		}							\
-		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->pending_destroy)			\
+		watchlist->in_notify =3D false;				\
+		if (watchlist->pending_destroy)				\
 			watchlist_destroy(watchlist);			\
-		else if ((watchlist)->stale_items)			\
+		else if (watchlist->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)
 =

-#define WATCHLIST_NOTIFY_NO_ARGS(watchlist, type)			\
+#define WATCHLIST_NOTIFY_NO_ARGS(list, type)				\
 	do {								\
+		struct watchlist *watchlist =3D (list);			\
 		const struct l_queue_entry *entry =3D			\
-				l_queue_get_entries((watchlist)->items);\
+				l_queue_get_entries(watchlist->items);	\
 									\
-		(watchlist)->in_notify =3D true;				\
+		watchlist->in_notify =3D true;				\
 		for (; entry; entry =3D entry->next) {			\
 			struct watchlist_item *item =3D entry->data;	\
 			type t =3D item->notify;				\
 			if (item->id =3D=3D 0)				\
 				continue;				\
 			t(item->notify_data);				\
-			if ((watchlist)->pending_destroy)		\
+			if (watchlist->pending_destroy)			\
 				break;					\
 		}							\
-		(watchlist)->in_notify =3D false;				\
-		if ((watchlist)->pending_destroy)			\
+		watchlist->in_notify =3D false;				\
+		if (watchlist->pending_destroy)				\
 			watchlist_destroy(watchlist);			\
-		else if ((watchlist)->stale_items)			\
+		else if (watchlist->stale_items)			\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)
-- =

2.25.1

--===============3048367124269508299==--

