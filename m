Content-Type: multipart/mixed; boundary="===============2262953288487502153=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/17] p2p: Move p2p_device_discovery_stop calls to
 connect_failed
Date: Wed, 09 Sep 2020 01:49:20 +0200
Message-ID: <20200908234933.301439-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2262953288487502153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move a few the calls to p2p_device_discovery_stop() done right after
p2p_connect_failed() directly to that function to reduce duplication.
---
 src/p2p.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 6c36d5b0..9983b0fc 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -518,6 +518,9 @@ static void p2p_connect_failed(struct p2p_device *dev)
 	if (dev->scan_id)
 		scan_cancel(dev->wdev_id, dev->scan_id);
 =

+	if (l_queue_isempty(dev->discovery_users))
+		p2p_device_discovery_stop(dev);
+
 	if (peer->wsc.pending_connect)
 		dbus_pending_reply(&peer->wsc.pending_connect,
 				dbus_error_failed(peer->wsc.pending_connect));
@@ -1749,10 +1752,6 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		l_error("GO Negotiation Request parse error %s (%i)",
 			strerror(-r), -r);
 		p2p_connect_failed(dev);
-
-		if (l_queue_isempty(dev->discovery_users))
-			p2p_device_discovery_stop(dev);
-
 		status =3D P2P_STATUS_FAIL_INVALID_PARAMS;
 		goto respond;
 	}
@@ -1770,10 +1769,6 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		}
 =

 		p2p_connect_failed(dev);
-
-		if (l_queue_isempty(dev->discovery_users))
-			p2p_device_discovery_stop(dev);
-
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
 		goto p2p_free;
 	}
@@ -1789,10 +1784,6 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 =

 		p2p_connect_failed(dev);
 		l_error("Persistent groups not supported");
-
-		if (l_queue_isempty(dev->discovery_users))
-			p2p_device_discovery_stop(dev);
-
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
 		goto p2p_free;
 	}
@@ -1800,10 +1791,6 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 	if (req_info.device_password_id !=3D dev->conn_password_id) {
 		p2p_connect_failed(dev);
 		l_error("Incompatible Password ID in the GO Negotiation Req");
-
-		if (l_queue_isempty(dev->discovery_users))
-			p2p_device_discovery_stop(dev);
-
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PROVISIONING;
 		goto p2p_free;
 	}
@@ -1812,10 +1799,6 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 	if (!p2p_device_validate_conn_wfd(dev, req_info.wfd,
 						req_info.wfd_size)) {
 		p2p_connect_failed(dev);
-
-		if (l_queue_isempty(dev->discovery_users))
-			p2p_device_discovery_stop(dev);
-
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
 		goto p2p_free;
 	}
@@ -1921,9 +1904,6 @@ static void p2p_go_neg_req_timeout(struct l_timeout *=
timeout, void *user_data)
 	l_debug("");
 =

 	p2p_connect_failed(dev);
-
-	if (l_queue_isempty(dev->discovery_users))
-		p2p_device_discovery_stop(dev);
 }
 =

 static bool p2p_go_negotiation_resp_cb(const struct mmpdu_header *mpdu,
-- =

2.25.1

--===============2262953288487502153==--

