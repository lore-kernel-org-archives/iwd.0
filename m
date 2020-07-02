Content-Type: multipart/mixed; boundary="===============8865609373583255563=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] wiphy: introduce new radio management APIs
Date: Thu, 02 Jul 2020 10:35:26 -0700
Message-ID: <20200702173533.8712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8865609373583255563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These APIs will handle fairness and order in any operations which
radios can only do sequentially (offchannel, scanning, connection etc.).

Both scan and frame-xchg are complex modules (especially scanning)
which is why the radio management APIs were implemented generic enough
where the changes to both modules will be minimal. Any module that
requires this kind of work can push a work item into the radio
management work queue (wiphy_radio_work_insert) and when the work
is ready to be started radio management will call back into the module.
Once the work is completed (and this may be some time later e.g. in
scan results or a frame watch) the module can signal back that the
work is finished (wiphy_radio_work_done). Wiphy will then pop the
queue and continue with the next work item.

A concept of priority was added in order to allow important offchannel
operations (e.g. ANQP) to take priority over other work items. The
priority is an integer, where lower values are of a higher priority.
The concept of priority cleanly solves a lot of the complexity that
was added in order to support ANQP queries (suspending scanning and
waiting for ANQP to finish before connecting).

Instead ANQP queries can be queued at a higher priority than scanning
which removes the need for suspending scans. In addition we can treat
connections as radio management work and insert them at a lower
priority than ANQP, but higher than scanning. This forces the
connection to wait for ANQP without having to track any state.
---
 src/wiphy.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  24 ++++++++++
 2 files changed, 148 insertions(+)

v3:
 - Moved functionality into wiphy, since the work queues are directly
   tied to each wiphy object anyways.
 - Added in_cb/stale members for more flexibility in signaling a work
   item done. Now either the callback return can be used to signal done
   or wiphy_radio_work_done can be used while still in the work callback.
   This allows for easier integration to existing modules where it may
   not be easy to return the status of the work item without major
   refactoring.

diff --git a/src/wiphy.c b/src/wiphy.c
index aef39549..2b95c23e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -62,6 +62,7 @@ static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes =3D 6;
 static char regdom_country[2];
+static uint32_t work_ids;
 =

 struct wiphy {
 	uint32_t id;
@@ -85,6 +86,8 @@ struct wiphy {
 	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
 	struct l_genl_family *nl80211;
 	char regdom_country[2];
+	/* Work queue for this radio */
+	struct l_queue *work;
 =

 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -216,6 +219,14 @@ static struct wiphy *wiphy_new(uint32_t id)
 	return wiphy;
 }
 =

+static void destroy_work(void *user_data)
+{
+	struct wiphy_radio_work_item *work =3D user_data;
+
+	if (work->ops && work->ops->destroy)
+		work->ops->destroy(work);
+}
+
 static void wiphy_free(void *data)
 {
 	struct wiphy *wiphy =3D data;
@@ -235,6 +246,7 @@ static void wiphy_free(void *data)
 	l_free(wiphy->vendor_str);
 	l_free(wiphy->driver_str);
 	l_genl_family_free(wiphy->nl80211);
+	l_queue_destroy(wiphy->work, destroy_work);
 	l_free(wiphy);
 }
 =

@@ -1072,6 +1084,8 @@ struct wiphy *wiphy_create(uint32_t wiphy_id, const c=
har *name)
 	if (!wiphy_is_managed(name))
 		wiphy->blacklisted =3D true;
 =

+	wiphy->work =3D l_queue_new();
+
 	return wiphy;
 }
 =

@@ -1449,6 +1463,116 @@ static void wiphy_reg_notify(struct l_genl_msg *msg=
, void *user_data)
 	}
 }
 =

