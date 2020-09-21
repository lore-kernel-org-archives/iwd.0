Content-Type: multipart/mixed; boundary="===============2035965472945515025=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] p2p: Free parsed frame data in
 p2p_go_negotiation_confirm_cb
Date: Mon, 21 Sep 2020 15:52:07 +0200
Message-ID: <20200921135209.595749-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200921135209.595749-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2035965472945515025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index cc24b92f..49a57eb0 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1810,19 +1810,19 @@ static bool p2p_go_negotiation_confirm_cb(const str=
uct mmpdu_header *mpdu,
 	if (info.dialog_token !=3D dev->conn_go_dialog_token) {
 		l_error("GO Negotiation Response dialog token doesn't match");
 		p2p_connect_failed(dev);
-		return true;
+		goto cleanup;
 	}
 =

 	if (info.status !=3D P2P_STATUS_SUCCESS) {
 		l_error("GO Negotiation Confirmation status %i", info.status);
 		p2p_connect_failed(dev);
-		return true;
+		goto cleanup;
 	}
 =

 	/* Check whether WFD IE is required, validate it if present */
 	if (!p2p_device_validate_conn_wfd(dev, info.wfd, info.wfd_size)) {
 		p2p_connect_failed(dev);
-		return true;
+		goto cleanup;
 	}
 =

 	/*
@@ -1833,7 +1833,7 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 	if (!p2p_device_validate_channel_list(dev, &info.channel_list,
 						&info.operating_channel)) {
 		p2p_connect_failed(dev);
-		return true;
+		goto cleanup;
 	}
 =

 	/*
@@ -1852,7 +1852,7 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 			l_error("Bad operating channel in GO Negotiation "
 				"Confirmation");
 			p2p_connect_failed(dev);
-			return true;
+			goto cleanup;
 		}
 =

 		/*
@@ -1873,7 +1873,7 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 			l_error("Bad operating channel in GO Negotiation "
 				"Confirmation");
 			p2p_connect_failed(dev);
-			return true;
+			goto cleanup;
 		}
 =

 		dev->conn_go_oper_freq =3D frequency;
@@ -1892,6 +1892,8 @@ static bool p2p_go_negotiation_confirm_cb(const struc=
t mmpdu_header *mpdu,
 						p2p_config_timeout_destroy);
 	}
 =

+done:
+	p2p_clear_go_negotiation_confirmation(&info);
 	return true;
 }
 =

-- =

2.25.1

--===============2035965472945515025==--

