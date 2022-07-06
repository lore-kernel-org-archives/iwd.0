Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B426646
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:38 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g4so15183936pgc.1
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=EDFwL54sUMDtcd0oN1OZugemeuPZfiiqVmfEJLbLG0Muy46Ttn7Knz14HnxFJtnLvX
         lufcy0ufcLfSmxLNmg7sfbzvd8G9IJC/blWUfyZ1gFcbPeUdbuZn5+1iojukMCEStwAD
         UK7ETwnF/KDdNi3EmQAZwIb/W+O0oL+FsWul+ZrjKrEoahEcU6ZPNBghVx0wJi11FSk9
         pfDpXG2KUPNYHdKX2SDn5kAnLji5OqoesCULNlFTkgQephCREXdro7azAnz9AlyKqYRI
         5dhIppX0a8dFmR7yNPM0u2dS+pxrz/l759wRA0PGKNjEtr+vU+lMkbMcy8CxxLDInoLw
         1xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBza7GTBinUd6pDhR8LmGnIFuQRHAGBueMNiYVmpyNY=;
        b=VfKqPjCRTcbwv/M30hkTKvDn9vUo12AKMtYfJO/+PU0sy85DoiuSIA2NuNhxbndUmg
         WbIB5HnLpd7JkAaaYUuoFum92SD8DAUq/8u7MHhUwbxLEOxULg2lMPTJoeibf3H1UMPL
         vV5ZZn2PlIS/9tnz3lTT/fUbD3cfdf26qjtG0C/rhKlSxQhiIN7JS2K8al+wAi6b41vV
         qipfueNeqGjIO0hNa+ZE43VtmiG95zbWjT6yKUxSdVuO2Vs87Pd5Q6IIyUv92zZJlHvm
         3kHDl/Sfpk24ovrT7ZJSzQ20FLXbLh4JLztzzWMX5tCgYmnWQMGsFfiBaQg2DS+tui2f
         qCUg==
X-Gm-Message-State: AJIora9CZPp957SQgM9P7aXOalZEl1HO6cZXMlpv94ef0BfaM9mhQEWh
	6ekMBjKvXWKqQk0bOfHQBrDfM3HUmys=
X-Google-Smtp-Source: AGRyM1u+eAY4f54FINz/Ah1hoUAqHdk7KEAme2r9W7hYF9Fg8YOXHvqNf8e7H43kGvSU9tIp+tvyzg==
X-Received: by 2002:a63:88c3:0:b0:40d:5f26:bfa8 with SMTP id l186-20020a6388c3000000b0040d5f26bfa8mr36125859pgd.608.1657146098332;
        Wed, 06 Jul 2022 15:21:38 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 14/14] client: update ad-hoc table header
Date: Wed,  6 Jul 2022 15:19:07 -0700
Message-Id: <20220706221907.126408-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706221907.126408-1-prestwoj@gmail.com>
References: <20220706221907.126408-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table header needs to be adjusted to include spaces between
columns.
---
 client/ad-hoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index 33bff9ca..49c97f74 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -117,7 +117,7 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 	struct l_queue *match =
 		proxy_interface_find_all(IWD_AD_HOC_INTERFACE, NULL, NULL);
 
-	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s%-*s",
+	display_table_header("Devices in Ad-Hoc Mode", MARGIN "%-*s  %-*s",
 				20, "Name", 8, "Started");
 
 	if (!match) {
-- 
2.34.1

