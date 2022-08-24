Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BC2906
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:28 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso2638462pjd.0
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XAtPjLSAF09RyXd7dVB7KRE+R+s1OYgJ5wzeblyh84s=;
        b=XMkCgTa4NEVEjijGPAX5ZABaWH4yPOfuQq+1Rrjc/k3NW18qshNPNn54iOGkJnJS6B
         3oWWHbyJZv7R3NNpOIs0CUUX81OzwpbYBJ9xj1FDDJxWKl91MeWfSKoyKOiomyE5AxGP
         +ZxoEUQG5Yn3V3Pwn4ffmLY6h8ii8Lv3GVeyCvrJFyfkLvI/A+9u3I6QLxWtwu2uOopF
         lWr1yjC8J8Rv+X+vnN0IK1IVtrVKzx+ch3a/M+6GeYIndAKOQukLvb+8ypMRr/dzTdkS
         yb7DJ0Bl8UROUGHQi01giH/D+b2oG9x2Hm6jgxynzBgtscHKqZTOLJejekDh+sogUeGO
         PqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XAtPjLSAF09RyXd7dVB7KRE+R+s1OYgJ5wzeblyh84s=;
        b=ZYx4aOyfElVNw1ucztAmP6Ht6aRuNXL2CNchi2HyMpdOUi1Fn9/HlqDuHus+IpKdSc
         8vvrjC4rHikgaqklQPDRys7jZBHPn73kfLiDEGC9QsJU+//tWBiqOyvYNzHUrhEA4rzo
         laBOArrnJYG2J4rWMJ3y52fKiaVpuV1XtfqjIfJo/6omBVt8dKPq8aS2X+5CYQSP20MO
         nRtXAIaUzaldKMIWgHMn5GfpyVB2D+zXm43DuW6Sx7xX/5GNTC3d8zjnovPvv0jP0adN
         4FJJ8ISUTQRVGxlb1QfzJF7BIdYJx9jmq9k40VOGOW9sVJTrS4WIIkVSnP9LDzbOT+nB
         wSsg==
X-Gm-Message-State: ACgBeo13+R6WGvmFyX1cPytOQGzZwB/9xObmAwPXM+Yy0o8lxoOg/7tI
	k3m9tLr1LDbTMmOfGningdilaoGC3UE=
X-Google-Smtp-Source: AA6agR6wA8n7YfH0Qv1CYX7GJKLkZlcr9gXsyzMOq30nlwUmYP+MkwEuekgebTCG4nWUZEMCbp53kA==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr953299plx.132.1661381728040;
        Wed, 24 Aug 2022 15:55:28 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/9] ft: implement offchannel authentication
Date: Wed, 24 Aug 2022 15:55:16 -0700
Message-Id: <20220824225518.2558698-7-prestwoj@gmail.com>
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

A new API was added, ft_authenticate, which will send an
authentication frame offchannel via CMD_FRAME. This bypasses
the kernel's authentication state allowing multiple auth
attempts to take place without disconnecting.
---
 src/ft.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |   5 +++
 2 files changed, 137 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 2c9c92e6..ce57020b 100644
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
@@ -1199,6 +1203,134 @@ failed:
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
+	return frame_xchg_start(wdev_id, iov, info->frequency, FRAME_GROUP_FT,
+				100, 0, 0,
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

