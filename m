Content-Type: multipart/mixed; boundary="===============5745368926896668393=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/16] wsc: Add wsc_new_p2p_enrollee
Date: Mon, 28 Oct 2019 15:05:07 +0100
Message-ID: <20191028140508.13518-15-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5745368926896668393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now WSC could only be triggered by calling a DBus method and
success and error paths would end with a reply to the DBus method.
Instead use a wsc done callback pointer so that the WSC connection
logic can be triggered through DBus or a C API.

Export a function that adds a new entry point to start the WSC
connection for the P2P provisioning phase.  The function doesn't have
anything specific to P2P at this point.
---
 src/wsc.c | 31 +++++++++++++++++++++++++++++++
 src/wsc.h |  9 +++++++++
 2 files changed, 40 insertions(+)

diff --git a/src/wsc.c b/src/wsc.c
index 0c241ee3..6866571a 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -1197,6 +1197,37 @@ static void wsc_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+struct wsc *wsc_new_p2p_enrollee(struct netdev *netdev, struct scan_bss *t=
arget,
+					char *pin, wsc_done_cb_t done_cb,
+					void *user_data)
+{
+	struct wsc *wsc;
+
+	wsc =3D l_new(struct wsc, 1);
+	wsc->netdev =3D netdev;
+	wsc->target =3D target;
+	wsc->config_method =3D pin ? WSC_CONFIGURATION_METHOD_KEYPAD :
+		WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+	wsc->done_cb =3D done_cb;
+	wsc->done_data =3D user_data;
+	wsc->pin =3D l_strdup(pin);
+
+	wsc_connect(wsc);
+
+	/*
+	 * Wsc objects created this way are not handled in wsc_remove_interface,
+	 * the caller is expected to watch interfaces going away and there's no
+	 * need to handle the event in both places.
+	 */
+
+	return wsc;
+}
+
+void wsc_destroy(struct wsc *wsc)
+{
+	wsc_free(wsc);
+}
+
 static int wsc_init(void)
 {
 	l_debug("");
diff --git a/src/wsc.h b/src/wsc.h
index ada08c89..3995a647 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -20,6 +20,10 @@
  *
  */
 =

+struct wsc;
+struct netdev;
+struct scan_bss;
+
 struct wsc_credentials_info {
 	char ssid[33];
 	enum security security;
@@ -33,3 +37,8 @@ struct wsc_credentials_info {
 =

 typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *creds,
 				unsigned int n_creds, void *user_data);
+
+struct wsc *wsc_new_p2p_enrollee(struct netdev *netdev, struct scan_bss *t=
arget,
+					char *pin, wsc_done_cb_t done_cb,
+					void *user_data);
+void wsc_destroy(struct wsc *wsc);
-- =

2.20.1

--===============5745368926896668393==--

