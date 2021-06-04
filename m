Content-Type: multipart/mixed; boundary="===============6469028308554749259=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/15] ap: Forward DHCP events to AP event handler
Date: Fri, 04 Jun 2021 03:50:45 +0200
Message-ID: <20210604015052.163727-8-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6469028308554749259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 42 ++++++++++++++++++++++++++++++++++++++----
 src/ap.h |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 0602792c..86e17387 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2044,6 +2044,28 @@ static void ap_start_failed(struct ap_state *ap, int=
 err)
 	l_free(ap);
 }
 =

+static void ap_dhcp_event_cb(struct l_dhcp_server *server,
+				enum l_dhcp_server_event event, void *user_data,
+				const struct l_dhcp_lease *lease)
+{
+	struct ap_state *ap =3D user_data;
+
+	switch (event) {
+	case L_DHCP_SERVER_EVENT_NEW_LEASE:
+		ap->ops->handle_event(AP_EVENT_DHCP_NEW_LEASE, lease,
+					ap->user_data);
+		break;
+
+	case L_DHCP_SERVER_EVENT_LEASE_EXPIRED:
+		ap->ops->handle_event(AP_EVENT_DHCP_LEASE_EXPIRED, lease,
+					ap->user_data);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static void ap_start_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
@@ -2056,10 +2078,20 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
d *user_data)
 		return;
 	}
 =

-	if (ap->netconfig_dhcp && !l_dhcp_server_start(ap->netconfig_dhcp)) {
-		l_error("DHCP server failed to start");
-		ap_start_failed(ap, -EINVAL);
-		return;
+	if (ap->netconfig_dhcp) {
+		if (!l_dhcp_server_start(ap->netconfig_dhcp)) {
+			l_error("DHCP server failed to start");
+			ap_start_failed(ap, -EINVAL);
+			return;
+		}
+
+		if (!l_dhcp_server_set_event_handler(ap->netconfig_dhcp,
+							ap_dhcp_event_cb,
+							ap, NULL)) {
+			l_error("l_dhcp_server_set_event_handler failed");
+			ap_start_failed(ap, -EIO);
+			return;
+		}
 	}
 =

 	ap->started =3D true;
@@ -3200,6 +3232,8 @@ static void ap_if_event_func(enum ap_event_type type,=
 const void *event_data,
 	case AP_EVENT_REGISTRATION_START:
 	case AP_EVENT_REGISTRATION_SUCCESS:
 	case AP_EVENT_PBC_MODE_EXIT:
+	case AP_EVENT_DHCP_NEW_LEASE:
+	case AP_EVENT_DHCP_LEASE_EXPIRED:
 		/* Ignored */
 		break;
 	}
diff --git a/src/ap.h b/src/ap.h
index 9a03d3ae..94d6c04d 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -33,6 +33,8 @@ enum ap_event_type {
 	AP_EVENT_REGISTRATION_START,
 	AP_EVENT_REGISTRATION_SUCCESS,
 	AP_EVENT_PBC_MODE_EXIT,
+	AP_EVENT_DHCP_NEW_LEASE,
+	AP_EVENT_DHCP_LEASE_EXPIRED,
 };
 =

 struct ap_event_start_failed_data {
-- =

2.30.2

--===============6469028308554749259==--

