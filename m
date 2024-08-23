Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FF188935
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434945; cv=none; b=N2MdXm3yATk1eJOYleBZgH2E9YEc02hev+sUpAvJxpilTb/LLYktqtu1ggtaProkgSDuLQRr1yRmNu93tiWecwkYJtKxpG9eJ3Mh4K/X0T9uIpm0ydPoNPXVkObriCZrxMAbLk3Z7XJrtCt4MsrIshfVqs9KRJwtkph5J7AWpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434945; c=relaxed/simple;
	bh=7C2x2qASi3XnDYCZpe6thSOkWxxnoJ9dTkttrm4rLv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZX37DuFR7f/naFhkIdd74oV6yI8+FFz7HEJAe36EDPqMMuU5Y5zJbpR8pel8fsV2/V+XgNf8YE72GvUTs2WvGHaTcwXUBZTUdKL5DOPLJlLJ8qz7M7j0S9980pQdoRZdRGA5Tvy9zNxOEGTOe0EkrqviZ45nT1F7yW8Ob0Ztgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdsrrifU; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdsrrifU"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27028b2cf22so1069327fac.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724434943; x=1725039743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HezyTkdsVA7AjaRwve/91tbtPh3VrKkZbWwAmuJ3SIU=;
        b=LdsrrifUmLsL/FgtQ1w/z8iXtpbz0PQ9/lSQjsAqFbt1FXqLaO14WjvK+CxrR572yE
         BE2Qdx45Twf6nItB1E7xu6yodIKSCPT40dOt3BZTMTY1mQcEDRVoroGGPsWmFHQJL6UW
         dBKcTAmZUUjeItg2eu3eXkb1Icdr590kFO4tecqinlGoir+dfl8zoQYcyt8pRajAsAZ0
         dY+V3hA05BOgv/lDuoYi96tVQE82O0WSB13weThv8cqgPu55j/AXiWbp1eX/4fyQLFPB
         OH/knxXo0ohLhvKZUHdsxRjDLbpaR7KpxJRBmWwTbNaiqPF36Yh2oWKG/we0XiL6xWCG
         cJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434943; x=1725039743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HezyTkdsVA7AjaRwve/91tbtPh3VrKkZbWwAmuJ3SIU=;
        b=nPy8zvo35wKooXCZz1vlso6wIc4yC7jkNaboFTcWFfUGuCufJBpYLugBUp1H31HduN
         NwQM93mjLgry4uXLtTtKMogtHRESABAIRc7AH7rETHtYjbuGKTi1EcW7mfsEbS4VQ8YE
         stGs5RUOB9+ll57e2KH2T2t5f3fNOkKZHPPhZpsudw5Y8j1bCo2KQ+sfRCyJfDrSrNMz
         S5gQic1jyuiubc+d4b4FT6ETw/nEj2hqgh+59QvMDoGefQZBvgRKPtXCYbHzOZOg6V1C
         TNjpJFRFNShiPMtolQL7LKZVdg9pW9oZ+3rgOk0GRLO1X7lkyAIVeqXozZkr/+738bQm
         qLfg==
X-Gm-Message-State: AOJu0Yz8pOwY9zGeWRmNZUP9VrkfxTGtgwwzAVjwHcWvV9Omu4IwA3LL
	DGKyur8rBFbDAN5NFbvO5FWQB3wxOQQsfyehoRPqtdEkDEszhcvQDFX/LA==
X-Google-Smtp-Source: AGHT+IHlHJkP8v/V9Z/VyCs47RQjw6o9eehezk66eoQX9gbiQZyL22R69Ye4O2nxt+0FAvJpii4pYA==
X-Received: by 2002:a05:6870:55cd:b0:260:27c6:48b6 with SMTP id 586e51a60fabf-273e455101emr1341972fac.8.1724434942830;
        Fri, 23 Aug 2024 10:42:22 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03aa9c67sm728506a34.30.2024.08.23.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:42:22 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [RFC PATCH v1 1/2] netdev: external auth support
