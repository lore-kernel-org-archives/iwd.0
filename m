Content-Type: multipart/mixed; boundary="===============3958188405492352405=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Mon, 10 May 2021 12:12:04 +0200
Message-ID: <20210510101204.175551-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210510101204.175551-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3958188405492352405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Station callbacks expect a reason code (as opposed to status codes) with
this event type.  This shouldn't matter a lot because
station_disconnect_event() only actually looks at the value during
connection establishment so usually the "result" parameter is going to
be HANDSHAKE_FAILED meaning that we'd already be getting a reason code
in status_or_reason, but there could be corner cases where we got a
different "result".
---
 src/netdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4fbe813a..6c063df5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -771,10 +771,15 @@ static void netdev_connect_failed(struct netdev *netd=
ev,
 =

 	if (connect_cb)
 		connect_cb(netdev, result, &status_or_reason, connect_data);
-	else if (event_filter)
+	else if (event_filter) {
+		/* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
+		if (result !=3D NETDEV_RESULT_HANDSHAKE_FAILED)
+			status_or_reason =3D MMPDU_REASON_CODE_UNSPECIFIED;
+
 		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
 				&status_or_reason,
 				connect_data);
+	}
 }
 =

 static void netdev_disconnect_cb(struct l_genl_msg *msg, void *user_data)
-- =

2.27.0

--===============3958188405492352405==--

