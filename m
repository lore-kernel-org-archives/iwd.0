Content-Type: multipart/mixed; boundary="===============8396822172622252117=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/19] p2p: Add the Provision Discovery frame sequence
Date: Thu, 23 Apr 2020 18:24:43 +0200
Message-ID: <20200423162447.15750-15-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8396822172622252117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When connecting to an existing group, use the Provision Discovery
Request/Response frame exchange before calling
p2p_start_client_provision().
---
 src/p2p.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 51a4fa80..14d1d11e 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -412,6 +412,15 @@ static const struct frame_xchg_prefix p2p_frame_go_neg=
_confirm =3D {
 	.len =3D 7,
 };
 =

+static const struct frame_xchg_prefix p2p_frame_pd_resp =3D {
+	/* Management -> Public Action -> P2P -> Provision Discovery Response */
+	.data =3D (uint8_t []) {
+		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
+		P2P_ACTION_PROVISION_DISCOVERY_RESP
+	},
+	.len =3D 7,
+};
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -1033,9 +1042,133 @@ static void p2p_start_go_negotiation(struct p2p_dev=
ice *dev)
 				p2p_go_negotiation_resp_cb, NULL);
 }
 =

+static bool p2p_provision_disc_resp_cb(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, struct p2p_device *dev)
+{
+	struct p2p_provision_discovery_resp info;
+	int r;
+
+	l_debug("");
+
+	if (!dev->conn_peer)
+		return true;
+
+	if (body_len < 8) {
+		l_error("Provision Discovery Response frame too short");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	r =3D p2p_parse_provision_disc_resp(body + 7, body_len - 7, &info);
+	if (r < 0) {
+		l_error("Provision Discovery Response parse error %s (%i)",
+			strerror(-r), -r);
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (info.dialog_token !=3D 2) {
+		l_error("Provision Discovery Response dialog token doesn't "
+			"match");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	if (info.wsc_config_method !=3D dev->conn_config_method) {
+		l_error("Provision Discovery Response WSC device password ID "
+			"wrong");
+		p2p_connect_failed(dev);
+		return true;
+	}
+
+	/*
+	 * If we're not joining an existing group, continue with Group
+	 * Formation now.
+	 */
+	if (!dev->conn_peer->group) {
+		p2p_start_go_negotiation(dev);
+		return true;
+	}
+
+	/*
+	 * Indended P2P Interface address is optional, we don't have the
+	 * BSSID of the group here.
+	 *
+	 * We might want to make sure that Group Formation is false but the
+	 * Capability attribute is also optional.
+	 */
+	dev->go_oper_freq =3D dev->conn_peer->bss->frequency;
+	memset(dev->go_interface_addr, 0, 6);
+	memcpy(dev->go_group_id.device_addr, dev->conn_peer->device_addr, 6);
+	l_strlcpy(dev->go_group_id.ssid,
+			(const char *) dev->conn_peer->bss->ssid,
+			dev->conn_peer->bss->ssid_len + 1);
+
+	/* Ready to start WSC */
+	p2p_start_client_provision(dev);
+	return true;
+}
+
+static void p2p_provision_disc_req_done(int error, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	if (error)
+		l_error("Sending the Provision Discovery Req failed: %s (%i)",
+			strerror(-error), -error);
+	else
+		l_error("No Provision Discovery Response after Request ACKed");
+
+	p2p_connect_failed(dev);
+}
+
 static void p2p_start_provision_discovery(struct p2p_device *dev)
 {
-	/* TODO: start Provision Discovery */
+	struct p2p_provision_discovery_req info =3D { .status =3D -1 };
+	uint8_t *req_body;
+	size_t req_len;
+	struct iovec iov[16];
+	int iov_len =3D 0;
+
+	/* This frame is pretty simple when P2Ps isn't supported */
+	info.dialog_token =3D 2;
+	info.capability =3D dev->capability;
+	info.device_info =3D dev->device_info;
+
+	if (dev->conn_peer->group) {
+		memcpy(info.group_id.device_addr, dev->conn_peer->bss->addr, 6);
+		memcpy(info.group_id.ssid, dev->conn_peer->bss->ssid,
+			dev->conn_peer->bss->ssid_len);
+	}
+
+	info.wsc_config_method =3D dev->conn_config_method;
+
+	req_body =3D p2p_build_provision_disc_req(&info, &req_len);
+	p2p_clear_provision_disc_req(&info);
+
+	if (!req_body) {
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	iov[iov_len].iov_base =3D req_body;
+	iov[iov_len].iov_len =3D req_len;
+	iov_len++;
+
+	/* WFD and other service IEs go here */
+
+	iov[iov_len].iov_base =3D NULL;
+
+	/*
+	 * Section 3.2.3: "The Provision Discovery Request frame shall be
+	 * sent to the P2P Device Address of the P2P Group Owner"
+	 */
+	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
+				200, 600, 8, false, FRAME_GROUP_CONNECT,
+				p2p_provision_disc_req_done,
+				&p2p_frame_pd_resp, p2p_provision_disc_resp_cb,
+				NULL);
 }
 =

 static bool p2p_peer_get_info(struct p2p_peer *peer,
-- =

2.20.1

--===============8396822172622252117==--