Date: Fri, 23 Aug 2024 12:41:53 -0500
Message-ID: <20240823174220.498594-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823174220.498594-1-denkenz@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain FullMAC drivers do not expose CMD_ASSOCIATE/CMD_AUTHENTICATE,
but lack the ability to fully offload SAE connections to the firmware.
Such connections can still be supported on such firmware by using
CMD_EXTERNAL_AUTH & CMD_FRAME.  The firmware sets the
NL80211_FEATURE_SAE bit (which implies support for CMD_AUTHENTICATE, but
oh well), and no other offload extended features.

When CMD_CONNECT is issued, the firmware sends CMD_EXTERNAL_AUTH via
unicast to the owner of the connection.  The connection owner is then
expected to send SAE frames with the firmware using CMD_FRAME and
receive authenticate frames using unicast CMD_FRAME notifications as
well.  Once SAE authentication completes, userspace is expected to
send a final CMD_EXTERNAL_AUTH back to the kernel with the corresponding
status code.  On failure, a non-0 status code should be used.

Note that for historical reasons, SAE AKM sent in CMD_EXTERNAL_AUTH is
given in big endian order, not CPU order as is expected!
---
 src/netdev.c      | 255 +++++++++++++++++++++++++++++++++++++++++-----
 src/nl80211util.c |   4 +-
 src/wiphy.c       |  19 ++--
 3 files changed, 237 insertions(+), 41 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 494e46a59de2..a1342d1bef94 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -187,6 +187,7 @@ struct netdev {
 	bool retry_auth : 1;
 	bool in_reassoc : 1;
 	bool privacy : 1;
+	bool external_auth : 1;
 };
 
 struct netdev_preauth_state {
@@ -815,6 +816,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->expect_connect_failure = false;
 	netdev->cur_rssi_low = false;
 	netdev->privacy = false;
+	netdev->external_auth = false;
 
 	if (netdev->connect_cmd) {
 		l_genl_msg_unref(netdev->connect_cmd);
@@ -2454,7 +2456,10 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 
 	switch (nhs->type) {
 	case CONNECTION_TYPE_SOFTMAC:
+		break;
 	case CONNECTION_TYPE_FULLMAC:
+		l_genl_msg_append_attr(msg,
+				NL80211_ATTR_EXTERNAL_AUTH_SUPPORT, 0, NULL);
 		break;
 	case CONNECTION_TYPE_SAE_OFFLOAD:
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
@@ -3368,6 +3373,77 @@ static void netdev_fils_tx_associate(struct iovec *fils_iov, size_t n_fils_iov,
 	}
 }
 
+static void netdev_external_auth_frame_cb(struct l_genl_msg *msg,
+							void *user_data)
+{
+	int error = l_genl_msg_get_error(msg);
+
+	if (error < 0)
+		l_debug("Failed to send External Auth Frame: %s(%d)",
+				strerror(-error), -error);
+}
+
+static void netdev_external_auth_sae_tx_authenticate(const uint8_t *body,
+					size_t body_len, void *user_data)
+{
+	struct netdev *netdev = user_data;
+	struct handshake_state *hs = netdev->handshake;
+	uint16_t frame_type = MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4;
+	struct iovec iov[2];
+	struct l_genl_msg *msg;
+	uint8_t algorithm[2] = { 0x03, 0x00 };
+
+	l_debug("");
+
+	iov[0].iov_base = &algorithm;
+	iov[0].iov_len = sizeof(algorithm);
+	iov[1].iov_base = (void *) body;
+	iov[1].iov_len = body_len;
+
+	msg = nl80211_build_cmd_frame(netdev->index, frame_type,
+					hs->spa, hs->aa, 0, iov, 2);
+
+	if (l_genl_family_send(nl80211, msg, netdev_external_auth_frame_cb,
+				netdev, NULL) > 0)
+		return;
+
+	l_genl_msg_unref(msg);
+}
+
+static void netdev_external_auth_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int error = l_genl_msg_get_error(msg);
+
+	if (error < 0)
+		l_debug("Failed to send External Auth: %s(%d)",
+				strerror(-error), -error);
+}
+
+static void netdev_send_external_auth(struct netdev *netdev,
+							uint16_t status_code)
+{
+	struct handshake_state *hs = netdev->handshake;
+	struct l_genl_msg *msg =
+		nl80211_build_external_auth(netdev->index, status_code,
+						hs->ssid, hs->ssid_len, hs->aa);
+
+	if (l_genl_family_send(nl80211, msg, netdev_external_auth_cb,
+				netdev, NULL) > 0)
+		return;
+
+	l_genl_msg_unref(msg);
+}
+
+static void netdev_external_auth_sae_tx_associate(void *user_data)
+{
+	struct netdev *netdev = user_data;
+
+	l_debug("");
+
+	netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_SUCCESS);
+	netdev_ensure_eapol_registered(netdev);
+}
+
 struct rtnl_data {
 	struct netdev *netdev;
 	uint8_t addr[ETH_ALEN];
@@ -3376,6 +3452,10 @@ struct rtnl_data {
 
 static int netdev_begin_connection(struct netdev *netdev)
 {
+	struct netdev_handshake_state *nhs =
+		l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
+
 	if (netdev->connect_cmd) {
 		netdev->connect_cmd_id = l_genl_family_send(nl80211,
 						netdev->connect_cmd,
@@ -3395,7 +3475,7 @@ static int netdev_begin_connection(struct netdev *netdev)
 	 */
 	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
 
-	if (netdev->ap) {
+	if (netdev->ap && nhs->type == CONNECTION_TYPE_SOFTMAC) {
 		if (!auth_proto_start(netdev->ap))
 			goto failed;
 
@@ -3770,7 +3850,11 @@ static int netdev_handshake_state_setup_connection_type(
 		if (softmac && wiphy_has_feature(wiphy, NL80211_FEATURE_SAE))
 			goto softmac;
 
-		return -EINVAL;
+		/* FullMAC uses EXTERNAL_AUTH and reuses this feature bit */
+		if (wiphy_has_feature(wiphy, NL80211_FEATURE_SAE))
+			goto fullmac;
+
+		return -ENOTSUP;
 	case IE_RSN_AKM_SUITE_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FILS_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
@@ -3841,40 +3925,43 @@ static void netdev_connect_common(struct netdev *netdev,
 		goto done;
 	}
 
-	if (nhs->type != CONNECTION_TYPE_SOFTMAC)
+	if (!IE_AKM_IS_SAE(hs->akm_suite) ||
+				nhs->type == CONNECTION_TYPE_SAE_OFFLOAD)
 		goto build_cmd_connect;
 
-	switch (hs->akm_suite) {
-	case IE_RSN_AKM_SUITE_SAE_SHA256:
-	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+	if (nhs->type == CONNECTION_TYPE_SOFTMAC)
 		netdev->ap = sae_sm_new(hs, netdev_sae_tx_authenticate,
-						netdev_sae_tx_associate,
-						netdev);
-
-		if (sae_sm_is_h2e(netdev->ap)) {
-			uint8_t own_rsnxe[20];
-
-			if (wiphy_get_rsnxe(netdev->wiphy,
-					own_rsnxe, sizeof(own_rsnxe))) {
-				set_bit(own_rsnxe + 2, IE_RSNX_SAE_H2E);
-				handshake_state_set_supplicant_rsnxe(hs,
-								own_rsnxe);
-			}
+					netdev_sae_tx_associate,
+					netdev);
+	else
+		netdev->ap =
+			sae_sm_new(hs, netdev_external_auth_sae_tx_authenticate,
+					netdev_external_auth_sae_tx_associate,
+					netdev);
+
+	if (sae_sm_is_h2e(netdev->ap)) {
+		uint8_t own_rsnxe[20];
+
+		if (wiphy_get_rsnxe(netdev->wiphy,
+				own_rsnxe, sizeof(own_rsnxe))) {
+			set_bit(own_rsnxe + 2, IE_RSNX_SAE_H2E);
+			handshake_state_set_supplicant_rsnxe(hs,
+							own_rsnxe);
 		}
+	}
+
+	if (nhs->type == CONNECTION_TYPE_SOFTMAC)
+		goto done;
 
-		break;
-	default:
 build_cmd_connect:
-		cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid);
+	cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid);
 
-		if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
-			sm = eapol_sm_new(hs);
+	if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
+		sm = eapol_sm_new(hs);
 
-			if (nhs->type == CONNECTION_TYPE_8021X_OFFLOAD)
-				eapol_sm_set_require_handshake(sm, false);
-		}
+		if (nhs->type == CONNECTION_TYPE_8021X_OFFLOAD)
+			eapol_sm_set_require_handshake(sm, false);
 	}
-
 done:
 	netdev->connect_cmd = cmd_connect;
 	netdev->event_filter = event_filter;
@@ -4379,6 +4466,52 @@ static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
 	netdev_send_qos_map_set(netdev, body + 4, body_len - 4);
 }
 
+static void netdev_sae_external_auth_frame_event(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	struct netdev *netdev = user_data;
+	const struct mmpdu_authentication *auth;
+	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
+	int ret;
+
+	if (!netdev->external_auth)
+		return;
+
+	if (!netdev->ap)
+		return;
+
+	auth = mmpdu_body(hdr);
+	/*
+	 * Allows station to persist settings so it does not retry
+	 * the higher order ECC group again
+	 */
+	if (L_CPU_TO_LE16(auth->status) ==
+			MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP &&
+			netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_ECC_GROUP_RETRY,
+					NULL, netdev->user_data);
+
+	ret = auth_proto_rx_authenticate(netdev->ap, (const void *) hdr,
+					mmpdu_header_len(hdr) + body_len);
+
+	switch (ret) {
+	case 0:
+	case -EAGAIN:
+		return;
+	case -ENOMSG:
+	case -EBADMSG:
+		return;
+	default:
+		break;
+	}
+
+	if (ret > 0)
+		status_code = (uint16_t)ret;
+
+	netdev_send_external_auth(netdev, status_code);
+}
+
 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
 {
 	struct netdev_preauth_state *preauth = user_data;
@@ -5203,6 +5336,63 @@ static void netdev_control_port_frame_event(struct l_genl_msg *msg,
 						frame, frame_len, unencrypted);
 }
 
+static void netdev_external_auth_event(struct l_genl_msg *msg,
+							struct netdev *netdev)
+{
+	const uint8_t *bssid;
+	struct iovec ssid;
+	uint32_t akm;
+	uint32_t action;
+	struct handshake_state *hs = netdev->handshake;
+
+	if (L_WARN_ON(nl80211_parse_attrs(msg, NL80211_ATTR_AKM_SUITES, &akm,
+				NL80211_ATTR_EXTERNAL_AUTH_ACTION, &action,
+				NL80211_ATTR_BSSID, &bssid,
+				NL80211_ATTR_SSID, &ssid,
+				NL80211_ATTR_UNSPEC) < 0))
+		return;
+
+	if (!L_IN_SET(action, NL80211_EXTERNAL_AUTH_START,
+				NL80211_EXTERNAL_AUTH_ABORT))
+		return;
+
+	/* kernel sends SAE_SHA256 AKM in BE order for legacy reasons */
+	if (!L_IN_SET(akm, CRYPTO_AKM_SAE_SHA256, CRYPTO_AKM_FT_OVER_SAE_SHA256,
+				L_CPU_TO_BE32(CRYPTO_AKM_SAE_SHA256))) {
+		l_warn("Unknown AKM: %08x", akm);
+		return;
+	}
+
+	if (action == NL80211_EXTERNAL_AUTH_ABORT) {
+		iwd_notice(IWD_NOTICE_CONNECT_INFO, "External Auth Aborted");
+		goto error;
+	}
+
+	iwd_notice(IWD_NOTICE_CONNECT_INFO,
+			"External Auth to SSID: %s, bssid: "MAC,
+			util_ssid_to_utf8(ssid.iov_len, ssid.iov_base),
+			MAC_STR(bssid));
+
+	if (hs->ssid_len != ssid.iov_len ||
+			memcmp(hs->ssid, ssid.iov_base, hs->ssid_len)) {
+		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target SSID mismatch");
+		goto error;
+	}
+
+	if (memcmp(hs->aa, bssid, ETH_ALEN)) {
+		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target BSSID mismatch");
+		goto error;
+	}
+
+	if (auth_proto_start(netdev->ap)) {
+		netdev->external_auth = true;
+		return;
+	}
+
+error:
+	netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
 static void netdev_unicast_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = NULL;
@@ -5240,6 +5430,9 @@ static void netdev_unicast_notify(struct l_genl_msg *msg, void *user_data)
 	case NL80211_CMD_CONTROL_PORT_FRAME:
 		netdev_control_port_frame_event(msg, netdev);
 		break;
+	case NL80211_CMD_EXTERNAL_AUTH:
+		netdev_external_auth_event(msg, netdev);
+		break;
 	}
 }
 
@@ -5412,6 +5605,7 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 	static const uint8_t action_ft_response_prefix[] =  { 0x06, 0x02 };
 	static const uint8_t auth_ft_response_prefix[] = { 0x02, 0x00 };
 	static const uint8_t action_qos_map_prefix[] = { 0x01, 0x04 };
+	static const uint8_t auth_sae_prefix[] = { 0x03, 0x00 };
 	uint64_t wdev = netdev->wdev_id;
 
 	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
@@ -5439,6 +5633,13 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
 				sizeof(action_qos_map_prefix),
 				netdev_qos_map_frame_event, netdev, NULL);
+
+	if (!wiphy_supports_cmds_auth_assoc(netdev->wiphy) &&
+			wiphy_has_feature(netdev->wiphy, NL80211_FEATURE_SAE))
+		frame_watch_add(wdev, 0, 0x00b0,
+				auth_sae_prefix, sizeof(auth_sae_prefix),
+				netdev_sae_external_auth_frame_event,
+				netdev, NULL);
 }
 
 static void netdev_setup_interface(struct netdev *netdev)
diff --git a/src/nl80211util.c b/src/nl80211util.c
index fcf70b9f1740..7590f90cd057 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -648,7 +648,9 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 	msg = l_genl_msg_new_sized(NL80211_CMD_FRAME, 128 + 512);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
+
+	if (freq)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_FRAME, iovs, iov_len + 1);
 
 	return msg;
