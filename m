Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEDD1C4ED9
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768457; cv=none; b=JWfLrwcqn5yGdOgwrMzZ7I1TTRRmeAGDsnmA13fUX4B3lKQX6sLSS3tuEPoSNdWQLrBoFoOZNOMj9J/wo4S/FLXe8bRrZa4axhKi7nj9RFTr58vasxL7vTpxZkmZU6I5xDfPzCQLf9ce1wLL9PrzGJZOxc43rKnILgVH2cRlEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768457; c=relaxed/simple;
	bh=zspJqs1wsRQqt4wv4BLNgokvhzNaH6VJ17Ous6xV5wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+N/Kue/8c7NrgSM0jH1ovsGwLqOB+SsYbqoildY6pWbPvn1wv3+5WSzGveWYdWzYoM9Tk8zB4+SpjKcdRtp0wotD1H67wFspig6w9ccjv0HVy8a8F+hyOd+BrTi2yNkBODMZD/aNLAUOYmSWB3Wo4kRDnB+0k9FbFqCJ+Acye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0w2AvqG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0w2AvqG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20227ba378eso50110385ad.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768455; x=1725373255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQHCId46i/MOvWqVFB+G6s6C5FAMw7KbkiJI5iJ3b38=;
        b=e0w2AvqG+TCcfO9ggYTqIHu8gZqR/clGq+76z3coMakHfTnCT4NjmLSzFvTNHaPipB
         Z7raLarC2ABr/wU21SkeR/AjHntb7t0dALPt0pDs0aPmgzHPMHEG5KnwvIrKuvV8Hy/m
         lorIOXOSR14nTliQLlMNG7/u2lAixtx0plsBaSMzJpEdAmgRXYYtGw9KTv6wMknU0K0J
         wy26jW1ATWTHLLZ1v/rc7OXNkA6u7CORLAnOwynPduWRza9qYCCIJM5hkTDhU8vrhzuN
         25bXOS3Nq1SG62n3z4Wd2tZZtgwVpIaGLazXsKo3lOBE+7CB4WCeMOj0n1YVxJ029obm
         A/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768455; x=1725373255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQHCId46i/MOvWqVFB+G6s6C5FAMw7KbkiJI5iJ3b38=;
        b=mlJTI9FGpNHkRWVjmnrJwSxk+Q8kN9K7VZOhPW/II6aMkHByU57lpXHhigoSiHOJFl
         TEU9IWLpng4LlPNncY56s3BLcb+8RjXcv10HZaWtVg8cVzUetS38BjQL9zjKxIVwx+GX
         l65VERF1f2/4mWvgGrK9coa8Q9Cslv5osAcfQgMdnxKU+5LMTamJmcFMk4OFHO2Ci7yK
         Gyjm+4DDBwDHKBJiaJ3XR6nmr2dKksqyuwbWl2DCpITy9jo+2rvU6+kWAZufneb08fFp
         Y7t1xAoCV4kgGvPHm0pD04mL5pesuiTeoJpUm9RP3ctwE4gyD6suGj1sCw1rE1Bfit9O
         FMMQ==
X-Gm-Message-State: AOJu0YxeOkLBNNuNess4J6fWu9+c7R3h7h0lmQBSZqNP5XEwmEaJ1c48
	j5q7uIt88ct1RdFgASXWvk08MJzFVAIh/PdcUU+YybIPbBaOkSRP/Htjtw==
X-Google-Smtp-Source: AGHT+IHPUuNqVYJy2WVtaFr9C+kg3M9VWxkmW5vWXUDAW4PUyqL+MzEuRU5ZIK1VW6XSrCWMCDXmiA==
X-Received: by 2002:a17:902:db07:b0:202:5ac:fa3b with SMTP id d9443c01a7336-2039e46a45dmr161777885ad.19.1724768454652;
        Tue, 27 Aug 2024 07:20:54 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567912sm83909075ad.33.2024.08.27.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:20:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] scan: remove legacy "Ghz" band modifier settings
Date: Tue, 27 Aug 2024 07:20:48 -0700
Message-Id: <20240827142048.750995-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/scan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index bee6c5b4..44bcfd3f 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2544,28 +2544,24 @@ double scan_get_band_rank_modifier(enum band_freq band)
 {
 	const struct l_settings *config = iwd_get_config();
 	double modifier;
-	char *str, *str_legacy;
+	char *str;
 
 	switch (band) {
 	case BAND_FREQ_2_4_GHZ:
 		str = "BandModifier2_4GHz";
-		str_legacy = "BandModifier2_4Ghz";
 		break;
 	case BAND_FREQ_5_GHZ:
 		str = "BandModifier5GHz";
-		str_legacy = "BandModifier5Ghz";
 		break;
 	case BAND_FREQ_6_GHZ:
 		str = "BandModifier6GHz";
-		str_legacy = "BandModifier6Ghz";
 		break;
 	default:
 		l_warn("Unhandled band %u", band);
 		return 0.0;
 	}
 
-	if (!l_settings_get_double(config, "Rank", str, &modifier) &&
-		!l_settings_get_double(config, "Rank", str_legacy, &modifier))
+	if (!l_settings_get_double(config, "Rank", str, &modifier))
 		modifier = 1.0;
 
 	return modifier;
-- 
2.34.1

