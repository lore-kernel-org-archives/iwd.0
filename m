Content-Type: multipart/mixed; boundary="===============6301091882087196723=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an auth-proto
Date: Fri, 03 Sep 2021 12:35:44 -0700
Message-ID: <20210903193544.13897-3-prestwoj@gmail.com>
In-Reply-To: <20210903193544.13897-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6301091882087196723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 545 +++++++++++++++++++++++++++------------------------
 src/owe.c    | 148 ++------------
 src/owe.h    |  12 +-
 3 files changed, 312 insertions(+), 393 deletions(-)

v3:
 * Deauth if OWE AKM is not in associate response RSN IE
 * Remove owe_sm forward declaration from netdev.h

diff --git a/src/netdev.c b/src/netdev.c
index 8592685c..db304c0d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -119,6 +119,7 @@ struct netdev {
 	void *user_data;
 	struct eapol_sm *sm;
 	struct auth_proto *ap;
+	struct owe_sm *owe_sm;
 	struct handshake_state *handshake;
 	uint32_t connect_cmd_id;
 	uint32_t disconnect_cmd_id;
@@ -752,6 +753,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->ap =3D NULL;
 	}
 =

+	if (netdev->owe_sm) {
+		owe_sm_free(netdev->owe_sm);
+		netdev->owe_sm =3D NULL;
+	}
+
 	eapol_preauth_cancel(netdev->index);
 =

 	if (netdev->handshake) {
@@ -2094,6 +2100,228 @@ static void netdev_driver_connected(struct netdev *=
netdev)
 		eapol_register(netdev->sm);
 }
 =

