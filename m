Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5B4C9E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:57 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso18638051pjd.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+1Hq6gU1qoUa8uJRy7hfWABMGhO9D8M9ZtXS31E9pws=;
        b=pBidfLoGr+XH5stYjnpDJpbSPYrGu8MyNStByitynJOsRqiyZ0I6RBwYKXV09LgZKU
         rMW+WISN5kU71/jEtsZIs+xm5vY1XeY99EFCQLN7nscPirDEZYzjnLzy5+qmYYw0CFCU
         YhqZEIxe8IjXv0K3t2+ORE7p/yJrM5+TBl48ymHWA5QVgZPJ7+URPxS+2TmMUvP4Lmb/
         t30RE5YAZ7aD+kjMRP+DTQQdTyyvJIx4Z/QWmjkOvuC05YhCzTIBUJRTVUfIAuM7yihp
         yOViDHqwCfd7T4rkf9YEIBLlK++WwUHA8++YSsL0JHbqhWwkpObaURnFX9zW5mrd7LZd
         ZGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+1Hq6gU1qoUa8uJRy7hfWABMGhO9D8M9ZtXS31E9pws=;
        b=y+3vTjNA7A/S1xqX1TnwRdq1fTmSj2P3kxZsAFt2kQ57M51Ctgn9CevY4yq+J4XRCR
         auwjNneQzIHpd0XWoP0WgyNtUbqQHwCmYg1DslUfqKcQXvV2JPHjX0XlxowiOz1y3sHa
         U3MTK7jfdEpX7R8YSTT3Ks8K5sn3SUt2dZjqXukA5q8wuwlzeM9BgNwuLmDRVWn03Vac
         JvDgzlSwjHTgJ/HCOk6iLmmztojFSFWNC5hzCbhfzjXr8LiqYxuQGLGqcbDvpfndEUs3
         06SIZPmei4BhT7TtDFBIQSRyID6KIYbxLct6wtO8xyn7WAZypvx3ayvZmMDYA5atXAnq
         K2Og==
X-Gm-Message-State: ACrzQf3HnhjpzljgfmqWC5FxhICsBia2TyXWftwMnzJiESwB7ezOligu
	wdfoqDSjE3hdkG1wI5PgXEVz0UELPu8=
X-Google-Smtp-Source: AMsMyM5Vn1looqmHbIetAAyBIadhg3T4vB9Nfh4ZGehEss2gaf/qzyrjnKUpvcOfIJ0vUVcolbXv5w==
X-Received: by 2002:a17:902:f70d:b0:172:d1d1:9b8c with SMTP id h13-20020a170902f70d00b00172d1d19b8cmr1513385plo.129.1663279677231;
        Thu, 15 Sep 2022 15:07:57 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/14] ft: remove unused code after refactor
Date: Thu, 15 Sep 2022 15:07:36 -0700
Message-Id: <20220915220741.1128728-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes unused code as well as makes a few functions static which
are no longer used externally.
---
 src/ft.c | 254 ++-----------------------------------------------------
 src/ft.h |  47 ----------
 2 files changed, 5 insertions(+), 296 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index abb2f380..2dfa7a11 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -24,6 +24,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include <ell/ell.h>
 
 #include "src/ie.h"
@@ -31,8 +33,6 @@
 #include "src/crypto.h"
 #include "src/ft.h"
 #include "src/mpdu.h"
-#include "src/auth-proto.h"
-#include "src/band.h"
 #include "src/scan.h"
 #include "src/frame-xchg.h"
 #include "src/util.h"
@@ -63,13 +63,8 @@ struct ft_info_finder {
 };
 
 struct ft_sm {
-	struct auth_proto ap;
 	struct handshake_state *hs;
 
-	ft_tx_authenticate_func_t tx_auth;
-	ft_tx_associate_func_t tx_assoc;
-	ft_get_oci get_oci;
-
 	ft_authenticate_cb_t auth_cb;
 	void *user_data;
 
@@ -496,79 +491,8 @@ static bool mde_equal(const uint8_t *mde1, const uint8_t *mde2)
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
@@ -610,75 +534,6 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
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
 	struct ft_sm *ft = ft_sm_find(ifindex);
@@ -818,38 +673,7 @@ int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
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
-	return ft_tx_reassociate(ft);
-}
-
-static void ft_auth_proto_free(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	l_queue_remove(sm_list, ft);
-
-	l_free(ft);
-}
-
-static bool ft_over_ds_start(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	return ft_tx_reassociate(ft) == 0;
-}
-
-bool ft_build_authenticate_ies(struct handshake_state *hs,
+static bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
 {
@@ -920,74 +744,6 @@ bool ft_build_authenticate_ies(struct handshake_state *hs,
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
-	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
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
-	ft->ap.free = ft_auth_proto_free;
-	ft->ap.rx_oci = ft_rx_oci;
-
-	memcpy(ft->prev_bssid, hs->aa, 6);
-
-	l_queue_push_tail(sm_list, ft);
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
-	ft->ap.free = ft_auth_proto_free;
-
-	memcpy(ft->prev_bssid, hs->aa, 6);
-
-	l_queue_push_tail(sm_list, ft);
-
-	return &ft->ap;
-}
-
 void __ft_set_tx_action_func(ft_tx_action_func_t func)
 {
 	tx_action = func;
diff --git a/src/ft.h b/src/ft.h
index 9839128a..1a18cd0e 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -26,60 +26,13 @@ struct scan_bss;
 typedef int (*ft_tx_action_func_t)(uint32_t ifindex, const uint8_t *dest,
 					struct iovec *iov, size_t iov_len);
 
-typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_len,
-					void *user_data);
 typedef int (*ft_tx_associate_func_t)(uint32_t ifindex,
 					const uint8_t *prev_bssid,
 					struct iovec *ie_iov, size_t iov_len);
-typedef int (*ft_get_oci)(void *user_data);
-
-typedef void (*ft_ds_free_func_t)(void *user_data);
 
 typedef void (*ft_authenticate_cb_t)(int err, const uint8_t *addr,
 					uint32_t freq, void *user_data);
 
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
-bool ft_build_authenticate_ies(struct handshake_state *hs,
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
-
 void __ft_set_tx_action_func(ft_tx_action_func_t func);
 void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
-- 
2.34.3

