Content-Type: multipart/mixed; boundary="===============7420363954937811455=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/10] ap: Send a specific error message on async AP start
 failure
Date: Fri, 05 Mar 2021 16:09:34 +0100
Message-ID: <20210305150936.868546-8-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7420363954937811455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We generate the DBus error reply type from the errno only when
ap_start() was failing synchronously, now also send the errno through
the callbacks so that we can also return a specific DBus reply when
failing asynchronously.  Thea AP autotest relies on receiving the
AlreadyExists DBus error.
---
 src/ap.c | 42 +++++++++++++++++++++++++-----------------
 src/ap.h |  4 ++++
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index c9eec2a7..8d58e66f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2123,9 +2123,11 @@ static void do_debug(const char *str, void *user_dat=
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

@@ -2140,22 +2142,17 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
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

 	if (ap->dhcp && !l_dhcp_server_start(ap->dhcp)) {
 		l_error("DHCP server failed to start");
-		goto failed;
+		ap_start_failed(ap, -EINVAL);
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
@@ -2266,12 +2263,12 @@ static void ap_ifaddr4_added_cb(int error, uint16_t=
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
@@ -2442,10 +2439,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
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
@@ -2598,16 +2597,20 @@ static void ap_netconfig_start(struct ap_state *ap)
 		goto error;
 =

 set_up_dhcp:
-	if (!ap_setup_dhcp(ap))
+	if (!ap_setup_dhcp(ap)) {
+		ret =3D -EIO;
 		goto error;
+	}
 =

 	/* See if the selected subnet is already set on the interface */
 	if (l_queue_find(ap->rtnl_addr4_dump, ap_addr4_match_subnet, ap)) {
 		/* Selected address already set, continue normally */
 		ap->cleanup_ip =3D false;
 =

-		if (!ap_start_send(ap))
+		if (!ap_start_send(ap)) {
+			ret =3D -EIO;
 			goto error;
+		}
 =

 		return;
 	}
@@ -2624,6 +2627,7 @@ set_up_dhcp:
 					ap_ifaddr4_added_cb, ap, NULL);
 	if (!ap->rtnl_add_cmd) {
 		l_error("Failed to add the IPv4 address");
+		ret =3D -EIO;
 		goto error;
 	}
 =

@@ -2631,7 +2635,7 @@ set_up_dhcp:
 	return;
 =

 error:
-	ap_start_failed(ap);
+	ap_start_failed(ap, ret);
 }
 =

 static void ap_ifaddr4_dump_cb(int error,
@@ -3004,13 +3008,17 @@ static void ap_if_event_func(enum ap_event_type typ=
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
index d776b27f..0a92f430 100644
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

--===============7420363954937811455==--

