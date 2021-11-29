Content-Type: multipart/mixed; boundary="===============1760216171661223287=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] offchannel: introduce new offchannel module
Date: Mon, 29 Nov 2021 15:16:47 -0800
Message-ID: <20211129231647.109200-1-prestwoj@gmail.com>

--===============1760216171661223287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |   1 +
 src/offchannel.c | 338 +++++++++++++++++++++++++++++++++++++++++++++++
 src/offchannel.h |  29 ++++
 3 files changed, 368 insertions(+)
 create mode 100644 src/offchannel.c
 create mode 100644 src/offchannel.h

diff --git a/Makefile.am b/Makefile.am
index 275dd1b9..5c5db879 100644
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
index 00000000..0ec067cd
--- /dev/null
+++ b/src/offchannel.c
@@ -0,0 +1,338 @@
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
+	struct l_timeout *timeout;
+	int error;
+
+	struct wiphy_radio_work_item work;
+
+	bool roc_started : 1;
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
+static struct offchannel_info *find_offchannel(uint64_t wdev_id)
+{
+	return l_queue_find(offchannel_list, match_wdev, &wdev_id);
+}
+
+static void offchannel_free(void *user_data)
+{
+	struct offchannel_info *info =3D user_data;
+
+	if (info->timeout)
+		l_timeout_remove(info->timeout);
+
+	l_free(info);
+}
+
+static void offchannel_destroy(void *user_data)
+{
+	struct offchannel_info *info =3D user_data;
+
+	if (info->destroy)
+		info->destroy(info->error, info->user_data);
+
+	l_queue_remove(offchannel_list, info);
+
+	offchannel_free(info);
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
+		goto error;
+	}
+
+	info->error =3D nl80211_parse_attrs(msg, NL80211_ATTR_COOKIE,
+					&info->roc_cookie, NL80211_ATTR_UNSPEC);
+	if (info->error < 0) {
+		l_error("Could not parse ROC cookie");
+		goto error;
+	}
+
+	return;
+
+error:
+	offchannel_cancel(info->wdev_id, info->work.id);
+}
+
+static void offchannel_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct offchannel_info *info =3D user_data;
+
+	info->error =3D -EBUSY;
+
+	offchannel_cancel(info->wdev_id, info->work.id);
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
+	/*
+	 * Don't rely on kernel timers for cleanup. This timeout is modified
+	 * when the ROC is started and will time the actual duration at that
+	 * point. If this timer expires prior to ROC starting the caller will
+	 * be notified with -EBUSY in the destroy callback. In addition the
+	 * offchannel_info is tracked in a queue only at this point so the
+	 * queue will only have one outstanding item per wdev.
+	 */
+	info->timeout =3D l_timeout_create_ms(info->duration, offchannel_timeout,
+						info, NULL);
+	l_queue_push_head(offchannel_list, info);
+
+	return false;
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
+static void offchannel_work_destroy(struct wiphy_radio_work_item *item)
+{
+	struct offchannel_info *info =3D l_container_of(item,
+						struct offchannel_info, work);
+
+	/*
+	 * Cancelled even before the kernel replied to the command. This
+	 * could happen due to an IO error, parsing error, or if a very short
+	 * duration is used. But if so there is no need to cancel ROC since the
+	 * driver never went off channel in the first place.
+	 */
+	if (info->roc_cmd_id) {
+		info->error =3D -ECANCELED;
+		l_genl_family_cancel(nl80211, info->roc_cmd_id);
+		goto destroy;
+	}
+
+	/*
+	 * If info->roc_cmd_id is zero but we still have no cookie, something
+	 * happened in offchannel_roc_cb. Basically, the command failed. The ROC
+	 * does not need to be cancelled and destroy can be called immediately.
+	 * An appropriate error will have been set by offchannel_roc_cb.
+	 */
+	if (!info->roc_cookie)
+		goto destroy;
+
+	/*
+	 * Cancelled prior to ROC completing, cancel ROC, and set -ECANCELLED
+	 */
+	if (info->roc_started && info->timeout) {
+		offchannel_cancel_roc(info);
+
+		l_timeout_remove(info->timeout);
+		info->timeout =3D NULL;
+
+		info->error =3D -ECANCELED;
+	}
+
+	/* Otherwise the ROC finished normally */
+
+destroy:
+	offchannel_destroy(info);
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
+
+	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id),
+					&info->work, 1, &offchannel_work_ops);
+}
+
+void offchannel_cancel(uint64_t wdev_id, uint32_t id)
+{
+	wiphy_radio_work_done(wiphy_find_by_wdev(wdev_id), id);
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
+	info =3D find_offchannel(wdev_id);
+	if (!info)
+		return;
+
+	/* ROC must have been started elsewhere, not by IWD */
+	if (info->roc_cookie !=3D cookie)
+		return;
+
+	switch (cmd) {
+	case NL80211_CMD_REMAIN_ON_CHANNEL:
+		l_timeout_modify_ms(info->timeout, info->duration);
+
+		info->roc_started =3D true;
+
+		if (info->started)
+			info->started(info->user_data);
+
+		break;
+	case NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL:
+		/* No matching ROC call? This shouldn't happen... */
+		if (L_WARN_ON(!info->roc_started))
+			return;
+
+		l_timeout_remove(info->timeout);
+		info->timeout =3D NULL;
+
+		info->error =3D 0;
+		offchannel_cancel(info->wdev_id, info->work.id);
+
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
+	l_queue_destroy(offchannel_list, offchannel_free);
+}
+
+IWD_MODULE(offchannel, offchannel_init, offchannel_exit);
+IWD_MODULE_DEPENDS(offchannel, wiphy);
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

--===============1760216171661223287==--

