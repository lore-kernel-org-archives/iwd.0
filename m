Content-Type: multipart/mixed; boundary="===============4922041737140436622=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/6] offchannel: introduce new offchannel module
Date: Wed, 17 Jun 2020 10:56:41 -0700
Message-ID: <20200617175645.31197-2-prestwoj@gmail.com>
In-Reply-To: <20200617175645.31197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4922041737140436622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module will handle fairness and order in any offchannel work that
needs to be done. Sending offchannel frames (frame-xchg) and scanning
are the two operations which should be queued and done sequentially
rather than simultaneously. The phy itself can only do one at a time,
and the kernel doesn't seem to treat these operations as equals meaning
we need to maintain the order ourselves and only send these types of
requests one at a time.

Both scan and frame-xchg are complex modules (especially scanning)
which is why this module was implemented generic enough where the
changes to both modules will be minimal. Any module that requires
some kind of offchannel work it can push a work item into the offchannel
queue (offchan_work_push) and when the work is ready to be started
offchannel.c will call back into the module. Once the work is completed
(and this may be some time later e.g. in scan results or a frame watch)
the module can signal back to offchannel.c that the work is finished
(offchan_work_done). offchannel will then pop the queue and continue
with the next work item.

A concept of priority was added in order to allow important offchannel
operations (e.g. ANQP) to take priority over other work items. There
are three priorities now: SUSPENDED, NORMAL, and HIGH. NORMAL and HIGH
are as you might expect, HIGH takes precedence and items will be
inserted before any other priorities. SUSPENDED is somewhat different
and exists to support scanning functionally as it is now. A work item
can be inserted as SUSPENDED priority and the item will be initialized
in a suspended state (explained below). Once resumed a SUSPENDED
priority work item will take on a NORMAL priority.

Additionally to support scanning, offchan_work_{suspend,resume} APIs were
added. These behave exactly as you would expect to match the
functionality already in scanning. You can suspend a work item and it
will remain in the queue but not acted on until resumed. The only
difference between this and scan_{suspend,resume} is that offchan_work_
acts on single work items, not the whole queue of work. This is because
the queue will also contain non-scanning items like frame-xchgs which
should still be executed (as they are now, e.g. ANQP).

The offchannel work queue's are created on a per-phy basis, so each
queue is tied to the creation and destruction of wiphys. Because of
this wiphy.c takes care of creating and destroying offchannel queues
using:

offchan_create_from_wiphy()
offchan_destroy()
---
 Makefile.am      |   1 +
 src/offchannel.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++
 src/offchannel.h |  70 +++++++++++
 3 files changed, 364 insertions(+)
 create mode 100644 src/offchannel.c
 create mode 100644 src/offchannel.h

diff --git a/Makefile.am b/Makefile.am
index 57c694df..8c17683e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -229,6 +229,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/frame-xchg.h src/frame-xchg.c \
 					src/eap-wsc.c src/eap-wsc.h \
 					src/wscutil.h src/wscutil.c \
