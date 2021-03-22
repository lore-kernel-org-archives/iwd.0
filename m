Content-Type: multipart/mixed; boundary="===============5723191726999097749=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] netdev: add SAE offload support
Date: Mon, 22 Mar 2021 09:01:55 -0700
Message-ID: <20210322160156.392256-5-prestwoj@gmail.com>
In-Reply-To: <20210322160156.392256-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5723191726999097749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SAE offload support requires some minor tweaks to CMD_CONNECT
as well as special checks once the connect event comes in. Since
at this point we are fully connected.
---
 src/netdev.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

v2:
 * More comments explaining things.

diff --git a/src/netdev.c b/src/netdev.c
index 66a781bc..0cd139c2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1212,6 +1212,11 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss =3D NULL;
 	}
 =

+	/* Allow station to sync the PSK to disk */
+	if (netdev->handshake->offload)
+		handshake_event(netdev->handshake,
+				HANDSHAKE_EVENT_SETTING_KEYS);
+
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -1979,6 +1984,14 @@ process_resp_ies:
 			netdev_send_qos_map_set(netdev, qos_set, qos_len);
 	}
 =

+	/*
+	 * TODO: Only SAE/WPA3-personal offload is supported. In this case IWD
+	 * is 'done'. In the case of 8021x offload EAP still needs to take
+	 * place, so this must be updated accordingly when that is implemented.
+	 */
+	if (netdev->handshake->offload)
+		goto done;
+
 	if (netdev->sm) {
 		/*
 		 * Let station know about the roam so a state change can occur.
@@ -2002,6 +2015,7 @@ process_resp_ies:
 		return;
 	}
 =

+done:
 	netdev_connect_ok(netdev);
 =

 	return;
@@ -2601,7 +2615,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
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
@@ -2618,6 +2634,12 @@ static struct l_genl_msg *netdev_build_cmd_connect(s=
truct netdev *netdev,
 						bss->ssid_len, bss->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
 =

+	if (hs->offload) {
+		if (IE_AKM_IS_SAE(hs->akm_suite))
+			l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
+					strlen(hs->passphrase), hs->passphrase);
+	}
+
 	if (prev_bssid)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
 						prev_bssid);
@@ -2659,7 +2681,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
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
@@ -3020,6 +3044,9 @@ int netdev_connect(struct netdev *netdev, struct scan=
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
@@ -3038,13 +3065,14 @@ int netdev_connect(struct netdev *netdev, struct sc=
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

--===============5723191726999097749==--

