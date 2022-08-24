Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C42F59
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:29 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id q63so2047879pga.9
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=syQH7Zbbgiv9g1VTv15Li/8fz3DkXknqaATWMXxO1Fg=;
        b=K1xmfuYURb0PLKRcxVB6/SY0x+0zJ7Xwej9CFFOwLey+2ooSzJGtm5BLQcMoq6d9WH
         EqAjUSAy3OlnB+NEvyBj9+9DkfAYh6ojDp4zz3H/1qFntZtPDgFt1nhGuPSgpp74WvZ4
         v3jwNCQs5LM53rlJJ9ZMQUkZO2NVbGHKKedNYOgvIZQYMHLMX2B8C4H+k3NtrOuo9Fqc
         lQQzqmp2jkWxvaWUDojnVS6qa/TI1BuR8ngdoYvdXMl2GR+3GRZeJ/HgA2ou3OI4awfw
         kykXMR+jRnffrg2X0XvJnOmEs9byC59od++2y8Aw+aSl8SUlCUFS8hJ4vtLP9+roGYgC
         uqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=syQH7Zbbgiv9g1VTv15Li/8fz3DkXknqaATWMXxO1Fg=;
        b=XnWQJJ71kGZtbo+gzSxADl+A/c+4uGnWYEltHHRGTLgeHA4i8EiH2wFOTU/d9IIAdn
         RlhDTaH8Pmb7N6yLV4Hs7FR+YrLWkwUOVIqTeQBImlCgl2PwvfwcsYd/cmUahiVQkwW9
         CIiE/+/CR4Jhc9oEuQeu7uUe7LttyCg2+VrptKbTYY/VQS5QyAUtlM/QIVipwo5jefeu
         W+NamokZUQXraLNKL5vCKe0LGlsxzUlzjLivnNlc56gvDWY36An/NAXigbMrvPQ5Fmf5
         620jtHiHpS/fgD6PuFSxO1h0REQdVCpkPD7EzmyCCLzB3JrTVyqfzmmxFwzeL88slGQm
         B2AQ==
X-Gm-Message-State: ACgBeo2sqMjkg7Lzqa8Y02hBVLaSn970t6+1m+ylOEK6r2lw6B10Cl51
	arYeNPxeFQWL9VD8bBZQswYAMd4/GLk=
X-Google-Smtp-Source: AA6agR6mqAfUZ4xJQZERi+Fv74tTGZ+VgRANrzhFzE04axk8ntHkJptb1mUIAqCpJtOlCERhYF7B+g==
X-Received: by 2002:a63:cd55:0:b0:42a:7649:77c7 with SMTP id a21-20020a63cd55000000b0042a764977c7mr855272pgj.149.1661381729296;
        Wed, 24 Aug 2022 15:55:29 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 9/9] ft: remove unused code after refactor
Date: Wed, 24 Aug 2022 15:55:18 -0700
Message-Id: <20220824225518.2558698-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
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
index 47e98c05..32d7ee27 100644
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

