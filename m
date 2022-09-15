Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AD4C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:56 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso113340pjq.1
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5SseaSGN95SnOOohBVrhDAEaaj7FfD2UPU+1/Ylnp98=;
        b=RkcNWZkEpqNWf3KNyccrrPD3zMy5eCaCDLem3yWwsEzJ1pyoj05EI26U3LLHsxiQag
         MeNfF5aAh/wYj+/5Rsuwv+g2ht5MdtQOZRsTN+OPPgWI2+Kt4bjkfBLs6IZ25aM8/9hR
         sOTVacCs/c4k7pOVkqywJPnmg3BMLemneLZgHIO2sDNLxDRJtPehNUt++J5eguNAHi9p
         xc51bPaGgFR0TnhSbi1VuurmfP8S4OaC4qD9A4CrA8fjraKtsQreO6s/0oy022m8VFnW
         1NgluUC1MtngRdi/1xCoZ9L+OsvdHKJbn8jLdwL7bMOGE7XYxBdsBwmms3Y/FPrqwYfl
         r82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5SseaSGN95SnOOohBVrhDAEaaj7FfD2UPU+1/Ylnp98=;
        b=AxAWTS1yq7s/V/hvQUuHkp1iDjFc9KzlGrLJ/Q2iApNcAdpOhxdWJS76FJ+EykduEM
         ejvTJli+JiChQj7UVUmmz+HIAVsnVAQ+AI1FJmcDgotx6HRN5ZBrP4FsLddLiFtj7ENv
         gxGWWaGcyT5zYanBvKg7RQ4mf4g301hUvrjUyNR8gFGp/jpW45VNPEKM4VkjDyfQbFeG
         xFhbJR/v00uoFZGt5HXQEEv/tbwqq/Pxu8EYCY8fJe6aIUX89AOgLQJd1BovHCVEM72g
         uwlFewPPBT+QpAc+eoHAAtcuakFnO12ScY4iU9GH2tPpALVW0kRq1IBZcnXDZczfORfB
         Mn0w==
X-Gm-Message-State: ACrzQf1qLL5JORFJsBZT5CuPxxvyT4R0vlu15YFtV22/HWEyYGaueYYS
	nOWStIYRz9hfQg5vLp58cKyNB7vph18=
X-Google-Smtp-Source: AMsMyM4BzpENwHB1xTquIlhNsUD04ZqJziDHfxQkrbsNlYCSirJUX2egJB9/FvreBa8qvvmnbirqTQ==
X-Received: by 2002:a17:902:7c03:b0:172:56b1:8152 with SMTP id x3-20020a1709027c0300b0017256b18152mr1715279pll.16.1663279675932;
        Thu, 15 Sep 2022 15:07:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/14] ft: implement offchannel authentication
Date: Thu, 15 Sep 2022 15:07:34 -0700
Message-Id: <20220915220741.1128728-7-prestwoj@gmail.com>
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

