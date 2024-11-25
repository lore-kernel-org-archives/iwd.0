Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98001B21B9
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547190; cv=none; b=bWtRuNtmB1BwTXAhDJCpnRgJf5hfx6yqPSxanc/FddW4usSfsX8yzGbcUgYAYTXizjgp0mhzpPOtwJdgqCHTbc38ovxJ7WqJ9oC5JQvLAxSqbyIA7gLUvtdq/JoSnZBP0HTU4YxyDekXN+xlgFJOdNluWH70/uilIesn6q+Nns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547190; c=relaxed/simple;
	bh=7s+XATaIEVLw+ymNkMgSPKBP1tauyA/J56rEO8p91lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/sJb4+0vnOumSU0sdTidyZVkZL33QyPwcAcaBGAJZwQkYbyy7I8TpdmXzqmWeM9zOIuQyrQD/C4AQy+HBHCyl8zG7m8/UHIaaev3F3Rgm02SdAz8u2yXFuhZpYSAHZJZI3ltvyyfbb2qc38MEP/ooCcW6PQpKXCnEht3pvSN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8j2ilyu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8j2ilyu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d43e034ef9so36839916d6.2
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547187; x=1733151987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV7e7R+xSr/iiXsr//cmCuDI/RQs/rnSm1Zw9/U1bi4=;
        b=N8j2ilyukdfTaIxbEV/uTAmeuCTuPtNrnpTovkbzWZEUZNiptPLzmLNRohOVSkTgBU
         0N8zWqQwiF+VkcYbqhC35DeNoqUu/WdRA+Zxxr9+9/1Xp+Xmjhu8+wSv/hInhqsAgEar
         US9G6ez9zmweD79a94f7wzk385c8PEIBmF/tpoD25eexDG/IDD4YRSeefFfc/RzGHS9I
         Uar9ax3LjFVmKOb6WUF0lO5RMM8JtrZu+qfn8uLmqlqvLdhfPqSv3HOPKxPHWLvN9o4k
         NXa8rwODAY+Z0vx6p3RTuqG4wB6lUr7Lxz6ffUYY6Cx/l/xQlaDDFhzWbkOWp1/efWdV
         cT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547187; x=1733151987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV7e7R+xSr/iiXsr//cmCuDI/RQs/rnSm1Zw9/U1bi4=;
        b=Br6c7OT0z4BCknNnL++GeH7roNdbhGP2XuSWer9LbfG/pxWPAZdI2dKABJ6IRcGyqE
         1il3yY2jczxoe+FIXKBRK81+qjj3PITOp7P44wN1Nb2YgS320M9bVxaaM1Ll3HA4ryRM
         vjN9mrzXOR6G5kfjuIAAFql6ZQ178folKhCUSXGNDSixdsOnKGplpsvRbVrHmrukun0Y
         9aFmOI+mgAxkYSmhRxs+ptP7EtzRujpFC7nWH2holirWh+uYtzozFbI2D/QhH/gN8O+M
         roDB54I2+/1N/OBcVEWvpcCNzSuVTfxPm2eojIBv7AVAyO8QqF9KG3btHz4Jq+EPJpNG
         upRw==
X-Gm-Message-State: AOJu0YwUZ7o8FSf1FpAWM/XaeLQ07RZDm56lWsTktI79H03VSbc0tLMt
	HBSdvDG3lHnLd6pp7HtRJjBPFvlkWKzVf8Xla5XG0jQvyCfR+VTUt5rdxQ==
X-Gm-Gg: ASbGncu+834+UbAkXQnZH/bG5uusTtZ6BnVOy4zFmxoFgfCVQ3p5wVbIbBhqHeXJg7d
	f1ZlebgkTsykIGEETozW8XNzzLT5TQLccPBJWugXEeNkExE34HCvP9SxuLClqn4h7IS5HxTQ0Tp
	Ov2xv9kvXLNJTGTND89FYs/fdmA45I3lle34fdXXGA4rBBBg3PqCRy3wBLIASQT+M/faCeDH38e
	4iXrnoI8JXf39TAUcX0tFkDKC9aoyGbcXm2ihsjCEmQGacFCu3AjDJ/oh4Q
X-Google-Smtp-Source: AGHT+IGsJWK1v625MRSgXfLu6nSPtp5iCyMyx9s27l9xHvlwWP09rsO9BPTTQBowcC/jcMXJK0PMFg==
X-Received: by 2002:a05:6214:248f:b0:6d4:1f86:b1e2 with SMTP id 6a1803df08f44-6d450e69972mr240886256d6.10.1732547187127;
        Mon, 25 Nov 2024 07:06:27 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab5cc3sm43569136d6.66.2024.11.25.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:06:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] wiphy: make "wiphy" const in wiphy_has_ext_feature
Date: Mon, 25 Nov 2024 07:06:20 -0800
Message-Id: <20241125150623.1014890-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 2 +-
 src/wiphy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index c286bb48..ecc345e9 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -643,7 +643,7 @@ bool wiphy_rrm_capable(struct wiphy *wiphy)
 	return false;
 }
 
-bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature)
+bool wiphy_has_ext_feature(const struct wiphy *wiphy, uint32_t feature)
 {
 	return feature < sizeof(wiphy->ext_features) * 8 &&
 		test_bit(wiphy->ext_features, feature);
diff --git a/src/wiphy.h b/src/wiphy.h
index 43e4aeb3..c527c79d 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -119,7 +119,7 @@ bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_supports_ext_key_id(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
-bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
+bool wiphy_has_ext_feature(const struct wiphy *wiphy, uint32_t feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
 uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy);
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
-- 
2.34.1

