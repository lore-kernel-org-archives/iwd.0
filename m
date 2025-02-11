Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA0265626
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303943; cv=none; b=TcYu3KINW5v7BGq63ukBDeKSTMuwP17z7BysV9lgcoNHLj2CKQIpalCQG47FlA7m30al7K5+MwC6ZQUTYGLoe5zmGjtCE4+QyMepuKUsg5gxvyJvOwMLVBwDVmp0jWSTCp2jtReZrsP3zyynygjoqlVE0Q9fW/Aw8yzayeCdIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303943; c=relaxed/simple;
	bh=lGh0L1YMdGrtH/xyjZcTWb0vxSsHjJDlkmjnWzvUjQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suS1NjRdksB9ymCQ0oa4XOovP/lPSwjL4TfOfQnTyYPYGmE9aCR9P0BEB69ZtDvEN8c5VjtDiZ2q180DcTYK/keufRL3EoIMsPOs5Z5OTUcrXAdbRbSs9cJ+19wzSixg98/4RY8Y2mCY41BofnOh0D+5noDZic34TcVVsIl2pE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL4UodUI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL4UodUI"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e440e64249so66887026d6.3
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739303941; x=1739908741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5izq2huXCM+mQqALzawLxTNOVGttXRL9q+QlyIezRk=;
        b=fL4UodUIAPTS1Ew8gm6HD6S/MXUoP65t/wEjHJh/l6WYvX9uHi5GpGgw0EwBoG8Vqk
         faZ8Ps3ztQDwsmgZX8Eh5RBshH/JZrWnvtThcfGdMSwIxZPIUsvkjqfTkmOcEhImHxsJ
         8EnSFkeMcoFB9yYOjxUqPGtX1cJnpt/lbeUhMH7Ww3w7FNJ7JS1z4iLBmy94OjiArS/4
         DM8AeogHjb5E27ethjstc+eyleX7rOaKyb0roSk+eJE12IWHJfnmkqG2BqemIZ7sinfO
         GQteDWo4zIqwSc0eUaCWqCyf/63V+Pl1y64dP2pw36agiCQen8jomLK1Xb3AvtRtt+VT
         NwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303941; x=1739908741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5izq2huXCM+mQqALzawLxTNOVGttXRL9q+QlyIezRk=;
        b=kZG2yb5Lp/5xUhHjMpuvKrL+b2j5In6Li+N4oJlBb3UXgYKFmYUsiK5YbwOzH1CSBx
         nBPuOkh55iEZHGqyKHisVs/aOt+WCva8xAkR3oGkOaeKNt3zIp6P1DjcHO2S1Bf8j02l
         NJuoTL96dZrBpyNvTaSiS5owUNmdxKQPzVeKpF4x1yRaG8PWg0hUsXeozdFFZt8syMht
         F/V3Z7DKMBrBV3UjeswmiMBq8SP4HS36t6IHC8yYfylCirPSGXjJW8PWD3s5NpcIFsOn
         R/IBBQgpBo83dQj/JLS/dMh0+E0w2ig3O8bRMDnwdzSyiCI6yOuJcDDcz03m/fxh2QY1
         quEA==
X-Gm-Message-State: AOJu0YyDsEh9CirrFz1zupo1yJDvcV2N/vlvPIxKQgO4SuR5QMtbihkl
	FB5YVBlgxD/lJXFvwIkc1UBN49wC1PRzk6fHX0OqWYubgm+z731U7oEOmg==
X-Gm-Gg: ASbGncuBGzrAkNgWkejGjx/opAyd4o9sQjlzgNPQ1PEZTOQ8RCuq35jSMPBx/UPL3BA
	jWWdIKj9AdZoeo//bDeUkzDRv/zhVkNafzid0Ps4rdGS17BEsQG+XPiWj/ask3T0kkmN95sFTbF
	9L9eX/p4acGa7tvaEYXH5CMaFhIKEXg0DZJBtfNiLzOxtxKrXWWglBp53ppOUSletluSYR+q/pN
	Cuf5Y6kMLINTytE9zOFCa+CTE+MNcd1bEqPnW3tjEI9LSK17I95orZZwAumpCtqugvGT/pZPO6K
	xQtppS4yMGK5lEO5ZKdnrKcIeeXX99kno5joej4ITr9/RI0ROA==
X-Google-Smtp-Source: AGHT+IHt3ZY844cgpzXZkQDmMiD5WKpFR0HJBa7nNgKf0ORBHQk3boVnbhaw6wISb/iKj6qC7s5yqA==
X-Received: by 2002:ad4:5e88:0:b0:6e2:481c:3713 with SMTP id 6a1803df08f44-6e46edb5319mr11210156d6.37.1739303939461;
        Tue, 11 Feb 2025 11:58:59 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44df787e8sm49690426d6.113.2025.02.11.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:58:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wiphy: add driver quirk to disable SAE
Date: Tue, 11 Feb 2025 11:58:54 -0800
Message-Id: <20250211195855.85360-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SAE/WPA3 is completely broken on brcmfmac, at least without a custom
kernel patch which isn't included in many OS distributions. In order
to help with this add a driver quirk so devices with brcmfmac can
utilize WPA2 instead of WPA3 and at least connect to networks at
this capacity until the fix is more widely distributed.
---
 src/wiphy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index c7df648a..46f7a6d9 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -74,6 +74,7 @@ enum driver_flag {
 	POWER_SAVE_DISABLE = 0x4,
 	OWE_DISABLE = 0x8,
 	MULTICAST_RX_DISABLE = 0x10,
+	SAE_DISABLE = 0x20,
 };
 
 struct driver_flag_name {
@@ -106,7 +107,8 @@ static const struct driver_flag_name driver_flag_names[] = {
 	{ "ForcePae",           FORCE_PAE },
 	{ "PowerSaveDisable",   POWER_SAVE_DISABLE },
 	{ "OweDisable",         OWE_DISABLE },
-	{ "MulticastRxDisable", MULTICAST_RX_DISABLE }
+	{ "MulticastRxDisable", MULTICAST_RX_DISABLE },
+	{ "SaeDisable",         SAE_DISABLE },
 };
 
 struct wiphy {
@@ -202,6 +204,9 @@ uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask)
 
 static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 {
+	if (wiphy->driver_flags & SAE_DISABLE)
+		return false;
+
 	/*
 	 * WPA3 Specification version 3, Section 2.2:
 	 * A STA shall not enable WEP and TKIP
@@ -1368,6 +1373,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
 			flags = l_strv_append(flags, "MulticastRxDisable");
 
+		if (wiphy->driver_flags & SAE_DISABLE)
+			flags = l_strv_append(flags, "SaeDisable");
+
 		joined = l_strjoinv(flags, ' ');
 
 		l_info("\tDriver Flags: %s", joined);
-- 
2.34.1