+static unsigned int ie_rsn_akm_suite_to_nl80211(enum ie_rsn_akm_suite akm)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+		return CRYPTO_AKM_8021X;
+	case IE_RSN_AKM_SUITE_PSK:
+		return CRYPTO_AKM_PSK;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+		return CRYPTO_AKM_FT_OVER_8021X;
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		return CRYPTO_AKM_FT_USING_PSK;
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return CRYPTO_AKM_8021X_SHA256;
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return CRYPTO_AKM_PSK_SHA256;
+	case IE_RSN_AKM_SUITE_TDLS:
+		return CRYPTO_AKM_TDLS;
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+		return CRYPTO_AKM_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
+		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+		return CRYPTO_AKM_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+		return CRYPTO_AKM_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_OWE:
+		return CRYPTO_AKM_OWE;
+	case IE_RSN_AKM_SUITE_OSEN:
+		return CRYPTO_AKM_OSEN;
+	}
+
+	return 0;
+}
+
+static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
+						struct handshake_state *hs,
+						const uint8_t *prev_bssid,
+						const struct iovec *vendor_ies,
+						size_t num_vendor_ies)
+{
+	struct netdev_handshake_state *nhs =3D
+		l_container_of(hs, struct netdev_handshake_state, super);
+	uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) ?
+					NL80211_AUTHTYPE_SAE :
+					NL80211_AUTHTYPE_OPEN_SYSTEM;
+	enum mpdu_management_subtype subtype =3D prev_bssid ?
+				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST :
+				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
+	struct l_genl_msg *msg;
+	struct iovec iov[64];
+	unsigned int n_iov =3D L_ARRAY_SIZE(iov);
+	unsigned int c_iov =3D 0;
+	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
+	uint8_t owe_dh_ie[5 + L_ECC_SCALAR_MAX_BYTES];
+	size_t dh_ie_len;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_CONNECT, 512);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ,
+							4, &netdev->frequency);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
+
+	switch (nhs->type) {
+	case CONNECTION_TYPE_SOFTMAC:
+	case CONNECTION_TYPE_FULLMAC:
+		break;
+	case CONNECTION_TYPE_SAE_OFFLOAD:
+		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
+					strlen(hs->passphrase), hs->passphrase);
+		break;
+	case CONNECTION_TYPE_PSK_OFFLOAD:
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
+		break;
+	case CONNECTION_TYPE_8021X_OFFLOAD:
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WANT_1X_4WAY_HS,
+					0, NULL);
+	}
+
+	if (prev_bssid)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
+						prev_bssid);
+
+	if (netdev->privacy)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_PRIVACY, 0, NULL);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
+
+	if (is_rsn) {
+		uint32_t nl_cipher;
+		uint32_t nl_akm;
+		uint32_t wpa_version;
+
+		if (hs->pairwise_cipher =3D=3D IE_RSN_CIPHER_SUITE_CCMP)
+			nl_cipher =3D CRYPTO_CIPHER_CCMP;
+		else
+			nl_cipher =3D CRYPTO_CIPHER_TKIP;
+
+		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
+					4, &nl_cipher);
+
+		if (hs->group_cipher =3D=3D IE_RSN_CIPHER_SUITE_CCMP)
+			nl_cipher =3D CRYPTO_CIPHER_CCMP;
+		else
+			nl_cipher =3D CRYPTO_CIPHER_TKIP;
+
+		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
+					4, &nl_cipher);
+
+		if (hs->mfp) {
+			uint32_t use_mfp =3D NL80211_MFP_REQUIRED;
+			l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP,
+								4, &use_mfp);
+		}
+
+		nl_akm =3D ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
+		if (nl_akm)
+			l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES,
+							4, &nl_akm);
+
+		if (IE_AKM_IS_SAE(hs->akm_suite))
+			wpa_version =3D NL80211_WPA_VERSION_3;
+		else if (hs->wpa_ie)
+			wpa_version =3D NL80211_WPA_VERSION_1;
+		else
+			wpa_version =3D NL80211_WPA_VERSION_2;
+
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
+						4, &wpa_version);
+
+		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT, 0, NULL);
+		c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
+	}
+
+	if (netdev->owe_sm) {
+		owe_build_dh_ie(netdev->owe_sm, owe_dh_ie, &dh_ie_len);
+		c_iov =3D iov_ie_append(iov, n_iov, c_iov, owe_dh_ie);
+	}
+
+	if (netdev->pae_over_nl80211)
+		l_genl_msg_append_attr(msg,
+				NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
+				0, NULL);
+
+	c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->mde);
+	c_iov =3D netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
+
+	mpdu_sort_ies(subtype, iov, c_iov);
+
+	if (vendor_ies && !L_WARN_ON(n_iov - c_iov < num_vendor_ies)) {
+		memcpy(iov + c_iov, vendor_ies,
+					sizeof(*vendor_ies) * num_vendor_ies);
+		c_iov +=3D num_vendor_ies;
+	}
+
+	if (c_iov)
+		l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
+
+	return msg;
+}
+
+static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev->connect_cmd_id =3D 0;
+
+	if (l_genl_msg_get_error(msg) >=3D 0) {
+		/*
+		 * connected should be false if the connect event hasn't come
+		 * in yet.  i.e. the CMD_CONNECT ack arrived first (typical).
+		 * Mark the connection as 'connected'
+		 */
+		if (!netdev->connected)
+			netdev_driver_connected(netdev);
+
+		return;
+	}
+
+	netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static bool netdev_retry_owe(struct netdev *netdev)
+{
+	struct iovec iov;
+
+	if (!owe_next_group(netdev->owe_sm))
+		return false;
+
+	iov.iov_base =3D netdev->handshake->vendor_ies;
+	iov.iov_len =3D netdev->handshake->vendor_ies_len;
+
+	netdev->connect_cmd =3D netdev_build_cmd_connect(netdev,
+					netdev->handshake, NULL, &iov, 1);
+
+	netdev->connect_cmd_id =3D l_genl_family_send(nl80211,
+						netdev->connect_cmd,
+						netdev_cmd_connect_cb, netdev,
+						NULL);
+
+	if (!netdev->connect_cmd_id)
+		return false;
+
+	netdev->connect_cmd =3D NULL;
+
+	return true;
+}
+
 static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *ne=
tdev)
 {
 	struct l_genl_attr attr;
@@ -2162,6 +2390,14 @@ static void netdev_connect_event(struct l_genl_msg *=
msg, struct netdev *netdev)
 			goto error;
 	}
 =

+	if (netdev->owe_sm && status_code && *status_code =3D=3D
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP) {
+		if (!netdev_retry_owe(netdev))
+			goto error;
+
+		return;
+	}
+
 	/* AP Rejected the authenticate / associate */
 	if (!status_code || *status_code !=3D 0)
 		goto error;
