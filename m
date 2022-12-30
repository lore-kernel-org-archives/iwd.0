Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAD7E
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 00:24:33 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id e21so4014039pfl.1
        for <iwd@lists.linux.dev>; Thu, 29 Dec 2022 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMOoq0teLswXIcbvc/quH/LGyYm6c+Y4B1pprfpIns4=;
        b=GCpsEaifaeuRF5hp++R9BhmV+x+QAwhd7rWTYHcoR2PdT+EdQ8gawBbdL5TvKkLb/z
         JQM7KzXR3wzLnpKbmY8bHG3CcRMjQgf5hAY7P8sDw6RxhjaifiMo7pEp/wwMbuqKsiVn
         9y5PmAmsjZU2CLSXm57R1QrgweyFjVtZ3ZFLocnoijyI59zf6cnolVu/kTDwseqGcUYA
         2CM1d96qT+DaDmD3pfuk+JXOZhX7w/dg7eYwj9FnzalFUQi0bMQYa68gf1bSY37DJDE4
         AR40AGGLk6L2UEf4sOqE385EAXFBJ//TR84Zq4/RFtY8cjPNkr91V7ZT/0E130h+aQd0
         i/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMOoq0teLswXIcbvc/quH/LGyYm6c+Y4B1pprfpIns4=;
        b=dIuexEPsyPHqEatld8TPQAd92Q+hrduPR4OZFu6y9Fvi+Lj2/6Y/MFSZ0bzZ40QYOS
         +1B1aNdYRW2j9DYOpHTG9C8qI/CrKMQHHaTJhW1/wnZDF/kmPBH1Mcr4YJol9rz0Qd0N
         ad7Pj99skbqXQ9YEkbJ2Zv6h+TZacnGcCyU+/S28GXbapWzf0L1Cg6MchpX0Xfx0R1fq
         G/yQLD5s3bM2ulJUxGC3A6wFtw3e+e/K6QXW61oInKMZLIiHt9rq5RhAYVsrteczQFHR
         6VV9YqisBquBAcubdLpkzmxjfeApXnr0pkCrGK1dbag2gwi1ayeahAbOQPUJgMkOQnv7
         FpPw==
X-Gm-Message-State: AFqh2kqN0IDwcnxo8EEqLUFNCHk20q5J4FMOyzuAaI7ZHA3XID/NP12a
	0qJKNSVy1m52+R419Tod+ZzwW0Yf1pI=
X-Google-Smtp-Source: AMrXdXt7bOGhlCiGxVcj9ERMh/TY1m/wm2B0vPYY365s33jqdttrUZtTAlXVgCWTAc1lWGwf1XTEwQ==
X-Received: by 2002:a62:ab19:0:b0:578:144f:ad59 with SMTP id p25-20020a62ab19000000b00578144fad59mr32805093pff.9.1672359872711;
        Thu, 29 Dec 2022 16:24:32 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79726000000b0057681626495sm13018325pfg.141.2022.12.29.16.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:24:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] monitor: fix buffer overrun parsing country IE
Date: Thu, 29 Dec 2022 16:24:25 -0800
Message-Id: <20221230002428.2870506-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The country IE can sometimes have a zero pad byte at the end for
alignment. This was not being checked for which caused the loop
to go past the end of the IE and print an entry for channel 0
(the pad byte) plus some garbage data.

Fix this by checking for the pad byte explicitly which skips the
print and terminates the loop.
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 9694cfd1..652dea96 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -494,7 +494,7 @@ static void print_ie_country(unsigned int level, const char *label,
 			if (code[i + 2] < 32)
 				print_attr(level + 1, "%27c (air propagation "
 					"time %2d µs)", ' ', 3 * code[i + 2]);
-		} else {
+		} else if (code[i] != 0) {
 			print_attr(level + 1, "First channel %3d number of "
 				"channels %2d max tx power %2d dBm",
 				code[i], code[i + 1], code[i + 2]);
-- 
2.34.3

