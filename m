Content-Type: multipart/mixed; boundary="===============2777547795325126037=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] netdev: add SAE offload support
Date: Thu, 18 Mar 2021 10:20:38 -0700
Message-ID: <20210318172039.278896-5-prestwoj@gmail.com>
In-Reply-To: <20210318172039.278896-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2777547795325126037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SAE offload support requires some minor tweaks to CMD_CONNECT
as well as special checks once the connect event comes in. Since
at this point we are fully connected.
---
 src/netdev.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 66a781bc..f4b44b31 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1979,6 +1979,13 @@ process_resp_ies:
 			netdev_send_qos_map_set(netdev, qos_set, qos_len);
 	}
 =

+	/*
+	 * A successful connect event using offload means IWD is fully
+	 * connected and completed the 4-way handshake
+	 */
+	if (netdev->handshake->offload)
+		goto done;
+
 	if (netdev->sm) {
 		/*
 		 * Let station know about the roam so a state change can occur.
@@ -2002,6 +2009,7 @@ process_resp_ies:
 		return;
 	}
 =

+done:
 	netdev_connect_ok(netdev);
 =

 	return;
@@ -2601,7 +2609,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 						const struct iovec *vendor_ies,
 						size_t num_vendor_ies)
 {
-	uint32_t auth_type =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
+	uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) ?
+					NL80211_AUTHTYPE_SAE :
+					NL80211_AUTHTYPE_OPEN_SYSTEM;
 	struct l_genl_msg *msg;
 	struct iovec iov[4 + num_vendor_ies];
 	int iov_elems =3D 0;
@@ -2618,6 +2628,15 @@ static struct l_genl_msg *netdev_build_cmd_connect(s=
truct netdev *netdev,
 						bss->ssid_len, bss->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
 =

+	if (hs->offload) {
+		l_genl_msg_append_attr(msg, NL80211_ATTR_EXTERNAL_AUTH_SUPPORT,
+					0, NULL);
+
+		if (IE_AKM_IS_SAE(hs->akm_suite))
+			l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
+					strlen(hs->passphrase), hs->passphrase);
+	}
+
 	if (prev_bssid)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
 						prev_bssid);
@@ -2659,7 +2678,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 			l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES,
 							4, &nl_akm);
 =

-		if (hs->wpa_ie)
+		if (IE_AKM_IS_SAE(hs->akm_suite))
+			wpa_version =3D NL80211_WPA_VERSION_3;
+		else if (hs->wpa_ie)
 			wpa_version =3D NL80211_WPA_VERSION_1;
 		else
 			wpa_version =3D NL80211_WPA_VERSION_2;
@@ -3020,6 +3041,9 @@ int netdev_connect(struct netdev *netdev, struct scan=
_bss *bss,
 	switch (hs->akm_suite) {
 	case IE_RSN_AKM_SUITE_SAE_SHA256:
 	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		if (hs->offload)
+			goto build_cmd_connect;
+
 		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
 						netdev_sae_tx_associate,
 						netdev);
@@ -3038,13 +3062,14 @@ int netdev_connect(struct netdev *netdev, struct sc=
an_bss *bss,
 						netdev);
 		break;
 	default:
+build_cmd_connect:
 		cmd_connect =3D netdev_build_cmd_connect(netdev, bss, hs,
 					NULL, vendor_ies, num_vendor_ies);
 =

 		if (!cmd_connect)
 			return -EINVAL;
 =

-		if (is_rsn || hs->settings_8021x)
+		if (!hs->offload && (is_rsn || hs->settings_8021x))
 			sm =3D eapol_sm_new(hs);
 	}
 =

-- =

2.26.2

--===============2777547795325126037==--

