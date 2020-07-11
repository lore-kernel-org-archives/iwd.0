Content-Type: multipart/mixed; boundary="===============7649797929907727371=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/18] p2p: Stop discovery after GO Negotiation Req error
Date: Sat, 11 Jul 2020 03:00:36 +0200
Message-ID: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7649797929907727371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we were in discovery only to be able to receive the target peer's
GO Negotiation Request (i.e. we have no users requesting discovery)
and we've received the frame and decided that the connection has
failed, exit discovery.
---
 src/p2p.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index b8c299a3..095a05cd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1403,6 +1403,10 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		l_error("GO Negotiation Request parse error %s (%i)",
 			strerror(-r), -r);
 		p2p_connect_failed(dev);
+
+		if (l_queue_isempty(dev->discovery_users))
+			p2p_device_discovery_stop(dev);
+
 		status =3D P2P_STATUS_FAIL_INVALID_PARAMS;
 		goto respond;
 	}
@@ -1420,6 +1424,10 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 		}
 =

 		p2p_connect_failed(dev);
+
+		if (l_queue_isempty(dev->discovery_users))
+			p2p_device_discovery_stop(dev);
+
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
 		goto p2p_free;
 	}
@@ -1435,6 +1443,10 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 =

 		p2p_connect_failed(dev);
 		l_error("Persistent groups not supported");
+
+		if (l_queue_isempty(dev->discovery_users))
+			p2p_device_discovery_stop(dev);
+
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PARAMS;
 		goto p2p_free;
 	}
@@ -1442,6 +1454,10 @@ static void p2p_device_go_negotiation_req_cb(const s=
truct mmpdu_header *mpdu,
 	if (req_info.device_password_id !=3D dev->conn_password_id) {
 		p2p_connect_failed(dev);
 		l_error("Incompatible Password ID in the GO Negotiation Req");
+
+		if (l_queue_isempty(dev->discovery_users))
+			p2p_device_discovery_stop(dev);
+
 		status =3D P2P_STATUS_FAIL_INCOMPATIBLE_PROVISIONING;
 		goto p2p_free;
 	}
-- =

2.25.1

--===============7649797929907727371==--