+					src/offchannel.h src/offchannel.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/offchannel.c b/src/offchannel.c
new file mode 100644
index 00000000..6ff3d71d
--- /dev/null
+++ b/src/offchannel.c
@@ -0,0 +1,293 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <stdbool.h>
+
+#include <ell/ell.h>
+
+#include "src/iwd.h"
+#include "src/module.h"
+#include "src/wiphy.h"
+#include "src/offchannel.h"
+
+struct offchan_work {
+	uint32_t id;
+	offchan_work_func_t do_work;
+	void *user_data;
+	offchan_work_destroy_func_t destroy;
+	enum offchan_work_priority priority;
+	bool suspended : 1;
+};
+
+/*
+ * Per-phy list of work requests
+ */
+struct offchan_phy {
+	struct wiphy *wiphy;
+	struct l_queue *work;
+	bool idle : 1;
+};
+
+static struct l_queue *phys;
+static uint32_t work_ids;
+
+static void destroy_work(void *user_data)
+{
+	struct offchan_work *work =3D user_data;
+
+	if (work->destroy)
+		work->destroy(work->user_data);
+
+	l_free(work);
+}
+
+static bool match_not_suspended(const void *a, const void *b)
+{
+	const struct offchan_work *work =3D a;
+
+	return !work->suspended;
+}
+
+static void offchan_work_next(struct offchan_phy *phy)
+{
+	struct offchan_work *work;
+	bool done;
+
+	if (!phy->idle)
+		return;
+
+	/* find first item that isn't suspended */
+	work =3D l_queue_find(phy->work, match_not_suspended, NULL);
+	if (!work) {
+		phy->idle =3D true;
+		return;
+	}
+
+	l_debug("Starting offchannel work %u", work->id);
+
+	/* Set idle as false in case the callback starts new work items */
+	phy->idle =3D false;
+
+	done =3D work->do_work(work->user_data);
+
+	if (done) {
+		l_debug("Offchannel work %u done", work->id);
+		l_queue_remove(phy->work, work);
+
+		destroy_work(work);
+
+		phy->idle =3D true;
+
+		offchan_work_next(phy);
+	}
+}
+
+static bool match_wiphy(const void *a, const void *b)
+{
+	const struct offchan_phy *phy =3D a;
+
+	return phy->wiphy =3D=3D b;
+}
+
+static struct offchan_phy *find_phy(uint64_t wdev_id)
+{
+	struct wiphy *wiphy =3D wiphy_find(wdev_id >> 32);
+
+	if (!wiphy)
+		return NULL;
+
+	return l_queue_find(phys, match_wiphy, wiphy);
+}
+
+static int insert_by_priority(const void *a, const void *b, void *user_dat=
a)
+{
+	const struct offchan_work *work =3D b;
+	uint8_t *count =3D user_data;
+
+	/* This ensures we are not pushing before head, or any priority items */
+	if (*count =3D=3D 0 || work->priority =3D=3D OFFCHAN_PRIORITY_HIGH) {
+		l_put_u8(*count + 1, count);
+		return 1;
+	}
+
+	l_debug("Inserting priority work item at index %u", *count);
+
+	return -1;
+}
+
+/*
+ * Push a new work item into the queue for this phy. The wdev_id is used to
+ * get the actual phy its under.
+ */
+uint32_t offchan_work_push(uint64_t wdev_id,
+				enum offchan_work_priority priority,
+				offchan_work_func_t func, void *user_data,
+				offchan_work_destroy_func_t destroy)
+{
+	struct offchan_work *work;
+	struct offchan_phy *phy =3D find_phy(wdev_id);
+	uint8_t count =3D 0;
+
+	if (!phy)
+		return 0;
+
+	work =3D l_new(struct offchan_work, 1);
+	work->do_work =3D func;
+	work->destroy =3D destroy;
+	work->user_data =3D user_data;
+	work->id =3D ++work_ids;
+	work->priority =3D priority;
+	work->suspended =3D priority =3D=3D OFFCHAN_PRIORITY_SUSPENDED;
+
+	l_debug("Queuing offchannel work %u", work->id);
+
+	if (priority =3D=3D OFFCHAN_PRIORITY_NORMAL || work->suspended) {
+		l_queue_push_tail(phy->work, work);
+		goto done;
+	}
+
+	/*
+	 * This is a priority work request sent when there are current work
+	 * items in the queue. The head of the queue should always contain a
+	 * started work item, so we need to insert somewhere after that which
+	 * includes any other priority work items that may have been pushed.
+	 */
+	l_queue_insert(phy->work, work, insert_by_priority, &count);
+
+done:
+	/* Start work if we are sitting idle */
+	offchan_work_next(phy);
+
+	return work->id;
+}
+
+static bool match_id(const void *a, const void *b)
+{
+	const struct offchan_work *work =3D a;
+
+	return work->id =3D=3D L_PTR_TO_UINT(b);
+}
+
+/*
+ * Signals that the work item is done. This can also be used to cancel any
+ * pending work item in the queue.
+ */
+void offchan_work_done(uint64_t wdev_id, uint32_t id)
+{
+	struct offchan_work *work;
+	struct offchan_phy *phy =3D find_phy(wdev_id);
+
+	if (!phy)
+		return;
+
+	work =3D l_queue_remove_if(phy->work, match_id, L_UINT_TO_PTR(id));
+	if (!work)
+		return;
+
+	l_debug("Offchannel work done %u", id);
+
+	destroy_work(work);
+
+	phy->idle =3D true;
+
+	offchan_work_next(phy);
+}
+
+void offchan_work_suspend(uint64_t wdev_id, uint32_t id)
+{
+	struct offchan_work *work;
+	struct offchan_phy *phy =3D find_phy(wdev_id);
+
+	if (!phy)
+		return;
+
+	work =3D l_queue_find(phy->work, match_id, L_UINT_TO_PTR(id));
+	if (!work)
+		return;
+
+
+	work->suspended =3D true;
+}
+
+void offchan_work_resume(uint64_t wdev_id, uint32_t id)
+{
+	struct offchan_work *work;
+	struct offchan_phy *phy =3D find_phy(wdev_id);
+
+	if (!phy)
+		return;
+
+	work =3D l_queue_find(phy->work, match_id, L_UINT_TO_PTR(id));
+	if (!work)
+		return;
+
+	/* If this item was pushed as SUSPENDED, take on NORMAL priority */
+	work->priority =3D work->priority =3D=3D OFFCHAN_PRIORITY_SUSPENDED ?
+				OFFCHAN_PRIORITY_NORMAL : work->priority;
+	work->suspended =3D false;
+
+	offchan_work_next(phy);
+}
+
+void offchan_create_from_wiphy(struct wiphy *wiphy)
+{
+	struct offchan_phy *phy =3D l_new(struct offchan_phy, 1);
+
+	phy->wiphy =3D wiphy;
+	phy->work =3D l_queue_new();
+	phy->idle =3D true;
+
+	l_queue_push_head(phys, phy);
+}
+
+static void destroy_offchan_phy(void *user_data)
+{
+	struct offchan_phy *phy =3D user_data;
+
+	l_queue_destroy(phy->work, destroy_work);
+
+	l_free(phy);
+}
+
+void offchan_destroy(struct wiphy *wiphy)
+{
+	struct offchan_phy *phy =3D l_queue_remove_if(phys, match_wiphy, wiphy);
+
+	if (!phy)
+		return;
+
+	destroy_offchan_phy(phy);
+}
+
+static int offchan_init(void)
+{
+	phys =3D l_queue_new();
+
+	return 0;
+}
+
+static void offchan_exit(void)
+{
+	l_queue_destroy(phys, destroy_offchan_phy);
+}
+
+IWD_MODULE(offchannel, offchan_init, offchan_exit);
diff --git a/src/offchannel.h b/src/offchannel.h
new file mode 100644
index 00000000..127a0b21
--- /dev/null
+++ b/src/offchannel.h
@@ -0,0 +1,70 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+/*
+ * Module specific function that does the actual offchannel work, whether =
this
+ * is scanning, sending offchannel frames, or listening for a message. This
+ * function should return a boolean indicating if the work is done (e.g.
+ * fire-and-forget frame). Most cases the work is not done by the time the
+ * function returns, and generally we need to wait for a frame to be recei=
ved
+ * or for scan results to come in. In this case offchan_work_done() should=
 be
+ * called asynchronously once the work has completed.
+ */
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <ell/ell.h>
+
+struct wiphy;
+
+/*
+ * The priority value of a work item:
+ *
+ * SUSPENDED - The purpose of this is to allow pushing a work item into the
+ *             queue that is already in a suspended state. This item will =
not
+ *             be run until it is resumed via offchan_work_resume. Once re=
sumed
+ *             the item will take a NORMAL priority.
+ * NORMAL -    Normal priority. Work item will be executed when it reaches=
 the
+ *             top of the queue.
+ * HIGH -      High priority. Any work item pushed with this priority will=
 be
+ *             inserted before any NORMAL/SUSPENDED priority items, but st=
ill
+ *             behind any other HIGH priority work items.
+ */
+enum offchan_work_priority {
+	OFFCHAN_PRIORITY_SUSPENDED,
+	OFFCHAN_PRIORITY_NORMAL,
+	OFFCHAN_PRIORITY_HIGH,
+};
+
+typedef bool (*offchan_work_func_t)(void *user_data);
+typedef void (*offchan_work_destroy_func_t)(void *user_data);
+
+uint32_t offchan_work_push(uint64_t wdev_id,
+				enum offchan_work_priority priority,
+				offchan_work_func_t func, void *user_data,
+				offchan_work_destroy_func_t destroy);
+void offchan_work_done(uint64_t wdev_id, uint32_t id);
+void offchan_work_suspend(uint64_t wdev_id, uint32_t id);
+void offchan_work_resume(uint64_t wdev_id, uint32_t id);
+
+void offchan_create_from_wiphy(struct wiphy *wiphy);
+void offchan_destroy(struct wiphy *wiphy);
-- =

2.21.1

--===============4922041737140436622==--

