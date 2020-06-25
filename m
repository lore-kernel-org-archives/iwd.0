Content-Type: multipart/mixed; boundary="===============5783400164339248973=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/7] radio_mgmt: introduce new radio management module
Date: Thu, 25 Jun 2020 11:56:39 -0700
Message-ID: <20200625185645.30122-2-prestwoj@gmail.com>
In-Reply-To: <20200625185645.30122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5783400164339248973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module will handle fairness and order in any operations which
radios can only do sequentially (offchannel, scanning, connection etc.).

Both scan and frame-xchg are complex modules (especially scanning)
which is why this module was implemented generic enough where the
changes to both modules will be minimal. Any module that requires
this kind of work can push a work item into the radio management work
queue (radio_mgmt_push) and when the work is ready to be started
radio management will call back into the module. Once the work is
completed (and this may be some time later e.g. in scan results or a
frame watch) the module can signal back to radio management that the
work is finished (radio_mgmt_done). Radio management will then pop
the queue and continue with the next work item.

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

The radio management work queue's are created on a per-phy basis, so
each queue is tied to the creation and destruction of wiphys. Because
of this wiphy.c takes care of creating and destroying offchannel queues
using:

radio_mgmt_create_from_wiphy()
radio_mgmt_destroy()
---
 Makefile.am      |   1 +
 src/radio_mgmt.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++
 src/radio_mgmt.h |  48 ++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 src/radio_mgmt.c
 create mode 100644 src/radio_mgmt.h

diff --git a/Makefile.am b/Makefile.am
index 57c694df..b0455e71 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -229,6 +229,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/frame-xchg.h src/frame-xchg.c \
 					src/eap-wsc.c src/eap-wsc.h \
 					src/wscutil.h src/wscutil.c \
