Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0C6EB72
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpmJM89h"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d04c097e34so1794875ad.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893894; x=1702498694; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMRJ21BvtcbcgEK0KkDWtNJ899I+7BxdrJXqZMjxwTs=;
        b=EpmJM89hxD1RiLDkMX66/DIgn3Ze2F2rrerr/QiIsArnIl+fUiuX6q5K++O5QtuHT5
         MFlUrtHjVZcaLLD/ofhp4r4rPYjCTM2D5Eu2j8aWVGAPSZzK3BCGexqERplalrXs2VbG
         Q3CbSXFWGjTjCZE/VvsEHc4/1JwAxPI7y4C1qC22LpvKDITlp0qxZ6WjoJ2SAatJHdak
         i9vVXAlNnbcmCbIT6yf6ShSUxwvqcaDvklaOw0zSqqERSIyPb+IK8ImOeFMM5nG48dwj
         0gZdKJywXX4QLMObJ1Z2wP/RVNQvyJa/TV1GJ5gm4eqPeEOesa+c/SOJeHLwv378KzPO
         Yh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893894; x=1702498694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMRJ21BvtcbcgEK0KkDWtNJ899I+7BxdrJXqZMjxwTs=;
        b=VMsoe0CLBDpEp3qWDAiAHmrsP0RUyY9UX2ItHJPYf17I3vdIZxoFCUhnd7yfGkkJZs
         Ra3TVCVJd97jub0ieu9fUhNDUA7l87vQBc3vDu5Pz1zUtruKIBJF/Xyy205Eg/fv4f4F
         wkVJRCi8UmA3SezAJ0j7uqRZ+sEzGRZDPmpXv18d3hFuB1BG6uB2F3zDviuwekyDUBxK
         Iekv28wTd41eF2vmq/MGmgzZli3vBDqWqUb4riRlVX7e/iqdY9k7oRxkTgiD9+mppN63
         aU2A67eRmfXuRhZGQWSFY18VdzmyZMnXuFfkGmuQr/Zt49LzZL+wbCufYMyY3iQcvNGL
         sBxA==
X-Gm-Message-State: AOJu0YyCMpBb43mNjJkZqxgJVbJUGd0pLQOGpTj2p96VTXW8oQfgX6mW
	u6mcB8k0PU/nNKXd8qHZk43xdl49vhXNyQ==
X-Google-Smtp-Source: AGHT+IGMXnxCxVQk6ghUxbxd5Yhd0PDKNTjwlnlIguruxUlzyFP52W0fQg6jTtnW8reA3mVW4l/C7g==
X-Received: by 2002:a17:902:ee05:b0:1d0:68a:4a12 with SMTP id z5-20020a170902ee0500b001d0068a4a12mr4174102plb.15.1701893893782;
        Wed, 06 Dec 2023 12:18:13 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:13 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 12/13] ft: remove ft_associate and helpers
Date: Wed,  6 Dec 2023 12:18:01 -0800
Message-Id: <20231206201802.2139649-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reassociation is done through netdev directly, these are no
longer needed.
---
 src/ft.c | 160 +------------------------------------------------------
 src/ft.h |   2 -
 2 files changed, 1 insertion(+), 161 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index c612a433..d8bee74c 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -43,7 +43,6 @@
 static const unsigned int FT_ONCHANNEL_TIME = 300u; /* ms */
 
 static ft_tx_frame_func_t tx_frame = NULL;
