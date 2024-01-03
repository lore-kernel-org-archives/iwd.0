Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AD1CAA1
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7VEtRCw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e05abcaeso49582505ad.1
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286606; x=1704891406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swEMhTSY4NugfLmz1aIIGG8gWgoxTPBLYNUWIUFGsKg=;
        b=U7VEtRCwdyVKpsvXLwm343Xl1tOYGaVM7gyfql71BIGNxNQO9RWdduoTogaOd3BS6l
         MHEu2TlnR1vbePRRjMKVegzOMbybVX2QtpM+dxSGXn1suyY+8Ztjzjc2FhBNB+snYj7J
         ZIRwHOKibaBrAiCReIF5cT5YIN77k61Uwm5q/Z1ysEUdoWw59CTfMpiQag8U9rG3sSFI
         be98nLJ8Cc9tIl7W59aKlStX3JWkowdIiTauM8XZzlgTSn9KOiqle/eJctDwQ3MI1Xt/
         Z2r+694LLN7PFT1S004V5/kFJwvwHzjWQUbqxKsEOVf3ku1ALPwZIPeh46KT6X8sfLAM
         +wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286606; x=1704891406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swEMhTSY4NugfLmz1aIIGG8gWgoxTPBLYNUWIUFGsKg=;
        b=vlCZbuuiqhfzo/MQ4vr4e6jzsLhBWOCV4+Wll06zo5QPWZYScc9ovF10eYOtz9SGG1
         J39UKTMJ6AsWCrFhgIleBuiaYosue2DwOFH3kgObsKg+W5V7HNxOuvs1PWdLyc5mhIxk
         S1FHWmLlRbZV+SOT2bs+0/LiOXaYu+MAuRWI0pvfMLyjMfv+vq9cRMGnSP6paZ/WD39n
         9LGiz1cz8Tg7ESXNTH12iQa9dUdjEq2DI1Nzho/akP/PymSPiOD4pRH5TwO2JUSxshxM
         UQkxZbAfjxufKz2tHO47glAIAs6UIfLpmybzZ5Fstij/5PA2IPr1WwNoK4TeOPO/xazC
         mwfA==
X-Gm-Message-State: AOJu0YyVpAkyvV3sSDWo7OoygVlkCEoSRItE5UHvCJ90iZHJYreewdwd
	Kf5jChkqL8oaforuS/MIzKuam/uAoG90Cg==
X-Google-Smtp-Source: AGHT+IF+eqjcim7vEXKxIZsup93xOqo5DfA9Y+uVkYt+FIVam4sHMX7hZ7Cc/LoNb0glytmR+h92WQ==
X-Received: by 2002:a17:903:228c:b0:1d4:4ae9:a23d with SMTP id b12-20020a170903228c00b001d44ae9a23dmr7182816plh.57.1704286606141;
        Wed, 03 Jan 2024 04:56:46 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001cfa718039bsm23674155plg.216.2024.01.03.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:56:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Keith G <ys3al35l@gmail.com>
Subject: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Date: Wed,  3 Jan 2024 04:56:38 -0800
Message-Id: <20240103125638.243820-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was seen that this flag seems to cause issues when in AP mode on
brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
scan is issued clients will disconnect. After testing this behavior
was isolated to the use of the COLOCATED_6GHZ flag.

Besides working around the problem on this specific hardware the
patch itself makes sense as a non-6GHz capable device shouldn't use
this flag anyways.

As stated in the patch comment, this isn't really a catch all
workaround since the flag is still used for devices supporting 6GHz.
If additional hardware exhibits this behavior we may need additional
changes like a hardware blacklist or an explicit option to disable
the flag.

Reported-By: Keith G <ys3al35l@gmail.com>
---
 src/scan.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index f48ffdef..8c6fdc08 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 	if (params->ap_scan)
 		flags |= NL80211_SCAN_FLAG_AP;
 
-	flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
+	/*
+	 * TODO: This flag appears to cause some undesired behavior on brcmfmac
+	 *       when the device is in AP mode, or has a secondary AP interface
+	 *       running, causing clients to disconnect when a scan is issued.
+	 *
+	 *       Only using this flag for 6GHz capable devices will limit this
+	 *       behavior to only 6GHz devices and in reality makes sense
+	 *       because a non-6GHz device shouldn't use this flag anyways. If
+	 *       more issues still are seen related to this we may need an
+	 *       explicit workaround, either brcmfmac-specific or a disable
+	 *       option.
+	 */
+	if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
+		flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
 
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
-- 
2.34.1

