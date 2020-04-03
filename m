Content-Type: multipart/mixed; boundary="===============2742172336890570726=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/17] p2p: Respond to Probe Reqs when waiting for GO
 negotiation
Date: Fri, 03 Apr 2020 18:14:26 +0200
Message-ID: <20200403161430.14168-13-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2742172336890570726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some devices (a Wi-Fi Display dongle in my case) will send us Probe
Requests and wait for a response before they send us the GO
Negotiation Request that we're waiting for after the peer initially
replied with "Fail: Information Not Available" to our GO Negotiation
attempt.  Curiously this specific device I tested would even accept
a Probe Response with a mangled body such that the IE sequence couldn't
be parsed.
---
 src/p2p.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index a9e26b5d..244ec1b9 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1828,6 +1828,131 @@ static bool p2p_device_scan_start(struct p2p_device=
 *dev)
 	return dev->scan_id !=3D 0;
 }
 =

+static void p2p_probe_resp_done(int error, void *user_data)
+{
+	if (error)
+		l_error("Sending the Probe Response failed: %s (%i)",
+			strerror(-error), -error);
+}
+
+static void p2p_device_send_probe_resp(struct p2p_device *dev,
+					const uint8_t *dest_addr)
+{
+	uint8_t resp_buf[64] __attribute__ ((aligned));
+	size_t resp_len =3D 0;
+	struct p2p_probe_resp resp_info =3D {};
+	uint8_t *p2p_ie;
+	size_t p2p_ie_size;
+	struct wsc_probe_response wsc_info =3D {};
+	uint8_t *wsc_data;
+	size_t wsc_data_size;
+	uint8_t *wsc_ie;
+	size_t wsc_ie_size;
+	struct iovec iov[16];
+	int iov_len =3D 0;
+	/* TODO: extract some of these from wiphy features */
+	uint16_t capability =3D IE_BSS_CAP_PRIVACY | IE_BSS_CAP_SHORT_PREAMBLE;
+	struct mmpdu_header *header;
+	uint32_t freq;
+
+	/* Header */
+	memset(resp_buf, 0, sizeof(resp_buf));
+	header =3D (void *) resp_buf;
+	header->fc.protocol_version =3D 0;
+	header->fc.type =3D MPDU_TYPE_MANAGEMENT;
+	header->fc.subtype =3D MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE;
+	memcpy(header->address_1, dest_addr, 6);	/* DA */
+	memcpy(header->address_2, dev->addr, 6);	/* SA */
+	memcpy(header->address_3, dev->addr, 6);	/* BSSID */
+
+	resp_len =3D (const uint8_t *) mmpdu_body(header) - resp_buf;
+
+	resp_len +=3D 8;			/* Timestamp */
+	resp_buf[resp_len++] =3D 0x64;	/* Beacon Interval: 100 TUs */
+	resp_buf[resp_len++] =3D 0x00;
+	resp_buf[resp_len++] =3D capability >> 0;
+	resp_buf[resp_len++] =3D capability >> 8;
+	resp_buf[resp_len++] =3D IE_TYPE_SSID;
+	resp_buf[resp_len++] =3D 7;
+	resp_buf[resp_len++] =3D 'D';
+	resp_buf[resp_len++] =3D 'I';
+	resp_buf[resp_len++] =3D 'R';
+	resp_buf[resp_len++] =3D 'E';
+	resp_buf[resp_len++] =3D 'C';
+	resp_buf[resp_len++] =3D 'T';
+	resp_buf[resp_len++] =3D '-';
+	resp_buf[resp_len++] =3D IE_TYPE_SUPPORTED_RATES;
+	resp_buf[resp_len++] =3D 8;
+	resp_buf[resp_len++] =3D 0x8c;
+	resp_buf[resp_len++] =3D 0x12;
+	resp_buf[resp_len++] =3D 0x18;
+	resp_buf[resp_len++] =3D 0x24;
+	resp_buf[resp_len++] =3D 0x30;
+	resp_buf[resp_len++] =3D 0x48;
+	resp_buf[resp_len++] =3D 0x60;
+	resp_buf[resp_len++] =3D 0x6c;
+
+	resp_info.capability =3D dev->capability;
+	resp_info.device_info =3D dev->device_info;
+
+	p2p_ie =3D p2p_build_probe_resp(&resp_info, &p2p_ie_size);
+	if (!p2p_ie) {
+		l_error("Can't build our Probe Response P2P IE");
+		return;
+	}
+
+	wsc_info.state =3D WSC_STATE_CONFIGURED;
+	wsc_info.response_type =3D WSC_RESPONSE_TYPE_ENROLLEE_OPEN_8021X;
+	wsc_info.uuid_e[15] =3D 0x01;
+	wsc_info.serial_number[0] =3D '0';
+	wsc_info.primary_device_type =3D dev->device_info.primary_device_type;
+	l_strlcpy(wsc_info.device_name, dev->device_info.device_name,
+			sizeof(wsc_info.device_name));
+	wsc_info.config_methods =3D dev->device_info.wsc_config_methods;
+	wsc_info.rf_bands =3D 0x01;	/* 2.4GHz */
+	wsc_info.version2 =3D true;
+
+	wsc_data =3D wsc_build_probe_response(&wsc_info, &wsc_data_size);
+	if (!wsc_data) {
+		l_free(p2p_ie);
+		l_error("Can't build our Probe Response WSC payload");
+		return;
+	}
+
+	wsc_ie =3D ie_tlv_encapsulate_wsc_payload(wsc_data, wsc_data_size,
+						&wsc_ie_size);
+	l_free(wsc_data);
+	if (!wsc_ie) {
+		l_free(p2p_ie);
+		l_error("Can't build our Probe Response WSC IE");
+		return;
+	}
+
+	iov[iov_len].iov_base =3D resp_buf;
+	iov[iov_len].iov_len =3D resp_len;
+	iov_len++;
+
+	iov[iov_len].iov_base =3D p2p_ie;
+	iov[iov_len].iov_len =3D p2p_ie_size;
+	iov_len++;
+
+	iov[iov_len].iov_base =3D wsc_ie;
+	iov[iov_len].iov_len =3D wsc_ie_size;
+	iov_len++;
+
+	/* WFD and other service IEs go here */
+
+	iov[iov_len].iov_base =3D NULL;
+
+	freq =3D scan_channel_to_freq(dev->listen_channel, SCAN_BAND_2_4_GHZ);
+	frame_xchg_start(dev->wdev_id, iov, freq, 0, 0, false, 0,
+				p2p_probe_resp_done, dev, NULL);
+	l_debug("Probe Response tx queued");
+
+	l_free(p2p_ie);
+	l_free(wsc_ie);
+}
+
 static void p2p_device_probe_cb(const struct mmpdu_header *mpdu,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -1843,12 +1968,17 @@ static void p2p_device_probe_cb(const struct mmpdu_=
header *mpdu,
 	struct p2p_channel_attr *channel;
 	enum scan_band band;
 	uint32_t frequency;
+	bool from_conn_peer;
 =

 	l_debug("");
 =

 	if (!dev->scan_timeout && !dev->scan_id)
 		return;
 =

+	from_conn_peer =3D
+		dev->go_neg_req_timeout && dev->conn_peer &&
+		!memcmp(mpdu->address_2, dev->conn_peer->bss->addr, 6);
+
 	wsc_payload =3D ie_tlv_extract_wsc_payload(body, body_len, &wsc_len);
 	if (!wsc_payload)	/* Not a P2P Probe Req, ignore */
 		return;
@@ -1859,7 +1989,15 @@ static void p2p_device_probe_cb(const struct mmpdu_h=
eader *mpdu,
 	if (r < 0) {
 		l_error("Probe Request WSC IE parse error %s (%i)",
 			strerror(-r), -r);
-		return;
+
+		/*
+		 * Ignore requests with erroneous WSC IEs except if they
+		 * come from the peer we're currently connecting to as a
+		 * workaround for implementations sending invalid Probe
+		 * Requests.
+		 */
+		if (!from_conn_peer)
+			return;
 	}
 =

 	r =3D p2p_parse_probe_req(body, body_len, &p2p_info);
@@ -1875,8 +2013,20 @@ static void p2p_device_probe_cb(const struct mmpdu_h=
eader *mpdu,
 	/*
 	 * We don't currently have a use case for replying to Probe Requests
 	 * except when waiting for a GO Negotiation Request from our target
-	 * peer.
+	 * peer.  Some of those peers (seemingly running ancient and/or
+	 * hw-manufacturer-provided versions of wpa_s) will only send us GO
+	 * Negotiation Requests each time they receive our Probe Response
+	 * frame, even if that frame's body is unparsable.
 	 */
+	if (from_conn_peer) {
+		/*
+		 * TODO: use ap.c code to check if we match the SSID, BSSID,
+		 * DSSS Channel etc. in the Probe Request, and to build the
+		 * Response body.
+		 */
+		p2p_device_send_probe_resp(dev, mpdu->address_2);
+		goto p2p_free;
+	}
 =

 	/*
 	 * The peer's listen frequency may be different from ours.
-- =

2.20.1

--===============2742172336890570726==--

