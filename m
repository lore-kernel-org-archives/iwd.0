Content-Type: multipart/mixed; boundary="===============1433467181744257395=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/11] p2p: Build and send the GO Negotiation Request
Date: Sat, 25 Apr 2020 11:09:26 +0200
Message-ID: <20200425090934.22285-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200425090934.22285-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1433467181744257395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index e758511f..46390930 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -120,6 +120,7 @@ static const int channels_scan_2_4_other[] =3D { 2, 3, =
4, 5, 7, 8, 9, 10 };
 enum {
 	FRAME_GROUP_DEFAULT =3D 0,
 	FRAME_GROUP_LISTEN,
+	FRAME_GROUP_CONNECT,
 };
 =

 static bool p2p_device_match(const void *a, const void *b)
@@ -292,6 +293,9 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	l_dbus_property_changed(dbus_get_bus(), p2p_device_get_path(dev),
 				IWD_P2P_INTERFACE, "AvailableConnections");
 =

+	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
+	frame_xchg_stop(dev->wdev_id);
+
 	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
 		/*
 		 * The device has been disabled in the mean time, all peers
@@ -321,6 +325,63 @@ static void p2p_connect_failed(struct p2p_device *dev)
 	p2p_connection_reset(dev);
 }
 =

+static void p2p_peer_frame_xchg(struct p2p_peer *peer, struct iovec *tx_bo=
dy,
+				const uint8_t *bssid,
+				unsigned int retry_interval,
+				unsigned int resp_timeout,
+				unsigned int retries_on_ack, bool own_channel,
+				uint32_t group_id, frame_xchg_cb_t cb, ...)
+{
+	struct p2p_device *dev =3D peer->dev;
+	struct iovec *frame;
+	const struct iovec *iov;
+	struct mmpdu_header *header;
+	uint8_t header_buf[32] __attribute__ ((aligned));
+	int iov_cnt;
+	uint32_t freq;
+	va_list args;
+
+	/* Header */
+	memset(header_buf, 0, sizeof(header_buf));
+	header =3D (void *) header_buf;
+	header->fc.protocol_version =3D 0;
+	header->fc.type =3D MPDU_TYPE_MANAGEMENT;
+	header->fc.subtype =3D MPDU_MANAGEMENT_SUBTYPE_ACTION;
+	/* Section 2.4.3 */
+	memcpy(header->address_1, peer->device_addr, 6);	/* DA */
+	memcpy(header->address_2, dev->addr, 6);		/* SA */
+	memcpy(header->address_3, bssid, 6);			/* BSSID */
+
+	for (iov =3D tx_body, iov_cnt =3D 0; iov->iov_base; iov++)
+		iov_cnt++;
+
+	frame =3D l_new(struct iovec, iov_cnt + 2);
+	frame[0].iov_base =3D header_buf;
+	frame[0].iov_len =3D (const uint8_t *) mmpdu_body(header) - header_buf;
+	memcpy(frame + 1, tx_body, sizeof(struct iovec) * iov_cnt);
+
+	freq =3D own_channel ?
+		scan_channel_to_freq(dev->listen_channel, SCAN_BAND_2_4_GHZ) :
+		peer->bss->frequency;
+
+	va_start(args, cb);
+	frame_xchg_startv(dev->wdev_id, frame, freq, retry_interval,
+				resp_timeout, retries_on_ack, group_id,
+				cb, dev, args);
+	va_end(args);
+
+	l_free(frame);
+}
+
+static const struct frame_xchg_prefix p2p_frame_go_neg_resp =3D {
+	/* Management -> Public Action -> P2P -> GO Negotiation Response */
+	.data =3D (uint8_t []) {
+		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
+		P2P_ACTION_GO_NEGOTIATION_RESP
+	},
+	.len =3D 7,
+};
+
 static void p2p_scan_destroy(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
@@ -328,9 +389,151 @@ static void p2p_scan_destroy(void *user_data)
 	dev->scan_id =3D 0;
 }
 =

