Content-Type: multipart/mixed; boundary="===============7912185538532617676=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/9] ap: Implement P2P GO-side 4-way handshake IP Allocation
Date: Sat, 07 Aug 2021 04:10:44 +0200
Message-ID: <20210807021048.321664-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7912185538532617676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the struct handshake_state::support_ip_allocation field already
supported in eapol.c authenticator side to enable the P2P IP Allocation
mechanism in ap.c.  Add the P2P_GROUP_CAP_IP_ALLOCATION bit in P2P group
capabilities to signal the feature is now supported.

There's no harm in enabling this feature in every AP (not just P2P Group
Owner) but the clients won't know whether we support it other than
through that P2P-specific group capability bit.
---
 src/ap.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/p2p.c |  1 +
 2 files changed, 59 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index a16200df..052cd0c3 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -118,6 +118,7 @@ struct sta_state {
 	struct l_settings *wsc_settings;
 	uint8_t wsc_uuid_e[16];
 	bool wsc_v2;
+	struct l_dhcp_lease *ip_alloc_lease;
 };
 =

 struct ap_wsc_pbc_probe_record {
@@ -177,6 +178,10 @@ static void ap_sta_free(void *data)
 	if (sta->gtk_query_cmd_id)
 		l_genl_family_cancel(ap->nl80211, sta->gtk_query_cmd_id);
 =

+	if (sta->ip_alloc_lease && ap->netconfig_dhcp)
+		l_dhcp_server_lease_remove(ap->netconfig_dhcp,
+						sta->ip_alloc_lease);
+
 	ap_stop_handshake(sta);
 =

 	l_free(sta);
@@ -839,6 +844,12 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					callback, user_data, NULL, NULL);
 }
 =

+#define IP4_FROM_STR(str)						\
+	(__extension__ ({						\
+		struct in_addr ia;					\
+		inet_pton(AF_INET, str, &ia) =3D=3D 1 ? ia.s_addr : 0;	\
+	}))
+
 static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start,
 				const uint8_t *gtk_rsc)
 {
@@ -863,6 +874,9 @@ static void ap_start_handshake(struct sta_state *sta, b=
ool use_eapol_start,
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
 					sta->ap->gtk_index, gtk_rsc);
 =

+	if (ap->netconfig_dhcp)
+		sta->hs->support_ip_allocation =3D true;
+
 	sta->sm =3D eapol_sm_new(sta->hs);
 	if (!sta->sm) {
 		ap_stop_handshake(sta);
@@ -886,12 +900,28 @@ static void ap_handshake_event(struct handshake_state=
 *hs,
 		enum handshake_event event, void *user_data, ...)
 {
 	struct sta_state *sta =3D user_data;
+	struct ap_state *ap =3D sta->ap;
 	va_list args;
 =

 	va_start(args, user_data);
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_COMPLETE:
+		if (sta->ip_alloc_lease) {
+			/*
+			 * Move the lease from offered to active state if the
+			 * client has actually used it.  In any case drop our
+			 * reference to the lease, the server owns the lease
+			 * and if we want to keep our reference we'd need to
+			 * react to relevant server events.
+			 */
+			if (hs->support_ip_allocation)
+				l_dhcp_server_request(ap->netconfig_dhcp,
+							sta->ip_alloc_lease);
+
+			sta->ip_alloc_lease =3D NULL;
+		}
+
 		ap_new_rsna(sta);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
@@ -900,6 +930,34 @@ static void ap_handshake_event(struct handshake_state =
*hs,
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 		sta->sm =3D NULL;
 		ap_remove_sta(sta);
+		break;
+	case HANDSHAKE_EVENT_IP_REQUEST:
+	{
+		L_AUTO_FREE_VAR(char *, lease_addr_str) =3D NULL;
+		L_AUTO_FREE_VAR(char *, lease_netmask_str) =3D NULL;
+		char own_addr_str[INET_ADDRSTRLEN];
+
+		if (!sta->ip_alloc_lease)
+			sta->ip_alloc_lease =3D l_dhcp_server_discover(
+							ap->netconfig_dhcp,
+							0, NULL, sta->addr);
+
+		if (!sta->ip_alloc_lease) {
+			l_error("l_dhcp_server_discover() failed, see "
+				"IWD_DHCP_DEBUG output");
+			break;
+		}
+
+		lease_addr_str =3D l_dhcp_lease_get_address(sta->ip_alloc_lease);
+		lease_netmask_str =3D
+			l_dhcp_lease_get_netmask(sta->ip_alloc_lease);
+		l_rtnl_address_get_address(ap->netconfig_addr4, own_addr_str);
+
+		sta->hs->client_ip_addr =3D IP4_FROM_STR(lease_addr_str);
+		sta->hs->subnet_mask =3D IP4_FROM_STR(lease_netmask_str);
+		sta->hs->go_ip_addr =3D IP4_FROM_STR(own_addr_str);
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/src/p2p.c b/src/p2p.c
index 6790caef..8170bbe0 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1276,6 +1276,7 @@ static void p2p_group_start(struct p2p_device *dev)
 =

 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GROUP_FORMATION;
+	dev->capability.group_caps |=3D P2P_GROUP_CAP_IP_ALLOCATION;
 =

 	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, NULL, dev);
 	l_settings_free(config);
-- =

2.30.2

--===============7912185538532617676==--

