Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640973D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:33 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso2357511oth.13
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBgi0EuoCm94wUm1zu6bmgYFnP7whyJrGGyjSUM8hyo=;
        b=Or7YksSQNQXIRfyQHd4CJvTZZMPb77BUGUqXi5gTgi6Qyk/RiRLeogvplTqqp4436w
         jU8K1hYLb/gIAHji0B3YR33VMfDBgSlTc01+LusLfq/kWlfR2btNPX+V1dZj1s7Rs1Yk
         WgIzMC2fau2lhDOXx0yzgB9mN9OSKNUCbOmfjLq9azQGDohMtyodg4/yKkkXmHlOpgaK
         gEj0ycBFBIMCUggnMzzypsXBzNdBCbOnjGtk0Nzb/2bI9h44mzrd5Ny6I3HFBL1z6Bi2
         p0az95w91KrGHxyveaBi3lB8xboc5bt+wfF+kP6jO0Cyo6XWYiklHLu81EAfN/a3TdS5
         5B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBgi0EuoCm94wUm1zu6bmgYFnP7whyJrGGyjSUM8hyo=;
        b=xT4j9Zswr5IYflEMlPOMnNHcoU4/RMRLcm6A8dEKjwC9HL9n8sI8GdQ8BUsDsiGNyi
         Xq0JCm0C0HCf8dOEu0S99NwITAKWfirIEzenC0GmTbr/yd3ahGstBwht6Nzeg+H+S6TT
         wqpGoE2/QZ+UCCVek4ht/ubJvletbARJR70cmZiGEunAXgLy2TGNDF/qjm8tKjWEfyPK
         pjczBdfJGYYKfeHuZwZJA424T4I+4HjBVSMe5MTvATUR+L9xoOTCqqVSK1pgXir94Qyw
         EuSC6o+Mn0JoYWa7k3zx6xZuSAY3KlFW5TMK/Ya8nzUqWOEy6uVd8uCgfl1yYWcpyZC9
         p7xA==
X-Gm-Message-State: ACrzQf0k1kx4xe9ZyUFoeIhZcrnlevUMzOrH/CNTMfunTga4I+nxXIdU
	y0m9cpsXcfrZWoBrEklSzwb7HSyrI1E=
X-Google-Smtp-Source: AMsMyM4arM9ng3ylC6b+zlygaaCH2O0STRs4sG4QdH8jmEP/fEOVQkKojITZpXNb40Hz02SkaVi6Vw==
X-Received: by 2002:a9d:322:0:b0:661:b793:6fb1 with SMTP id 31-20020a9d0322000000b00661b7936fb1mr10680560otv.14.1666379611731;
        Fri, 21 Oct 2022 12:13:31 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:31 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/26] ie: Simplify implementation
Date: Fri, 21 Oct 2022 14:12:45 -0500
Message-Id: <20221021191307.31492-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of copy-pasting the same basic operation (memcpy & assignment),
use a goto and a common path instead.  This should also make it easier
for the compiler to optimize this function.
---
 src/ie.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 7159222a4f6c..8ceefc643615 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -885,38 +885,37 @@ int ie_parse_osen_from_data(const uint8_t *data, size_t len,
 static bool ie_build_cipher_suite(uint8_t *data, const uint8_t *oui,
 					const enum ie_rsn_cipher_suite suite)
 {
+	uint8_t selector;
+
 	switch (suite) {
 	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
-		memcpy(data, oui, 3);
-		data[3] = 0;
-		return true;
+		selector = 0;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_WEP40:
-		memcpy(data, oui, 3);
-		data[3] = 1;
-		return true;
+		selector = 1;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_TKIP:
-		memcpy(data, oui, 3);
-		data[3] = 2;
-		return true;
+		selector = 2;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_CCMP:
-		memcpy(data, oui, 3);
-		data[3] = 4;
-		return true;
+		selector = 4;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_WEP104:
-		memcpy(data, oui, 3);
-		data[3] = 5;
-		return true;
+		selector = 5;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
-		memcpy(data, oui, 3);
-		data[3] = 6;
-		return true;
+		selector = 6;
+		goto done;
 	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
-		memcpy(data, oui, 3);
-		data[3] = 7;
-		return true;
+		selector = 7;
+		goto done;
 	}
 
 	return false;
+done:
+	memcpy(data, oui, 3);
+	data[3] = selector;
+	return true;
 }
 
 #define RETURN_AKM(data, oui, id)		\
-- 
2.35.1

