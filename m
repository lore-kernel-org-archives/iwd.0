Content-Type: multipart/mixed; boundary="===============3893692427798359480=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] netdev: separate netdev_{roam,connect}_event
Date: Fri, 02 Apr 2021 10:11:14 -0700
Message-ID: <20210402171118.915230-2-prestwoj@gmail.com>
In-Reply-To: <20210402171118.915230-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3893692427798359480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

netdev_connect_event was being reused for parsing of CMD_ROAM
attributes which made some amount of sense since these events
are nearly identical, but due to the nature of firmware roaming
there really isn't much IWD needs to parse from CMD_ROAM. In
addition netdev_connect_event was getting rather complicated
since it had to handle both CMD_ROAM and CMD_CONNECT.

The only bits of information IWD needs to parse from CMD_ROAM
is the roamed BSSID, authenticator IEs, and supplicant IEs. Since
this is so limited it now makes little sense to reuse the entire
netdev_connect_event function, and intead only parse what is
needed for CMD_ROAM.
---
 src/netdev.c | 60 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 9e665ee4..9f26ce68 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1897,7 +1897,6 @@ static void netdev_connect_event(struct l_genl_msg *m=
sg, struct netdev *netdev)
 	struct ie_tlv_iter iter;
 	const uint8_t *resp_ies =3D NULL;
 	size_t resp_ies_len;
-	uint8_t cmd =3D l_genl_msg_get_command(msg);
 =

 	l_debug("");
 =

@@ -1951,16 +1950,9 @@ static void netdev_connect_event(struct l_genl_msg *=
msg, struct netdev *netdev)
 			goto error;
 	}
 =

-	/*
-	 * A CMD_ROAM event will not have a status code, since it indicates
-	 * the hardware has already roamed. A failed roam on fullmac should
-	 * result in an explicit disconnect event.
-	 */
-	if (cmd =3D=3D NL80211_CMD_CONNECT) {
-		/* AP Rejected the authenticate / associate */
-		if (!status_code || *status_code !=3D 0)
-			goto error;
-	}
+	/* AP Rejected the authenticate / associate */
+	if (!status_code || *status_code !=3D 0)
+		goto error;
 =

 	if (!ies)
 		goto process_resp_ies;
@@ -2029,18 +2021,6 @@ process_resp_ies:
 		goto done;
 =

 	if (netdev->sm) {
-		/*
-		 * Let station know about the roam so a state change can occur.
-		 */
-		if (cmd =3D=3D NL80211_CMD_ROAM) {
-			if (netdev->event_filter)
-				netdev->event_filter(netdev,
-						NETDEV_EVENT_ROAMING,
-						NULL, netdev->user_data);
-			/* EAPoL started after GET_SCAN */
-			return;
-		}
-
 		/*
 		 * Start processing EAPoL frames now that the state machine
 		 * has all the input data even in FT mode.
@@ -4169,20 +4149,35 @@ static bool netdev_get_fw_scan_cb(int err, struct l=
_queue *bss_list,
  * The current handshake/netdev_handshake objects are reused after being
  * reset to allow eapol to happen again without it thinking this is a re-k=
ey.
  */
-static bool netdev_roam_event(struct l_genl_msg *msg, struct netdev *netde=
v)
+static void netdev_roam_event(struct l_genl_msg *msg, struct netdev *netde=
v)
 {
 	struct netdev_handshake_state *nhs =3D
 			l_container_of(netdev->handshake,
 					struct netdev_handshake_state,
 					super);
-	const uint8_t *mac;
+	struct l_genl_attr attr;
+	uint16_t type, len;
+	const void *data;
+	const uint8_t *mac =3D NULL;
 =

 	l_debug("");
 =

 	netdev->operational =3D false;
 =

-	if (nl80211_parse_attrs(msg, NL80211_ATTR_MAC, &mac,
-					NL80211_ATTR_UNSPEC) < 0) {
+	l_genl_attr_init(&attr, msg);
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_MAC:
+			mac =3D data;
+			break;
+		case NL80211_ATTR_REQ_IE:
+			parse_request_ies(netdev, data, len);
+			break;
+		}
+	}
+
+	if (!mac) {
 		l_error("Failed to parse ATTR_MAC from CMD_ROAM");
 		goto failed;
 	}
@@ -4199,14 +4194,16 @@ static bool netdev_roam_event(struct l_genl_msg *ms=
g, struct netdev *netdev)
 					netdev, NULL))
 		goto failed;
 =

-	return true;
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_ROAMING,
+					NULL, netdev->user_data);
 =

+	return;
 failed:
 	l_error("Failed to roam to new BSS");
 	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
 					MMPDU_REASON_CODE_UNSPECIFIED);
 =

-	return false;
 }
 =

 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
@@ -4251,9 +4248,8 @@ static void netdev_mlme_notify(struct l_genl_msg *msg=
, void *user_data)
 		netdev_associate_event(msg, netdev);
 		break;
 	case NL80211_CMD_ROAM:
-		if (!netdev_roam_event(msg, netdev))
-			return;
-		/* fall through */
+		netdev_roam_event(msg, netdev);
+		break;
 	case NL80211_CMD_CONNECT:
 		netdev_connect_event(msg, netdev);
 		break;
-- =

2.26.2

--===============3893692427798359480==--