-static ft_tx_associate_func_t tx_assoc = NULL;
 static struct l_queue *info_list = NULL;
 
 struct ft_info {
@@ -224,117 +223,6 @@ static bool ft_parse_associate_resp_frame(const uint8_t *frame, size_t frame_len
 	return true;
 }
 
-static int ft_tx_reassociate(uint32_t ifindex, uint32_t freq,
-				const uint8_t *prev_bssid)
-{
-	struct netdev *netdev = netdev_find(ifindex);
-	struct handshake_state *hs = netdev_get_handshake(netdev);
-	struct iovec iov[3];
-	int iov_elems = 0;
-	uint32_t kck_len = handshake_state_get_kck_len(hs);
-	bool is_rsn = hs->supplicant_ie != NULL;
-	uint8_t *rsne = NULL;
-
-	if (is_rsn) {
-		struct ie_rsn_info rsn_info;
-
-		/*
-		 * Rebuild the RSNE to include the PMKR1Name and append
-		 * MDE + FTE.
-		 *
-		 * 12.8.4: "If present, the RSNE shall be set as follows:
-		 * - Version field shall be set to 1.
-		 * - PMKID Count field shall be set to 1.
-		 * - PMKID field shall contain the PMKR1Name.
-		 * - All other fields shall be as specified in 8.4.2.27
-		 *   and 11.5.3."
-		 */
-		if (ie_parse_rsne_from_data(hs->supplicant_ie,
-						hs->supplicant_ie[1] + 2,
-						&rsn_info) < 0)
-			goto error;
-
-		rsn_info.num_pmkids = 1;
-		rsn_info.pmkids = hs->pmk_r1_name;
-
-		/* Always set OCVC false for FT for now */
-		rsn_info.ocvc = false;
-
-		rsne = alloca(256);
-		ie_build_rsne(&rsn_info, rsne);
-
-		iov[iov_elems].iov_base = rsne;
-		iov[iov_elems].iov_len = rsne[1] + 2;
-		iov_elems += 1;
-	}
-
-	/* The MDE advertised by the BSS must be passed verbatim */
-	iov[iov_elems].iov_base = (void *) hs->mde;
-	iov[iov_elems].iov_len = hs->mde[1] + 2;
-	iov_elems += 1;
-
-	if (is_rsn) {
-		struct ie_ft_info ft_info;
-		uint8_t *fte;
-
-		/*
-		 * 12.8.4: "If present, the FTE shall be set as follows:
-		 * - ANonce, SNonce, R0KH-ID, and R1KH-ID shall be set to
-		 *   the values contained in the second message of this
-		 *   sequence.
-		 * - The Element Count field of the MIC Control field shall
-		 *   be set to the number of elements protected in this
-		 *   frame (variable).
-		 * [...]
-		 * - All other fields shall be set to 0."
-		 */
-
-		memset(&ft_info, 0, sizeof(ft_info));
-
-		ft_info.mic_element_count = 3;
-		memcpy(ft_info.r0khid, hs->r0khid, hs->r0khid_len);
-		ft_info.r0khid_len = hs->r0khid_len;
-		memcpy(ft_info.r1khid, hs->r1khid, 6);
-		ft_info.r1khid_present = true;
-		memcpy(ft_info.anonce, hs->anonce, 32);
-		memcpy(ft_info.snonce, hs->snonce, 32);
-
-		/*
-		 * IEEE 802.11-2020 Section 13.7.1 FT reassociation in an RSN
-		 *
-		 * "If dot11RSNAOperatingChannelValidationActivated is true and
-		 *  the FTO indicates OCVC capability, the target AP shall
-		 *  ensure that OCI subelement of the FTE matches by ensuring
-		 *  that all of the following are true:
-		 *      - OCI subelement is present
-		 *      - Channel information in the OCI matches current
-		 *        operating channel parameters (see 12.2.9)"
-		 */
-		if (hs->supplicant_ocvc && hs->chandef) {
-			oci_from_chandef(hs->chandef, ft_info.oci);
-			ft_info.oci_present = true;
-		}
-
-		fte = alloca(256);
-		ie_build_fast_bss_transition(&ft_info, kck_len, fte);
-
-		if (!ft_calculate_fte_mic(hs, 5, rsne, fte, NULL, ft_info.mic))
-			goto error;
-
-		/* Rebuild the FT IE now with the MIC included */
-		ie_build_fast_bss_transition(&ft_info, kck_len, fte);
-
-		iov[iov_elems].iov_base = fte;
-		iov[iov_elems].iov_len = fte[1] + 2;
-		iov_elems += 1;
-	}
-
-	return tx_assoc(ifindex, freq, prev_bssid, iov, iov_elems);
-
-error:
-	return -EINVAL;
-}
-
 static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 				const uint8_t *authenticator_ie)
 {
@@ -762,11 +650,6 @@ void __ft_set_tx_frame_func(ft_tx_frame_func_t func)
 	tx_frame = func;
 }
 
-void __ft_set_tx_associate_func(ft_tx_associate_func_t func)
-{
-	tx_assoc = func;
-}
-
 static bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
 			const uint8_t *ies, size_t ies_len)
 {
@@ -1173,7 +1056,7 @@ static void ft_authenticate_destroy(int error, void *user_data)
 /*
  * There is no callback here because its assumed that another work item will
  * be inserted following this call which will check if authentication succeeded
- * via ft_associate.
+ * via ft_handshake_setup.
  *
  * If the netdev goes away while authentication is in-flight station will clear
  * the authentications during cleanup, and in turn cancel the offchannel
@@ -1235,47 +1118,6 @@ int ft_authenticate_onchannel(uint32_t ifindex, const struct scan_bss *target)
 	return 0;
 }
 
-int ft_associate(uint32_t ifindex, const uint8_t *addr)
-{
-	struct netdev *netdev = netdev_find(ifindex);
-	struct handshake_state *hs = netdev_get_handshake(netdev);
-	struct ft_info *info;
-	int ret;
-
-	/*
-	 * TODO: Since FT-over-DS is done early, before the time of roaming, it
-	 *       may end up that a completely new BSS is the best candidate and
-	 *       we haven't yet authenticated. We could actually authenticate
-	 *       at this point, but for now just assume the caller will choose
-	 *       a different BSS.
-	 */
-	info = ft_info_find(ifindex, addr);
-	if (!info)
-		return -ENOENT;
-
-	/*
-	 * Either failed or no response. This may have been an FT-over-DS
-	 * attempt so clear out the entry so FT-over-Air can try again.
-	 */
-	if (info->status != 0) {
-		int status = info->status;
-
-		l_queue_remove(info_list, info);
-		ft_info_destroy(info);
-
-		return status;
-	}
-
-	ft_prepare_handshake(info, hs);
-
-	ret = ft_tx_reassociate(ifindex, info->frequency, info->prev_bssid);
-
-	/* After this no previous auths will be valid */
-	ft_clear_authentications(ifindex);
-
-	return ret;
-}
-
 int ft_handshake_setup(uint32_t ifindex, const uint8_t *target)
 {
 	struct netdev *netdev = netdev_find(ifindex);
diff --git a/src/ft.h b/src/ft.h
index 23d0136e..92c207fb 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -32,7 +32,6 @@ typedef int (*ft_tx_associate_func_t)(uint32_t ifindex, uint32_t freq,
 					struct iovec *ie_iov, size_t iov_len);
 
 void __ft_set_tx_frame_func(ft_tx_frame_func_t func);
-void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
 			size_t frame_len);
 void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
@@ -43,6 +42,5 @@ int ft_handshake_setup(uint32_t ifindex, const uint8_t *target);
 
 void ft_clear_authentications(uint32_t ifindex);
 int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
-int ft_associate(uint32_t ifindex, const uint8_t *addr);
 int ft_authenticate(uint32_t ifindex, const struct scan_bss *target);
 int ft_authenticate_onchannel(uint32_t ifindex, const struct scan_bss *target);
-- 
2.34.1

