Content-Type: multipart/mixed; boundary="===============2340020662652968573=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/17] p2p: Free parsed frame data in
 p2p_go_negotiation_resp_cb
Date: Wed, 09 Sep 2020 01:49:22 +0200
Message-ID: <20200908234933.301439-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2340020662652968573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 0ec83ac3..5ab03c87 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1943,7 +1943,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	if (resp_info.dialog_token !=3D 1) {
 		l_error("GO Negotiation Response dialog token doesn't match");
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	if (resp_info.status !=3D P2P_STATUS_SUCCESS) {
@@ -1956,12 +1956,12 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 						p2p_go_neg_req_timeout, dev,
 						p2p_go_neg_req_timeout_destroy);
 			p2p_device_discovery_start(dev);
-			return true;
+			goto p2p_free;
 		}
 =

 		l_error("GO Negotiation Response status %i", resp_info.status);
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	/*
@@ -1975,31 +1975,33 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 		if (resp_info.go_intent =3D=3D 0) {
 			/* Can't continue */
 			p2p_connect_failed(dev);
-			return true;
+			goto p2p_free;
 		}
 	}
 =

 	if (resp_info.capability.group_caps & P2P_GROUP_CAP_PERSISTENT_GROUP) {
 		l_error("Persistent groups not supported");
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	if (resp_info.device_password_id !=3D dev->conn_password_id) {
 		l_error("GO Negotiation Response WSC device password ID wrong");
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	if (!p2p_device_validate_channel_list(dev, &resp_info.channel_list,
-						&resp_info.operating_channel))
-		return true;
+						&resp_info.operating_channel)) {
+		p2p_connect_failed(dev);
+		goto p2p_free;
+	}
 =

 	/* Check whether WFD IE is required, validate it if present */
 	if (!p2p_device_validate_conn_wfd(dev, resp_info.wfd,
 						resp_info.wfd_size)) {
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	band =3D scan_oper_class_to_band(
@@ -2037,11 +2039,10 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 	confirm_body =3D p2p_build_go_negotiation_confirmation(&confirm_info,
 								&confirm_len);
 	confirm_info.wfd =3D NULL;
-	p2p_clear_go_negotiation_resp(&resp_info);
 =

 	if (!confirm_body) {
 		p2p_connect_failed(dev);
-		return true;
+		goto p2p_free;
 	}
 =

 	iov[iov_len].iov_base =3D confirm_body;
@@ -2053,6 +2054,9 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
 				0, 0, 0, false, FRAME_GROUP_CONNECT,
 				p2p_go_negotiation_confirm_done, NULL);
+
+p2p_free:
+	p2p_clear_go_negotiation_resp(&resp_info);
 	return true;
 }
 =

-- =

2.25.1

--===============2340020662652968573==--

