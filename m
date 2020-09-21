Content-Type: multipart/mixed; boundary="===============8531001818328207116=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] p2p: Free response frame payloads
Date: Mon, 21 Sep 2020 21:04:24 +0200
Message-ID: <20200921190425.615855-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200921190425.615855-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8531001818328207116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 49a57eb0..7e0fcf4d 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -2169,6 +2169,7 @@ respond:
 					p2p_go_negotiation_resp_err_done, NULL);
 =

 	l_debug("GO Negotiation Response sent with status %i", status);
+	l_free(resp_body);
 }
 =

 static void p2p_go_negotiation_confirm_done(int error, void *user_data)
@@ -2437,6 +2438,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
 				0, 0, 0, false, FRAME_GROUP_CONNECT,
 				p2p_go_negotiation_confirm_done, NULL);
+	l_free(confirm_body);
 =

 p2p_free:
 	p2p_clear_go_negotiation_resp(&resp_info);
@@ -2526,6 +2528,7 @@ static void p2p_start_go_negotiation(struct p2p_devic=
e *dev)
 				p2p_go_negotiation_req_done,
 				&p2p_frame_go_neg_resp,
 				p2p_go_negotiation_resp_cb, NULL);
+	l_free(req_body);
 }
 =

 static bool p2p_provision_disc_resp_cb(const struct mmpdu_header *mpdu,
@@ -2666,6 +2669,7 @@ static void p2p_start_provision_discovery(struct p2p_=
device *dev)
 				p2p_provision_disc_req_done,
 				&p2p_frame_pd_resp, p2p_provision_disc_resp_cb,
 				NULL);
+	l_free(req_body);
 }
 =

 static bool p2p_peer_get_info(struct p2p_peer *peer,
-- =

2.25.1

--===============8531001818328207116==--

