Content-Type: multipart/mixed; boundary="===============8144203321901229420=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/2] offchannel: introduce new offchannel module
Date: Mon, 06 Dec 2021 10:19:56 -0800
Message-ID: <20211206181956.1161332-2-prestwoj@gmail.com>
In-Reply-To: 20211206181956.1161332-1-prestwoj@gmail.com

--===============8144203321901229420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module provides a convenient wrapper around both
CMD_[CANCEL_]_REMAIN_ON_CHANNEL APIs.

Certain protocols require going offchannel to send frames, and/or
wait for a response. The frame-xchg module somewhat does this but
has some limitations. For example you cannot just go offchannel;
an initial frame must be sent out to start the procedure. In addition
frame-xchg does not work for broadcasts since it expects an ACK.

This module is much simpler and only handles going offchannel for
a duration. During this time frames may be sent or received. After
the duration the caller will get a callback and any included error
if there was one. Any offchannel request can be cancelled prior to
the duration expriring if the offchannel work has finished early.
---
 Makefile.am      |   1 +
 src/offchannel.c | 314 +++++++++++++++++++++++++++++++++++++++++++++++
 src/offchannel.h |  29 +++++
 3 files changed, 344 insertions(+)
 create mode 100644 src/offchannel.c
 create mode 100644 src/offchannel.h

v3:
 * wait until cancel ROC event before calling done on work in cases
   where ROC has started
 * Fixed nl80211 cancel logic to only cancel if the command has not
   yet left the genl queue, not unconditionally

diff --git a/Makefile.am b/Makefile.am
index 1e1c230f..d93dd2c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -247,6 +247,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/ip-pool.h src/ip-pool.c \
 					src/band.h src/band.c \
 					src/sysfs.h src/sysfs.c \