@@ -2175,8 +2411,12 @@ process_resp_ies:
 	if (resp_ies) {
 		const uint8_t *fte =3D NULL;
 		const uint8_t *qos_set =3D NULL;
+		const uint8_t *owe_dh =3D NULL;
+		size_t owe_dh_len =3D 0;
 		size_t qos_len =3D 0;
 		struct ie_ft_info ft_info;
+		struct ie_rsn_info info;
+		bool owe_akm_found =3D false;
 =

 		ie_tlv_iter_init(&iter, resp_ies, resp_ies_len);
 =

@@ -2203,7 +2443,53 @@ process_resp_ies:
 					data - 3,
 					ie_tlv_iter_get_length(&iter) + 3);
 				break;
+			case IE_TYPE_OWE_DH_PARAM:
+				if (!netdev->owe_sm)
+					continue;
+
+				owe_dh =3D data;
+				owe_dh_len =3D len;
+
+				break;
+
+			case IE_TYPE_RSN:
+				if (!netdev->owe_sm)
+					continue;
+
+				if (ie_parse_rsne(&iter, &info) < 0) {
+					l_error("could not parse RSN IE");
+					goto error;
+				}
+
+				/*
+				 * RFC 8110 Section 4.2
+				 * An AP agreeing to do OWE MUST include the OWE AKM in
+				 * the RSN element portion of the 802.11 association
+				 * response.
+				 */
+				if (info.akm_suites !=3D IE_RSN_AKM_SUITE_OWE) {
+					l_error("OWE AKM not included");
+					goto deauth;
+				}
+
+				owe_akm_found =3D true;
+
+				break;
+			}
+		}
+
+		if (netdev->owe_sm) {
+			if (!owe_dh || !owe_akm_found) {
+				l_error("OWE DH element/RSN not found");
+				goto error;
 			}
+
+			if (owe_process_dh_ie(netdev->owe_sm, owe_dh,
+						owe_dh_len) !=3D 0)
+				goto error;
+
+			owe_sm_free(netdev->owe_sm);
+			netdev->owe_sm =3D NULL;
 		}
 =

 		/* FILS handles its own FT key derivation */
@@ -2271,52 +2557,6 @@ deauth:
 							netdev, NULL);
 }
 =

-static unsigned int ie_rsn_akm_suite_to_nl80211(enum ie_rsn_akm_suite akm)
-{
-	switch (akm) {
-	case IE_RSN_AKM_SUITE_8021X:
-		return CRYPTO_AKM_8021X;
-	case IE_RSN_AKM_SUITE_PSK:
-		return CRYPTO_AKM_PSK;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
-		return CRYPTO_AKM_FT_OVER_8021X;
-	case IE_RSN_AKM_SUITE_FT_USING_PSK:
-		return CRYPTO_AKM_FT_USING_PSK;
-	case IE_RSN_AKM_SUITE_8021X_SHA256:
-		return CRYPTO_AKM_8021X_SHA256;
-	case IE_RSN_AKM_SUITE_PSK_SHA256:
-		return CRYPTO_AKM_PSK_SHA256;
-	case IE_RSN_AKM_SUITE_TDLS:
-		return CRYPTO_AKM_TDLS;
-	case IE_RSN_AKM_SUITE_SAE_SHA256:
-		return CRYPTO_AKM_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
-		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
-		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
-	case IE_RSN_AKM_SUITE_FILS_SHA256:
-		return CRYPTO_AKM_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FILS_SHA384:
-		return CRYPTO_AKM_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_OWE:
-		return CRYPTO_AKM_OWE;
-	case IE_RSN_AKM_SUITE_OSEN:
-		return CRYPTO_AKM_OSEN;
-	}
-
-	return 0;
-}
-
 static struct l_genl_msg *netdev_build_cmd_associate_common(
 							struct netdev *netdev)
 {
@@ -2602,28 +2842,6 @@ assoc_failed:
 	netdev->expect_connect_failure =3D true;
 }
 =