+static void radio_mgmt_work_next(struct wiphy *wiphy)
+{
+	struct wiphy_radio_work_item *work;
+	bool done;
+
+	work =3D l_queue_peek_head(wiphy->work);
+	if (!work)
+		return;
+
+	work->in_cb =3D true;
+
+	done =3D work->ops->do_work(work);
+
+	work->in_cb =3D false;
+
+	if (done || work->stale) {
+		l_queue_remove(wiphy->work, work);
+
+		destroy_work(work);
+
+		radio_mgmt_work_next(wiphy);
+	}
+}
+
+static int insert_by_priority(const void *a, const void *b, void *user_dat=
a)
+{
+	const struct wiphy_radio_work_item *new =3D a;
+	const struct wiphy_radio_work_item *work =3D b;
+	uint8_t *count =3D user_data;
+
+	/* This ensures we are not pushing before head, or any priority items */
+	if (*count =3D=3D 0 || work->priority <=3D new->priority) {
+		l_put_u8(*count + 1, count);
+		return 1;
+	}
+
+	l_debug("Inserting priority work item at index %u", *count);
+
+	return -1;
+}
+
+uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
+				struct wiphy_radio_work_item *item,
+				int priority,
+				const struct wiphy_radio_work_item_ops *ops)
+{
+	uint8_t count =3D 0;
+
+	item->priority =3D priority;
+	item->ops =3D ops;
+	item->id =3D ++work_ids;
+
+	/*
+	 * The head of the queue will always contain the current work item, so
+	 * we pass a count in to ensure we always insert after the head.
+	 */
+	l_queue_insert(wiphy->work, item, insert_by_priority, &count);
+
+	if (l_queue_length(wiphy->work) =3D=3D 1)
+		radio_mgmt_work_next(wiphy);
+
+	return item->id;
+}
+
+static bool match_id(const void *a, const void *b)
+{
+	const struct wiphy_radio_work_item *item =3D a;
+
+	if (item->id =3D=3D L_PTR_TO_UINT(b))
+		return true;
+
+	return false;
+}
+
+void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id)
+{
+	struct wiphy_radio_work_item *item;
+	bool next =3D false;
+
+	item =3D l_queue_find(wiphy->work, match_id, L_UINT_TO_PTR(id));
+	if (!item)
+		return;
+
+	/*
+	 * This was the current work item. If we are in the callback mark the
+	 * item as stale and it will get cleaned up after the callback returns,
+	 * as well as the next work item started.
+	 */
+	if (item->in_cb) {
+		item->stale =3D true;
+		return;
+	}
+
+	/*
+	 * Otherwise we are being called asynchronously and the next work item
+	 * can be started if this one was the current.
+	 */
+	if (item =3D=3D l_queue_peek_head(wiphy->work))
+		next =3D true;
+
+	l_queue_remove(wiphy->work, item);
+
+	item->id =3D 0;
+
+	destroy_work(item);
+
+	if (next)
+		radio_mgmt_work_next(wiphy);
+}
+
 static int wiphy_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
diff --git a/src/wiphy.h b/src/wiphy.h
index ed435517..2a597878 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -26,6 +26,24 @@
 struct wiphy;
 struct scan_bss;
 struct scan_freq_set;
+struct wiphy_radio_work_item;
+
+typedef bool (*wiphy_radio_work_func_t)(struct wiphy_radio_work_item *item=
);
+typedef void (*wiphy_radio_work_destroy_func_t)(
+					struct wiphy_radio_work_item *item);
+
+struct wiphy_radio_work_item_ops {
+	wiphy_radio_work_func_t do_work;
+	wiphy_radio_work_destroy_func_t destroy;
+};
+
+struct wiphy_radio_work_item {
+	uint32_t id;
+	int priority;
+	const struct wiphy_radio_work_item_ops *ops;
+	bool in_cb : 1;
+	bool stale : 1;
+};
 =

 enum wiphy_state_watch_event {
 	WIPHY_STATE_WATCH_EVENT_POWERED,
@@ -90,3 +108,9 @@ uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func, void *user_data,
 				wiphy_destroy_func_t destroy);
 bool wiphy_state_watch_remove(struct wiphy *wiphy, uint32_t id);
+
+uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
+				struct wiphy_radio_work_item *item,
+				int priority,
+				const struct wiphy_radio_work_item_ops *ops);
+void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id);
-- =

2.21.1

--===============8865609373583255563==--

