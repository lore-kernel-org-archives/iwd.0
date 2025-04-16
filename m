Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164E5258
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806862; cv=none; b=FoGay/CaehVwDNvnVedsgRFhluedJmRIoDa8HOiOYhh838nZBr+rEO3ptgZaukeff6onITi/nn+jMwqw5Dx7t2rus3ZocQotsdknZvVaBxB0eSkX5FEkq3xlMX/K7ByaPivpVS/yL8D7J44ujDEnoEjI/nIqEcnugKRY1qwX8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806862; c=relaxed/simple;
	bh=VnDh7mlZzCLMOr8e7zBmrpt9l6MXNJY4nZkKXCJYJmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InD45/UUIAWYezlCDunE0Gog2cMTsGfuX1hgBcxAuOZZxanQdA0maZnUGbbzLmjrsatZKfRy3OQdAJnzCfRsqCMOV4pMAwwd7Lb4ftY2ofpqMlo7CVp0IjooKNVp4+8Qsuu/GlvYGPOLW8o9J7uD7gb0nmOCRwXr+pbQ1eVEK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKMO4NxZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKMO4NxZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c1138ae5so6564686b3a.3
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806859; x=1745411659; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSDj/39tpbDor2l+nQ1XjcUis6ZoQLqS8VhJ+o14iBY=;
        b=RKMO4NxZgPy7YSZ3bkDzU71xdnLz6YPNcHkXk+UxFMPbtP9c1f5u7mIMtyT9gYo6mp
         de62N2AAv8uLV3hn3MC9iRZEDrfymyqRudz3zdy+MR2Ft1JBSRw6ot5PB6dZeHEhcLbP
         o5kdKH7C02F4MqY0A+Ywium+ndqXaKJ0Sgk0BnRn4uCEf/BlB8B9hR6vrQWvV0Oj+faz
         8Ol47JqHDkbaI8g1eP/vV3FYjCM2PIq3y6UtMwhCv55lRNoIH87Vnixs4B5TM2ru3R64
         GDYJHR+2YbWa4FRJ8Y/R+TgGwpcUsXnPYZ28TY0UGIhTqierGiaqUgWEqJjQ1GZqeOY1
         15Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806859; x=1745411659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSDj/39tpbDor2l+nQ1XjcUis6ZoQLqS8VhJ+o14iBY=;
        b=HeICwt/CAtxVUjgrBPJx5/hgp9HGFWIYLkpd2USVYWlyWVQl1xuUytAHjc9OJje1aa
         6KgEr6nDjhTEd69DIH4QjQLtagchtVNK27OfFHdOkRqiOD+mlxYlneKpe1sxr2MOEw0r
         vkwKW9YgAq25NsZTOpwxA4Lr+TqPni4U6OKGMrU2m60fKX5DWeHKdfyBfGOz0ZQTGvLP
         h6DssguMGVt+dPi7qDUxSJA6PHHNKVfsGq/IU8byHff4mW+oufNgYhnadWAhUlSvCAZh
         1lYqV+/FyfaKqXpsBpYHkjZPrFkiT9WjI4q5DycZnJ853EEZ24CQhbKIj2/jSvZWqLuD
         ZlsA==
X-Gm-Message-State: AOJu0YxPzmD5WmAqZrwwPayHhYml5QK3PpNDjVGkMDBqS0ez4R361w51
	fI2jiKbyqQLjXenuMEv8SJJvDZUBC6ALD4RKXr+Tj8FyYQA7yW7hl+xw4g==
X-Gm-Gg: ASbGncsuVJV6I1jY/Ac6AhNo+MfSgbcCwLsHB5BB3p0H8qDrTz2gaHoLX/mOZB5kDqc
	DKFcjNa/OMni3PL6FaT9yi9LzxiGT6roZchseoEcpVW2ToDioGJ8inIS1ztZtMr0j6PV83PMIkd
	xTDF0i91m1MYpcdiLr38ciVLvSnAER5JpBdgIaIl1DFc0O5YuhzBGR2vmbEW87S3a3ZVsz0bHIM
	cbXhe1mc8Twl1iCos+GoMm6/wysFbW6oOakayiXliolNcn22S1Bd8Cmk6CDetpgAW4lL+vYHki4
	uO+X7YxMt/GwYSLap+JmLlj7mjntvT4qQbMSscttKpKENUr9iABS283s4QFz66JLZXyrQJsTu73
	3d93wVuleWlciwjZpXMW190ABZYc=
X-Google-Smtp-Source: AGHT+IHqWfXLVS1Vnkgi/TXFkOFQtLNGW81oX9x9aYAsYhVFSpBvcKvz6tWNTdpk/Jw4stcp5ZkEJA==
X-Received: by 2002:a05:6a20:c6c1:b0:1f5:9098:e446 with SMTP id adf61e73a8af0-203b3e6abacmr2965447637.2.1744806859692;
        Wed, 16 Apr 2025 05:34:19 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] dpp-util: fail on duplicate values in URI
Date: Wed, 16 Apr 2025 05:34:08 -0700
Message-Id: <20250416123414.114231-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAC and version elements weren't super critical but the channel
and bootstrapping key elements would result in memory leaks if there
were duplicates.

This patch now will not allow duplicate elements in the URI.
---
 src/dpp-util.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cfdedbdd..1986a5cc 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -1166,21 +1166,34 @@ struct dpp_uri_info *dpp_parse_uri(const char *uri)
 
 		switch (*pos) {
 		case 'C':
+			if (L_WARN_ON(info->freqs))
+				goto free_info;
+
 			info->freqs = dpp_parse_class_and_channel(pos + 2, len);
 			if (!info->freqs)
 				goto free_info;
 			break;
 		case 'M':
+			if (L_WARN_ON(!l_memeqzero(info->mac,
+							sizeof(info->mac))))
+				goto free_info;
+
 			ret = dpp_parse_mac(pos + 2, len, info->mac);
 			if (ret < 0)
 				goto free_info;
 			break;
 		case 'V':
+			if (L_WARN_ON(info->version != 0))
+				goto free_info;
+
 			ret = dpp_parse_version(pos + 2, len, &info->version);
 			if (ret < 0)
 				goto free_info;
 			break;
 		case 'K':
+			if (L_WARN_ON(info->boot_public))
+				goto free_info;
+
 			info->boot_public = dpp_parse_key(pos + 2, len);
 			if (!info->boot_public)
 				goto free_info;
-- 
2.34.1