-static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-
-	netdev->connect_cmd_id =3D 0;
-
-	if (l_genl_msg_get_error(msg) >=3D 0) {
-		/*
-		 * connected should be false if the connect event hasn't come
-		 * in yet.  i.e. the CMD_CONNECT ack arrived first (typical).
-		 * Mark the connection as 'connected'
-		 */
-		if (!netdev->connected)
-			netdev_driver_connected(netdev);
-
-		return;
-	}
-
-	netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
-				MMPDU_STATUS_CODE_UNSPECIFIED);
-}
-
 static struct l_genl_msg *netdev_build_cmd_authenticate(struct netdev *net=
dev,
 							uint32_t auth_type)
 {
@@ -2777,64 +2995,6 @@ static void netdev_sae_tx_associate(void *user_data)
 	}
 }
 =

-static void netdev_owe_tx_authenticate(void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-	struct l_genl_msg *msg;
-
-	msg =3D netdev_build_cmd_authenticate(netdev,
-						NL80211_AUTHTYPE_OPEN_SYSTEM);
-
-	if (!l_genl_family_send(nl80211, msg, netdev_auth_cb,
-							netdev, NULL)) {
-		l_genl_msg_unref(msg);
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-		return;
-	}
-
-	netdev->auth_cmd =3D l_genl_msg_ref(msg);
-}
-
-static void netdev_owe_tx_associate(struct iovec *owe_iov, size_t n_owe_io=
v,
-					void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-	struct handshake_state *hs =3D netdev->handshake;
-	struct l_genl_msg *msg;
-	struct iovec iov[64];
-	unsigned int n_iov =3D L_ARRAY_SIZE(iov);
-	unsigned int c_iov =3D 0;
-	enum mpdu_management_subtype subtype =3D
-				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
-
-	msg =3D netdev_build_cmd_associate_common(netdev);
-
-	c_iov =3D netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
-
-	if (!L_WARN_ON(n_iov - c_iov < n_owe_iov)) {
-		memcpy(iov + c_iov, owe_iov, sizeof(*owe_iov) * n_owe_iov);
-		c_iov +=3D n_owe_iov;
-	}
-
-	mpdu_sort_ies(subtype, iov, c_iov);
-
-	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
-
-	/* If doing a non-FT Reassociation */
-	if (netdev->in_reassoc)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
-					netdev->ap->prev_bssid);
-
-	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb,
-							netdev, NULL)) {
-		l_genl_msg_unref(msg);
-		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-	}
-}
-
 static void netdev_fils_tx_authenticate(const uint8_t *body,
 					size_t body_len,
 					void *user_data)
@@ -2902,127 +3062,6 @@ static void netdev_fils_tx_associate(struct iovec *=
fils_iov, size_t n_fils_iov,
 	}
 }
 =

