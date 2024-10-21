Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EB1F4FA1
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514560; cv=none; b=uj5RIJafKVIABY198fJghEaFEeW+aWtWpqLMeIY9u6GSsZ3uHeZ4Auq+etDyMvkk3dPP7lt/oFF3cX3fEqbuB/HnZvKIyoD3gKS+CPRT5JP9PJHHEwP8Ce/g0ImyYwaH3fKUGts/d/BlofyQ51dUZNRetz5bMRRl2DpfnxpwwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514560; c=relaxed/simple;
	bh=Wm0n8XYvElWvSP91YZYfuwKwtgHHzChMOQ8QVE+Y0Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvOiHt6G5k01p0IncgTjluiwjB2mwCTl4zjOXeRghYX2uNsr9WH7RSMxv+3Sx2RD35aOi6DNJLACKbL3KrXtZAIow+W88RdXmdVFdYsegfnpv2j6ue++Dcjlk95VKbIGve/qU15h+uzrOSlxZ7/zxazM4cq5Ig4X/UTS0tSKYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzaRdgAd; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzaRdgAd"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e60f6ea262so591202b6e.1
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514557; x=1730119357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifUILBcVGHThmeBEsolYHrYcMP3CfuCaq5wCJ3iBQkM=;
        b=NzaRdgAdvu2aKxsbbx2xVRTa+tymHVGxGdjIaFtTn/41vedG6TdlPek1RA3kfRJ1g/
         4YSh9CB56fSdcKTkZhDgCqCj9dFSkfTCpLd+stLykvH7V5YBXr3elE7RKJJAG5sCtrHo
         ZGOEKtUQhXYOcojNe3lUmRkYlEb9bA9cucPFYdz5JINEF3HYvTIIR4oln9fTTMd5AS+U
         MvlPJnT3GqtSSSzWUmSdFe5r1rTqzeW8ohZmISbBPaNWGKkbV57n4910hX3WD/9qY5/2
         UJ1qwlw1k1lHKdeMQK3a38lJLIvUNU5VBG8jVmAjoJfydq/4PspIHmcIh+ymiTr4gaDj
         x6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514557; x=1730119357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifUILBcVGHThmeBEsolYHrYcMP3CfuCaq5wCJ3iBQkM=;
        b=DZzGTf0uri2QDLeWO1o8hCcKiD8LGKZ/1DBch049+P/4gL/CiqdVWa/0rYh2SZsab0
         N8gDrLIinIkRlRO1OZkZZaH7q4p+jjif7ezSfTODu/g6eRUOuHOamFDSkHjhLBHIolgR
         wsSrm9DBBbF1ANZBYeXzps76d93LQvppofRcKIXVGAa8udgZYifxH6HMTyPQ3spWKhyk
         NJ7roIBc8r/xoKQsU9hRVUgTCFkXzXnqNnXipM5zYasymyUMe2+LQ33QhwNt7Y2FPdZY
         pEmxPeTUXDq0dTIvcBVv24VbGz2NGkLJbqxMPqgM51kTqnXuzFXI3NUdhDDBSc+JrTJf
         S/GA==
X-Gm-Message-State: AOJu0YyMQQ0EtRyLJduLRoZ09tZQoetMZacmplFEp6PRzW/Yr4ZSRxPJ
	isIT9dOwSKiYqOsnzCNuA3bBVUiLF/jOm2oFPiQWa6doFVj+oY/RyriK0w==
