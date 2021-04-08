Content-Type: multipart/mixed; boundary="===============7567703080202722808=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] netdev: implement netdev_handshake_state_set_pmk
Date: Thu, 08 Apr 2021 08:46:44 -0700
Message-ID: <20210408154646.1182833-3-prestwoj@gmail.com>
In-Reply-To: <20210408154646.1182833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7567703080202722808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 8021x offloading procedure still does EAP in userspace which
negotiates the PMK. The kernel then expects to obtain this PMK
from userspace by calling SET_PMK. This then allows the firmware
to begin the 4-way handshake.

netdev_handshake_set_pmk kicks off the final userspace
actions prior to the firmware starting the 4-way handshake:

 - SET_PMK using PMK negotiated with EAP
 - SET_STATION (concurrently with SET_PMK)
 - Emit SETTING_KEYS event
 - netdev_connect_ok

One thing to note is that the kernel provides no way of knowing if
the 4-way handshake completed. Assuming SET_PMK/SET_STATION come
back with no errors, IWD assumes the PMK was valid. If not, or
due to some other issue in the 4-way, the kernel will send a
disconnect.
---
 src/netdev.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  2 ++
 2 files changed, 87 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index d8703ed2..dc4aa5bc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -82,6 +82,7 @@ struct netdev_handshake_state {
 	uint32_t group_new_key_cmd_id;
 	uint32_t group_management_new_key_cmd_id;
 	uint32_t set_station_cmd_id;
+	uint32_t set_pmk_cmd_id;
 	bool ptk_installed;
 	bool gtk_installed;
 	bool igtk_installed;
@@ -242,6 +243,11 @@ static void netdev_handshake_state_cancel_all(
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
@@ -1695,6 +1701,85 @@ invalid_key:
 	netdev_setting_keys_failed(nhs, err);
 }
 =

+static void try_offload_handshake_complete(struct netdev_handshake_state *=
nhs,
+						int err)
+{
+	struct netdev *netdev =3D nhs->netdev;
+
+	if (err < 0) {
+		l_error("Error with SET_PMK/SET_STATION");
+		netdev_setting_keys_failed(nhs, err);
+		return;
+	}
+
+	if (nhs->set_pmk_cmd_id =3D=3D 0 && nhs->set_station_cmd_id =3D=3D 0) {
+		handshake_event(netdev->handshake,
+				HANDSHAKE_EVENT_SETTING_KEYS);
+		netdev_connect_ok(netdev);
+	}
+}
+
+static void netdev_set_pmk_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev_handshake_state *nhs =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
+
+	nhs->set_pmk_cmd_id =3D 0;
+
+	try_offload_handshake_complete(nhs, err);
+}
+
+static void netdev_set_station_offload_cb(struct l_genl_msg *msg,
+						void *user_data)
+{
+	struct netdev_handshake_state *nhs =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
+
+	nhs->set_station_cmd_id =3D 0;
+
+	try_offload_handshake_complete(nhs, err);
+}
+
+void netdev_handshake_set_pmk(struct handshake_state *hs)
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
+
+	msg =3D nl80211_build_set_station_authorized(netdev->index,
+							netdev->handshake->aa);
+
+	nhs->set_station_cmd_id =3D l_genl_family_send(nl80211, msg,
+						netdev_set_station_offload_cb,
+						nhs, NULL);
+	if (!nhs->set_station_cmd_id) {
+		l_error("Failed to SET_STATION");
+		netdev_setting_keys_failed(nhs, -EIO);
+	}
+}
+
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode)
 {
 	struct netdev_handshake_state *nhs =3D
diff --git a/src/netdev.h b/src/netdev.h
index c2c43290..2985e099 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -140,6 +140,8 @@ const char *netdev_get_path(struct netdev *netdev);
 struct handshake_state *netdev_handshake_state_new(struct netdev *netdev);
 struct handshake_state *netdev_get_handshake(struct netdev *netdev);
 =

+void netdev_handshake_set_pmk(struct handshake_state *hs);
+
 int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
 				struct handshake_state *hs,
 				const struct iovec *vendor_ies,
-- =

2.26.2

--===============7567703080202722808==--

