Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F1191F86
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931668; cv=none; b=lEzOriqD/vMQjVVnT1jmPmpkl7kL9R4qv5KnJXVbNY1UeP/JbKyqVOEAaF0tN1yLKdAxkZzyL+QzO8iM58SMpclP8OMELx/DVu6PrbU46M+kliL6QL1ieJhR9h26KM1g4t9lOo0BB0ClDRJJ5ciXq/H8muC7N964+tIKWzzOepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931668; c=relaxed/simple;
	bh=A9yY3+o6FFyKAlUQ0LAV9mLrk2JGbqeG5iTdK3MDjY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yehtc0Vh8fM5wxMKJectO6lGJspiD2NnXWTKcWKutgyvut0QmB8FY8obDUc4PN0pqJPxNSWXuFBATg03WafJJxYfO/8650ZGnD+/AWmCBf+oGccp+1C3q+4ya37xTjAtRK84L+ONRHGDSiNJ82fuyGMNrk9ZsYsL26H8zs/ZZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhyWPyIy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyWPyIy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201ee6b084bso4409025ad.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931666; x=1725536466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUQPqErKvzcKGx1kBxvI9e2IL6KbK8/k9dhcf8zHyrM=;
        b=lhyWPyIypj2w5hTc5Wzzdk3f2FC9BXG4INnboUEFjqYP1jTqPSMEksk68e6Gg28pYt
         8hd+bkNU5HqK1pnvoLtdVVTcZlnWM3yukOkP4htF9I6BmoZqL5sBtOTpOkwEZ8+YDjp6
         FvWKyCu6YfYDfp/sPLKJW5Cuk4XHzp4GObnr20pbyiktQUGbYTeXa1Rg6KKmXRmiTsp/
         sa6TRSPBgj2wb/W9RAT0WW/fTbPp6r2uS3BXgSRP/wEVdr2c0R92aPJbrhqJF69rMq7T
         /Zk9G3bmGXaKqR8OM5f71mjVWjeotdkugiS6XJrVCG1caqIw73PhhM6S1vy+0JhIYh2e
         LGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931666; x=1725536466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUQPqErKvzcKGx1kBxvI9e2IL6KbK8/k9dhcf8zHyrM=;
        b=q4lbW/zzI2ULI+HjT35Y15aDwrkfPVe3/FqDqRUnYeip+5is+Eqm7W9A6Go/ZMyiuy
         no2ydwVWSKQ6Tfsop52CWEPGwBZ/yK3+3zBvvgRxHFpBFSGg4tSygMh/lUhI7/wQz2D8
         M37HmVeCuuzOvUYKBdh2M+7sk7spkugQ/X4Jdh2BCHjMYdB5xYtVVMoby85w3H8uMpGj
         EcF4znJ4bI9BYpDONgBBZmB1hiiBBPlzVy+6MxSKS/wvEp70BhTyA/f12H6BGyF3dlc+
         pRt8r/Xv9zA7MQntynsGUbgHbY+gLA+OYsUyZCxkVJXUo1cuNufvagX+jspo6hgvqQal
         TFWA==
X-Gm-Message-State: AOJu0YysY3dwvlt3+u07dcyOT/3DbdY79YO1TxusUP3/wE1feFJVLNfY
	aLYKl1i2es3bpenvUHY+X8xxUdGGogGVfM8frfiZ0OdLULV9b30qA0Jpew==
X-Google-Smtp-Source: AGHT+IG1hl77OKTuK5CWYKbulzRpSG7TeXW3V2S4fZOEhZiAme9JX+SqRLjPbpm5uQkszhAVSQwDjQ==
X-Received: by 2002:a17:902:ecc5:b0:202:49ea:b6f4 with SMTP id d9443c01a7336-2050c3c8968mr28290755ad.37.1724931665602;
        Thu, 29 Aug 2024 04:41:05 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b37d5sm9699315ad.25.2024.08.29.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:41:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] wiphy: add flag for supporting remain on channel
Date: Thu, 29 Aug 2024 04:41:00 -0700
Message-Id: <20240829114102.56284-1-prestwoj@gmail.com>
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
index 13d498a5..cdaa89ad 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -149,6 +149,7 @@ struct wiphy {
 	bool self_managed : 1;
 	bool ap_probe_resp_offload : 1;
 	bool supports_uapsd : 1;
+	bool supports_cmd_offchannel : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -939,6 +940,11 @@ bool wiphy_supports_uapsd(const struct wiphy *wiphy)
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
@@ -1385,6 +1391,9 @@ static void parse_supported_commands(struct wiphy *wiphy,
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

