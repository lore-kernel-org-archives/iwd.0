Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEDE2F2E
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:19 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id b23so10593414pfp.9
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AzrztUuuPCl1EHEXOfJ9BK+/IR+wHu/eLVw69YB/C7M=;
        b=AGtLLf8gsxuLVEHd+1/5du8hohgbKrZRpHiNHdNn6aqQjZd3ePIHGL0nL8RVTGQaFu
         mEhgvQ6CRYxnd4MAYe22v2gsu5sl2Ja+5I+LjITSJXK82eoAj+6Ihi8qyVSOWRFW3F4o
         KcbLBcVBbbMDHip+H7Pl6f9f/H998/SsXyB1G8YUVQ00cJH8SkMFOZOd1NNPTOEiSAyn
         hghvADsVmGOn9LdF4EqTumrpCqtmdBTwuSgvwgCGTCGIVAPDUClWw154ce9Z/CL773qE
         Kq9rUwk4pCdZHo8p4u2dTfQ16O7wl/v03gdId4tCP2Hf/OK13GLpIRNR2AfjsKjLfcIH
         hF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AzrztUuuPCl1EHEXOfJ9BK+/IR+wHu/eLVw69YB/C7M=;
        b=geC/FKbCeRIPAZ8DNDboL9goVhV+UeM+MzlbbScU4bRaJj6Vq3jvp3b1hKLajrxelb
         1Z8NvFRzw16IlHNL6VJ2U8z1gnldjgg1723M4y7DqJrSG1fgcWVbri3Syh+wQpOg7GCx
         8XguhXs/gG7trpR/rZfdMYz0aqSbAYDETKscwqyOiQuwkX2prOfXGT+yt8TGwUPPc0Uc
         x062H1ildYLwkxZh2m7P9y4LUr09lsizAJwHnZNBjHkdLrh14rSMslAhF9Td6Mc8hV01
         qChmiwx6h1+GYyL98EOH6YD+ttDRMYMU1UwY+apLxtFSlz3idv7U2Kj+hrYotAUkXECj
         P25w==
X-Gm-Message-State: ACrzQf0+2pmr5kqsEJWwAqwmk/JJ1t+LVZytt5A2OqkzooDr6gXTSkFb
	4eRA2WXqTDER9NsNYTAGv+LA8liPokI=
X-Google-Smtp-Source: AMsMyM7rbj9AkL/4Rl+gOcryw6p6UCfd5ClRpSgLEudVkJaJqsUEqRwkZiXq0EP9WEL0vpJh1tQJGg==
X-Received: by 2002:a63:db54:0:b0:43a:390b:716 with SMTP id x20-20020a63db54000000b0043a390b0716mr4802778pgi.360.1663884498951;
        Thu, 22 Sep 2022 15:08:18 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 11/11] ft: remove auth-proto/ft_sm
Date: Thu, 22 Sep 2022 15:08:09 -0700
Message-Id: <20220922220809.862022-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is no longer used.
---
 src/ft.c | 255 +------------------------------------------------------
 src/ft.h |  49 -----------
 2 files changed, 3 insertions(+), 301 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 7ca9a3f0..3576ab98 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -61,21 +61,6 @@ struct ft_info {
 	bool parsed : 1;
 };
 
