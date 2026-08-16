Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572D37EFE7
	for <iwd@lists.linux.dev>; Sun, 16 Aug 2026 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786839238; cv=none; b=uuhvtlL1FxWm6inXa6vRviL+212CgICYv15AjeDt9YF36wm/E+8kv899kgUGS/tPocskq1JKbwogmOR4dxCxGJHyLrTFyLQlCLpWcKzEkucHS+gyb+ECTqrUPEC0ee7tT5oXp5zaemOhbkytruca579IKJDKTVZbuSvRHf6ATzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786839238; c=relaxed/simple;
	bh=y1XkHJIfBOVGA+VVJe2COeQS/aJGYtVD+5KGI+pao+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tLQ4SGLZcb9FhoGvU/kkAf7yLRn/UQUOsFaD9rVfu4YnBA+JKN9b7mM5+imvGrnmhTWXlSi56iitNEFOGkMy9QYLK6B+TvG+/SlwYNxs3Kulf0h31bDi4mhtLg3IUKazispJSKMiGaYO13HfZqRGXPRO/EUssTYmZqyGvVVtRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=HYzTF6nQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="HYzTF6nQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980dc26022so22598905e9.1
        for <iwd@lists.linux.dev>; Sat, 15 Aug 2026 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1786839232; x=1787444032; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Swu5QdUkrrKXwrAFsBoUnTgKdipzzWtjz8TKQO49fxk=;
        b=HYzTF6nQ0BXdlMfHoFdyAFkT2KUC2hjUyxZsuDzZMBMcW6KoUue580QOZLj1kgtvX4
         nZoyW2RMUF+RdoIN9BEul8IVe63ZMWSideusiT5sCtE6Y0sWsDWYoHy+w1RuTOsTDXRL
         wrn4y4iEGBgspU1h39INmrTAT3Gi9gkuIK6rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786839232; x=1787444032;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Swu5QdUkrrKXwrAFsBoUnTgKdipzzWtjz8TKQO49fxk=;
        b=KcDKEEJlnXLVLFPdcsznEisX7jeZ+Bz0Xo5oj4w+68As3ZWKnf7khL2dpOLS9lFzuN
         kqHZ8qBXAevh+GhOJTagxVOVXWvFnaJlJQnNs2DZ57pWSwohNbOgohXAeXKr4Zx5dsbM
         b0TI85ASVVcYFIiZ0aaCSKYmaRoGHwA7Hg4d3GYu9BA7ksCFooQE5fmMCs3hGD5vQWxO
         Kt8IG6GVd0UPdncU8DyaG/274WJZRhwp6syNflbBvqrivqjnfLTVfrs/yU9EV0EL7WOO
         f7oicI0cQxgl3Z5kbcB4ssWrtQx7HnUSqqPYhBsTF8vlVW+ejmJ0I20+//m4++jVF4wN
         D0Cg==
X-Gm-Message-State: AOJu0YxK3QvaB2qEBAkhWNP5m7YZrXb6CK5PsMcfWM2IJcnlyqATx/3t
	pmUe1lgIOUev6ZFlH5A6AAtI6Wy62H6T97EzODSZBH9XONzZ2sIaYoozc0/0z8SE/OLc15aVQT0
	szIzsDGU=
X-Gm-Gg: AR+sD13d3pUtdsTrPdMG8s1mLfW93h4Z07e1ODk7npFc6Cq6LrQe3/RiB6ajh/KM/TW
	vtWdCAjts1k203X4oc0aki4ttk1THZcy+NLL2/pakBZIyk/k5t7aRBUxmy/hepy0elvYFtiS/3J
	j/jvc+rVoiAU/d1NTnkwJW8jo8DWJSGC2gV3AnmVG3vt9Xk8LTutQungkJ5Cd3BM+8A5GpfrRHo
	wEhL2P+Kpo2NMs61+umsp3w1mzKdTGOp+iPvxQUpQE2kZR5VN55jOyrfGh2CstZJoBpTARTjbYf
	eN1FuwDC2q/uPHppbLlUpCBCsVD31ayNcniv07j8v2uB00Eyf78yC7M5ySzJBRRhmpgRQyUGjuc
	TzWcOnejDZ3Jqrlb6NwAgDq960mCHXu6BsMJuyipeXEJMBlq7Kb1W3U6z4Vl2fTXdoJB+Ca613u
	/m94egLHUaXVca0iItDUvslUBPW6rxeaU8+fnSc64Ov36YhLI=
X-Received: by 2002:a05:600c:1395:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-4998797684cmr207086525e9.6.1786839232497;
        Sat, 15 Aug 2026 17:13:52 -0700 (PDT)
