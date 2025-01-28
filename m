Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566801B4248
	for <iwd@lists.linux.dev>; Tue, 28 Jan 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087484; cv=none; b=VxGCcHx/BqAtv4Uq4fj1gB9hQ3OCjGs2vi0/CNwLibT6uKwvs4Gj23HEguoe28+v9E4KGAXq17NxLR3zqGTFViBz5UiQsc4lAxnXTLFuBvtNCeW8KTXYIgZUs3BWZot8NeyZ75/lc2YI73PaK8pWaKzfttAaOLL+LlaMoBcpYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087484; c=relaxed/simple;
	bh=jTFAw7pxpALJLwsy1fuz3aDufCzZOPRtxgABH7mhVyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJv3W4Xt68t7Rrqdp1vvgJZl10/CVBONii3rntftv6loJTABrAlPs3EjB7TO1nBO0FvfEhATYY/jnopWuMAi8gEZ3BtX0hFTAZVpOSrF9t9u4s0vkYIO58/K5DYOsd0st0sxy069VIk5hBUTPoUlqHjK7x/N7sG3RTOUjBOWGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I89hXd52; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I89hXd52"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so10230747a91.2
        for <iwd@lists.linux.dev>; Tue, 28 Jan 2025 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738087481; x=1738692281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHFHl2NpHUx7c5ppbJjZ/IWSP1CwdKQlZrbC3J7Z7qM=;
        b=I89hXd52i1VajvB8dDosU1NuYepSRDEV4riWAvC8YFjMHZmjYrZELdliUFP1DI1z6B
         wZUZZwQggc+CDplUb6ivYX1upQiH83E9i0neOWChCJr4rLuyohLWDM86MFy6VpnyhKRt
         85GLLVCglGyYwy15+7Zq89mZVS4g3pFsRRBB3MecVSL8lkkMLyNCXiwkCcEuHE1KJJvH
         MBc5S9e4XakSTIZ6JvhaikAYIKCKOhN02jMsw/6awWn+Q2KR5M/RWf5od1h9NsKxMAEi
         Wm5SZ+jU7ifV4saLVz/8GYjB1V5Tu5+jsDHZtUd20O8fe2A3onUWBqYh+vAG8c1meKpz
         Ggzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738087481; x=1738692281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHFHl2NpHUx7c5ppbJjZ/IWSP1CwdKQlZrbC3J7Z7qM=;
        b=PnHspXS6T3MmjsC/vyUYini8Kqk8bQdgq1kU6hU3MrZ5NiV4sY+eGxY7Xsihw4fHXV
         +RDiR+jSDPk845g961BetpBIew4Pq+GPTJY0TvFiCkmvxyBofQVYVYmlKkKpKHPT4C8o
         JhJZMQhwHF9n2P+inUBH9g5x9rFDsLRcfhjY5zGPEa8LvB+Wa4uvgDU6RSYMJCHZiHlb
         HQJoBfpzHwW8OawqHB/9tLVZuKqRVIQXpWurp21APXY9rM7l+XAPOHdSzUqs8Mod3FHE
         q3NjpE9gXh3xsb15CDpCaA66GbR8MniIy9wopWhpUO4Fc6goHfCu/tTWBWZNVy0uLpvp
         zs6w==
X-Gm-Message-State: AOJu0YyS2wx5jfJIP8D3e4pSZRA2/aqXj+k6eWmyYddeuT/0YMBNTC/2
	+rCQaaalYLYHwnB70HoCzzAvuDMEgAsEkRhEISQ5rbvxHAtri+GqL6Zv3w==
X-Gm-Gg: ASbGnct/ToR+6FH1Bcn2k537V9+9gbAGzInoT05w+555zyUucSjn+endBnScTqiAM+q
	R4r6Q39IuoZXyqVPK74U+aDVOoGuvr1NAZRHAdRJ2/3iWVINppnBUFEPe2lMGUYKKocz+umonrF
	jgNrEh3u2Tkmnny1dUmXnx2NFw7jkb/GxGU+j4V3hucxYlu/PzXfOmdIgu25eCh2k3C3D5WO/vq
	trcOo8caN0wUeN5De429qsz2Klxv/vDQ5SutpigGOi9DqH0XtqX23QVXspdt996v5o9m9HlazkP
	94leNsOPh/LwWW8lrLdceLask8tBX+kB+ACYHEiGrEOuSEmltqhd6hymkVjn4u6uOtyii7M7Ee3
	01A==
X-Google-Smtp-Source: AGHT+IHnG9B7WnLAvugJ0nKdOd4IoFgWmbT9esTySQw0yr+3uIIR9eEZxomJVDeiDsT3Xd/64CCD5w==
X-Received: by 2002:a05:6a00:2302:b0:72a:bc6a:3a85 with SMTP id d2e1a72fcca58-72fd0c72bbbmr110162b3a.22.1738087481126;
        Tue, 28 Jan 2025 10:04:41 -0800 (PST)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c969sm9499289b3a.150.2025.01.28.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 10:04:40 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] netdev: avoid PMKSA for fullmac drivers
Date: Tue, 28 Jan 2025 10:04:38 -0800
Message-Id: <20250128180438.65113-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fullmac drivers need additional support to correctly work with
PMKSA. This can be disabled via main.conf, but to avoid extra user
configuration avoid the use of PMKSA for fullmac drivers
automatically.
---
 src/netdev.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2a6d94fc..7af3c39a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1518,7 +1518,8 @@ static void try_handshake_complete(struct netdev_handshake_state *nhs)
 
 		l_debug("Invoking handshake_event()");
 
-		handshake_state_cache_pmksa(&nhs->super);
+		if (nhs->type != CONNECTION_TYPE_FULLMAC)
+			handshake_state_cache_pmksa(&nhs->super);
 
 		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
 			return;
@@ -2455,6 +2456,19 @@ static void netdev_driver_connected(struct netdev *netdev)
 		eapol_register(netdev->sm);
 }
 
+static bool netdev_handshake_can_use_pmksa(struct netdev_handshake_state *nhs)
+{
+	/*
+	 * Do not use PMKSA if this is a fullmac driver as they need additional
+	 * support (SET_PMKSA) in order to function properly. Until this support
+	 * is added fullmac drivers will not utilize PMKSA.
+	 */
+	if (nhs->type == CONNECTION_TYPE_FULLMAC)
+		return false;
+
+	return nhs->super.have_pmksa;
+}
+
 static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 						struct handshake_state *hs,
 						const uint8_t *prev_bssid)
@@ -2473,7 +2487,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	 *       0 (open) for FT Initial Mobility Domain Association over
 	 *         PMKSA caching
 	 */
-	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
+	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) &&
+					!netdev_handshake_can_use_pmksa(nhs) ?
 					NL80211_AUTHTYPE_SAE :
 					NL80211_AUTHTYPE_OPEN_SYSTEM;
 	enum mpdu_management_subtype subtype = prev_bssid ?
@@ -4053,7 +4068,8 @@ static void netdev_connect_common(struct netdev *netdev,
 	 * If SAE, and we have a valid PMKSA cache we can skip the entire SAE
 	 * protocol and authenticate using the cached keys.
 	 */
-	if (IE_AKM_IS_SAE(hs->akm_suite) && hs->have_pmksa) {
+	if (IE_AKM_IS_SAE(hs->akm_suite) &&
+					netdev_handshake_can_use_pmksa(nhs)) {
 		l_debug("Skipping SAE by using PMKSA cache");
 		goto build_cmd_connect;
 	}
-- 
2.34.1

