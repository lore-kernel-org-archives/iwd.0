Content-Type: multipart/mixed; boundary="===============3361234829452888159=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/12] netdev: support RX only and TX modify keys
Date: Mon, 04 Oct 2021 09:48:56 -0700
Message-ID: <20211004164902.2274318-6-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============3361234829452888159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements the new handshake callback for setting an RX only
key. This uses NEW_KEY as well as the new kernel key format. Once
the NEW_KEY callback comes in netdev calls back into eapol with
success or failure. If successful eapol will ultimately set the
PTK again after sending message 4. netdev_set_tk was modified to
handle this new case and rather than set the new key, it does
SET_KEY to modify the new PTK as TX/RX.
---
 src/netdev.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index c6867ce3..8847c4a9 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -170,6 +170,9 @@ struct netdev {
 =

 	struct l_queue *ft_ds_list;
 =

+	handshake_install_rx_tk_cb_t rx_tk_cb;
+	void *rx_tk_data;
+
 	bool connected : 1;
 	bool associated : 1;
 	bool operational : 1;
@@ -1731,6 +1734,34 @@ error:
 	netdev_setting_keys_failed(nhs, err);
 }
 =

+static void netdev_new_rx_pairwise_key_cb(struct l_genl_msg *msg, void *da=
ta)
+{
+	struct netdev_handshake_state *nhs =3D data;
+	struct netdev *netdev =3D nhs->netdev;
+	int err =3D l_genl_msg_get_error(msg);
+
+	nhs->pairwise_new_key_cmd_id =3D 0;
+
+	netdev->rx_tk_cb(err =3D=3D 0, netdev->rx_tk_data);
+
+	netdev->rx_tk_cb =3D NULL;
+	netdev->rx_tk_data =3D NULL;
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
+	return;
+
+error:
+	netdev_setting_keys_failed(nhs, err);
+}
+
 static struct l_genl_msg *netdev_build_cmd_new_key_pairwise(
 							struct netdev *netdev,
 							uint32_t cipher,
@@ -1752,6 +1783,54 @@ static struct l_genl_msg *netdev_build_cmd_new_key_p=
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
+				&netdev->handshake->ptk_index);
+	l_genl_msg_append_attr(msg, NL80211_KEY_MODE, 1, &key_mode);
+	l_genl_msg_leave_nested(msg);
+
+	return msg;
+}
+
 static void netdev_group_timeout_cb(struct l_timeout *timeout, void *user_=
data)
 {
 	struct netdev_handshake_state *nhs =3D user_data;
@@ -1776,6 +1855,61 @@ static void netdev_group_timeout_cb(struct l_timeout=
 *timeout, void *user_data)
 	netdev_connect_ok(nhs->netdev);
 }
 =

+static void netdev_set_tx_tk(struct handshake_state *hs)
+{
+	struct netdev_handshake_state *nhs =3D
+		l_container_of(hs, struct netdev_handshake_state, super);
+	struct netdev *netdev =3D nhs->netdev;
+	struct l_genl_msg *msg =3D netdev_build_cmd_set_key_tx(netdev);
+
+	nhs->pairwise_new_key_cmd_id =3D
+		l_genl_family_send(nl80211, msg, netdev_new_pairwise_key_cb,
+						nhs, NULL);
+	if (nhs->pairwise_new_key_cmd_id > 0)
+		return;
+
+	l_genl_msg_unref(msg);
+
+	netdev_setting_keys_failed(nhs, -EIO);
+}
+
+static void netdev_set_rx_tk(struct handshake_state *hs, uint8_t key_idx,
+				const uint8_t *tk, uint32_t cipher,
+				handshake_install_rx_tk_cb_t callback,
+				void *user_data)
+{
+	struct netdev_handshake_state *nhs =3D
+		l_container_of(hs, struct netdev_handshake_state, super);
+	uint8_t tk_buf[32];
+	struct netdev *netdev =3D nhs->netdev;
+	struct l_genl_msg *msg;
+	const uint8_t *addr =3D netdev_choose_key_address(nhs);
+	int err;
+
+	err =3D -ENOENT;
+	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
+		goto invalid_key;
+
+	msg =3D netdev_build_cmd_new_rx_key_pairwise(netdev, cipher, addr, tk_buf,
+						crypto_cipher_key_len(cipher),
+						hs->ptk_index);
+	nhs->pairwise_new_key_cmd_id =3D
+		l_genl_family_send(nl80211, msg, netdev_new_rx_pairwise_key_cb,
+						nhs, NULL);
+
+	if (nhs->pairwise_new_key_cmd_id > 0) {
+		netdev->rx_tk_cb =3D callback;
+		netdev->rx_tk_data =3D user_data;
+		return;
+	}
+
+	err =3D -EIO;
+	l_genl_msg_unref(msg);
+
+invalid_key:
+	netdev_setting_keys_failed(nhs, err);
+}
+
 static void netdev_set_tk(struct handshake_state *hs,
 				const uint8_t *tk, uint32_t cipher)
 {
@@ -1819,6 +1953,15 @@ static void netdev_set_tk(struct handshake_state *hs,
 =

 	l_debug("%d", netdev->index);
 =

+	/*
+	 * The new PTK has been installed, message 4/4 sent, now enable TX on
+	 * the new key
+	 */
+	if (hs->use_ext_key_id && nhs->complete) {
+		netdev_set_tx_tk(hs);
+		return;
+	}
+
 	err =3D -ENOENT;
 	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
 		goto invalid_key;
@@ -6250,6 +6393,7 @@ static int netdev_init(void)
 	__handshake_set_install_tk_func(netdev_set_tk);
 	__handshake_set_install_gtk_func(netdev_set_gtk);
 	__handshake_set_install_igtk_func(netdev_set_igtk);
+	__handshake_set_install_rx_tk_func(netdev_set_rx_tk);
 =

 	__eapol_set_rekey_offload_func(netdev_set_rekey_offload);
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
-- =

2.31.1

--===============3361234829452888159==--

