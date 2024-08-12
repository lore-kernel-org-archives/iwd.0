Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5918453F
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477591; cv=none; b=rFfPL0BZlBA6hP0wc+0A6+gM1gA5NA1VCMwYZ/aLIB9vTUrgMcY3LdiCj/LsrtRD6LBZ/7pOGX3+Hlrkjpnb8BLYWKJTB1NCIeDRLXxTQ6MALySMDlWvKLo/d/VK+SYJMTUJASzFcUHnFop8YIjnR0SqXUr8QmWfG9OMXK87Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477591; c=relaxed/simple;
	bh=pPO1f1eW/mVhcTn0HPd8uGgycFi3Yd/9Qj+fseKwfHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxdkciTS76HDCEygiVDaokynKnhHLMCL3xHtPuqcsgu99wG/lDP9gNSUxcGNMg4RYI0tMhoLegbVfH6fOqqXKea0G0dMxKiCk9LYEWsEQF9rGnWT8GGChnBFJRe5pL3a0vh9VHWc5DRRgyMS1BX3+CUc2fC+vDf5t4x6VhL2RP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsMOMZo/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsMOMZo/"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efa16aad9so5832993e87.0
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477588; x=1724082388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thWe1ydZOe4eEmuknFajVWF+FQWtQsVenIO3kVW6KAs=;
        b=EsMOMZo/YT0PDhODoyL1Op/1MtAisYpzb0NyqArAXIqcHNh/TD0tc/2maEBPnAqUvm
         FfwhIkprsd2V8U0MiF1B5aX2YeyXOPZiON2JqkD3JtSSDp5koejiKGlDKtNcAlhzAO8y
         g8UAS9cKZrY+5F24AeRNW1MRkvZAjf4O5Bdg7u74sHXj57wqbNcugySVkKJuJliSdU4P
         0cMtmYuw2zGcdPFJQZa5re8VJ1GC8qorKjZF09b9RWq2YBVz9PpofXvn7cTqmYMsaD+C
         jaYfXEYZbDgfPNzme1W6uZMzR2bz+7C9Edz8CfsbQzK2z4MPc60CnKZRxwRSwhShow07
         Jk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477588; x=1724082388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thWe1ydZOe4eEmuknFajVWF+FQWtQsVenIO3kVW6KAs=;
        b=dB1ifCsmMTOxnE85T9O3OgxgQvhjKoxkEQHb1DYvjUs57cQ7jTBvrtrKx4Oxk0rapL
         EFoBJmURar9yO54i2zEek0elXXO1YDSul47vihDWTuVRL/pz1+wQOGDkUsg6N122A5Sv
         ejz/icB3lHs60GaSkgF0bL8fONLxFV9+gGmfPI76KCq5+nLFmwLN3j9SUgotC7qMWM/J
         L5GKdn61fcZOmOb25MEzV27eAg1k+vaGnXxV2qTaBrbcJq5TLS9qAf91NsFYUXEE3DsH
         aC7ppNtLsYJgaulF4ztDDhtr1lb63XvNtXHbRYiKDtJBLsJzY4/Fp4eoYXN2vDJSQ1g8
         NAdg==
X-Gm-Message-State: AOJu0Yx7XcBkYn27+ak2w2nXqpkiZ5fiTcgaC3PeuxxoSK8y0FGdPMJv
	w0KOGE9mIT2dnWG8ajBM26FScEC/B5hAMP3l1EN+EDsQh0BSuIgpVIcM9A==
X-Google-Smtp-Source: AGHT+IEFDmkjvRzmRyPSCEJTW+4rJYXgm0xWIDS4f+/vWgcequFvb9sBqSZS6TliLIfA+V0y0VX3OA==
X-Received: by 2002:a05:6512:108a:b0:52f:cd03:a847 with SMTP id 2adb3069b0e04-532136b3804mr344506e87.61.1723477587395;
        Mon, 12 Aug 2024 08:46:27 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 05/13] network: remove network_bss_list_clear
Date: Mon, 12 Aug 2024 08:46:05 -0700
Message-Id: <20240812154613.126522-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 6 ------
 src/network.h | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/network.c b/src/network.c
index 76238e56..85d2a983 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1286,12 +1286,6 @@ bool network_bss_list_isempty(struct network *network)
 	return l_queue_isempty(network->bss_list);
 }
 
-void network_bss_list_clear(struct network *network)
-{
-	l_queue_destroy(network->bss_list, NULL);
-	network->bss_list = l_queue_new();
-}
-
 struct scan_bss *network_bss_list_pop(struct network *network)
 {
 	struct scan_bss *bss = l_queue_pop_head(network->bss_list);
diff --git a/src/network.h b/src/network.h
index b27158ee..78ced99d 100644
--- a/src/network.h
+++ b/src/network.h
@@ -76,7 +76,7 @@ bool network_bss_update(struct network *network, struct scan_bss *bss);
 const char *network_bss_get_path(const struct network *network,
 						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
-void network_bss_list_clear(struct network *network);
+
 struct scan_bss *network_bss_list_pop(struct network *network);
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 							const uint8_t *addr);
-- 
2.34.1