diff --git a/src/wiphy.c b/src/wiphy.c
index 13d498a5cd0c..1ab2f3f75382 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -229,29 +229,22 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 	 *    cards the entire SAE protocol as well as the subsequent 4-way
 	 *    handshake are all done in the driver/firmware (fullMAC).
 	 *
-	 * 3. TODO: Cards which allow SAE in userspace via CMD_EXTERNAL_AUTH.
+	 * 3. Cards which allow SAE in userspace via CMD_EXTERNAL_AUTH.
 	 *    These cards do not support AUTH/ASSOC commands but do implement
 	 *    CMD_EXTERNAL_AUTH which is supposed to allow userspace to
-	 *    generate Authenticate frames as it would for case (1). As it
-	 *    stands today only one driver actually uses CMD_EXTERNAL_AUTH and
-	 *    for now IWD will not allow connections to SAE networks using this
-	 *    mechanism.
+	 *    generate Authenticate frames as it would for case (1).
 	 */
-
 	if (wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {
 		/* Case (1) */
 		if (wiphy->support_cmds_auth_assoc)
 			return true;
 
-		/*
-		 * Case (3)
-		 *
-		 * TODO: No support for CMD_EXTERNAL_AUTH yet.
-		 */
-		l_warn("SAE unsupported: %s needs CMD_EXTERNAL_AUTH for SAE",
+		/* Case 3 */
+		iwd_notice(IWD_NOTICE_CONNECT_INFO,
+			"FullMAC driver: %s using SAE.  Expect EXTERNAL_AUTH",
 			wiphy->driver_str);
 
-		return false;
+		return true;
 	}
 
 	/* Case (2) */
-- 
2.45.2

