Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B9364B5
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7A1QZnb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77ba957043cso54171885a.2
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149487; x=1700754287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1UR/o6ISEvarVQEpap9fiz+maexg1Tb6LpfD/kXP4U=;
        b=m7A1QZnbADkWfpjTNZmhwW2K6eEBcRFoKaLC4iThIajOSkgNqaxk+YE6d7QdM1hzga
         cSWUODFo50sxGkt+fPnYtwBRxqUglQKkzJTvq1h5yNUCroq9FWeNd8LfXuhKB5M7l8My
         tuxgVgKpQR6rDK/eBMA7EoJ1fOOwoGr4rxrqglwonrLcEP/cGCwefKqwSJwII5HCw255
         /JgYi4LjZ7wUoqpxIC/HrFo1kjKsC/ektPv4535YrvKLMmW1MvY8Sc4vtE/k3l2DZoK5
         w1NfVmmp0KxWt2vZNPGpCLlwYVpSHLn8jAmQ1e0B5epA9eM0Pi1HGDBQbSWQfUzE7MSO
         JOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149487; x=1700754287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1UR/o6ISEvarVQEpap9fiz+maexg1Tb6LpfD/kXP4U=;
        b=CDLFNvVb8OdtMolk2z6FouR8RqNGKnM1ouZAX4rnlG4SKArthOsS/+coLFYlBJ83hP
         J8L3RPfnBQcGw0SquF1JEJssB+RXuitFlbMAALlwE1UNt8Ud3WdmIv/ar+BEgVTPXeD5
         6UiGhjg6DjPLnEiCu8wEYUuIfxqko2VK5jwiCURlmKM3S4s+F5GI4//FkqhAHHiJEE46
         wasXaCgkIGYn3lLFMuCDs6ZOWLjrkwKb7HKuUweU6mKD9R736FaDtvCgPKEznX2xwvJv
         zUa1rrlwWfAEpGJ9KQutpmu37U0J3vXP2E7UzVu705wSkgZEwc9Nr/WJcMGOD2VCDRsW
         6epQ==
X-Gm-Message-State: AOJu0YyLjFslnWiDfMRBwHkLpEGdB0TsAdc7r8BYgc40VlL/qQLr3fQu
	mleoJOpRuyPjjbu06Y54TdOsML13Gho=
X-Google-Smtp-Source: AGHT+IGSutPUwOIQcJolfQJYcedVeRrid9QHhSpfAoaqIzhmr6IH610lEY6NFs7ZU2ZzlTXmDww0IQ==
X-Received: by 2002:a05:620a:2411:b0:779:da55:b327 with SMTP id d17-20020a05620a241100b00779da55b327mr11120396qkn.11.1700149486643;
        Thu, 16 Nov 2023 07:44:46 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a271700b007759a81d88esm4338300qkp.50.2023.11.16.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:44:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] dpp: check for non-utf8 SSID's in scan results
Date: Thu, 16 Nov 2023 07:44:39 -0800
Message-Id: <20231116154439.33880-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116154439.33880-1-prestwoj@gmail.com>
References: <20231116154439.33880-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory this shouldn't be possible because the configuration object
validates that the SSID is utf-8. But it doesn't hurt to check
especially since we can't control what the kernel sends us.
---
 src/dpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 18b2a7c6..8da79603 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -884,6 +884,9 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 	/* Purely for grabbing the SSID */
 	bss = l_queue_peek_head(bss_list);
 
+	if (L_WARN_ON(!util_ssid_is_utf8(bss->ssid_len, bss->ssid)))
+		goto reset;
+
 	memcpy(ssid, bss->ssid, bss->ssid_len);
 	ssid[bss->ssid_len] = '\0';
 
-- 
2.34.1

