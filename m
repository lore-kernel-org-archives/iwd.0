Content-Type: multipart/mixed; boundary="===============5944767964386423101=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] frame-xchg: Fix group removal inside frame callback
Date: Tue, 21 Jul 2020 02:45:39 +0200
Message-ID: <20200721004540.399351-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200721004540.399351-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5944767964386423101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a frame registered in a given group Id triggers a callback and that
callback ends up calling frame_watch_group_remove for that group Id,
that call will happen inside WATCHLIST_NOTIFY_MATCHES and will free the
memory used by the watchlist.  watchlist.h has protection against the
watchlist being "destroyed" inside WATCHLIST_NOTIFY_MATCHES, but not
against its memory being freed -- the memory where it stores the in_notify
and destroy_pending flags.  Free the group immediately after
WATCHLIST_NOTIFY_MATCHES to avoid reads/writes to those flags triggering
valgrind warnings.
---
 src/frame-xchg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index f07a4d8d..53bda4b4 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -231,6 +231,10 @@ static void frame_watch_unicast_notify(struct l_genl_m=
sg *msg, void *user_data)
 	WATCHLIST_NOTIFY_MATCHES(&group->watches, frame_watch_match_prefix,
 					&info, frame_watch_cb_t, mpdu,
 					info.body, info.body_len, rssi);
+
+	/* Has frame_watch_group_destroy been called inside a frame CB? */
+	if (group->watches.pending_destroy)
+		l_free(group);
 }
 =

 static void frame_watch_group_destroy(void *data)
@@ -244,7 +248,16 @@ static void frame_watch_group_destroy(void *data)
 	l_io_destroy(group->io);
 	l_queue_destroy(group->write_queue,
 			(l_queue_destroy_func_t) l_genl_msg_unref);
+
+	/*
+	 * We may be inside a frame notification but even then use
+	 * watchlist_destroy to prevent any more notifications from
+	 * being dispatched.
+	 */
 	watchlist_destroy(&group->watches);
+	if (group->watches.in_notify)
+		return;
+
 	l_free(group);
 }
 =

-- =

2.25.1

--===============5944767964386423101==--

