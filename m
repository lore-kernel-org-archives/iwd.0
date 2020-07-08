Content-Type: multipart/mixed; boundary="===============7181103128197331856=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] wiphy: introduce new radio management APIs
Date: Wed, 08 Jul 2020 10:47:34 -0700
Message-ID: <20200708174739.14188-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7181103128197331856==
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
 src/wiphy.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  22 +++++++++++
 2 files changed, 133 insertions(+)

v2:
 - Removed in_cb/stale members. This disallows the caller from signaling
   work done inside the work callback.
 - Cleaned up some old radio_mgmt naming
 - Remove 'count' concept when inserting work items. Instead the priority
   of the current work item is set to INT_MIN which will ensure no other
   work item gets inserted ahead of the current item.

diff --git a/src/wiphy.c b/src/wiphy.c
index aef39549..2e2693cf 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -32,6 +32,7 @@
 #include <fnmatch.h>
 #include <unistd.h>
 #include <string.h>
+#include <limits.h>
 =

 #include <ell/ell.h>
 =

@@ -62,6 +63,7 @@ static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes =3D 6;
 static char regdom_country[2];
+static uint32_t work_ids;
 =

 struct wiphy {
 	uint32_t id;
@@ -85,6 +87,8 @@ struct wiphy {
 	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
 	struct l_genl_family *nl80211;
 	char regdom_country[2];
+	/* Work queue for this radio */
+	struct l_queue *work;
 =

 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -216,6 +220,14 @@ static struct wiphy *wiphy_new(uint32_t id)
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
@@ -235,6 +247,7 @@ static void wiphy_free(void *data)
 	l_free(wiphy->vendor_str);
 	l_free(wiphy->driver_str);
 	l_genl_family_free(wiphy->nl80211);
+	l_queue_destroy(wiphy->work, destroy_work);
 	l_free(wiphy);
 }
 =

@@ -1072,6 +1085,8 @@ struct wiphy *wiphy_create(uint32_t wiphy_id, const c=
har *name)
 	if (!wiphy_is_managed(name))
 		wiphy->blacklisted =3D true;
 =

+	wiphy->work =3D l_queue_new();
+
 	return wiphy;
 }
 =

@@ -1449,6 +1464,102 @@ static void wiphy_reg_notify(struct l_genl_msg *msg=
, void *user_data)
 	}
 }
 =

+static void wiphy_radio_work_next(struct wiphy *wiphy)
+{
+	struct wiphy_radio_work_item *work;
+	bool done;
+
+	work =3D l_queue_peek_head(wiphy->work);
+	if (!work)
+		return;
+
+	/*
+	 * Ensures no other work item will get inserted before this one while
+	 * the work is being done.
+	 */
+	work->priority =3D INT_MIN;
+
+	l_debug("Starting work item %u", work->id);
+	done =3D work->ops->do_work(work);
+
+	if (done) {
+		work->id =3D 0;
+
+		l_queue_remove(wiphy->work, work);
+
+		destroy_work(work);
+
+		wiphy_radio_work_next(wiphy);
+	}
+}
+
+static int insert_by_priority(const void *a, const void *b, void *user_dat=
a)
+{
+	const struct wiphy_radio_work_item *new =3D a;
+	const struct wiphy_radio_work_item *work =3D b;
+
+	if (work->priority <=3D new->priority)
+		return 1;
+
+	return -1;
+}
+
+uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
+				struct wiphy_radio_work_item *item,
+				int priority,
+				const struct wiphy_radio_work_item_ops *ops)
+{
+	item->priority =3D priority;
+	item->ops =3D ops;
+	item->id =3D ++work_ids;
+
+	l_debug("Inserting work item %u", item->id);
+
+	l_queue_insert(wiphy->work, item, insert_by_priority, NULL);
+
+	if (l_queue_length(wiphy->work) =3D=3D 1)
+		wiphy_radio_work_next(wiphy);
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
+	l_debug("Work item %u done", id);
+
+	item->id =3D 0;
+
+	/*
+	 * This is the current work item so we can continue onto the next.
+	 */
+	if (item =3D=3D l_queue_peek_head(wiphy->work))
+		next =3D true;
+
+	l_queue_remove(wiphy->work, item);
+
+	destroy_work(item);
+
+	if (next)
+		wiphy_radio_work_next(wiphy);
+}
+
 static int wiphy_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
diff --git a/src/wiphy.h b/src/wiphy.h
index 689f868b..50c8c936 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -26,6 +26,22 @@
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
+};
 =

 enum wiphy_state_watch_event {
 	WIPHY_STATE_WATCH_EVENT_POWERED,
@@ -92,3 +108,9 @@ uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
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

--===============7181103128197331856==--

