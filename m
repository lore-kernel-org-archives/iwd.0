Content-Type: multipart/mixed; boundary="===============3730915289806993189=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 06/11] wsc: Replace netdev_connect_wsc with netdev_connect
 usage
Date: Mon, 21 Oct 2019 15:55:05 +0200
Message-ID: <20191021135510.12657-6-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3730915289806993189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

netdev_connect can achieve the same effect as netdev_connect_wsc but is
more flexible as it allows us to supply additional association IEs.  We
will need this capability to make P2P connections.  This way we're also
moving the WSC-specific bits to wsc.c from the crowded netdev.c.

Also make sure we free the handshake state on netdev_connect error in
wsc_connect().
---
 src/netdev.c |  2 +-
 src/wsc.c    | 43 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 48cdb5c1..93baa6ea 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2501,7 +2501,7 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 		if (!cmd_connect)
 			return -EINVAL;
 =

-		if (is_rsn)
+		if (is_rsn || hs->settings_8021x)
 			sm =3D eapol_sm_new(hs);
 	}
 =

diff --git a/src/wsc.c b/src/wsc.c
index 068cf82a..d971797a 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -360,7 +360,7 @@ static void wsc_credential_obtained(struct wsc *wsc,
 	wsc->n_creds +=3D 1;
 }
 =

-static void wsc_eapol_event(uint32_t event, const void *event_data,
+static void wsc_eap_event(uint32_t event, const void *event_data,
 							void *user_data)
 {
 	struct wsc *wsc =3D user_data;
@@ -434,6 +434,11 @@ static void wsc_connect(struct wsc *wsc)
 	struct handshake_state *hs;
 	struct l_settings *settings =3D l_settings_new();
 	struct scan_bss *bss =3D wsc->target;
+	int r;
+	struct wsc_association_request request;
+	uint8_t *pdu;
+	size_t pdu_len;
+	struct iovec ie_iov;
 =

 	wsc->target =3D NULL;
 =

@@ -473,19 +478,41 @@ static void wsc_connect(struct wsc *wsc)
 	}
 =

 	handshake_state_set_event_func(hs, wsc_handshake_event, wsc);
+	handshake_state_set_eap_event_func(hs, wsc_eap_event, wsc);
 	handshake_state_set_8021x_config(hs, settings);
 	wsc->eap_settings =3D settings;
 =

-	if (netdev_connect_wsc(wsc->netdev, bss, hs,
-					wsc_netdev_event, wsc_connect_cb,
-					wsc_eapol_event, wsc) < 0) {
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
-		handshake_state_free(hs);
-		return;
+	request.version2 =3D true;
+	request.request_type =3D WSC_REQUEST_TYPE_ENROLLEE_OPEN_8021X;
+
+	pdu =3D wsc_build_association_request(&request, &pdu_len);
+	if (!pdu) {
+		r =3D -ENOMEM;
+		goto error;
 	}
 =

+	ie_iov.iov_base =3D ie_tlv_encapsulate_wsc_payload(pdu, pdu_len,
+							&ie_iov.iov_len);
+	l_free(pdu);
+
+	if (!ie_iov.iov_base) {
+		r =3D -ENOMEM;
+		goto error;
+	}
+
+	r =3D netdev_connect(wsc->netdev, bss, hs, &ie_iov, 1, wsc_netdev_event,
+				wsc_connect_cb, wsc);
+	l_free(ie_iov.iov_base);
+
+	if (r < 0)
+		goto error;
+
 	wsc->wsc_association =3D true;
+	return;
+error:
+	handshake_state_free(hs);
+	dbus_pending_reply(&wsc->pending,
+				dbus_error_failed(wsc->pending));
 }
 =

 static void station_state_watch(enum station_state state, void *userdata)
-- =

2.20.1

--===============3730915289806993189==--

