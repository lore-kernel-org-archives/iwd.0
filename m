Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995156B77
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633652; cv=none; b=jwr7a01ip3Yt5DS5ZXMrAKMw2494KJb9Nx0csXwuOC17s8oQCKxJMrUSzdVgd+ifHYmPtBzB5c8dRt7+jxcuIDwuFKkA05tk2CnooXC2HaJ7duwpfbM3ou3BhGQcag9pUrNMNpw0VEK/XMY5gu5YW8oy5Cw3SXrnAZEZpTZckjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633652; c=relaxed/simple;
	bh=KOSndVOPk/AIggXmWzeUkI2McatGtRaQB0bRXHRSYPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEmhOXIF/YOZ4sNQbZ60DdaUq6NFvJeLyJaIeqmvMGugfBs1NPtL9eXFNrJrnb06uXOXPWAiA82tkzPhsOZuMVm6pLOL1PEqXmp3maAUSAVcG/ZxKqdDpBbRpVaRLC3KEuVlHKAqpJIIQe2QPB7l9sDLY2EstE4KVqRnbOb00NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3on0a4E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3on0a4E"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e21d1e8307so2895555ad.2
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633650; x=1712238450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqCiX7tfeOR0T/dGmE9vFayKUanKH/+IRm+jn3vnZuE=;
        b=I3on0a4EqZuG0z0DsKDY1Qpe00my6k63kG3Aj9ZrDoCiOkc+DbAnjGKhrcXTsGnSY+
         1UXTWKdAqvx6+nJltaTg3mU6FGpCLIV6/gBVuT48fu1OhNHUcZkQwWjyL4nnT3B9WgFn
         DwuFaHMfzRDO2/Ea+vr4DpNZ8cZzrN3EeUG5NckV4LDC1gYSu9gliWMpwixwYvfOIlxH
         +HUB9LaxSudskTBJOX/1SgIgw4C1wQ0WTWLez+tBbPont3BqY3FS6jCyxw1UELx7pL4d
         gMULGO7yn56v6C2gb6OU4g/Xkd3+YE7g9QM8RqdHGquY/1JplDxFgDj5X/o4XY6xQxMC
         WXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633650; x=1712238450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqCiX7tfeOR0T/dGmE9vFayKUanKH/+IRm+jn3vnZuE=;
        b=NG2WlJEpf5NBWU8UcwZ77y3gIH/o50BxBuAXOgwcrib8jttvvIJSb2T8/gV18uTj97
         2pNGiGus1qIGOLhnYvAJjAiYuv4wVwMN4j2Fh8Mb7gCQ6Pu+Ax/50ZhCe6p9tNZ6OYVX
         q0k4hWVlZOe7nUaBIAiG9ViUfpr6xwwtUbxtslatO/M9p35FiVOlSxC0ANnlpyIItqKX
         HeiBbLZxR2rwJ2tWNof7g7F8I5RNq6ye8neAzDbjO+pgUxUAIboOJkxkrClNIY1A26iJ
         11j2D8irOx+Kc63UcezvgpBeIO2JspZn1wKEbAyFB6PspvpUCFW/fWrWWbG01BnY4ObB
         WM0Q==
X-Gm-Message-State: AOJu0Yx5x/htn6SAzQd9BZX+qx29sUrJBKrVm4jjrOcf59fcr3GGhQvY
	kn+ev635WAH/f8LsCUlEzaCudQe9iLXfGzbHm9lAck4RB5Gw4hYZ8AIpq5NY
X-Google-Smtp-Source: AGHT+IHejvinc6WmAHQuIj3ggvRcjKdnREFS9khaUQdrIVq6tx/yv28ZTC6KIuMle9ekw1nZ6QD8wA==
X-Received: by 2002:a17:903:32cb:b0:1e0:b629:b009 with SMTP id i11-20020a17090332cb00b001e0b629b009mr3621177plr.20.1711633649784;
        Thu, 28 Mar 2024 06:47:29 -0700 (PDT)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170902f94500b001e10b6f45dasm1568838plb.295.2024.03.28.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:47:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] wiphy: add better handling for rate estimation errors
Date: Thu, 28 Mar 2024 06:47:25 -0700
Message-Id: <20240328134725.1484257-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328134725.1484257-1-prestwoj@gmail.com>
References: <20240328134725.1484257-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In most cases any failure here is likely just due to the AP not
supporting the feature, whether its HE/VHT/HE. This should result
in the estimation returning -ENOTSUP in which case we move down
the list. Any other non-zero return we will now warn to make it
clear the IEs did exist, but were not properly formatted.

In addition HE specifically has an extra validation function which,
if failed, was bailing out of the estimation function entirely.
Instead this is now treated as if there was no HE capabilities and
the logic can move down to VHT, HT, or basic rates.
---
 src/wiphy.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 0d64b1b3..705fb9cc 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -989,6 +989,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *he_capabilities = NULL;
 	const struct band *bandp;
 	enum band_freq band;
+	int ret;
 
 	if (band_freq_to_channel(bss->frequency, &band) == 0)
 		return -ENOTSUP;
@@ -1037,8 +1038,10 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 			vht_operation = iter.data - 2;
 			break;
 		case IE_TYPE_HE_CAPABILITIES:
-			if (!ie_validate_he_capabilities(iter.data, iter.len))
-				return -EBADMSG;
+			if (!ie_validate_he_capabilities(iter.data, iter.len)) {
+				l_warn("invalid HE capabilities");
+				continue;
+			}
 
 			he_capabilities = iter.data;
 			break;
@@ -1047,26 +1050,39 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 		}
 	}
 
-	if (!band_estimate_he_rx_rate(bandp, he_capabilities,
+	ret = band_estimate_he_rx_rate(bandp, he_capabilities,
 					bss->signal_strength / 100,
-					out_data_rate))
+					out_data_rate);
+	if (!ret)
 		return 0;
+	else if (ret != -ENOTSUP)
+		l_warn("error parsing HE capabilities");
 
-	if (!band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
+	ret = band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
 					ht_capabilities, ht_operation,
 					bss->signal_strength / 100,
-					out_data_rate))
+					out_data_rate);
+	if (!ret)
 		return 0;
+	else if (ret != -ENOTSUP)
+		l_warn("error parsing VHT capabilities");
 
-	if (!band_estimate_ht_rx_rate(bandp, ht_capabilities, ht_operation,
+	ret = band_estimate_ht_rx_rate(bandp, ht_capabilities, ht_operation,
 					bss->signal_strength / 100,
-					out_data_rate))
+					out_data_rate);
+	if (!ret)
 		return 0;
+	else if (ret != -ENOTSUP)
+		l_warn("error parsing HT capabilities");
 
-	return band_estimate_nonht_rate(bandp, supported_rates,
+	ret = band_estimate_nonht_rate(bandp, supported_rates,
 						ext_supported_rates,
 						bss->signal_strength / 100,
 						out_data_rate);
+	if (ret != 0 && ret != -ENOTSUP)
+		l_warn("error parsing non-HT rates");
+
+	return ret;
 }
 
 bool wiphy_regdom_is_updating(struct wiphy *wiphy)
-- 
2.34.1