X-Google-Smtp-Source: AGHT+IHj2eemCipDP0pP+MFXJO5tcsI3ZHvAjIDhJ5wQamhwlTfIHHlp7Mij+vVlod6R2scGhbMs9A==
X-Received: by 2002:a05:6808:318e:b0:3e5:f4f9:3280 with SMTP id 5614622812f47-3e602c50eb6mr8541204b6e.10.1729514556706;
        Mon, 21 Oct 2024 05:42:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([72.46.116.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999ab0sm17006586d6.93.2024.10.21.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:42:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] dpp: tie frame registration to DPP state
Date: Mon, 21 Oct 2024 05:42:28 -0700
Message-Id: <20241021124228.145516-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021124228.145516-1-prestwoj@gmail.com>
References: <20241021124228.145516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to several other modules DPP registers for its frame
watches on init then ignores anything is receives unless DPP
is actually running.

Due to some recent issues surrounding ath10k and multicast frames
it was discovered that simply registering for multicast RX frames
causes a significant performance impact depending on the current
channel load.

Regardless of the impact to a single driver, it is actually more
efficient to only register for the DPP frames when DPP starts
rather than when IWD initializes. This prevents any of the frames
from hitting userspace which would otherwise be ignored.

Using the frame-xchg group ID's we can only register for DPP
frames when needed, then close that group and the associated
frame watches.
---
 src/dpp.c | 150 ++++++++++++------------------------------------------
 1 file changed, 33 insertions(+), 117 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 004b431d..f7989d2b 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -66,7 +66,6 @@ static struct l_genl_family *nl80211;
 static uint8_t broadcast[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 static struct l_queue *dpp_list;
 static uint32_t mlme_watch;
-static uint32_t unicast_watch;
 
 static uint8_t dpp_prefix[] = { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 
@@ -552,6 +551,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 
 	dpp_property_changed_notify(dpp);
 
+	frame_watch_group_remove(dpp->wdev_id, FRAME_GROUP_DPP);
+
 	dpp->interface = DPP_INTERFACE_UNBOUND;
 
 	if (station) {
@@ -3475,10 +3476,11 @@ failed:
 	dpp_reset(dpp);
 }
 
-static void dpp_handle_frame(struct dpp_sm *dpp,
-				const struct mmpdu_header *frame,
-				const void *body, size_t body_len)
+static void dpp_handle_frame(const struct mmpdu_header *frame,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
 {
+	struct dpp_sm *dpp = user_data;
 	const uint8_t *ptr;
 
 	/*
@@ -3638,99 +3640,6 @@ retransmit:
 						dpp_frame_timeout, dpp, NULL);
 }
 
-static void dpp_unicast_notify(struct l_genl_msg *msg, void *user_data)
-{
-	struct dpp_sm *dpp;
-	const uint64_t *wdev_id = NULL;
-	struct l_genl_attr attr;
-	uint16_t type, len, frame_len;
-	const void *data;
-	const struct mmpdu_header *mpdu = NULL;
-	const uint8_t *body;
-	size_t body_len;
-
-	if (l_genl_msg_get_command(msg) != NL80211_CMD_FRAME)
-		return;
-
-	if (!l_genl_attr_init(&attr, msg))
-		return;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_WDEV:
-			if (len != 8)
-				break;
-
-			wdev_id = data;
-			break;
-
-		case NL80211_ATTR_FRAME:
-			mpdu = mpdu_validate(data, len);
-			if (!mpdu) {
-				l_warn("Frame didn't validate as MMPDU");
-				return;
-			}
-
-			frame_len = len;
-			break;
-		}
-	}
-
-	if (!wdev_id) {
-		l_warn("Bad wdev attribute");
-		return;
-	}
-
-	dpp = l_queue_find(dpp_list, match_wdev, wdev_id);
-	if (!dpp)
-		return;
-
-	if (!mpdu) {
-		l_warn("Missing frame data");
-		return;
-	}
-
-	body = mmpdu_body(mpdu);
-	body_len = (const uint8_t *) mpdu + frame_len - body;
-
-	if (body_len < sizeof(dpp_prefix) ||
-			memcmp(body, dpp_prefix, sizeof(dpp_prefix)) != 0)
-		return;
-
-	dpp_handle_frame(dpp, mpdu, body, body_len);
-}
-
-static void dpp_frame_watch_cb(struct l_genl_msg *msg, void *user_data)
-{
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("Could not register frame watch type %04x: %i",
-			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
-}
-
-/*
- * Special case the frame watch which includes the presence frames since they
- * require multicast support. This is only supported by ath9k, so adding
- * general support to frame-xchg isn't desireable.
- */
-static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
-				const uint8_t *prefix, size_t prefix_len)
-{
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 32 + prefix_len);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dpp->wdev_id);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
-				prefix_len, prefix);
-	if (dpp->mcast_support)
-		l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST,
-					0, NULL);
-
-	l_genl_family_send(nl80211, msg, dpp_frame_watch_cb,
-					L_UINT_TO_PTR(frame_type), NULL);
-}
-
 static void dpp_start_enrollee(struct dpp_sm *dpp);
 static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp);
 
