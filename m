Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883017E447
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011880; cv=none; b=XXE9FaChemkZ40fsOCmDyGQcAxKZ4/PdE3vSIJILtZdYXiIDmgf4R3mWGYZszbpvBE+xrpWyplzeheKNWiB6xkxAqyZm/hcyaZ4kqm44dVBiADbjHH1BFj3vBc0gSOZX58NE1VM2Y5vE77VE5wpPaewmg60MsztZUy6ZE3+/0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011880; c=relaxed/simple;
	bh=Bje7IpN4RQsxkAYgKI8HY0lZdJMcf+8NhsJlKcPa6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkptCgQr3nSZbEvC9tKbyB4KxSI0WldY2nupORqaJEDtUoM+dcbvm06bjMKKDWl/mMLg3mQKDxty4ifH0m+xzncg2keO48eLnFnDMoiMFlCTVKsW5COFFzxWIGjxI/fvuu0wl7p4u7q5/OXZ4PZvbnErEa2T5S6PTVVoc2fDHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1KlyBB4; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1KlyBB4"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-704156d0e0dso763376a34.1
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011878; x=1722616678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnNGwxQsolwbKc9YoX7E5tOP7IITbKC2WKS9xrdWB6w=;
        b=G1KlyBB4nHg3aPqK7DKpSzbtlV+r+8I0fP1EfATfibXbZgW2p9IFZhAPDNU1o7V1pA
         CIIh5go8Fu22hIJgi1K+6NIYQO/qZfKiyZZlDggZ6l2GabOVuNmPNmWJyHIeVYdgOD7F
         TBw3FwydwZdZ5wMYVVlER15BBiyt53m5ntV6qmnNhxXKwmZ8ReBdt5zJ6M3S09EE/L2w
         sX/wj7dUQ6lqyPschcAlBri+pF9Ve2TVGzndi/cJt+SzDl5SjL6+HhK3OagDVbgYIJQQ
         wo9/zZkM5rByBXRHVR68odBnMuRwlPOJFvs9fw0xpUUegiwqPmYpcQG/aRA3+X8+t26i
         mg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011878; x=1722616678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnNGwxQsolwbKc9YoX7E5tOP7IITbKC2WKS9xrdWB6w=;
        b=HlcMExJtgyfWbVkovLsE7GCAskPfgKI+jKRp6X7GUFBztdxYGfU6JR69MVjwQp3hvr
         U/J/3e9GX9E+1FTPGIP+kJ4Gjgfs+OWZFqgE/wOzW2ZLQCEbhGnDutMTnnf+AFSK1pHN
         wKSMn62hBDslRDBYn2L7oym38Rpvp4XEKBHRwv0V5u4Sw27cajvWg+MP9So1HySxzlpU
         XmRoySgxLDryudSYFI5odJg0RzvL/hFmBwRhNqxvGNDyG0BN0j4Ln5x2npemZYn+vEGu
         CXX0RaD4RYHC627/m+9Y+Y/4PmNP/FaLQq+P7bTxFBCjIGPK+KH0jrzVTwDd86QXDeMa
         8mJg==
X-Gm-Message-State: AOJu0YwNx5j6JqQq3lcFCLWOuEFCWf2s+rHips2zxFd/sqqpXXh0RP5p
	e0iAOPedDI6SaJhIM3BD1q2NmueZRB7t86x1H7TyU2x3/B2BkY3oQ/puXA==
X-Google-Smtp-Source: AGHT+IGjK++yGKEBqjXnu5xp0cUz5TOP6CzZtOJ0g7eqgmrGFoQZY4s8ev+d4+q056Qn3yscup4r7Q==
X-Received: by 2002:a05:6830:2a04:b0:708:b2f3:5f11 with SMTP id 46e09a7af769-70940c6d80emr121374a34.27.1722011877794;
        Fri, 26 Jul 2024 09:37:57 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81463easm14841081cf.26.2024.07.26.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:37:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] wiphy: add flag for supporting remain on channel
Date: Fri, 26 Jul 2024 09:37:50 -0700
Message-Id: <20240726163752.1651669-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 9 +++++++++
 src/wiphy.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index fb36ebb2..ad9bf59b 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -149,6 +149,7 @@ struct wiphy {
 	bool self_managed : 1;
 	bool ap_probe_resp_offload : 1;
 	bool supports_uapsd : 1;
+	bool supports_cmd_offchannel : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -938,6 +939,11 @@ bool wiphy_supports_uapsd(const struct wiphy *wiphy)
 	return wiphy->supports_uapsd;
 }
 
+bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy)
+{
+	return wiphy->supports_cmd_offchannel;
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
@@ -1384,6 +1390,9 @@ static void parse_supported_commands(struct wiphy *wiphy,
 		case NL80211_CMD_ASSOCIATE:
 			assoc = true;
 			break;
+		case NL80211_CMD_REMAIN_ON_CHANNEL:
+			wiphy->supports_cmd_offchannel = true;
+			break;
 		}
 	}
 
diff --git a/src/wiphy.h b/src/wiphy.h
index bc82a007..17e53075 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -141,6 +141,7 @@ bool wiphy_get_rsnxe(const struct wiphy *wiphy, uint8_t *buf, size_t len);
 void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
 bool wiphy_supports_uapsd(const struct wiphy *wiphy);
+bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.1

