Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74B3C6B1
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIGsI4i7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c9b1e3a809so10772685ad.2
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140920; x=1697745720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbBqznPx/bYtVaUA2xH/5i4n96YuxtVDKfRDEub83LI=;
        b=dIGsI4i7cPRSv3X7sbJlARfT2HmYyJ9mlTTeuPEEtGA7/AwRYs6uKaB4jxuBXEvf/1
         j091Sftx94DO5m3WimIu5elRUObTyOBlaZbaUy3mqYpYG9E0R6Dfv/utjZwcp8nohAPt
         vrHaR2vb3Mhhb871p+fOZskE17PTnBbckMspc7mWSSXcw1Y3JbUZzAu49aUklb0A1v1l
         FfcLWkWL3QimbIigdzO+5mNotDVo/SFZovquCFAw8xUL32f0tqQ2m+imqHnIJ2ZlAMMh
         vS3yFHVdZ2VnLvaHYrr6UYevEc1U8UaBIq5xMlurAop16+7J/QqXrjPcjW2g/f39jpYk
         MOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140920; x=1697745720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbBqznPx/bYtVaUA2xH/5i4n96YuxtVDKfRDEub83LI=;
        b=C63tSaIaAbE4O34HhxkdgUcmZr3KG5cHABkbMU3FpJqBLM5gvQx110I8B1juYh1YZQ
         yCDiB1b0VgIYz/g3wHHyntmFdbCmp39i+GFR5dd05SUUAB1wcV9dliZ/wHT/sINBy5b3
         3vrWOVzv7HcN6+Y90BGCjdh0zy/CZU6LmVaRWkt8D2XX4ElSJxRt7+ylSmYUgzuPN2kx
         7DGZ0VQm05kpQNka0qBdMXzF5+h/nxMtleNKYh64lr8lwe1V9k7TvMLYxwgyW0fkHbUH
         VTh1YVrXwNf//FmUwnZpdZpXDS9lNGdDGw58lIBXICCV5+CVmJIR0Wc5YqlZuNCUMmUB
         xW0g==
X-Gm-Message-State: AOJu0Yx+kNB8YNw5fZw8GVtSyHFDC6EeCxPhS3UpJFORH28fSIT6MrOd
	bfeZ+vPhYs6599xeYVNmXdvD3WxBH2c=
X-Google-Smtp-Source: AGHT+IE64OO1Ers7zP1VvYPB29N0m1YH+GKhnp52YmH1xKnscYs5VHb47p23KTVRmIWpMIN/oMxyKA==
X-Received: by 2002:a17:903:443:b0:1c5:ce3c:c391 with SMTP id iw3-20020a170903044300b001c5ce3cc391mr21363540plb.12.1697140920307;
        Thu, 12 Oct 2023 13:02:00 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/21] dpp: rename auth_addr to peer_addr
Date: Thu, 12 Oct 2023 13:01:32 -0700
Message-Id: <20231012200150.338401-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is more generic and with adding PKEX it makes sense to
refer to it as peer_addr.
---
 src/dpp.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 75f77481..25371fc5 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -114,7 +114,7 @@ struct dpp_sm {
 
 	uint32_t offchannel_id;
 
-	uint8_t auth_addr[6];
+	uint8_t peer_addr[6];
 	uint8_t r_nonce[32];
 	uint8_t i_nonce[32];
 	uint8_t e_nonce[32];
@@ -694,7 +694,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	 * Can a configuration request come from someone other than who you
 	 * authenticated to?
 	 */
-	if (memcmp(dpp->auth_addr, frame->address_2, 6))
+	if (memcmp(dpp->peer_addr, frame->address_2, 6))
 		return;
 
 	if (body_len < 19)
@@ -825,7 +825,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	dpp_write_config(config, network);
 	dpp_configuration_free(config);
 
-	send_config_result(dpp, dpp->auth_addr);
+	send_config_result(dpp, dpp->peer_addr);
 
 	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
@@ -855,7 +855,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	memset(hdr, 0, sizeof(hdr));
 
 	l_put_le16(0x00d0, hdr);
-	memcpy(hdr + 4, dpp->auth_addr, 6);
+	memcpy(hdr + 4, dpp->peer_addr, 6);
 	memcpy(hdr + 10, netdev_get_address(dpp->netdev), 6);
 	memcpy(hdr + 16, broadcast, 6);
 
@@ -945,7 +945,7 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 		return;
 	}
 
