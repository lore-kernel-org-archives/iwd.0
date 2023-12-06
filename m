Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC23EA9A
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBS4cx53"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77f391c96c8so3161285a.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875244; x=1702480044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F76txXl0Lz9+jyQuBRiv0Gmf26qPnZ580WlyjFMVyXM=;
        b=aBS4cx53OufdtecTztAyAzLol5p9BJIdIMYN8R/WVkx11IH8/TpwzOMjHkhQ1w2Dd9
         npPU88g3GdbW6a1r9qP0tt4gP3pDgGv35m4CUzNvmWnl++NT7CZ5dWKQR7xSnRsTkP2L
         zGmAwfkqxowU3wQHAb4NXlhNJ29AVxZ6OdBlr4jni2CvWqGxl/88CYsT+56rvYXOVhFc
         cb1y01EOdTeCSYiYcBBneSQIoYd0idSg/yxhsYfDYJ6+sYz3+tLk7M57PxBKviN2gHiT
         1CTyL30kMXCZLA0vYTGdpRm27QPI/Bpokiad5u3zSg1yE8JntET7nTddlgHO0FSMslXK
         mzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875244; x=1702480044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76txXl0Lz9+jyQuBRiv0Gmf26qPnZ580WlyjFMVyXM=;
        b=AyExgzoTKr7piW1bVZTcga8qGTe1a1uhprMJQgq3SlP0lB+CGOYmUiAiAuf/CFNWGW
         G4DKBjCYw6823WpKFj53adowanC7jPujzqcIAjCT38gimZu2WoLikiuSbYAFBERwcE5k
         NW5GF463GrjXCsR0rBUL5tsnIg3tQDGESmmnev08WpiVpHHsPup+eItyOh+o9JT9cFtA
         9G+ABn3P+5Nmjvr/ISsNuQOkyXVQWARLrlkV2jtEO+e1kXkqs7ZqgYAXUYnzgmcgcvq4
         yN2g3lmo8+wVSfu8QZXeVa7/2ZFznhZwhKkjMxLSOsVQ8ErCYbh7mFfJlcpqOb1FeZYT
         NkzQ==
X-Gm-Message-State: AOJu0YyiX0hbKd2GnVxo6wHEUqx7VJpFpuUSd7H1C5NgdFVzvOQiiZPJ
	26WGfK/7nmdEb4Ts1IOhbIt92ssOjmc=
X-Google-Smtp-Source: AGHT+IEvtWOLQuTA+vgce5nrWz/tbzEqUafoXu6S4/dvamGnlYFNiFzkHmH9QI43z6Z8cWPKQ/57Kg==
X-Received: by 2002:a05:620a:3996:b0:77e:fba3:9d21 with SMTP id ro22-20020a05620a399600b0077efba39d21mr897147qkn.133.1701875244098;
        Wed, 06 Dec 2023 07:07:24 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 8/9] ft: remove ft_associate and helpers
Date: Wed,  6 Dec 2023 07:07:07 -0800
Message-Id: <20231206150708.2080336-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
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
index 738e08c3..add6a42b 100644
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

