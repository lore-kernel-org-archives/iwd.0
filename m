Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F17E
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:03 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so39030pjc.3
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZNJqVzNqIeHRpSHGVfGGecu6wCe6Sy58TzyuQNckpk=;
        b=IaIPFNGrYXKYMB2k/YVwQ85R3DJSRrz1tQljzVju4yNhk9eYeUyPpCtcLaAyUUfgVs
         sGvlTG7VVlx8v7NZGltPq00UnwltLnrpJp4cnQgV7GXrvB8HFTlbu1PtCuH/Fbk+rBce
         QynLxVsXLGWbrPI17QehOxoRJ95+lDWT30WH/aVePRkB4E1rFX5KhhZjS9SkNCzF6tgq
         pXsXw9lZoZkT8i1kJ4mpuqUAqrUMVgTNU2maRUyy18V+H2Z70wemZXZha7UfkpAZd59G
         zu2hwdGQkQwgqUXpmBP7OG0DSEUzQZONL/SxNtmQ9mVFETujYjKmgsqUMrLis3oBLVLk
         Fx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZNJqVzNqIeHRpSHGVfGGecu6wCe6Sy58TzyuQNckpk=;
        b=5bHM3/J5u2hesanp4a0CXsPLjTUurmbT6RJc7pPqvcCJlU9iHk9kKyDaeax31xyOU0
         bDgff9igfSK0Mhnuw0qgIgd9OsP3SkplTcZZBaP3atKdkt4EWXI9LmIneAJg7fPnbArr
         BBXtE9X/55i49n4N5CWFCF6nxjvY6dSb/b5NJ4gWMkhQmBUN3NdUd/agFFXH83qW2KdR
         RjkBcQhQCl5YTnrdNUgXmAIRJkBXGZTaOAcL2OmqHZ6Q2ReysrQnfCOvqAhvM5Xwn9bo
         V+nK0PEZky/Yos0KgcyH/2p8rKADgBUaOl9iwPzeip/A4m00RO8hMkOovtgp0rUNl348
         s6+A==
X-Gm-Message-State: ACrzQf18mkGzujkM0bPF2ORVLz69MwQDflvbyp9xDexjSVd94/oadXBc
	HiZqRfi2jJ4Fyc0N2EJsuuqqJUe3mlE=
X-Google-Smtp-Source: AMsMyM5DyhwflzaR/I5rB7Ga5Ysao85XP5VCWlSmJ2WznOebW7qUmeEuahdaUj0H7syJgOHyMiykFg==
X-Received: by 2002:a17:903:50b:b0:187:11e:5f1f with SMTP id jn11-20020a170903050b00b00187011e5f1fmr21533143plb.41.1667333882647;
        Tue, 01 Nov 2022 13:18:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/17] netdev: add more info to key setting debug messages
Date: Tue,  1 Nov 2022 13:17:43 -0700
Message-Id: <20221101201747.143379-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify that the ifindex is being printed and print the key ID
as well.
---
 src/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 22288c67..59e73608 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1635,7 +1635,7 @@ static void netdev_set_gtk(struct handshake_state *hs, uint16_t key_index,
 
 	nhs->gtk_installed = false;
 
-	l_debug("%d", netdev->index);
+	l_debug("ifindex=%d key_idx=%u", netdev->index, key_index);
 
 	if (crypto_cipher_key_len(cipher) != gtk_len) {
 		l_error("Unexpected key length: %d", gtk_len);
@@ -1680,7 +1680,7 @@ static void netdev_set_igtk(struct handshake_state *hs, uint16_t key_index,
 
 	nhs->igtk_installed = false;
 
-	l_debug("%d", netdev->index);
+	l_debug("ifindex=%d key_idx=%u", netdev->index, key_index);
 
 	if (crypto_cipher_key_len(cipher) != igtk_len) {
 		l_error("Unexpected key length: %d", igtk_len);
@@ -2054,7 +2054,7 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
 		return;
 	}
 
-	l_debug("%d", netdev->index);
+	l_debug("ifindex=%d key_idx=%u", netdev->index, key_index);
 
 	err = -ENOENT;
 	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
-- 
2.34.3