-struct ft_sm {
-	struct auth_proto ap;
-	struct handshake_state *hs;
-
-	ft_tx_authenticate_func_t tx_auth;
-	ft_tx_associate_func_t tx_assoc;
-	ft_get_oci get_oci;
-
-	void *user_data;
-
-	bool over_ds : 1;
-
-	uint8_t prev_bssid[6];
-};
-
 /*
  * Calculate the MIC field of the FTE and write it directly to that FTE,
  * assuming it was all zeros before.  See 12.8.4 and 12.8.5.
@@ -501,79 +486,8 @@ static bool mde_equal(const uint8_t *mde1, const uint8_t *mde2)
 	return memcmp(mde1, mde1, mde1[1] + 2) == 0;
 }
 
-bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
-					struct handshake_state *hs,
-					const uint8_t *ies,
-					size_t ies_len)
-{
-	const uint8_t *mde = NULL;
-	const uint8_t *fte = NULL;
-	bool is_rsn = hs->supplicant_ie != NULL;
-
-	if (parse_ies(hs, info->authenticator_ie, ies, ies_len,
-				&mde, &fte) < 0)
-		return false;
-
-	if (!mde_equal(info->mde, mde))
-		goto ft_error;
-
-	if (is_rsn) {
-		if (!ft_parse_fte(hs, info->snonce, fte, &info->ft_info))
-			goto ft_error;
-
-		info->fte = l_memdup(fte, fte[1] + 2);
-	} else if (fte)
-		goto ft_error;
-
-	return true;
-
-ft_error:
-	return false;
-}
-
-static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
-			size_t ies_len)
-{
-	const uint8_t *mde = NULL;
-	const uint8_t *fte = NULL;
-	bool is_rsn = hs->supplicant_ie != NULL;
-
-	/* Check 802.11r IEs */
-	if (!ies)
-		goto ft_error;
-
-	if (parse_ies(hs, hs->authenticator_ie, ies, ies_len,
-				&mde, &fte) < 0)
-		goto ft_error;
-
-	if (!mde_equal(hs->mde, mde))
-		goto ft_error;
-
-	if (is_rsn) {
-		struct ie_ft_info ft_info;
-
-		if (!ft_parse_fte(hs, hs->snonce, fte, &ft_info))
-			goto ft_error;
-
-		handshake_state_set_fte(hs, fte);
-
-		handshake_state_set_anonce(hs, ft_info.anonce);
-
-		handshake_state_set_kh_ids(hs, ft_info.r0khid,
-						ft_info.r0khid_len,
-						ft_info.r1khid);
-
-		handshake_state_derive_ptk(hs);
-	} else if (fte)
-		goto ft_error;
-
-	return 0;
-
-ft_error:
-	return -EBADMSG;
-}
-
-int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
+static int ft_over_ds_parse_action_response(const uint8_t *frame,
+					size_t frame_len,
 					const uint8_t **spa_out,
 					const uint8_t **aa_out,
 					const uint8_t **ies_out,
@@ -623,75 +537,6 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 	return 0;
 }
 
-bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
-					struct handshake_state *hs)
-{
-	if (!hs->supplicant_ie)
-		return true;
-
-	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
-
-	handshake_state_set_fte(hs, info->fte);
-
-	handshake_state_set_anonce(hs, info->ft_info.anonce);
-
-	handshake_state_set_kh_ids(hs, info->ft_info.r0khid,
-						info->ft_info.r0khid_len,
-						info->ft_info.r1khid);
-
-	handshake_state_derive_ptk(hs);
-
-	return true;
-}
-
-void ft_ds_info_free(struct ft_ds_info *info)
-{
-	__typeof__(info->free) destroy = info->free;
-
-	if (info->fte)
-		l_free(info->fte);
-
-	if (info->authenticator_ie)
-		l_free(info->authenticator_ie);
-
-	if (destroy)
-		destroy(info);
-}
-
-static int ft_rx_authenticate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	const uint8_t *ies = NULL;
-	size_t ies_len;
-	int ret;
-
-	/*
-	 * Parse the Authentication Response and validate the contents
-	 * according to 12.5.2 / 12.5.4: RSN or non-RSN Over-the-air
-	 * FT Protocol.
-	 */
-	if (!ft_parse_authentication_resp_frame(frame, frame_len, ft->hs->spa,
-						ft->hs->aa, ft->hs->aa,
-						2, &status_code,
-						&ies, &ies_len))
-		goto auth_error;
-
-	/* AP Rejected the authenticate / associate */
-	if (status_code != 0)
-		goto auth_error;
-
-	ret = ft_process_ies(ft->hs, ies, ies_len);
-	if (ret < 0)
-		goto auth_error;
-
-	return ft->get_oci(ft->user_data);
-
-auth_error:
-	return (int)status_code;
-}
-
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 {
 	struct netdev *netdev = netdev_find(ifindex);
@@ -831,36 +676,7 @@ int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 	return 0;
 }
 
-static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
-{
-	struct ft_sm *sm = l_container_of(ap, struct ft_sm, ap);
-
-	return __ft_rx_associate(sm->hs->ifindex, frame, frame_len);
-}
-
-static int ft_rx_oci(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	return ft_tx_reassociate(ft->hs->ifindex, 0, ft->prev_bssid);
-}
-
-static void ft_sm_free(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	l_free(ft);
-}
-
-static bool ft_over_ds_start(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	return ft_tx_reassociate(ft->hs->ifindex, 0, ft->prev_bssid) == 0;
-}
-
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
+static bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
 {
@@ -932,71 +748,6 @@ bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 	return true;
 }
 