-	if (memcmp(dpp->auth_addr, frame->address_2, 6)) {
+	if (memcmp(dpp->peer_addr, frame->address_2, 6)) {
 		l_debug("Configuration request not from authenticated peer");
 		return;
 	}
@@ -1181,7 +1181,7 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 				sizeof(r_proto_key));
 
 	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->auth_addr,
+				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
 	iov[0].iov_base = hdr;
 
@@ -1245,7 +1245,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
-	if (memcmp(from, dpp->auth_addr, 6))
+	if (memcmp(from, dpp->peer_addr, 6))
 		return;
 
 	l_debug("authenticate confirm");
@@ -1368,7 +1368,7 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 	struct iovec iov[2];
 
 	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->auth_addr,
+				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_RESPONSE, hdr);
 	iov[0].iov_base = hdr;
 
@@ -1451,7 +1451,7 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 				sizeof(i_proto_key));
 
 	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
-				dpp->auth_addr,
+				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_REQUEST, hdr);
 	iov[0].iov_base = hdr;
 
@@ -1814,7 +1814,7 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 				dpp->boot_public, dpp->auth_tag))
 		goto auth_request_failed;
 
-	memcpy(dpp->auth_addr, from, 6);
+	memcpy(dpp->peer_addr, from, 6);
 
 	dpp->state = DPP_STATE_AUTHENTICATING;
 	dpp_reset_protocol_timer(dpp);
@@ -1839,7 +1839,7 @@ static void dpp_send_authenticate_confirm(struct dpp_sm *dpp)
 	uint8_t zero = 0;
 
 	iov[0].iov_len = dpp_build_header(netdev_get_address(dpp->netdev),
-					dpp->auth_addr,
+					dpp->peer_addr,
 					DPP_FRAME_AUTHENTICATION_CONFIRM, hdr);
 	iov[0].iov_base = hdr;
 
@@ -1893,7 +1893,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	if (!dpp->freqs)
 		return;
 
-	if (memcmp(from, dpp->auth_addr, 6))
+	if (memcmp(from, dpp->peer_addr, 6))
 		return;
 
 	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
@@ -2066,12 +2066,12 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
 
 	/*
 	 * The URI may not have contained a MAC address, if this announcement
-	 * verifies set auth_addr then.
+	 * verifies set peer_addr then.
 	 */
-	if (!l_memeqzero(dpp->auth_addr, 6) &&
-				memcmp(from, dpp->auth_addr, 6)) {
+	if (!l_memeqzero(dpp->peer_addr, 6) &&
+				memcmp(from, dpp->peer_addr, 6)) {
 		l_debug("Unexpected source "MAC" expected "MAC, MAC_STR(from),
-						MAC_STR(dpp->auth_addr));
+						MAC_STR(dpp->peer_addr));
 		return;
 	}
 
@@ -2106,7 +2106,7 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
 	 * This is the peer we expected, save away the address and derive the
 	 * initial keys.
 	 */
-	memcpy(dpp->auth_addr, from, 6);
+	memcpy(dpp->peer_addr, from, 6);
 
 	dpp->state = DPP_STATE_AUTHENTICATING;
 
@@ -2214,7 +2214,7 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	if (!dpp)
 		return;
 
-	if (dpp->state <= DPP_STATE_PRESENCE)
+	if (dpp->state == DPP_STATE_PRESENCE || dpp->state == DPP_STATE_NOTHING)
 		return;
 
 
@@ -2563,7 +2563,7 @@ static bool dpp_configurator_start_presence(struct dpp_sm *dpp, const char *uri)
 	}
 
 	if (!l_memeqzero(info->mac, 6))
-		memcpy(dpp->auth_addr, info->mac, 6);
+		memcpy(dpp->peer_addr, info->mac, 6);
 
 	if (info->freqs)
 		freqs = scan_freq_set_to_fixed_array(info->freqs, &freqs_len);
-- 
2.25.1