A new API was added, ft_authenticate, which will send an
authentication frame offchannel via CMD_FRAME. This bypasses
the kernel's authentication state allowing multiple auth
attempts to take place without disconnecting.
---
 src/ft.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |   5 +++
 2 files changed, 139 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 2c9c92e6..559e3984 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -50,6 +50,7 @@ struct ft_info {
 	uint8_t mde[3];
 	uint8_t *fte;
 	uint8_t *authenticator_ie;
+	uint32_t frequency;
 
 	struct ie_ft_info ft_info;
 
@@ -69,6 +70,7 @@ struct ft_sm {
 	ft_tx_associate_func_t tx_assoc;
 	ft_get_oci get_oci;
 
+	ft_authenticate_cb_t auth_cb;
 	void *user_data;
 
 	bool over_ds : 1;
@@ -1082,6 +1084,8 @@ static struct ft_info *ft_info_new(struct handshake_state *hs,
 	memcpy(info->aa, target_bss->addr, 6);
 	memcpy(info->mde, target_bss->mde, sizeof(info->mde));
 
+	info->frequency = target_bss->frequency;
+
 	if (target_bss->rsne)
 		info->authenticator_ie = l_memdup(target_bss->rsne,
 						target_bss->rsne[1] + 2);
@@ -1199,6 +1203,136 @@ failed:
 	return ret;
 }
 
+static void ft_authenticate_cb(int err, void *user_data)
+{
+	if (err < 0)
+		l_debug("Failed to send FT-Authenticate");
+}
+
+static void ft_authenticate_destroy(void *user_data)
+{
+	struct ft_sm *sm = user_data;
+	struct ft_info *info = l_queue_peek_head(sm->ft_auths);
+
+	if (L_WARN_ON(!info))
+		return;
+
+	if (!info->parsed)
+		goto failed;
+
+	sm->auth_cb(0, info->aa, info->frequency, sm->user_data);
+
+	return;
+
+failed:
+	l_queue_pop_head(sm->ft_auths);
+	ft_info_destroy(info);
+
+	sm->auth_cb(-EINVAL, info->aa, info->frequency, sm->user_data);
+}
+
+static void ft_authenticate_response_cb(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	struct ft_sm *sm = user_data;
+	struct ft_info *info = l_queue_peek_head(sm->ft_auths);
+	uint16_t status;
+	const uint8_t *ies;
+	size_t ies_len;
+
+	if (!ft_parse_authentication_resp_frame((const uint8_t *)hdr,
+					mmpdu_header_len(hdr) + body_len,
+					info->spa, info->aa, info->aa, 2,
+					&status, &ies, &ies_len))
+		return;
+
+	if (status != 0)
+		return;
+
+	if (!ft_parse_ies(info, sm->hs, ies, ies_len))
+		return;
+
+	info->parsed = true;
+
+	return;
+}
+
+static const struct frame_xchg_prefix ft_prefix = {
+	.frame_type = 0x0000 | (MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4),
+	.data = (uint8_t []) { 0x02, 0x00 },
+	.len = 2,
+};
+
+static bool ft_send_authenticate(struct ft_sm *sm, struct ft_info *info)
+{
+	uint64_t wdev_id = netdev_get_wdev_id(netdev_find(sm->hs->ifindex));
+	uint8_t header[28 + sizeof(struct mmpdu_authentication)];
+	uint8_t ies[256];
+	size_t len;
+	struct iovec iov[3];
+	struct mmpdu_header *mpdu = (struct mmpdu_header *) header;
+	struct mmpdu_authentication *auth;
+	struct handshake_state *hs = sm->hs;
+
+	memset(mpdu, 0, sizeof(*mpdu));
+
+	/* Header */
+	mpdu->fc.protocol_version = 0;
+	mpdu->fc.type = MPDU_TYPE_MANAGEMENT;
+	mpdu->fc.subtype = MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION;
+	memcpy(mpdu->address_1, info->aa, 6);
+	memcpy(mpdu->address_2, info->spa, 6);
+	memcpy(mpdu->address_3, info->aa, 6);
+
+	/* Authentication body */
+	auth = (void *) mmpdu_body(mpdu);
+	auth->algorithm = L_CPU_TO_LE16(MMPDU_AUTH_ALGO_FT);
+	auth->transaction_sequence = L_CPU_TO_LE16(1);
+	auth->status = L_CPU_TO_LE16(0);
+
+	iov[0].iov_base = mpdu;
+	iov[0].iov_len = mmpdu_header_len(mpdu) +
+				sizeof(struct mmpdu_authentication);
+
+	if (!ft_build_authenticate_ies(hs, info->snonce, ies, &len))
+		return false;
+
+	iov[1].iov_base = ies;
+	iov[1].iov_len = len;
+
+	iov[2].iov_base = NULL;
+
+	return frame_xchg_start(wdev_id, iov, info->frequency, 0,
+				300, 0, FRAME_GROUP_FT,
+				ft_authenticate_cb, sm,
+				ft_authenticate_destroy, &ft_prefix,
+				ft_authenticate_response_cb, NULL) != 0;
+}
+
+int ft_authenticate(struct ft_sm *sm, const struct scan_bss *target,
+			ft_authenticate_cb_t cb, void *user_data)
+{
+	struct ft_info *info = ft_info_new(sm->hs, target);
+	int ret = -EINVAL;
+
+	if (!ft_send_authenticate(sm, info))
+		goto failed;
+
+	l_queue_clear(sm->ft_auths, ft_info_destroy);
+
+	sm->auth_cb = cb;
+	sm->user_data = user_data;
+
+	l_queue_push_tail(sm->ft_auths, info);
+
+	return 0;
+
+failed:
+	l_free(info);
+	return ret;
+}
+
 int ft_associate(struct ft_sm *sm, const uint8_t *addr)
 {
 	struct ft_info *info;
diff --git a/src/ft.h b/src/ft.h
index 6e0f4271..9839128a 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -35,6 +35,9 @@ typedef int (*ft_get_oci)(void *user_data);
 
 typedef void (*ft_ds_free_func_t)(void *user_data);
 
+typedef void (*ft_authenticate_cb_t)(int err, const uint8_t *addr,
+					uint32_t freq, void *user_data);
+
 struct ft_ds_info {
 	uint8_t spa[6];
 	uint8_t aa[6];
@@ -87,3 +90,5 @@ void ft_sm_free(struct ft_sm *sm);
 
 int ft_action(struct ft_sm *sm, const struct scan_bss *target);
 int ft_associate(struct ft_sm *sm, const uint8_t *addr);
+int ft_authenticate(struct ft_sm *sm, const struct scan_bss *target,
+			ft_authenticate_cb_t cb, void *user_data);
-- 
2.34.3

