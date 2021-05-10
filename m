Content-Type: multipart/mixed; boundary="===============7296080001797377815=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/11] ap: Send a specific error message on async AP start
 failure
Date: Mon, 10 May 2021 10:58:02 +0200
Message-ID: <20210510085806.174213-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7296080001797377815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We generate the DBus error reply type from the errno only when
ap_start() was failing synchronously, now also send the errno through
the callbacks so that we can also return a specific DBus reply when
failing asynchronously.  Thea AP autotest relies on receiving the
AlreadyExists DBus error.
---
 src/ap.c | 39 +++++++++++++++++++++++----------------
 src/ap.h |  4 ++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 9813a90d..a676bd28 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2058,9 +2058,11 @@ static void do_debug(const char *str, void *user_dat=
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

@@ -2075,8 +2077,8 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 =

 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
-
-		goto failed;
+		ap_start_failed(ap, l_genl_msg_get_error(msg));
+		return;
 	}
 =

 	if (ap->netconfig_dhcp) {
@@ -2091,17 +2093,13 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
d *user_data)
 							inet_ntoa(ia)) ||
 				!l_dhcp_server_start(ap->netconfig_dhcp)) {
 			l_error("DHCP server failed to start");
-			goto failed;
+			ap_start_failed(ap, -EINVAL);
+			return;
 		}
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
@@ -2216,12 +2214,12 @@ static void ap_ifaddr4_added_cb(int error, uint16_t=
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
@@ -2393,10 +2391,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
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
@@ -2815,8 +2815,10 @@ already_set:
 		/* Selected address already set, continue normally */
 		ap->cleanup_addr4 =3D false;
 =

-		if (!ap_start_send(ap))
+		if (!ap_start_send(ap)) {
+			ret =3D -EIO;
 			goto error;
+		}
 =

 		goto cleanup;
 	}
@@ -2834,6 +2836,7 @@ already_set:
 						ap_ifaddr4_added_cb, ap, NULL);
 	if (!ap->rtnl_add_cmd) {
 		l_error("Failed to add the IPv4 address");
+		ret =3D -EIO;
 		goto error;
 	}
 =

@@ -2847,7 +2850,7 @@ cleanup:
 	return;
 =

 error:
-	ap_start_failed(ap);
+	ap_start_failed(ap, ret);
 }
 =

 static void ap_ifaddr4_dump_cb(int error,
@@ -3205,13 +3208,17 @@ static void ap_if_event_func(enum ap_event_type typ=
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
index 2163d2db..30da3b34 100644
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

--===============7296080001797377815==--

