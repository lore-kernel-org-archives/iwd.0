Content-Type: multipart/mixed; boundary="===============5357381648291479477=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 07/11] netdev: Drop unused netdev_connect_wsc
Date: Mon, 21 Oct 2019 15:55:06 +0200
Message-ID: <20191021135510.12657-7-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5357381648291479477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

---
 src/netdev.c | 57 ----------------------------------------------------
 src/netdev.h |  9 ---------
 2 files changed, 66 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 93baa6ea..488370ab 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -52,7 +52,6 @@
 #include "src/device.h"
 #include "src/scan.h"
 #include "src/netdev.h"
-#include "src/wscutil.h"
 #include "src/ft.h"
 #include "src/util.h"
 #include "src/watchlist.h"
@@ -2509,62 +2508,6 @@ int netdev_connect(struct netdev *netdev, struct sca=
n_bss *bss,
 						event_filter, cb, user_data);
 }
 =

-int netdev_connect_wsc(struct netdev *netdev, struct scan_bss *bss,
-				struct handshake_state *hs,
-				netdev_event_func_t event_filter,
-				netdev_connect_cb_t cb,
-				netdev_eapol_event_func_t eapol_cb,
-				void *user_data)
-{
-	struct l_genl_msg *cmd_connect;
-	struct wsc_association_request request;
-	uint8_t *pdu;
-	size_t pdu_len;
-	void *ie;
-	size_t ie_len;
-	struct eapol_sm *sm;
-
-	if (netdev->type !=3D NL80211_IFTYPE_STATION &&
-			netdev->type !=3D NL80211_IFTYPE_P2P_CLIENT)
-		return -ENOTSUP;
-
-	if (netdev->connected)
-		return -EISCONN;
-
-	cmd_connect =3D netdev_build_cmd_connect(netdev, bss, hs, NULL, NULL, 0);
-	if (!cmd_connect)
-		return -EINVAL;
-
-	request.version2 =3D true;
-	request.request_type =3D WSC_REQUEST_TYPE_ENROLLEE_OPEN_8021X;
-
-	pdu =3D wsc_build_association_request(&request, &pdu_len);
-	if (!pdu)
-		goto error;
-
-	ie =3D ie_tlv_encapsulate_wsc_payload(pdu, pdu_len, &ie_len);
-	l_free(pdu);
-
-	if (!ie)
-		goto error;
-
-	l_genl_msg_append_attr(cmd_connect, NL80211_ATTR_IE, ie_len, ie);
-	l_free(ie);
-
-	handshake_state_set_eap_event_func(hs,
-					(handshake_eap_event_func_t) eapol_cb,
-					user_data);
-
-	sm =3D eapol_sm_new(hs);
-
-	return netdev_connect_common(netdev, cmd_connect, bss, hs, sm,
-						event_filter, cb, user_data);
-
-error:
-	l_genl_msg_unref(cmd_connect);
-	return -ENOMEM;
-}
-
 int netdev_disconnect(struct netdev *netdev,
 				netdev_disconnect_cb_t cb, void *user_data)
 {
diff --git a/src/netdev.h b/src/netdev.h
index 77da52de..b4da4fc2 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -107,9 +107,6 @@ typedef void (*netdev_watch_func_t)(struct netdev *netd=
ev,
 					enum netdev_watch_event event,
 					void *user_data);
 typedef void (*netdev_destroy_func_t)(void *user_data);
-typedef void (*netdev_eapol_event_func_t)(unsigned int event,
-					const void *event_data,
-					void *user_data);
 typedef void (*netdev_neighbor_report_cb_t)(struct netdev *netdev, int err,
 					const uint8_t *reports,
 					size_t reports_len, void *user_data);
@@ -150,12 +147,6 @@ int netdev_connect(struct netdev *netdev, struct scan_=
bss *bss,
 				size_t num_vendor_ies,
 				netdev_event_func_t event_filter,
 				netdev_connect_cb_t cb, void *user_data);
-int netdev_connect_wsc(struct netdev *netdev, struct scan_bss *bss,
-				struct handshake_state *hs,
-				netdev_event_func_t event_filter,
-				netdev_connect_cb_t cb,
-				netdev_eapol_event_func_t eapol_cb,
-				void *user_data);
 int netdev_disconnect(struct netdev *netdev,
 				netdev_disconnect_cb_t cb, void *user_data);
 int netdev_reassociate(struct netdev *netdev, struct scan_bss *target_bss,
-- =

2.20.1

--===============5357381648291479477==--

