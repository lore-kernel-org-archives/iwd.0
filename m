Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1429746F
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 22:09:00 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id p24so13572283plw.1
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kATEalScbkZvJKpTK7sG5qF8oWC+Zk2z8K6zZQVy3+g=;
        b=jI9cl2WZPW+CtLiOwJSjCsC5ZME9uA+4iWKU2orp33ig67qolSrxpsq2y8tTCxClub
         bHQuajX1boEKiXLoZ4aW5V+cnFXM6j6wbDVscA3FJfQCGedh6mGcsC6BqToNu9f1YsKI
         YfIXRTGBx1y8Ix1BCWLfWs12tesYi2eY5OM9QFbfF7Eskl94F04clrommKcn2Ns7Gwpl
         nX/Px8t482HwY+cLaxyz6K5Esm5Gz+jI6DEZ7+7m/eQf3DZWKa27fUkWupiMpcn+AxH3
         YwCX6/9Jyi1OLkcMLBq6WJWKgSHl6/0E+ZoIi2bfg08ev40r49q/ZyktwUsH+6TQXsZn
         GNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kATEalScbkZvJKpTK7sG5qF8oWC+Zk2z8K6zZQVy3+g=;
        b=FAKA6wj+C/mt7G8KroYNuNbO6Qm4gNqQSPHLfpfxK0fqMF+Z2pibPPqPCAailyFaBL
         cvc5t4XvDDqgzo4ogO0tnQq8huK571Cu8T6euuUPwA9iroH2a0ymCNosyc09iB8NIc8r
         snB3T6T0UPZH3GF60OZsmKp4XouVwtq+mXTHIAUKbf2hiedrjKdRnI8gnExwmyrFk5dO
         iqPmKpSyLkPw0cuEPylLFoyY5Jh43HfTnlRi7GrDifWmG8k7rTTc9FFQ8Xk5HZIMxkzh
         z7l5lTm9Fv8jsTm7MJPqyMzFazQeUUGI/nUPL09+VIlRkQXLKFLXblQ8W5lQjtHgJFol
         18eQ==
X-Gm-Message-State: ANoB5pm5/TXUanPtbI6AJ7dA4sO3C7fVSdiAt/JNui05ICbnei8FGeiO
	TH5l/GLTZin1Tjt6r7ODPenGTvN4hzo=
X-Google-Smtp-Source: AA0mqf5ikQB4ty8nHlMiaYQ/yhlvVRmwjB7iD8Fj1PVvf7xeTrp3wUtpdb5O2gIKPoozj/vOVgqp8Q==
X-Received: by 2002:a17:902:9349:b0:189:b0ff:e318 with SMTP id g9-20020a170902934900b00189b0ffe318mr17938380plp.1.1670882939874;
        Mon, 12 Dec 2022 14:08:59 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902f35300b001893efd3e03sm6884525ple.119.2022.12.12.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:08:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] scan: remove early supported check for 6ghz in wiphy watch
Date: Mon, 12 Dec 2022 14:08:57 -0800
Message-Id: <20221212220857.1284874-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the regdom updates during a periodic scan the results will be
delayed until after the update in order to, potentially, add 6GHz
frequencies since they may become available. The delayed results
happen regardless of 6GHz support but scan_wiphy_watch() was
returning early if 6GHz was not supported causing the scan request
to never complete.
---
 src/scan.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 5d2f2957..f63b3ed2 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1933,12 +1933,9 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	struct scan_freq_set *freqs_6ghz;
 	struct scan_freq_set *allowed;
 	bool allow_6g;
-	const struct scan_freq_set *supported =
-					wiphy_get_supported_freqs(wiphy);
 
-	/* Only care about regulatory events, and if 6GHz capable */
-	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE ||
-			!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ))
+	/* Only care about completed regulatory dumps */
+	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
 		return;
 
 	if (!sc->sp.id)
-- 
2.34.3

