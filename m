Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CE4C64
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:50 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so11031036pjk.2
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=roGslHM6Xpxf5HcZoIGarcIyZwvZUHVOoWMRsykKzgg=;
        b=oCOh7fqkkXWnAphXl+jPuY7wH5CspoKTKmV+Vw6m6IQANvwrhfjDjroUaSYJ4bS655
         hb0bdgKubL560SUxtFv1zYnoEqGxSuesB0TjKeUioNluqggdoLL2ygLn3IbHsncoC1cf
         YknM0auNuu6eq0KCaB6rtr8d+Of0U5WD+48mNtzapOYbOFOEchKY6QX0rbvcLkdQP4fX
         oX5ALZN5RonjImB0XvIAR2qjANZahlQcpKtqaCF3Y5Ff4BUKSZRMqZvOOLPqKaspzd15
         o/pjMKNzK1TZpX438c9gquZzOfD7v/EAfVK3UXD/TtQmqk/xx0z8wIm4qRhZVoRRwKpw
         TUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=roGslHM6Xpxf5HcZoIGarcIyZwvZUHVOoWMRsykKzgg=;
        b=bZhhIwNO02b9ID92zQtZ8F3AHLkbwKHQzk03tKcTZajNccz1Te5PEM5iQ42YLM6JP8
         Y/eA/RCFaH22S6YvAQVDOG8qWw47VI0NYyQY4RK7kvdD1iJ1+WhFlT3JwGDdj4XUMb8b
         5MKdIDcnarxwvP4iCarJjHDNg4PN//KxzlozPMjqPAxURgDCXbrmB+RJsYo0ZP42Ou0R
         7mnXxCM/9n/QxVeLcmVHNBaOWoqW4qlh1P5cj8w5y2RfhFYH5X0s9SzzQrsru0zChjND
         pZU+PcgESX0tQsIY2sjqvo3rkDQH+1UIsNKA0YoSUEy8/kCndLQDV8EevYHs8FyEcvDK
         GuXQ==
X-Gm-Message-State: ACrzQf1KgHkWBlhPFUya7lSJvDbgG4tS141gXG5KQcEHS9wLkdKNNhY+
	tT6wbqUvAPBHsCtY8lZLIynvPgeK5bQ=
X-Google-Smtp-Source: AMsMyM4EjMbqDRLRe26NgMuDG/MPaiu9EWIkS6TpwQavp4JsYbFClDrM8L5oIk4kAz64rwHOTPMK1A==
X-Received: by 2002:a17:902:d543:b0:179:f6e7:314c with SMTP id z3-20020a170902d54300b00179f6e7314cmr2809111plf.1.1664308070325;
        Tue, 27 Sep 2022 12:47:50 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 11/11] ft: remove auth-proto/ft_sm
Date: Tue, 27 Sep 2022 12:47:31 -0700
Message-Id: <20220927194731.269732-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
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
index a4277cbe..72c42309 100644
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

