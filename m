Content-Type: multipart/mixed; boundary="===============5534862810472607766=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] netdev: move address generation into station
Date: Thu, 19 Mar 2020 13:03:50 -0700
Message-ID: <20200319200353.7001-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5534862810472607766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moves all the new address randomization/generation code into
station in order to support per-network address override. This was moved
into station because the address override setting will be set inside a
network config file, which netdev does not have any access to.

The way this is being achieved is to have the handshake set the desired
station address. Then, inside netdev, if the handshake spa address does
not match netdev's address we do a MAC change. Because of this wsc now
has to set the spa address before calling netdev_connect.
---
 src/netdev.c  | 37 +++++++++++++++----------------------
 src/station.c | 14 ++++++++++++++
 src/wsc.c     |  3 +++
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e1c775be..8f53463b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -166,7 +166,6 @@ static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
 static bool pae_over_nl80211;
-static bool mac_per_ssid;
 =

 static void do_debug(const char *str, void *user_data)
 {
@@ -2417,8 +2416,6 @@ static int netdev_begin_connection(struct netdev *net=
dev,
 		}
 	}
 =

-	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
-
 	/* set connected since the auth protocols cannot do so internally */
 	if (netdev->ap && auth_proto_start(netdev->ap))
 		netdev->connected =3D true;
@@ -2485,8 +2482,8 @@ static void netdev_mac_power_up_cb(int error, uint16_=
t type,
 	netdev->mac_change_cmd_id =3D 0;
 =

 	if (error) {
-		l_error("Error taking interface %u up for per-network MAC "
-			"generation: %s", netdev->index, strerror(-error));
+		l_error("Error taking interface %u up for setting per-network "
+			"MAC address: %s", netdev->index, strerror(-error));
 		netdev_mac_change_failed(netdev, req, error);
 		return;
 	}
@@ -2511,13 +2508,13 @@ static void netdev_mac_power_down_cb(int error, uin=
t16_t type,
 	netdev->mac_change_cmd_id =3D 0;
 =

 	if (error) {
-		l_error("Error taking interface %u down for per-network MAC "
-			"generation: %s", netdev->index, strerror(-error));
+		l_error("Error taking interface %u down for setting per-network"
+			" MAC address: %s", netdev->index, strerror(-error));
 		netdev_mac_change_failed(netdev, req, error);
 		return;
 	}
 =

-	l_debug("Setting generated address on ifindex: %d to: "MAC,
+	l_debug("Setting address on ifindex: %d to: "MAC,
 					netdev->index, MAC_STR(req->addr));
 	netdev->mac_change_cmd_id =3D l_rtnl_set_mac(rtnl, netdev->index,
 					req->addr, true,
@@ -2555,18 +2552,15 @@ static void netdev_mac_power_down_cb(int error, uin=
t16_t type,
  */
 static int netdev_start_powered_mac_change(struct netdev *netdev,
 					struct scan_bss *bss,
-					struct l_genl_msg *cmd_connect)
+					struct l_genl_msg *cmd_connect,
+					const uint8_t *new_addr)
 {
 	struct rtnl_data *req;
-	uint8_t new_addr[6];
-
-	wiphy_generate_address_from_ssid(netdev->wiphy, (const char *)bss->ssid,
-						new_addr);
 =

 	/*
 	 * MAC has already been changed previously, no need to again
 	 */
-	if (!memcmp(new_addr, netdev->addr, sizeof(new_addr)))
+	if (!memcmp(new_addr, netdev->addr, sizeof(netdev->addr)))
 		return -EALREADY;
 =

 	req =3D l_new(struct rtnl_data, 1);
@@ -2614,9 +2608,14 @@ static int netdev_connect_common(struct netdev *netd=
ev,
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
 =

-	if (mac_per_ssid) {
+	/*
+	 * If the handshake address does not match netdevs, the MAC needs to be
+	 * changed
+	 */
+	if (memcmp(netdev->addr, hs->spa, ETH_ALEN) !=3D 0) {
 		int ret =3D netdev_start_powered_mac_change(netdev, bss,
-								cmd_connect);
+								cmd_connect,
+								hs->spa);
 		if (ret !=3D -EALREADY)
 			return ret;
 	}
@@ -4664,7 +4663,6 @@ static int netdev_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 	const struct l_settings *settings =3D iwd_get_config();
-	const char *rand_addr_str;
 =

 	if (rtnl)
 		return -EALREADY;
@@ -4700,11 +4698,6 @@ static int netdev_init(void)
 					&pae_over_nl80211))
 		pae_over_nl80211 =3D true;
 =

-	rand_addr_str =3D l_settings_get_value(settings, "General",
-						"AddressRandomization");
-	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
-		mac_per_ssid =3D true;
-
 	watchlist_init(&netdev_watches, NULL);
 	netdev_list =3D l_queue_new();
 =

diff --git a/src/station.c b/src/station.c
index 36b41f64..1b9a204c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -871,10 +871,12 @@ static struct handshake_state *station_handshake_setu=
p(struct station *station,
 {
 	enum security security =3D network_get_security(network);
 	struct l_settings *settings =3D network_get_settings(network);
+	const struct l_settings *iwd_settings =3D iwd_get_config();
 	struct wiphy *wiphy =3D station->wiphy;
 	struct handshake_state *hs;
 	const char *ssid;
 	uint32_t eapol_proto_version;
+	const char *addr_setting;
 =

 	hs =3D netdev_handshake_state_new(station->netdev);
 =

@@ -934,6 +936,18 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 		hs->erp_cache =3D erp_cache_get(network_get_ssid(network));
 =

+	addr_setting =3D l_settings_get_value(iwd_settings, "General",
+						"AddressRandomization");
+	if (addr_setting && !strcmp(addr_setting, "network")) {
+		uint8_t new_addr[6];
+
+		wiphy_generate_address_from_ssid(wiphy, (const char *)bss->ssid,
+							new_addr);
+		handshake_state_set_supplicant_address(hs, new_addr);
+	} else
+		handshake_state_set_supplicant_address(hs,
+					netdev_get_address(station->netdev));
+
 	return hs;
 =

 no_psk:
diff --git a/src/wsc.c b/src/wsc.c
index 393e8d8d..bdca241a 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -382,6 +382,9 @@ static int wsc_enrollee_connect(struct wsc_enrollee *ws=
ce, struct scan_bss *bss,
 	if (ies_num)
 		memcpy(ie_iov + 1, ies, sizeof(struct iovec) * ies_num);
 =

+	handshake_state_set_supplicant_address(hs,
+					netdev_get_address(wsce->netdev));
+
 	r =3D netdev_connect(wsce->netdev, bss, hs, ie_iov, 1 + ies_num,
 				wsc_enrollee_netdev_event,
 				wsc_enrollee_connect_cb, wsce);
-- =

2.21.1

--===============5534862810472607766==--