-static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
-						struct handshake_state *hs,
-						const uint8_t *prev_bssid,
-						const struct iovec *vendor_ies,
-						size_t num_vendor_ies)
-{
-	struct netdev_handshake_state *nhs =3D
-		l_container_of(hs, struct netdev_handshake_state, super);
-	uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) ?
-					NL80211_AUTHTYPE_SAE :
-					NL80211_AUTHTYPE_OPEN_SYSTEM;
-	enum mpdu_management_subtype subtype =3D prev_bssid ?
-				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST :
-				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
-	struct l_genl_msg *msg;
-	struct iovec iov[64];
-	unsigned int n_iov =3D L_ARRAY_SIZE(iov);
-	unsigned int c_iov =3D 0;
-	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_CONNECT, 512);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ,
-							4, &netdev->frequency);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
-
-	switch (nhs->type) {
-	case CONNECTION_TYPE_SOFTMAC:
-	case CONNECTION_TYPE_FULLMAC:
-		break;
-	case CONNECTION_TYPE_SAE_OFFLOAD:
-		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
-					strlen(hs->passphrase), hs->passphrase);
-		break;
-	case CONNECTION_TYPE_PSK_OFFLOAD:
-		l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
-		break;
-	case CONNECTION_TYPE_8021X_OFFLOAD:
-		l_genl_msg_append_attr(msg, NL80211_ATTR_WANT_1X_4WAY_HS,
-					0, NULL);
-	}
-
-	if (prev_bssid)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
-						prev_bssid);
-
-	if (netdev->privacy)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_PRIVACY, 0, NULL);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
-
-	if (is_rsn) {
-		uint32_t nl_cipher;
-		uint32_t nl_akm;
-		uint32_t wpa_version;
-
-		if (hs->pairwise_cipher =3D=3D IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher =3D CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher =3D CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
-					4, &nl_cipher);
-
-		if (hs->group_cipher =3D=3D IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher =3D CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher =3D CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
-					4, &nl_cipher);
-
-		if (hs->mfp) {
-			uint32_t use_mfp =3D NL80211_MFP_REQUIRED;
-			l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP,
-								4, &use_mfp);
-		}
-
-		nl_akm =3D ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
-		if (nl_akm)
-			l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES,
-							4, &nl_akm);
-
-		if (IE_AKM_IS_SAE(hs->akm_suite))
-			wpa_version =3D NL80211_WPA_VERSION_3;
-		else if (hs->wpa_ie)
-			wpa_version =3D NL80211_WPA_VERSION_1;
-		else
-			wpa_version =3D NL80211_WPA_VERSION_2;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
-						4, &wpa_version);
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT, 0, NULL);
-		c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
-	}
-
-	if (netdev->pae_over_nl80211)
-		l_genl_msg_append_attr(msg,
-				NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
-				0, NULL);
-
-	c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->mde);
-	c_iov =3D netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
-
-	mpdu_sort_ies(subtype, iov, c_iov);
-
-	if (vendor_ies && !L_WARN_ON(n_iov - c_iov < num_vendor_ies)) {
-		memcpy(iov + c_iov, vendor_ies,
-					sizeof(*vendor_ies) * num_vendor_ies);
-		c_iov +=3D num_vendor_ies;
-	}
-
-	if (c_iov)
-		l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
-
-	return msg;
-}
-
 struct rtnl_data {
 	struct netdev *netdev;
 	uint8_t addr[ETH_ALEN];
@@ -3397,6 +3436,8 @@ static int netdev_handshake_state_setup_connection_ty=
pe(
 				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
 			goto psk_offload;
 =

+	/* fall through */
+	case IE_RSN_AKM_SUITE_OWE:
 		if (softmac)
 			goto softmac;
 =

@@ -3425,12 +3466,11 @@ static int netdev_handshake_state_setup_connection_=
type(
 			goto softmac;
 =

 		return -EINVAL;
-	case IE_RSN_AKM_SUITE_OWE:
 	case IE_RSN_AKM_SUITE_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FILS_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-		/* FILS and OWE have no offload in any upstream driver */
+		/* FILS has no offload in any upstream driver */
 		if (softmac)
 			goto softmac;
 =

@@ -3509,10 +3549,9 @@ static void netdev_connect_common(struct netdev *net=
dev,
 =

 		break;
 	case IE_RSN_AKM_SUITE_OWE:
-		netdev->ap =3D owe_sm_new(hs, netdev_owe_tx_authenticate,
-						netdev_owe_tx_associate,
-						netdev);
-		break;
+		netdev->owe_sm =3D owe_sm_new(hs);
+
+		goto build_cmd_connect;
 	case IE_RSN_AKM_SUITE_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FILS_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
diff --git a/src/owe.c b/src/owe.c
index b1eea025..eed3e266 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -34,7 +34,6 @@
 #include "src/auth-proto.h"
 =

 struct owe_sm {
-	struct auth_proto ap;
 	struct handshake_state *hs;
 	const struct l_ecc_curve *curve;
 	struct l_ecc_scalar *private;
@@ -42,10 +41,6 @@ struct owe_sm {
 	uint8_t retry;
 	uint16_t group;
 	const unsigned int *ecc_groups;
-
-	owe_tx_authenticate_func_t auth_tx;
-	owe_tx_associate_func_t assoc_tx;
-	void *user_data;
 };
 =

 static bool owe_reset(struct owe_sm *owe)
@@ -72,62 +67,28 @@ static bool owe_reset(struct owe_sm *owe)
 	return true;
 }
 =

-static void owe_free(struct auth_proto *ap)
+void owe_sm_free(struct owe_sm *owe)
 {
-	struct owe_sm *owe =3D l_container_of(ap, struct owe_sm, ap);
-
 	l_ecc_scalar_free(owe->private);
 	l_ecc_point_free(owe->public_key);
 =

 	l_free(owe);
 }
 =

-static bool owe_start(struct auth_proto *ap)
+void owe_build_dh_ie(struct owe_sm *owe, uint8_t *buf, size_t *len_out)
 {
-	struct owe_sm *owe =3D l_container_of(ap, struct owe_sm, ap);
-
-	owe->auth_tx(owe->user_data);
-
-	return true;
-}
-
-static int owe_rx_authenticate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
-{
-	struct owe_sm *owe =3D l_container_of(ap, struct owe_sm, ap);
-
-	uint8_t buf[5 + L_ECC_SCALAR_MAX_BYTES];
-	struct iovec iov[3];
-	int iov_elems =3D 0;
-	size_t len;
-
-	/*
-	 * RFC 8110 Section 4.3
-	 * A client wishing to do OWE MUST indicate the OWE AKM in the RSN
-	 * element portion of the 802.11 association request ...
-	 */
-	iov[iov_elems].iov_base =3D owe->hs->supplicant_ie;
-	iov[iov_elems].iov_len =3D owe->hs->supplicant_ie[1] + 2;
-	iov_elems++;
-
 	/*
-	 * ... and MUST include a Diffie-Hellman Parameter element to its
-	 * 802.11 association request.
+	 * A client wishing to do OWE ... MUST include a Diffie-Hellman
+	 * Parameter element to its 802.11 association request.
 	 */
 	buf[0] =3D IE_TYPE_EXTENSION;
 	buf[2] =3D IE_TYPE_OWE_DH_PARAM - 256;
 	l_put_le16(owe->group, buf + 3); /* group */
-	len =3D l_ecc_point_get_x(owe->public_key, buf + 5,
+	*len_out =3D l_ecc_point_get_x(owe->public_key, buf + 5,
 					L_ECC_SCALAR_MAX_BYTES);
-	buf[1] =3D 3 + len; /* length */
-
-	iov[iov_elems].iov_base =3D (void *) buf;
-	iov[iov_elems].iov_len =3D buf[1] + 2;
-	iov_elems++;
+	buf[1] =3D 3 + *len_out; /* length */
 =

-	owe->assoc_tx(iov, iov_elems, owe->user_data);
-
-	return 0;
+	*len_out +=3D 5;
 }
 =

 /*
@@ -220,7 +181,7 @@ failed:
 	return false;
 }
 =

-static bool owe_retry(struct owe_sm *owe)
+bool owe_next_group(struct owe_sm *owe)
 {
 	/* retry with another group, if possible */
 	owe->retry++;
@@ -228,88 +189,23 @@ static bool owe_retry(struct owe_sm *owe)
 	if (!owe_reset(owe))
 		return false;
 =

-	l_debug("OWE retrying with group %u", owe->group);
-
-	owe_rx_authenticate(&owe->ap, NULL, 0);
-
 	return true;
 }
 =

-static int owe_rx_associate(struct auth_proto *ap, const uint8_t *frame,
-				size_t len)
+int owe_process_dh_ie(struct owe_sm *owe, const uint8_t *dh, size_t len)
 {
-	struct owe_sm *owe =3D l_container_of(ap, struct owe_sm, ap);
-
-	const struct mmpdu_header *mpdu =3D (const struct mmpdu_header *) frame;
-	const struct mmpdu_association_response *body =3D mmpdu_body(mpdu);
-	struct ie_tlv_iter iter;
-	size_t owe_dh_len =3D 0;
-	const uint8_t *owe_dh =3D NULL;
-	struct ie_rsn_info info;
-	bool akm_found =3D false;
-	const void *data;
-
-	if (L_LE16_TO_CPU(body->status_code) =3D=3D
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP) {
-		if (!owe_retry(owe))
-			goto owe_bad_status;
-
-		return -EAGAIN;
-	} else if (body->status_code)
-		goto owe_bad_status;
-
-	ie_tlv_iter_init(&iter, body->ies, (const uint8_t *) mpdu + len -
-				body->ies);
-
-	while (ie_tlv_iter_next(&iter)) {
-		uint16_t tag =3D ie_tlv_iter_get_tag(&iter);
-
-		data =3D ie_tlv_iter_get_data(&iter);
-		len =3D ie_tlv_iter_get_length(&iter);
-
-		switch (tag) {
-		case IE_TYPE_OWE_DH_PARAM:
-			owe_dh =3D data;
-			owe_dh_len =3D len;
-
-			break;
-		case IE_TYPE_RSN:
-			if (ie_parse_rsne(&iter, &info) < 0) {
-				l_error("could not parse RSN IE");
-				goto invalid_ies;
-			}
-
-			/*
-			 * RFC 8110 Section 4.2
-			 * An AP agreeing to do OWE MUST include the OWE AKM in
-			 * the RSN element portion of the 802.11 association
-			 * response.
-			 */
-			if (info.akm_suites !=3D IE_RSN_AKM_SUITE_OWE) {
-				l_error("OWE AKM not included");
-				goto invalid_ies;
-			}
-
-			akm_found =3D true;
-
-			break;
-		default:
-			continue;
-		}
-	}
-
-	if (!owe_dh || owe_dh_len < 34 || !akm_found) {
+	if (!dh || len < 34) {
 		l_error("associate response did not include proper OWE IE's");
 		goto invalid_ies;
 	}
 =

-	if (l_get_le16(owe_dh) !=3D owe->group) {
+	if (l_get_le16(dh) !=3D owe->group) {
 		l_error("associate response contained unsupported group %u",
-				l_get_le16(owe_dh));
+				l_get_le16(dh));
 		return -EBADMSG;
 	}
 =

-	if (!owe_compute_keys(owe, owe_dh + 2, owe_dh_len - 2)) {
+	if (!owe_compute_keys(owe, dh + 2, len - 2)) {
 		l_error("could not compute OWE keys");
 		return -EBADMSG;
 	}
@@ -318,33 +214,19 @@ static int owe_rx_associate(struct auth_proto *ap, co=
nst uint8_t *frame,
 =

 invalid_ies:
 	return MMPDU_STATUS_CODE_INVALID_ELEMENT;
-
-owe_bad_status:
-	return L_LE16_TO_CPU(body->status_code);
 }
 =

-struct auth_proto *owe_sm_new(struct handshake_state *hs,
-				owe_tx_authenticate_func_t auth,
-				owe_tx_associate_func_t assoc,
-				void *user_data)
+struct owe_sm *owe_sm_new(struct handshake_state *hs)
 {
 	struct owe_sm *owe =3D l_new(struct owe_sm, 1);
 =

 	owe->hs =3D hs;
-	owe->auth_tx =3D auth;
-	owe->assoc_tx =3D assoc;
-	owe->user_data =3D user_data;
 	owe->ecc_groups =3D l_ecc_supported_ike_groups();
 =

-	owe->ap.start =3D owe_start;
-	owe->ap.free =3D owe_free;
-	owe->ap.rx_authenticate =3D owe_rx_authenticate;
-	owe->ap.rx_associate =3D owe_rx_associate;
-
 	if (!owe_reset(owe)) {
 		l_free(owe);
 		return NULL;
 	}
 =

-	return &owe->ap;
+	return owe;
 }
diff --git a/src/owe.h b/src/owe.h
index 9a21505f..8a734a00 100644
--- a/src/owe.h
+++ b/src/owe.h
@@ -23,11 +23,9 @@
 struct owe_sm;
 struct handshake_state;
 =

-typedef void (*owe_tx_authenticate_func_t)(void *user_data);
-typedef void (*owe_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_l=
en,
-					void *user_data);
+struct owe_sm *owe_sm_new(struct handshake_state *hs);
+void owe_sm_free(struct owe_sm *sm);
 =

-struct auth_proto *owe_sm_new(struct handshake_state *hs,
-				owe_tx_authenticate_func_t auth,
-				owe_tx_associate_func_t assoc,
-				void *user_data);
+void owe_build_dh_ie(struct owe_sm *sm, uint8_t *buf, size_t *len_out);
+int owe_process_dh_ie(struct owe_sm *sm, const uint8_t *dh, size_t len);
+bool owe_next_group(struct owe_sm *sm);
-- =

2.31.1

--===============6301091882087196723==--

