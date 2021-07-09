Content-Type: multipart/mixed; boundary="===============2897841444193565231=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] ap: Implement P2P GO-side 4-way handshake IP Allocation
Date: Fri, 09 Jul 2021 13:49:30 +0200
Message-ID: <20210709114931.378607-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2897841444193565231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the struct handshake_state::support_ip_allocation field already
supported in eapol.c authenticator side to enable the P2P IP Allocation
mechanism in ap.c.  Add the P2P_GROUP_CAP_IP_ALLOCATION bit in P2P group
capabilities to signal the feature is now supported.

There's no harm in enabling this feature in every AP (not just P2P Group
Owner) but the clients won't know whether we support it other than
through that P2P-specific group capability bit.  We might want to start
sending the IP Allocation Requests in our station mode 4-Way Handshakes
just in case the AP is IWD-based or implements the same logic.
Including the extra KDE would add 7 bytes (potentially wasted) in the
handshake frame 2/4.
---
 src/ap.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/p2p.c |  1 +
 2 files changed, 57 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index aa0f2511..cf52e144 100644
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

+	if (sta->ip_alloc_lease)
+		l_dhcp_server_release_lease(ap->netconfig_dhcp,
+						sta->ip_alloc_lease);
+
 	ap_stop_handshake(sta);
 =

 	l_free(sta);
@@ -830,6 +835,12 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					callback, user_data, NULL, NULL);
 }
 =

+#define IP4_FROM_STR(str)						\
+	(__extension__ ({						\
+		struct in_addr ia;					\
+		inet_pton(AF_INET, str, &ia) =3D=3D 1 ? ntohl(ia.s_addr) : 0; \
+	}))
+
 static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start,
 				const uint8_t *gtk_rsc)
 {
@@ -854,6 +865,34 @@ static void ap_start_handshake(struct sta_state *sta, =
bool use_eapol_start,
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
 					sta->ap->gtk_index, gtk_rsc);
 =

+	if (ap->netconfig_dhcp) {
+		L_AUTO_FREE_VAR(char *, lease_addr_str) =3D NULL;
+		L_AUTO_FREE_VAR(char *, lease_netmask_str) =3D NULL;
+		char own_addr_str[INET_ADDRSTRLEN];
+
+		if (!sta->ip_alloc_lease)
+			sta->ip_alloc_lease =3D l_dhcp_server_new_lease(
+							ap->netconfig_dhcp,
+							sta->addr);
+
+		if (!sta->ip_alloc_lease) {
+			l_error("l_dhcp_server_new_lease failed, see "
+				"IWD_DHCP_DEBUG output");
+			ap_stop_handshake(sta);
+			goto error;
+		}
+
+		lease_addr_str =3D l_dhcp_lease_get_address(sta->ip_alloc_lease);
+		lease_netmask_str =3D
+			l_dhcp_lease_get_netmask(sta->ip_alloc_lease);
+		l_rtnl_address_get_address(ap->netconfig_addr4, own_addr_str);
+
+		sta->hs->support_ip_allocation =3D true;
+		sta->hs->client_ip_addr =3D IP4_FROM_STR(lease_addr_str);
+		sta->hs->subnet_mask =3D IP4_FROM_STR(lease_netmask_str);
+		sta->hs->go_ip_addr =3D IP4_FROM_STR(own_addr_str);
+	}
+
 	sta->sm =3D eapol_sm_new(sta->hs);
 	if (!sta->sm) {
 		ap_stop_handshake(sta);
@@ -877,12 +916,18 @@ static void ap_handshake_event(struct handshake_state=
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
+		if (sta->ip_alloc_lease && !sta->hs->support_ip_allocation)
+			/* Client sent no IP Address Request */
+			l_dhcp_server_release_lease(ap->netconfig_dhcp,
+					l_steal_ptr(sta->ip_alloc_lease));
+
 		ap_new_rsna(sta);
 		break;
 	case HANDSHAKE_EVENT_FAILED:
@@ -2044,6 +2089,14 @@ static void ap_start_failed(struct ap_state *ap, int=
 err)
 	l_free(ap);
 }
 =

+static void ap_sta_lease_expired(void *data, void *user_data)
+{
+	struct sta_state *sta =3D data;
+
+	if (sta->ip_alloc_lease =3D=3D user_data)
+		sta->ip_alloc_lease =3D NULL;
+}
+
 static void ap_dhcp_event_cb(struct l_dhcp_server *server,
 				enum l_dhcp_server_event event, void *user_data,
 				const struct l_dhcp_lease *lease)
@@ -2057,6 +2110,9 @@ static void ap_dhcp_event_cb(struct l_dhcp_server *se=
rver,
 		break;
 =

 	case L_DHCP_SERVER_EVENT_LEASE_EXPIRED:
+		l_queue_foreach(ap->sta_states, ap_sta_lease_expired,
+				(void *) lease);
+
 		ap->ops->handle_event(AP_EVENT_DHCP_LEASE_EXPIRED, lease,
 					ap->user_data);
 		break;
diff --git a/src/p2p.c b/src/p2p.c
index 124372e6..3fb08009 100644
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

--===============2897841444193565231==--