+/*
+ * It seems that sending more than about 42 channels in a frame's Channel
+ * List attribute will baffle some devices enough that they will ignore
+ * the frame.
+ */
+#define MAX_CHANNELS 40
+
+static void p2p_add_freq_func(uint32_t freq, void *user_data)
+{
+	struct p2p_channel_entries *channel_entry =3D user_data;
+	uint8_t channel;
+	enum scan_band band;
+
+	if (channel_entry->n_channels >=3D MAX_CHANNELS)
+		return;
+
+	channel =3D scan_freq_to_channel(freq, &band);
+
+	if (band !=3D scan_oper_class_to_band((const uint8_t *) "XX\x4",
+						channel_entry->oper_class))
+		return;
+
+	channel_entry->channels[channel_entry->n_channels++] =3D channel;
+}
+
+static void p2p_device_fill_channel_list(struct p2p_device *dev,
+					struct p2p_channel_list_attr *attr)
+{
+	struct p2p_channel_entries *channel_entry;
+	unsigned int total_channels;
+
+	memcpy(attr->country, dev->listen_country, 3);
+	attr->channel_entries =3D l_queue_new();
+
+	channel_entry =3D l_malloc(sizeof(struct p2p_channel_entries) +
+					MAX_CHANNELS);
+	channel_entry->oper_class =3D 81;
+	channel_entry->n_channels =3D 0;
+	scan_freq_set_foreach(wiphy_get_supported_freqs(dev->wiphy),
+				p2p_add_freq_func, channel_entry);
+	l_queue_push_tail(attr->channel_entries, channel_entry);
+	total_channels =3D channel_entry->n_channels;
+
+	if (total_channels >=3D MAX_CHANNELS)
+		return;
+
+	channel_entry =3D l_malloc(sizeof(struct p2p_channel_entries) +
+					MAX_CHANNELS);
+	channel_entry->oper_class =3D 115;
+	channel_entry->n_channels =3D 0;
+	scan_freq_set_foreach(wiphy_get_supported_freqs(dev->wiphy),
+				p2p_add_freq_func, channel_entry);
+
+	if (total_channels + channel_entry->n_channels > MAX_CHANNELS)
+		channel_entry->n_channels =3D MAX_CHANNELS - total_channels;
+
+	l_queue_push_tail(attr->channel_entries, channel_entry);
+}
+
+static bool p2p_go_negotiation_resp_cb(const struct mmpdu_header *mpdu,
+					const void *body, size_t body_len,
+					int rssi, struct p2p_device *dev)
+{
+	/* TODO: handle the GO Negotiation Response frame */
+	return false;
+}
+
+static void p2p_go_negotiation_req_done(int error, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	if (error)
+		l_error("Sending the GO Negotiation Req failed: %s (%i)",
+			strerror(-error), -error);
+	else
+		l_error("No GO Negotiation Response after Request ACKed");
+
+	p2p_connect_failed(dev);
+}
+
 static void p2p_start_go_negotiation(struct p2p_device *dev)
 {
-	/* TODO: start GO Negotiation */
+	struct p2p_go_negotiation_req info =3D {};
+	uint8_t *req_body;
+	size_t req_len;
+	struct iovec iov[16];
+	int iov_len =3D 0;
+	/*
+	 * Devices should respond within 100ms but times of ~400ms are
+	 * often seen instead.
+	 *
+	 * 3.1.4.2: "The P2P Device that sent the Group Owner Negotiation
+	 * frame shall assume that Group Owner Negotiation failed and is
+	 * complete if it does not receive the next frame in the exchange
+	 * within 100 milliseconds of receiving an acknowledgement frame."
+	 */
+	unsigned int resp_timeout =3D 600;
+
+	info.dialog_token =3D 1;
+	info.capability =3D dev->capability;
+	info.go_intent =3D 0;	/* Don't want to be the GO */
+	info.go_tie_breaker =3D 0;
+	info.config_timeout.go_config_timeout =3D 50;	/* 500ms */
+	info.config_timeout.client_config_timeout =3D 50;	/* 500ms */
+	memcpy(info.listen_channel.country, dev->listen_country, 3);
+	info.listen_channel.oper_class =3D dev->listen_oper_class;
+	info.listen_channel.channel_num =3D dev->listen_channel;
+	memcpy(info.intended_interface_addr, dev->conn_addr, 6);
+
+	/*
+	 * In theory we support an empty set of operating channels for
+	 * our potential group as a GO but we have to include our
+	 * supported channels because the peer can only choose their
+	 * own channels from our list.  Use the listen channel as the
+	 * preferred operating channel because we have no preference.
+	 */
+	p2p_device_fill_channel_list(dev, &info.channel_list);
+	memcpy(info.operating_channel.country, dev->listen_country, 3);
+	info.operating_channel.oper_class =3D dev->listen_oper_class;
+	info.operating_channel.channel_num =3D dev->listen_channel;
+	info.device_info =3D dev->device_info;
+	info.device_password_id =3D dev->conn_password_id;
+
+	req_body =3D p2p_build_go_negotiation_req(&info, &req_len);
+	p2p_clear_go_negotiation_req(&info);
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
+	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
+				100, resp_timeout, 256, false,
+				FRAME_GROUP_CONNECT,
+				p2p_go_negotiation_req_done,
+				&p2p_frame_go_neg_resp,
+				p2p_go_negotiation_resp_cb, NULL);
 }
 =

 static void p2p_start_provision_discovery(struct p2p_device *dev)
-- =

2.25.1

--===============1433467181744257395==--

