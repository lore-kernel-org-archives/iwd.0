Content-Type: multipart/mixed; boundary="===============1843162277242580120=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] netdev: implement netdev_set_pmk
Date: Fri, 09 Apr 2021 09:14:46 -0700
Message-ID: <20210409161446.1303013-3-prestwoj@gmail.com>
In-Reply-To: <20210409161446.1303013-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1843162277242580120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 8021x offloading procedure still does EAP in userspace which
negotiates the PMK. The kernel then expects to obtain this PMK
from userspace by calling SET_PMK. This then allows the firmware
to begin the 4-way handshake.

Using __eapol_install_set_pmk_func to install netdev_set_pmk,
netdev now gets called into once EAP finishes and can begin
the final userspace actions prior to the firmware starting
the 4-way handshake:

 - SET_PMK using PMK negotiated with EAP
 - Emit SETTING_KEYS event
 - netdev_connect_ok

One thing to note is that the kernel provides no way of knowing if
the 4-way handshake completed. Assuming SET_PMK/SET_STATION come
back with no errors, IWD assumes the PMK was valid. If not, or
due to some other issue in the 4-way, the kernel will send a
disconnect.
---
 src/netdev.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

v2:
 * used new __eapol_set_install_pmk_func
 * Removed SET_STATION call. After testing it appears this is
   not needed.
diff --git a/src/netdev.c b/src/netdev.c
index f41cd2c9..b3357068 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -83,6 +83,7 @@ struct netdev_handshake_state {
 	uint32_t group_new_key_cmd_id;
 	uint32_t group_management_new_key_cmd_id;
 	uint32_t set_station_cmd_id;
+	uint32_t set_pmk_cmd_id;
 	bool ptk_installed;
 	bool gtk_installed;
 	bool igtk_installed;
@@ -252,6 +253,11 @@ static void netdev_handshake_state_cancel_all(
 		l_genl_family_cancel(nl80211, nhs->set_station_cmd_id);
 		nhs->set_station_cmd_id =3D 0;
 	}
+
+	if (nhs->set_pmk_cmd_id) {
+		l_genl_family_cancel(nl80211, nhs->set_pmk_cmd_id);
+		nhs->set_pmk_cmd_id =3D 0;
+	}
 }
 =

 static void netdev_handshake_state_free(struct handshake_state *hs)
@@ -1705,6 +1711,54 @@ invalid_key:
 	netdev_setting_keys_failed(nhs, err);
 }
 =

+static void netdev_set_pmk_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev_handshake_state *nhs =3D user_data;
+	struct netdev *netdev =3D nhs->netdev;
+	int err =3D l_genl_msg_get_error(msg);
+
+	nhs->set_pmk_cmd_id =3D 0;
+
+	if (err < 0) {
+		l_error("Error with SET_PMK/SET_STATION");
+		netdev_setting_keys_failed(nhs, err);
+		return;
+	}
+
+	handshake_event(netdev->handshake, HANDSHAKE_EVENT_SETTING_KEYS);
+	netdev_connect_ok(netdev);
+}
+
+static void netdev_set_pmk(struct handshake_state *hs, const uint8_t *pmk,
+				size_t pmk_len)
+{
+	struct l_genl_msg *msg;
+	struct netdev_handshake_state *nhs =3D l_container_of(hs,
+				struct netdev_handshake_state, super);
+	struct netdev *netdev =3D nhs->netdev;
+
+	/* Only relevent for 8021x offload */
+	if (nhs->type !=3D CONNECTION_TYPE_8021X_OFFLOAD)
+		return;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_SET_PMK);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6, netdev->handshake->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK,
+				netdev->handshake->pmk_len,
+				netdev->handshake->pmk);
+
+	nhs->set_pmk_cmd_id =3D l_genl_family_send(nl80211, msg,
+							netdev_set_pmk_cb,
+							nhs, NULL);
+	if (!nhs->set_pmk_cmd_id) {
+		l_error("Failed to set SET_PMK");
+		netdev_setting_keys_failed(nhs, -EIO);
+		return;
+	}
+}
+
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode)
 {
 	struct netdev_handshake_state *nhs =3D
@@ -5566,6 +5620,7 @@ static int netdev_init(void)
 =

 	__eapol_set_rekey_offload_func(netdev_set_rekey_offload);
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
+	__eapol_set_install_pmk_func(netdev_set_pmk);
 =

 	unicast_watch =3D l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
 						netdev_unicast_notify,
-- =

2.26.2

--===============1843162277242580120==--