Received: from localhost ([2a00:1358:e0ce:6800::3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777d428sm104904495e9.0.2026.08.15.17.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:13:51 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
Date: Sun, 16 Aug 2026 03:13:45 +0300
Subject: [PATCH] wiphy: do not select FT AKMs if we are going to reject
 them later
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-brcmfmac-ft-v1-1-6a87b3453173@intelfx.name>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMzQpAQBSG4VvRWZsyoyS3IgszvsNRfppBSu7dY
 Pks3veiAC8IVCUXeRwSZJkjdJqQG9q5h5IumkxmiqzUhbLeTTy1TvGmtGGYjmFzMMVi9WA5v1v
 d/A67HeG2d0H3/QDajE4DbwAAAA==
X-Change-ID: 20260816-brcmfmac-ft-12fe2dfeb3ef
To: iwd@lists.linux.dev
Cc: Ivan Shapovalov <intelfx@intelfx.name>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4189; i=intelfx@intelfx.name;
 h=from:subject:message-id; bh=y1XkHJIfBOVGA+VVJe2COeQS/aJGYtVD+5KGI+pao+s=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdDVVdHM2x2aGVTbFF6Mk1wO
 VdTR0xJYUdmWVdUQTdNSzAwV2ZSbDcvbkhJdml2eHU2ZDdiSjNnCmR2REJTcjI4M2pzenBsejcx
 RkhLd2lER3hTQXJwc2l5Ky82MHNFZHpKeWdkOHR5UUN6T0hsUWxrQ0FNWHB3Qk0KUkdVanczLy8
 4cVJXNmNlUG1CWmMzMXQ5dlhySmR4ZUpueHpkWDgrZVY5NVc4T3ZFNG9XWEdmNnBQWG5rN2lPZA
 oyV0pzRzlHNVZ0VENtZTJheXpISDROb3JSbTgveVZ6NmY1d2RBQT09Cj0zdHN0Ci0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=intelfx@intelfx.name; a=openpgp;
 fpr=04DEA27EEF682F17083D892295D5D5F5A5A5E5E5

The condition for choosing a FT AKM for SAE does not match the condition
used further down the line to validate the permissibility of an FT AKM.

Make a minimal change to bring the two in line, just to prevent choosing
a FT AKM that we are going to reject anyway.

Tested on a BCM43455 (brcmfmac) device, firmware 7.45.265 (28bca26 CY),
where this change [among others] allows to associate with a network that
advertises WPA3-Personal+FT (w/o FT actually being used). Without this
change, the FT AKM is selected, subsequently triggering an assertion
and failing the association.

See: f5c5efa0 ("wiphy: allow FT AKM to be used if Auth/Assoc is not supported")
Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
Note that the resulting condition (which I wrote to mirror condition in
netdev_handshake_state_setup_connection_type()) differs from the similar
condition for WPA2-FT just below, which also checks for 4-way handshake
offload in the !softmac arm:

WPA3-FT: (IE_AKM_IS_FT() && (softmac || roam_offload))
WPA2-FT: (IE_AKM_IS_FT() && (softmac || (psk_offload && roam_offload))

I do not have enough knowledge to tell if this is an omission or a
deliberate asymmetry between WPA2 and WPA3 implementations.
---
 src/netdev.c |  7 +++++++
 src/wiphy.c  | 20 ++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..fdf3695f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4079,6 +4079,13 @@ static int netdev_handshake_state_setup_connection_type(
 	/*
 	 * Sanity check that any FT AKMs are set only on softmac or on
 	 * devices that support firmware roam
+	 *
+	 * XXX: is this the right condition?
+	 *      This can be reworded as `IE_AKM_IS_FT() && !(softmac || canroam)`,
+	 *      i.e. allow if `softmac OR support roam offload`. Should we also
+	 *      check for SAE offload in the second arm, i.e. allow if
+	 *      `softmac OR (support roam offload AND support SAE offload)`?
+	 *      See comment in wiphy.c:wiphy_select_akm().
 	 */
 	if (L_WARN_ON(IE_AKM_IS_FT(hs->akm_suite) && !softmac && !canroam))
 		return -ENOTSUP;
diff --git a/src/wiphy.c b/src/wiphy.c
index b6774f69..1e18685d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -288,6 +288,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 {
 	bool psk_offload = wiphy_has_ext_feature(wiphy,
 				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK);
+	bool softmac = wiphy_supports_cmds_auth_assoc(wiphy);
+	bool roam_offload = wiphy_supports_firmware_roam(wiphy);
 
 	/*
 	 * If FT is available, use FT authentication to keep the door open
@@ -339,8 +341,19 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 				goto wpa2_personal;
 			}
 
-			if (info->akm_suites &
-					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
+			/*
+			 * XXX: this replicates the condition in netdev.c:netdev_handshake_state_setup_connection_type():
+			 *      `IE_AKM_IS_FT() && !softmac && !canroam` -> ENOTSUP.
+			 *      Thus, unlike condition for WPA2-FT below, we do not check for psk_offload.
+			 *
+			 *      Should this instead be `softmac || (sae_offload && roam_offload)`?
+			 *
+			 *      Or, conservatively, just `softmac` (like FT check for 802.1x above)?
+			 *      FT check for WPA2 below was loosened to allow offload in
+			 *      f5c5efa ("wiphy: allow FT AKM to be used if Auth/Assoc is not supported").
+			 */
+			if ((info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) &&
+				(softmac || roam_offload))
 				return IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256;
 
 			if (info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256)
@@ -355,8 +368,7 @@ wpa2_personal:
 		 */
 		if ((info->akm_suites & IE_RSN_AKM_SUITE_FT_USING_PSK) &&
 					bss->rsne && bss->mde_present) {
-			if (wiphy->support_cmds_auth_assoc ||
-					(psk_offload && wiphy->support_fw_roam))
+			if (softmac || (psk_offload && roam_offload))
 				return IE_RSN_AKM_SUITE_FT_USING_PSK;
 		}
 

---
base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
change-id: 20260816-brcmfmac-ft-12fe2dfeb3ef

Best regards,
--  
Ivan Shapovalov <intelfx@intelfx.name>