+					src/offchannel.h src/offchannel.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/offchannel.c b/src/offchannel.c
new file mode 100644
index 00000000..b05b9464
--- /dev/null
+++ b/src/offchannel.c
@@ -0,0 +1,314 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include <ell/ell.h>
+
+#include "linux/nl80211.h"
+
+#include "src/offchannel.h"
+#include "src/wiphy.h"
+#include "src/nl80211util.h"
+#include "src/iwd.h"
+#include "src/module.h"
+
+struct offchannel_info {
+	uint64_t wdev_id;
+	uint32_t freq;
+	uint32_t duration;
+
+	uint32_t roc_cmd_id;
+	uint64_t roc_cookie;
+
+	offchannel_started_cb_t started;
+	offchannel_destroy_cb_t destroy;
+	void *user_data;
+	int error;
+
+	struct wiphy_radio_work_item work;
+
+	bool needs_cancel : 1;
+};
+
+static struct l_genl_family *nl80211;
+static struct l_queue *offchannel_list;
+
+static bool match_wdev(const void *a, const void *user_data)
+{
+	const struct offchannel_info *info =3D a;
+	const uint64_t *wdev_id =3D user_data;
+
+	return info->wdev_id =3D=3D *wdev_id;
+}
+
+static void offchannel_cancel_roc(struct offchannel_info *info)
+{
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &info->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_COOKIE, 8, &info->roc_cookie);
+
+	/* Nothing much can be done if this fails */
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_genl_msg_unref(msg);
+}
+
+static void offchannel_roc_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct offchannel_info *info =3D user_data;
+
+	info->error =3D l_genl_msg_get_error(msg);
+	info->roc_cmd_id =3D 0;
+
+	if (info->error < 0) {
+		l_debug("Error from CMD_REMAIN_ON_CHANNEL (%d)", info->error);
+		goto work_done;
+	}
+
+	info->error =3D nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE,
+					&info->roc_cookie, NL80211_ATTR_UNSPEC);
+	if (info->error < 0) {
+		l_error("Could not parse ROC cookie");
+		goto work_done;
+	}
+
+	/* This request was cancelled, and ROC needs to be cancelled */
+	if (info->needs_cancel)
+		offchannel_cancel_roc(info);
+
+	return;
+
+work_done:
+	wiphy_radio_work_done(wiphy_find_by_wdev(info->wdev_id), info->work.id);
+}
+
+static bool offchannel_work_ready(struct wiphy_radio_work_item *item)
+{
+	struct l_genl_msg *msg;
+	struct offchannel_info *info =3D l_container_of(item,
+						struct offchannel_info, work);
+
+	msg =3D l_genl_msg_new(NL80211_CMD_REMAIN_ON_CHANNEL);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &info->wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &info->freq);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4, &info->duration);
+
+	info->roc_cmd_id =3D l_genl_family_send(nl80211, msg, offchannel_roc_cb,
+						info, NULL);
+	if (!info->roc_cmd_id) {
+		info->error =3D -EIO;
+		l_genl_msg_unref(msg);
+		return true;
+	}
+
+	l_queue_push_head(offchannel_list, info);
+
+	return false;
+}
+
+static void offchannel_work_destroy(struct wiphy_radio_work_item *item)
+{
+	struct offchannel_info *info =3D l_container_of(item,
+						struct offchannel_info, work);
+
+	if (info->destroy)
+		info->destroy(info->error, info->user_data);
+
+	l_queue_remove(offchannel_list, info);
+	l_free(info);
+}
+
+static const struct wiphy_radio_work_item_ops offchannel_work_ops =3D {
+	.do_work =3D offchannel_work_ready,
+	.destroy =3D offchannel_work_destroy,
+};
+
+uint32_t offchannel_start(uint64_t wdev_id, uint32_t freq, uint32_t durati=
on,
+			offchannel_started_cb_t started, void *user_data,
+			offchannel_destroy_cb_t destroy)
+{
+	struct offchannel_info *info =3D l_new(struct offchannel_info, 1);
+
+	info->wdev_id =3D wdev_id;
+	info->freq =3D freq;
+	info->duration =3D duration;
+	info->started =3D started;
+	info->destroy =3D destroy;
+	info->user_data =3D user_data;
+	/*
+	 * Set error as cancelled in case this work gets cancelled prior to
+	 * the wiphy work starting.
+	 */
+	info->error =3D -ECANCELED;
+
+	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id),
+					&info->work, 1, &offchannel_work_ops);
+}
+
+void offchannel_cancel(uint64_t wdev_id, uint32_t id)
+{
+	struct wiphy *wiphy =3D wiphy_find_by_wdev(wdev_id);
+	struct offchannel_info *info;
+	int ret;
+
+	if (!wiphy)
+		return;
+
+	/*
+	 * Exit if work does not exist, if it hasn't started 'done' the work,
+	 * otherwise decide how the work needs to be canceled.
+	 */
+	ret =3D wiphy_radio_work_is_running(wiphy, id);
+	if (ret < 0)
+		return;
+	else if (ret > 0)
+		goto work_done;
+
+	info =3D l_queue_find(offchannel_list, match_wdev, &wdev_id);
+	if (!info)
+		return;
+
+	if (info->roc_cmd_id) {
+		/*
+		 * If the command hasn't left the genl queue it can be cancelled
+		 * without any further action. Otherwise command has been sent
+		 * to the kernel and we must wait until ROC starts and cancel at
+		 * that time.
+		 */
+		if (!l_genl_family_request_sent(nl80211, info->roc_cmd_id)) {
+			l_genl_family_cancel(nl80211, info->roc_cmd_id);
+			info->roc_cmd_id =3D 0;
+			goto work_done;
+		}
+
+		info->needs_cancel =3D true;
+
+		return;
+	}
+
+	/*
+	 * Something weird must have happened on the kernel side. This error
+	 * will already be handled in offchannel_roc_cb but warn here to inform
+	 * the user.
+	 */
+	if (L_WARN_ON(!info->roc_cookie))
+		return;
+
+	/*
+	 * At this point we know ROC has at least been queued (potentially not
+	 * started) and can be cancelled. The work will be completed once the
+	 * kernel sends the cancel ROC event.
+	 */
+	offchannel_cancel_roc(info);
+
+	return;
+
+work_done:
+	wiphy_radio_work_done(wiphy, id);
+}
+
+static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct offchannel_info *info;
+	uint64_t wdev_id;
+	uint64_t cookie;
+	uint8_t cmd;
+
+	cmd =3D l_genl_msg_get_command(msg);
+
+	if (cmd !=3D NL80211_CMD_REMAIN_ON_CHANNEL &&
+			cmd !=3D NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL)
+		return;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
+					NL80211_ATTR_COOKIE, &cookie,
+					NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	info =3D l_queue_find(offchannel_list, match_wdev, &wdev_id);
+	if (!info)
+		return;
+
+	/* ROC must have been started elsewhere, not by IWD */
+	if (info->roc_cookie !=3D cookie)
+		return;
+
+	switch (cmd) {
+	case NL80211_CMD_REMAIN_ON_CHANNEL:
+		if (info->started)
+			info->started(info->user_data);
+
+		break;
+	case NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL:
+		info->error =3D 0;
+
+		wiphy_radio_work_done(wiphy_find_by_wdev(info->wdev_id),
+					info->work.id);
+		break;
+	default:
+		return;
+	}
+}
+
+static int offchannel_init(void)
+{
+	struct l_genl *genl =3D iwd_get_genl();
+
+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
+	if (!nl80211) {
+		l_error("Failed to obtain nl80211");
+		return -EIO;
+	}
+
+	if (!l_genl_family_register(nl80211, "mlme", offchannel_mlme_notify,
+								NULL, NULL)) {
+		l_error("Failed to register for MLME");
+		l_genl_family_free(nl80211);
+		nl80211 =3D NULL;
+
+		return -EIO;
+	}
+
+	offchannel_list =3D l_queue_new();
+
+	return 0;
+}
+
+static void offchannel_exit(void)
+{
+	l_debug("");
+
+	l_genl_family_free(nl80211);
+	nl80211 =3D NULL;
+
+	l_queue_destroy(offchannel_list, l_free);
+}
+
+IWD_MODULE(offchannel, offchannel_init, offchannel_exit);
diff --git a/src/offchannel.h b/src/offchannel.h
new file mode 100644
index 00000000..1ffa94f1
--- /dev/null
+++ b/src/offchannel.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
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
+typedef void (*offchannel_started_cb_t)(void *user_data);
+typedef void (*offchannel_destroy_cb_t)(int error, void *user_data);
+
+uint32_t offchannel_start(uint64_t wdev_id, uint32_t freq, uint32_t durati=
on,
+			offchannel_started_cb_t started, void *user_data,
+			offchannel_destroy_cb_t destroy);
+void offchannel_cancel(uint64_t wdev_id, uint32_t id);
-- =

2.31.1

--===============8144203321901229420==--

