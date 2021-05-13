Content-Type: multipart/mixed; boundary="===============4483712897013233949=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/9] ap: Send a specific error message on async AP start
 failure
Date: Thu, 13 May 2021 20:47:16 +0200
Message-ID: <20210513184718.265483-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210513184718.265483-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4483712897013233949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We generate the DBus error reply type from the errno only when
ap_start() was failing synchronously, now also send the errno through
the callbacks so that we can also return a specific DBus reply when
failing asynchronously.  Thea AP autotest relies on receiving the
AlreadyExists DBus error.
---
 src/ap.c | 32 ++++++++++++++++++--------------
 src/ap.h |  4 ++++
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index cffb2906..edb280ae 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2053,9 +2053,11 @@ static void do_debug(const char *str, void *user_dat=
a)
 	l_info("%s%s", prefix, str);
 }
 =

-static void ap_start_failed(struct ap_state *ap)
+static void ap_start_failed(struct ap_state *ap, int err)
 {
-	ap->ops->handle_event(AP_EVENT_START_FAILED, NULL, ap->user_data);
+	struct ap_event_start_failed_data data =3D { err };
+
+	ap->ops->handle_event(AP_EVENT_START_FAILED, &data, ap->user_data);
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
 =

@@ -2070,22 +2072,18 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
d *user_data)
 =

 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
-
-		goto failed;
+		ap_start_failed(ap, l_genl_msg_get_error(msg));
+		return;
 	}
 =

 	if (ap->netconfig_dhcp && !l_dhcp_server_start(ap->netconfig_dhcp)) {
 		l_error("DHCP server failed to start");
-		goto failed;
+		ap_start_failed(ap, -EINVAL);
+		return;
 	}
 =

 	ap->started =3D true;
 	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
-
-	return;
-
-failed:
-	ap_start_failed(ap);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -2200,12 +2198,12 @@ static void ap_ifaddr4_added_cb(int error, uint16_t=
 type, const void *data,
 =

 	if (error) {
 		l_error("Failed to set IP address");
-		ap_start_failed(ap);
+		ap_start_failed(ap, error);
 		return;
 	}
 =

 	if (!ap_start_send(ap))
-		ap_start_failed(ap);
+		ap_start_failed(ap, -EIO);
 }
 =

 static bool ap_parse_new_station_ies(const void *data, uint16_t len,
@@ -2377,10 +2375,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	switch (l_genl_msg_get_command(msg)) {
 	case NL80211_CMD_STOP_AP:
 		if (ap->start_stop_cmd_id) {
+			struct ap_event_start_failed_data data =3D { -ECANCELED };
+
 			l_genl_family_cancel(ap->nl80211,
 						ap->start_stop_cmd_id);
 			ap->start_stop_cmd_id =3D 0;
-			ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
+			ap->ops->handle_event(AP_EVENT_START_FAILED, &data,
 						ap->user_data);
 		} else if (ap->started) {
 			ap->started =3D false;
@@ -3143,13 +3143,17 @@ static void ap_if_event_func(enum ap_event_type typ=
e, const void *event_data,
 =

 	switch (type) {
 	case AP_EVENT_START_FAILED:
+	{
+		const struct ap_event_start_failed_data *data =3D event_data;
+
 		if (L_WARN_ON(!ap_if->pending))
 			break;
 =

-		reply =3D dbus_error_failed(ap_if->pending);
+		reply =3D dbus_error_from_errno(data->error, ap_if->pending);
 		dbus_pending_reply(&ap_if->pending, reply);
 		ap_if->ap =3D NULL;
 		break;
+	}
 =

 	case AP_EVENT_STARTED:
 		if (L_WARN_ON(!ap_if->pending))
diff --git a/src/ap.h b/src/ap.h
index ff6b635d..2f1422ca 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -35,6 +35,10 @@ enum ap_event_type {
 	AP_EVENT_PBC_MODE_EXIT,
 };
 =

+struct ap_event_start_failed_data {
+	int error;
+};
+
 struct ap_event_station_added_data {
 	const uint8_t *mac;
 	const uint8_t *assoc_ies;
-- =

2.27.0

--===============4483712897013233949==--