+					src/radio_mgmt.h src/radio_mgmt.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/radio_mgmt.c b/src/radio_mgmt.c
new file mode 100644
index 00000000..ff7f944c
--- /dev/null
+++ b/src/radio_mgmt.c
@@ -0,0 +1,240 @@
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
+#include "src/radio_mgmt.h"
+
+struct radio_mgmt_work {
+	uint32_t id;
+	radio_mgmt_work_func_t do_work;
+	void *user_data;
+	radio_mgmt_work_destroy_func_t destroy;
+	int priority;
+};
+
+/*
+ * Per-phy list of work requests
+ */
+struct radio_mgmt_phy {
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
+	struct radio_mgmt_work *work =3D user_data;
+
+	if (work->destroy)
+		work->destroy(work->user_data);
+
+	l_free(work);
+}
+
+static void radio_mgmt_work_next(struct radio_mgmt_phy *phy)
+{
+	struct radio_mgmt_work *work;
+	bool done;
+
+	if (!phy->idle)
+		return;
+
+	/* find first item that isn't suspended */
+	work =3D l_queue_peek_head(phy->work);
+	if (!work) {
+		phy->idle =3D true;
+		return;
+	}
+
+	l_debug("Starting radio work %u", work->id);
+
+	/* Set idle as false in case the callback starts new work items */
+	phy->idle =3D false;
+
+	done =3D work->do_work(work->user_data);
+
+	if (done) {
+		l_debug("Radio work %u done", work->id);
+		l_queue_remove(phy->work, work);
+
+		destroy_work(work);
+
+		phy->idle =3D true;
+
+		radio_mgmt_work_next(phy);
+	}
+}
+
+static bool match_wiphy(const void *a, const void *b)
+{
+	const struct radio_mgmt_phy *phy =3D a;
+
+	return phy->wiphy =3D=3D b;
+}
+
+static struct radio_mgmt_phy *find_phy(uint64_t wdev_id)
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
+	const struct radio_mgmt_work *new =3D a;
+	const struct radio_mgmt_work *work =3D b;
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
+/*
+ * Push a new work item into the queue for this phy. The wdev_id is used to
+ * get the actual phy its under.
+ */
+uint32_t radio_mgmt_push(uint64_t wdev_id, int priority,
+				radio_mgmt_work_func_t func, void *user_data,
+				radio_mgmt_work_destroy_func_t destroy)
+{
+	struct radio_mgmt_work *work;
+	struct radio_mgmt_phy *phy =3D find_phy(wdev_id);
+	uint8_t count =3D 0;
+
+	if (!phy)
+		return 0;
+
+	work =3D l_new(struct radio_mgmt_work, 1);
+	work->do_work =3D func;
+	work->destroy =3D destroy;
+	work->user_data =3D user_data;
+	work->id =3D ++work_ids;
+	work->priority =3D priority;
+
+	l_debug("Queuing radio work %u", work->id);
+
+	/*
+	 * The head of the queue will always contain the current work item, so
+	 * we pass a count in to ensure we always insert after the head.
+	 */
+	l_queue_insert(phy->work, work, insert_by_priority, &count);
+
+	/* Start work if we are sitting idle */
+	radio_mgmt_work_next(phy);
+
+	return work->id;
+}
+
+static bool match_id(const void *a, const void *b)
+{
+	const struct radio_mgmt_work *work =3D a;
+
+	return work->id =3D=3D L_PTR_TO_UINT(b);
+}
+
+/*
+ * Signals that the work item is done. This can also be used to cancel any
+ * pending work item in the queue.
+ */
+void radio_mgmt_done(uint64_t wdev_id, uint32_t id)
+{
+	struct radio_mgmt_work *work;
+	struct radio_mgmt_phy *phy =3D find_phy(wdev_id);
+
+	if (!phy)
+		return;
+
+	work =3D l_queue_remove_if(phy->work, match_id, L_UINT_TO_PTR(id));
+	if (!work)
+		return;
+
+	l_debug("Radio work done %u", id);
+
+	destroy_work(work);
+
+	phy->idle =3D true;
+
+	radio_mgmt_work_next(phy);
+}
+
+void radio_mgmt_create_from_wiphy(struct wiphy *wiphy)
+{
+	struct radio_mgmt_phy *phy =3D l_new(struct radio_mgmt_phy, 1);
+
+	phy->wiphy =3D wiphy;
+	phy->work =3D l_queue_new();
+	phy->idle =3D true;
+
+	l_queue_push_head(phys, phy);
+}
+
+static void destroy_radio_mgmt_phy(void *user_data)
+{
+	struct radio_mgmt_phy *phy =3D user_data;
+
+	l_queue_destroy(phy->work, destroy_work);
+
+	l_free(phy);
+}
+
+void radio_mgmt_destroy(struct wiphy *wiphy)
+{
+	struct radio_mgmt_phy *phy =3D l_queue_remove_if(phys, match_wiphy, wiphy=
);
+
+	if (!phy)
+		return;
+
+	destroy_radio_mgmt_phy(phy);
+}
+
+static int radio_mgmt_init(void)
+{
+	phys =3D l_queue_new();
+
+	return 0;
+}
+
+static void radio_mgmt_exit(void)
+{
+	l_queue_destroy(phys, destroy_radio_mgmt_phy);
+}
+
+IWD_MODULE(radio_mgmt, radio_mgmt_init, radio_mgmt_exit);
diff --git a/src/radio_mgmt.h b/src/radio_mgmt.h
new file mode 100644
index 00000000..4429ea8c
--- /dev/null
+++ b/src/radio_mgmt.h
@@ -0,0 +1,48 @@
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
+ * or for scan results to come in. In this case radio_mgmt_work_done() sho=
uld be
+ * called asynchronously once the work has completed.
+ */
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <ell/ell.h>
+
+struct wiphy;
+
+typedef bool (*radio_mgmt_work_func_t)(void *user_data);
+typedef void (*radio_mgmt_work_destroy_func_t)(void *user_data);
+
+uint32_t radio_mgmt_push(uint64_t wdev_id, int priority,
+				radio_mgmt_work_func_t func, void *user_data,
+				radio_mgmt_work_destroy_func_t destroy);
+void radio_mgmt_done(uint64_t wdev_id, uint32_t id);
+
+void radio_mgmt_create_from_wiphy(struct wiphy *wiphy);
+void radio_mgmt_destroy(struct wiphy *wiphy);
-- =

2.21.1

--===============5783400164339248973==--