-static bool ft_start(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-	struct handshake_state *hs = ft->hs;
-	struct iovec iov;
-	uint8_t buf[512];
-	size_t len;
-
-	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, hs->snonce,
-					buf, &len))
-		return false;
-
-	iov.iov_base = buf;
-	iov.iov_len = len;
-
-	ft->tx_auth(&iov, 1, ft->user_data);
-
-	return true;
-}
-
-struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
-				ft_tx_associate_func_t tx_assoc,
-				ft_get_oci get_oci,
-				void *user_data)
-{
-	struct ft_sm *ft = l_new(struct ft_sm, 1);
-
-	ft->tx_auth = tx_auth;
-	ft->tx_assoc = tx_assoc;
-	ft->get_oci = get_oci;
-	ft->hs = hs;
-	ft->user_data = user_data;
-
-	ft->ap.rx_authenticate = ft_rx_authenticate;
-	ft->ap.rx_associate = ft_rx_associate;
-	ft->ap.start = ft_start;
-	ft->ap.free = ft_sm_free;
-	ft->ap.rx_oci = ft_rx_oci;
-
-	memcpy(ft->prev_bssid, hs->aa, 6);
-
-	return &ft->ap;
-}
-
-struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_associate_func_t tx_assoc,
-				void *user_data)
-{
-	struct ft_sm *ft = l_new(struct ft_sm, 1);
-
-	ft->tx_assoc = tx_assoc;
-	ft->hs = hs;
-	ft->user_data = user_data;
-	ft->over_ds = true;
-
-	ft->ap.rx_associate = ft_rx_associate;
-	ft->ap.start = ft_over_ds_start;
-	ft->ap.free = ft_sm_free;
-
-	memcpy(ft->prev_bssid, hs->aa, 6);
-
-	return &ft->ap;
-}
-
 void __ft_set_tx_frame_func(ft_tx_frame_func_t func)
 {
 	tx_frame = func;
diff --git a/src/ft.h b/src/ft.h
index 0e8c3a90..f3f19599 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -20,7 +20,6 @@
  *
  */
 
-struct handshake_state;
 struct scan_bss;
 
 typedef int (*ft_tx_frame_func_t)(uint32_t ifindex, uint16_t frame_type,
@@ -28,57 +27,9 @@ typedef int (*ft_tx_frame_func_t)(uint32_t ifindex, uint16_t frame_type,
 					const uint8_t *dest, struct iovec *iov,
 					size_t iov_len);
 
-typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_len,
-					void *user_data);
-
 typedef int (*ft_tx_associate_func_t)(uint32_t ifindex, uint32_t freq,
 					const uint8_t *prev_bssid,
 					struct iovec *ie_iov, size_t iov_len);
-typedef int (*ft_get_oci)(void *user_data);
-
-typedef void (*ft_ds_free_func_t)(void *user_data);
-
-struct ft_ds_info {
-	uint8_t spa[6];
-	uint8_t aa[6];
-	uint8_t snonce[32];
-	uint8_t mde[3];
-	uint8_t *fte;
-	uint8_t *authenticator_ie;
-
-	struct ie_ft_info ft_info;
-
-	void (*free)(struct ft_ds_info *s);
-};
-
-void ft_ds_info_free(struct ft_ds_info *info);
-
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
-				const uint8_t *new_snonce, uint8_t *buf,
-				size_t *len);
-
-int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
-					const uint8_t **spa_out,
-					const uint8_t **aa_out,
-					const uint8_t **ies_out,
-					size_t *ies_len);
-bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
-					struct handshake_state *hs,
-					const uint8_t *ies,
-					size_t ies_len);
-
-struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
-				ft_tx_associate_func_t tx_assoc,
-				ft_get_oci get_oci,
-				void *user_data);
-
-struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
-				ft_tx_associate_func_t tx_assoc,
-				void *user_data);
-
-bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
-					struct handshake_state *hs);
 
 void __ft_set_tx_frame_func(ft_tx_frame_func_t func);
 void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
-- 
2.34.3

