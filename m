Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BE125DC
	for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKtfR33u"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ab9f1efecfso127956241.3
        for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698273749; x=1698878549; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANYVaPzk+EaGRjFDDoQTdDNi4LMpw0noRtC5P/qdbOk=;
        b=gKtfR33ugwwzMB6cnH1kj2LDqLGFLMVJFKosPu5gjpmo1U/1Nh4WeCPeHQVJunPMM0
         z8pF3wZokqKU5qpIPVturrNdjpnPyHfIvM3A2nBlyjuqYNOOwshMipy+lT1hYiv2Zn9t
         QBPkZyZXIn705KJyijtXeDKOQ2/qJ5yrHi9esK3GjmlPo9AiqQp29w93YQohLjlmmYZI
         LEtK5L+4LOUSXTZJ/EaGBKi/c6YifE9KUhAId6lEA9joJdTsxE+f0Sjq7DQEiDE5MTB8
         doFHj2yuJ44MITsklEHEWHspIO/7XqwyY/MRWgl76d3LaYlF8MYFdNUgrs6su0a+z8IT
         9VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698273749; x=1698878549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANYVaPzk+EaGRjFDDoQTdDNi4LMpw0noRtC5P/qdbOk=;
        b=b5dAhcc+h/8ql4OypPkPjF/BsWsWkoIT0RFjFw017nS/7T79P4pQBSov9UKXQlnwZu
         MAVDQnOFDtM11Yzo8ZLrc5vJaEOdd96At9qpUNDfJRFRMp/5ShrnTy+dATTSGqWYmCVG
         +7h163Sm31pxhr5cE7qZhjXRlXyBOVLqgfYY+pafz6KHce3YWhh9rKA1rqHLXZ9WkY71
         Zgt2gFQCMt5YCyInVNXNBDBOviraIMnBP2MV7Kk29onMicAPlV0lzhHumiKoQGWBcf/0
         Mqi/GUzA2UyGVV6ZVqp7IIGtzCYY6vyBN4O6xK4VHQmfbjZk/etin5AfIg3chpjtjWM7
         H3yA==
X-Gm-Message-State: AOJu0Yw31/rhQSLtjdTxUP/LNis6djaNMJFzdCcvpgAtW/YADOhCZycu
	IRYv22N07nFrazChJDQ3051ucgbfGeY=
X-Google-Smtp-Source: AGHT+IF+JiTsuP1uXuuGYh2/5ShHesIeKWWlCG+Iyar8AwjW2qQQC7uF4HWtDGM9QEdOxDllKulXow==
X-Received: by 2002:a67:ae45:0:b0:457:e828:3747 with SMTP id u5-20020a67ae45000000b00457e8283747mr17003740vsh.5.1698273749401;
        Wed, 25 Oct 2023 15:42:29 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a056214184400b0064f53943626sm4755788qvy.89.2023.10.25.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:42:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] unit: correct memcpy overrun in test-dpp
Date: Wed, 25 Oct 2023 15:42:24 -0700
Message-Id: <20231025224224.321013-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memcpy in HEX2BUF was copying the length of the buffer that was
passed in, not the actual length of the converted hexstring. This
test was segfaulting in the Alpine CI which uses clang/musl.
---
 unit/test-dpp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index c782efba..c3f3731f 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -183,8 +183,9 @@ const char *r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c5
 			"4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f";
 
 #define HEX2BUF(s, buf, _len) { \
-	unsigned char *_tmp = l_util_from_hexstring(s, NULL); \
-	memcpy(buf, _tmp, _len); \
+	size_t _len_out; \
+	unsigned char *_tmp = l_util_from_hexstring(s, &_len_out); \
+	memcpy(buf, _tmp, _len_out); \
 	l_free(_tmp); \
 }
 
-- 
2.25.1

