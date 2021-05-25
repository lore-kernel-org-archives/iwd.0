Content-Type: multipart/mixed; boundary="===============5494992882156608608=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/7] ap: Send a specific error message on async AP start
 failure
Date: Tue, 25 May 2021 14:55:06 +0200
Message-ID: <20210525125508.2695708-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5494992882156608608==
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
index 52587d9d..639c9101 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2054,9 +2054,11 @@ static void do_debug(const char *str, void *user_dat=
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

@@ -2071,22 +2073,18 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
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
@@ -2201,12 +2199,12 @@ static void ap_ifaddr4_added_cb(int error, uint16_t=
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
@@ -2378,10 +2376,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
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
@@ -3145,13 +3145,17 @@ static void ap_if_event_func(enum ap_event_type typ=
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
index b0100f34..9a03d3ae 100644
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

--===============5494992882156608608==--

