Content-Type: multipart/mixed; boundary="===============5739987098672136097=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 2/5] netdev: support extended key IDs
Date: Fri, 08 Oct 2021 11:07:23 -0700
Message-ID: <20211008180726.2599788-2-prestwoj@gmail.com>
In-Reply-To: 20211008180726.2599788-1-prestwoj@gmail.com

--===============5739987098672136097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements the new handshake callback for setting a TK with
an extended key ID. The procedure is different from legacy zero
index TKs.

First the new TK is set as RX only. Then message 4 should be sent
out (so it uses the existing TK). This poses a slight issue with
PAE sockets since message order is not guaranteed. In this case
the 4th message is stored and sent after the new TK is installed.
Then the new TK is modified using SET_KEY to both send and
receive.

In the case of control port over NL80211 the above can be avoided
and we can simply install the new key, send message 4, and modify
the TK as TX + RX all in sequence, without waiting for any callbacks.
---
 src/netdev.c | 394 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 293 insertions(+), 101 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index de2f3d58..1316a07b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -87,6 +87,7 @@ struct netdev_handshake_state {
 	uint32_t group_management_new_key_cmd_id;
 	uint32_t set_station_cmd_id;
 	uint32_t set_pmk_cmd_id;
+	uint32_t pairwise_set_key_tx_cmd_id;
 	bool ptk_installed;
 	bool gtk_installed;
 	bool igtk_installed;
@@ -102,6 +103,12 @@ struct netdev_ft_over_ds_info {
 	bool parsed : 1;
 };
 =

+struct netdev_ext_key_info {
+	uint16_t proto;
+	bool noencrypt;
+	struct eapol_frame frame[0];
+};
+
 struct netdev {
 	uint32_t index;
 	uint64_t wdev_id;
@@ -170,6 +177,8 @@ struct netdev {
 =

 	struct l_queue *ft_ds_list;
 =

+	struct netdev_ext_key_info *ext_key_info;
+
 	bool connected : 1;
 	bool associated : 1;
 	bool operational : 1;
@@ -336,6 +345,11 @@ static void netdev_handshake_state_cancel_all(
 		l_genl_family_cancel(nl80211, nhs->set_pmk_cmd_id);
 		nhs->set_pmk_cmd_id =3D 0;
 	}
+
+	if (nhs->pairwise_set_key_tx_cmd_id) {
+		l_genl_family_cancel(nl80211, nhs->pairwise_set_key_tx_cmd_id);
+		nhs->pairwise_set_key_tx_cmd_id =3D 0;
+	}
 }
 =

 static void netdev_handshake_state_free(struct handshake_state *hs)
@@ -766,6 +780,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->handshake =3D NULL;
 	}
 =

+	if (netdev->ext_key_info) {
+		l_free(netdev->ext_key_info);
+		netdev->ext_key_info =3D NULL;
+	}
+
 	if (netdev->neighbor_report_cb) {
 		netdev->neighbor_report_cb(netdev, -ENOTCONN, NULL, 0,
 						netdev->user_data);
@@ -1693,6 +1712,24 @@ static void netdev_set_igtk(struct handshake_state *=
hs, uint16_t key_index,
 	netdev_setting_keys_failed(nhs, -EIO);
 }
 =

+static struct l_genl_msg *netdev_build_cmd_set_key_tx(struct netdev *netde=
v)
+{
+	uint8_t key_mode =3D NL80211_KEY_SET_TX;
+	struct l_genl_msg *msg =3D l_genl_msg_new_sized(NL80211_CMD_SET_KEY, 512);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN,
+					netdev->handshake->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
+	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1,
+				&netdev->handshake->active_tk_index);
+	l_genl_msg_append_attr(msg, NL80211_KEY_MODE, 1, &key_mode);
+	l_genl_msg_leave_nested(msg);
+
+	return msg;
+}
+
 static void netdev_new_pairwise_key_cb(struct l_genl_msg *msg, void *data)
 {
 	struct netdev_handshake_state *nhs =3D data;
@@ -1730,6 +1767,163 @@ error:
 	netdev_setting_keys_failed(nhs, err);
 }
 =

+static struct l_genl_msg *netdev_build_control_port_frame(struct netdev *n=
etdev,
+							const uint8_t *to,
+							uint16_t proto,
+							bool unencrypted,
+							const void *body,
+							size_t body_len)
+{
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_CONTROL_PORT_FRAME,
+							128 + body_len);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME, body_len, body);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, 2,
+				&proto);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, to);
+
+	if (unencrypted)
+		l_genl_msg_append_attr(msg,
+				NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT, 0, NULL);
+
+	return msg;
+}
+
+static void netdev_control_port_frame_cb(struct l_genl_msg *msg,
+							void *user_data)
+{
+	int err =3D l_genl_msg_get_error(msg);
+	const char *ext_error;
+
+	if (err >=3D 0)
+		return;
+
+	ext_error =3D l_genl_msg_get_extended_error(msg);
+	l_error("CMD_CONTROL_PORT failed: %s",
+			ext_error ? ext_error : strerror(-err));
+}
+
+static int netdev_control_port_write_pae(struct netdev *netdev,
+						const uint8_t *dest,
+						uint16_t proto,
+						const struct eapol_frame *ef,
+						bool noencrypt)
+{
+	int fd =3D l_io_get_fd(netdev->pae_io);
+	struct sockaddr_ll sll;
+	size_t frame_size =3D sizeof(struct eapol_header) +
+					L_BE16_TO_CPU(ef->header.packet_len);
+	ssize_t r;
+
+	memset(&sll, 0, sizeof(sll));
+	sll.sll_family =3D AF_PACKET;
+	sll.sll_ifindex =3D netdev->index;
+	sll.sll_protocol =3D htons(proto);
+	sll.sll_halen =3D ETH_ALEN;
+	memcpy(sll.sll_addr, dest, ETH_ALEN);
+
+	r =3D sendto(fd, ef, frame_size, 0,
+			(struct sockaddr *) &sll, sizeof(sll));
+	if (r < 0)
+		l_error("EAPoL write socket: %s", strerror(errno));
+
+	return r;
+}
+
+static int netdev_control_port_frame(uint32_t ifindex,
+					const uint8_t *dest, uint16_t proto,
+					const struct eapol_frame *ef,
+					bool noencrypt,
+					void *user_data)
+{
+	struct l_genl_msg *msg;
+	struct netdev *netdev;
+	size_t frame_size;
+
+	netdev =3D netdev_find(ifindex);
+	if (!netdev)
+		return -ENOENT;
+
+	frame_size =3D sizeof(struct eapol_header) +
+			L_BE16_TO_CPU(ef->header.packet_len);
+
+	if (!netdev->pae_over_nl80211)
+		return netdev_control_port_write_pae(netdev, dest, proto,
+							ef, noencrypt);
+
+	msg =3D netdev_build_control_port_frame(netdev, dest, proto, noencrypt,
+						ef, frame_size);
+	if (!msg)
+		return -ENOMEM;
+
+	if (!l_genl_family_send(nl80211, msg, netdev_control_port_frame_cb,
+				netdev, NULL)) {
+		l_genl_msg_unref(msg);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int netdev_set_key_tx(struct netdev *netdev)
+{
+	struct netdev_handshake_state *nhs =3D l_container_of(netdev->handshake,
+					struct netdev_handshake_state, super);
+	struct l_genl_msg *msg =3D netdev_build_cmd_set_key_tx(netdev);
+
+	nhs->pairwise_set_key_tx_cmd_id =3D l_genl_family_send(nl80211, msg,
+						netdev_new_pairwise_key_cb,
+						nhs, NULL);
+	if (nhs->pairwise_set_key_tx_cmd_id > 0)
+		return 0;
+
+	l_genl_msg_unref(msg);
+
+	return -EIO;
+}
+
+static void netdev_new_rx_pairwise_key_cb(struct l_genl_msg *msg, void *da=
ta)
+{
+	struct netdev_handshake_state *nhs =3D data;
+	struct netdev *netdev =3D nhs->netdev;
+	struct netdev_ext_key_info *info =3D netdev->ext_key_info;
+	int err =3D l_genl_msg_get_error(msg);
+
+	nhs->pairwise_new_key_cmd_id =3D 0;
+
+	if (err < 0) {
+		const char *ext_error =3D l_genl_msg_get_extended_error(msg);
+
+		l_error("New Key for RX Pairwise Key failed for ifindex: %d:%s",
+				netdev->index,
+				ext_error ? ext_error : strerror(-err));
+		goto error;
+	}
+
+	if (!info)
+		return;
+
+	err =3D netdev_control_port_write_pae(netdev, nhs->super.aa, info->proto,
+						info->frame, info->noencrypt);
+	l_free(netdev->ext_key_info);
+	netdev->ext_key_info =3D NULL;
+
+	if (err < 0)
+		goto error;
+
+	err =3D netdev_set_key_tx(netdev);
+	if (err < 0)
+		goto error;
+
+	return;
+
+error:
+	netdev_setting_keys_failed(nhs, err);
+}
+
 static struct l_genl_msg *netdev_build_cmd_new_key_pairwise(
 							struct netdev *netdev,
 							uint32_t cipher,
@@ -1751,6 +1945,36 @@ static struct l_genl_msg *netdev_build_cmd_new_key_p=
airwise(
 	return msg;
 }
 =

+static struct l_genl_msg *netdev_build_cmd_new_rx_key_pairwise(
+							struct netdev *netdev,
+							uint32_t cipher,
+							const uint8_t *aa,
+							const uint8_t *tk,
+							size_t tk_len,
+							uint8_t key_id)
+{
+	uint8_t key_mode =3D NL80211_KEY_NO_TX;
+	uint32_t key_type =3D NL80211_KEYTYPE_PAIRWISE;
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
+
+	l_genl_msg_append_attr(msg, NL80211_KEY_DATA, tk_len, tk);
+	l_genl_msg_append_attr(msg, NL80211_KEY_CIPHER, 4, &cipher);
+	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &key_id);
+	l_genl_msg_append_attr(msg, NL80211_KEY_MODE, 1, &key_mode);
+	l_genl_msg_append_attr(msg, NL80211_KEY_TYPE, 4, &key_type);
+
+	l_genl_msg_leave_nested(msg);
+
+	return msg;
+}
+
 static void netdev_group_timeout_cb(struct l_timeout *timeout, void *user_=
data)
 {
 	struct netdev_handshake_state *nhs =3D user_data;
@@ -1837,6 +2061,74 @@ invalid_key:
 	netdev_setting_keys_failed(nhs, err);
 }
 =

+static void netdev_set_ext_tk(struct handshake_state *hs, uint8_t key_idx,
+				const uint8_t *tk, uint32_t cipher,
+				const struct eapol_frame *step4, uint16_t proto,
+				bool noencrypt)
+{
+	struct netdev_handshake_state *nhs =3D
+		l_container_of(hs, struct netdev_handshake_state, super);
+	uint8_t tk_buf[32];
+	struct netdev *netdev =3D nhs->netdev;
+	struct l_genl_msg *msg;
+	const uint8_t *addr =3D netdev_choose_key_address(nhs);
+	int err;
+	size_t frame_size =3D sizeof(struct eapol_header) +
+				L_BE16_TO_CPU(step4->header.packet_len);
+
+	err =3D -ENOENT;
+	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
+		goto error;
+
+	msg =3D netdev_build_cmd_new_rx_key_pairwise(netdev, cipher, addr, tk_buf,
+						crypto_cipher_key_len(cipher),
+						hs->active_tk_index);
+	nhs->pairwise_new_key_cmd_id =3D
+		l_genl_family_send(nl80211, msg, netdev_new_rx_pairwise_key_cb,
+						nhs, NULL);
+
+	if (!nhs->pairwise_new_key_cmd_id)
+		goto io_error;
+
+	/*
+	 * Without control port we cannot guarantee the order that messages go
+	 * out and must wait for NEW_KEY to call back before sending message 4
+	 */
+	if (!netdev->pae_over_nl80211) {
+		netdev->ext_key_info =3D l_malloc(
+					sizeof(struct netdev_ext_key_info) +
+					frame_size);
+		memcpy(netdev->ext_key_info->frame, step4, frame_size);
+		netdev->ext_key_info->proto =3D proto;
+		netdev->ext_key_info->noencrypt =3D noencrypt;
+		return;
+	}
+
+	/*
+	 * Otherwise, order of messages will be guaranteed. Therefore we can
+	 * send send message 4, and set the TK to TX (below) without waiting for
+	 * any callbacks
+	 */
+	err =3D netdev_control_port_frame(netdev->index, netdev->handshake->aa,
+					proto, step4, noencrypt, NULL);
+	if (err < 0)
+		goto error;
+
+	/* Then toggle to RX + TX */
+	err =3D netdev_set_key_tx(netdev);
+	if (err < 0)
+		goto error;
+
+	return;
+
+io_error:
+	err =3D -EIO;
+	l_genl_msg_unref(msg);
+
+error:
+	netdev_setting_keys_failed(nhs, err);
+}
+
 static void netdev_set_pmk_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev_handshake_state *nhs =3D user_data;
@@ -5123,107 +5415,6 @@ static void netdev_control_port_frame_event(struct =
l_genl_msg *msg,
 						frame, frame_len, unencrypted);
 }
 =

-static struct l_genl_msg *netdev_build_control_port_frame(struct netdev *n=
etdev,
-							const uint8_t *to,
-							uint16_t proto,
-							bool unencrypted,
-							const void *body,
-							size_t body_len)
-{
-	struct l_genl_msg *msg;
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_CONTROL_PORT_FRAME,
-							128 + body_len);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME, body_len, body);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, 2,
-				&proto);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, to);
-
-	if (unencrypted)
-		l_genl_msg_append_attr(msg,
-				NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT, 0, NULL);
-
-	return msg;
-}
-
-static void netdev_control_port_frame_cb(struct l_genl_msg *msg,
-							void *user_data)
-{
-	int err =3D l_genl_msg_get_error(msg);
-	const char *ext_error;
-
-	if (err >=3D 0)
-		return;
-
-	ext_error =3D l_genl_msg_get_extended_error(msg);
-	l_error("CMD_CONTROL_PORT failed: %s",
-			ext_error ? ext_error : strerror(-err));
-}
-
-static int netdev_control_port_write_pae(struct netdev *netdev,
-						const uint8_t *dest,
-						uint16_t proto,
-						const struct eapol_frame *ef,
-						bool noencrypt)
-{
-	int fd =3D l_io_get_fd(netdev->pae_io);
-	struct sockaddr_ll sll;
-	size_t frame_size =3D sizeof(struct eapol_header) +
-					L_BE16_TO_CPU(ef->header.packet_len);
-	ssize_t r;
-
-	memset(&sll, 0, sizeof(sll));
-	sll.sll_family =3D AF_PACKET;
-	sll.sll_ifindex =3D netdev->index;
-	sll.sll_protocol =3D htons(proto);
-	sll.sll_halen =3D ETH_ALEN;
-	memcpy(sll.sll_addr, dest, ETH_ALEN);
-
-	r =3D sendto(fd, ef, frame_size, 0,
-			(struct sockaddr *) &sll, sizeof(sll));
-	if (r < 0)
-		l_error("EAPoL write socket: %s", strerror(errno));
-
-	return r;
-}
-
-static int netdev_control_port_frame(uint32_t ifindex,
-					const uint8_t *dest, uint16_t proto,
-					const struct eapol_frame *ef,
-					bool noencrypt,
-					void *user_data)
-{
-	struct l_genl_msg *msg;
-	struct netdev *netdev;
-	size_t frame_size;
-
-	netdev =3D netdev_find(ifindex);
-	if (!netdev)
-		return -ENOENT;
-
-	frame_size =3D sizeof(struct eapol_header) +
-			L_BE16_TO_CPU(ef->header.packet_len);
-
-	if (!netdev->pae_over_nl80211)
-		return netdev_control_port_write_pae(netdev, dest, proto,
-							ef, noencrypt);
-
-	msg =3D netdev_build_control_port_frame(netdev, dest, proto, noencrypt,
-						ef, frame_size);
-	if (!msg)
-		return -ENOMEM;
-
-	if (!l_genl_family_send(nl80211, msg, netdev_control_port_frame_cb,
-				netdev, NULL)) {
-		l_genl_msg_unref(msg);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void netdev_unicast_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
@@ -6244,6 +6435,7 @@ static int netdev_init(void)
 	__handshake_set_install_tk_func(netdev_set_tk);
 	__handshake_set_install_gtk_func(netdev_set_gtk);
 	__handshake_set_install_igtk_func(netdev_set_igtk);
+	__handshake_set_install_ext_tk_func(netdev_set_ext_tk);
 =

 	__eapol_set_rekey_offload_func(netdev_set_rekey_offload);
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
-- =

2.31.1

--===============5739987098672136097==--