@@ -3820,8 +3729,6 @@ static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct dpp_sm *dpp = l_new(struct dpp_sm, 1);
-	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
-	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
 
 	dpp->netdev = netdev;
@@ -3857,17 +3764,6 @@ static void dpp_create(struct netdev *netdev)
 	 */
 	dpp->refcount = 2;
 
-	dpp_frame_watch(dpp, 0x00d0, dpp_prefix, sizeof(dpp_prefix));
-
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
-				dpp_conf_response_prefix,
-				sizeof(dpp_conf_response_prefix), false,
-				dpp_handle_config_response_frame, dpp, NULL);
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
-				dpp_conf_request_prefix,
-				sizeof(dpp_conf_request_prefix), false,
-				dpp_handle_config_request_frame, dpp, NULL);
-
 	dpp->known_network_watch = known_networks_watch_add(
 					dpp_known_network_watch, dpp, NULL);
 
@@ -4012,6 +3908,26 @@ done:
 	return 0;
 }
 
+static void dpp_add_frame_watches(struct dpp_sm *dpp, bool multicast_rx)
+{
+	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
+	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
+
+	frame_watch_add(dpp->wdev_id, FRAME_GROUP_DPP, 0x00d0,
+			dpp_prefix, sizeof(dpp_prefix), multicast_rx,
+			dpp_handle_frame, dpp, NULL);
+
+	frame_watch_add(dpp->wdev_id, FRAME_GROUP_DPP, 0x00d0,
+			dpp_conf_response_prefix,
+			sizeof(dpp_conf_response_prefix), false,
+			dpp_handle_config_response_frame, dpp, NULL);
+
+	frame_watch_add(dpp->wdev_id, FRAME_GROUP_DPP, 0x00d0,
+			dpp_conf_request_prefix,
+			sizeof(dpp_conf_request_prefix), false,
+			dpp_handle_config_request_frame, dpp, NULL);
+}
+
 static void dpp_start_enrollee(struct dpp_sm *dpp)
 {
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
@@ -4051,6 +3967,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 	dpp->interface = DPP_INTERFACE_DPP;
 
+	dpp_add_frame_watches(dpp, false);
+
 	ret = dpp_try_disconnect_station(dpp, &wait_for_disconnect);
 	if (ret < 0) {
 		dpp_reset(dpp);
@@ -4188,6 +4106,8 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	} else
 		dpp->current_freq = bss->frequency;
 
+	dpp_add_frame_watches(dpp, responder);
+
 	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
 					netdev_get_address(dpp->netdev),
 					&bss->frequency, 1, NULL, NULL);
@@ -4517,6 +4437,8 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
 
+	dpp_add_frame_watches(dpp, false);
+
 	ret = dpp_try_disconnect_station(dpp, &wait_for_disconnect);
 	if (ret < 0) {
 		dpp_reset(dpp);
@@ -4613,6 +4535,7 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp->config = dpp_configuration_new(network_get_settings(network),
 						network_get_ssid(network),
 						hs->akm_suite);
+	dpp_add_frame_watches(dpp, true);
 
 	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
@@ -4741,11 +4664,6 @@ static int dpp_init(void)
 	mlme_watch = l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
 
-	unicast_watch = l_genl_add_unicast_watch(iwd_get_genl(),
-						NL80211_GENL_NAME,
-						dpp_unicast_notify,
-						NULL, NULL);
-
 	dpp_list = l_queue_new();
 
 	return 0;
@@ -4760,8 +4678,6 @@ static void dpp_exit(void)
 
 	netdev_watch_remove(netdev_watch);
 
-	l_genl_remove_unicast_watch(iwd_get_genl(), unicast_watch);
-
 	l_genl_family_unregister(nl80211, mlme_watch);
 	mlme_watch = 0;
 
-- 
2.34.1

