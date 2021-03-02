Content-Type: multipart/mixed; boundary="===============8103216383130820610=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] ap: Send a specific error message on async AP start
 failure
Date: Tue, 02 Mar 2021 13:08:10 +0100
Message-ID: <20210302120813.757731-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210302120813.757731-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8103216383130820610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We generate the DBus error reply type from the errno only when
ap_start() was failing synchronously, now also send the errno through
the callbacks so that we can also return a specific DBus reply when
failing asynchronously.  Thea AP autotest relies on receiving the
AlreadyExists DBus error.
---
 src/ap.c | 34 +++++++++++++++++++---------------
 src/ap.h |  4 ++++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index d871f973..c5e6c43e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1979,9 +1979,11 @@ static void do_debug(const char *str, void *user_dat=
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

@@ -1996,22 +1998,18 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
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

 	if (ap->server && !l_dhcp_server_start(ap->server)) {
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
@@ -2122,12 +2120,12 @@ static void ap_ifaddr4_added_cb(int error, uint16_t=
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
@@ -2298,10 +2296,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
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
@@ -2749,7 +2749,7 @@ static void ap_netconfig_start(struct ap_state *ap, u=
int32_t existing_addr,
 			return;
 	}
 =

-	ap_start_failed(ap);
+	ap_start_failed(ap, err);
 }
 =

 static void ap_ifaddr4_dump_cb(int error,
@@ -3155,13 +3155,17 @@ static void ap_if_event_func(enum ap_event_type typ=
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
index dc57a0bb..40b39bc0 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -34,6 +34,10 @@ enum ap_event_type {
 	AP_EVENT_PBC_MODE_EXIT,
 };
 =

+struct ap_event_start_failed_data {
+	int error;
+};
+
 struct ap_event_station_added_data {
 	const uint8_t *mac;
 	const uint8_t *rsn_ie;
-- =

2.27.0

--===============8103216383130820610==--

