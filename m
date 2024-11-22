Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC581DF256
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288574; cv=none; b=nX2EZ6Al5SJ5IqOxL5mcZt/bYKgedvuNAQu2S8yZ4fPwjTQo0XCX+kxnhEgcyqaV7sOXf30Jqtlm8vmkQSgDuzbfPz0Cgu9ETpgPA2gXMSe8yjYl1B5W9fEMqIIJlXCzqa73UORpC9L5Qd3zS69myqfQ42m1ZY9MSAOD1hYUswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288574; c=relaxed/simple;
	bh=t0edp6TmEPXhr84a55bPQVEMNChrrlAbVIBX/0QfKNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOmslDdzy/Q8DKh2ogKSnV9ljNNCnaPX8lvNWBqNrjHhqE5gB4D9TRJ9f9ppqcC5J8/y7LCpWZwqpp13GfjIPsR/kGfCIqCTPQXKeFDc31iz/HjCw92WBJ+KFIJx/QeG78RxZ6hcKIcABOX4oEBhEihdYEw5+UJiaVFSGqSm3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfQB91XA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfQB91XA"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1434b00a2so134301185a.0
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288572; x=1732893372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jbefqhtIlzzufaPAwsPs/PIphvpcMtoy2neMRUjSUQ=;
        b=OfQB91XA6fy74vZrYuq3gbfF1s6cKo3Uz/o8/H0wZX0Ajlti+Ze4R4V2o1f6d1LJ06
         y8/XKTfjxudKAtesN/WPfv5BSM+69XH/sGWq2uMIreY4XG1BJQM253Ig7uHqQ6PEdEBu
         lW8QbJHnnseZNHhFbWlXqo4/AsCb618ub6b+8MeSXSoj1FeBH57BRZyb4to9mCj6JHjL
         2PpclYHSwrY1ouDIpCEn75pTme1ZScS62RvzPH4U4ZjD2ipAZ/zKh3AibyKEkrM/x700
         Yt1TC61NoaniB2wx1+YTQVXk/5C8hBAKIirQEqssGqySFegXI3jm0eYA1p5yCz+HtQGE
         Pmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288572; x=1732893372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jbefqhtIlzzufaPAwsPs/PIphvpcMtoy2neMRUjSUQ=;
        b=wnPQ79BvO3F0P+yNvDZSzIbLeIHnC9En7GMTl6jl4lv6CIyZqOgIrm51bWgGBgET1u
         i83itaHEKUtm/Vc0cQGg3w8Wekz96Hk3DyrSWSST7gEKDdAMqM2JnFKFU5WyXyXSohfH
         eEnMH5/prZRU9rHiM1ME0+ptOSe7mi7Nb4RT96EsYPJmZ8ox4qEzTgno8qEyRxFTq/6K
         HVMLH0RaYbksF/UHCQ8rGybTqtsxuZ0c4IcdfzbCqzIRkjvtwHcKKnNajOxYq8eXhy0l
         sK//f+6jmqOX5mr3eepoM18V/sT/lvjJnEG3+C6s/AZXiTASUPowxFDG7gbGEFt7wWOj
         c9aQ==
X-Gm-Message-State: AOJu0Yy5kzyj7qFZIo0S0Opvg3xGQeJPY7QKQtIcyGUAg2CrRLC2pqea
	O+YgI9Zxs44LUU2siY4CMFazN+horRbqGpjdlUc6PfCfBvIO5zQsFBaXyQ==
X-Gm-Gg: ASbGncvRjjSOiFyRbrNSIczb2T7q01KSUFs7PDO9aPev/rt8CTnVJ6fwp4UWp7g7soF
	fOnWP9Yfb++H/jmaeO7RePehTQXLfoEXLDwfV9tpTUZoETZymjhuKlYWorJQhidmpA40AGOO4RL
	iEiikjy/kCsOm1jp/QeWY65Hj4/pMbIpWLDec34oBBSe7f+ddWXrE34HuDsiVqhWkVdmdvPVKqi
	i37+wpTTihcvF3js6HKlsntUdpKBXmjI0bHqR6+JDiJLNtKHWBQEKzfCZaI
X-Google-Smtp-Source: AGHT+IHFLHiJtD7CqUZRAblar/5Udr8iooyFHEcsC9ojubVOEql5xtmFyGJ9kDXpA0lGP/QT8jxRIg==
X-Received: by 2002:a05:6214:27cd:b0:6d4:246a:735a with SMTP id 6a1803df08f44-6d451378123mr53169506d6.45.1732288571651;
        Fri, 22 Nov 2024 07:16:11 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/15] netdev: add support to use PMKSA over SAE if available
Date: Fri, 22 Nov 2024 07:15:47 -0800
Message-Id: <20241122151551.286355-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was quite simple and only requiring caching the PMKSA after a
successful handshake, and using the correct authentication type
for connections if we have a prior PMKSA cached.

This is only being added for initial SAE associations for now since
this is where we gain the biggest improvement, in addition to the
requirement by the WiFi alliance to label products as "WPA3 capable"
---
 src/netdev.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4dccb78a..02496c92 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -65,6 +65,7 @@
 #include "src/frame-xchg.h"
 #include "src/diagnostic.h"
 #include "src/band.h"
+#include "src/pmksa.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1517,6 +1518,8 @@ static void try_handshake_complete(struct netdev_handshake_state *nhs)
 
 		l_debug("Invoking handshake_event()");
 
+		handshake_state_cache_pmksa(&nhs->super);
+
 		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
 			return;
 
@@ -2458,7 +2461,19 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 {
 	struct netdev_handshake_state *nhs =
 		l_container_of(hs, struct netdev_handshake_state, super);
-	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) ?
+	/*
+	 * Choose Open system auth type if PMKSA caching is used for an SAE AKM:
+	 *
+	 * IEEE 802.11-2020 Table 9-151
+	 *   - SAE authentication:
+	 *       3 (SAE) for SAE Authentication
+	 *       0 (open) for PMKSA caching
+	 *   - FT authentication over SAE:
+	 *       3 (SAE) for FT Initial Mobility Domain Association
+	 *       0 (open) for FT Initial Mobility Domain Association over
+	 *         PMKSA caching
+	 */
+	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
 					NL80211_AUTHTYPE_SAE :
 					NL80211_AUTHTYPE_OPEN_SYSTEM;
 	enum mpdu_management_subtype subtype = prev_bssid ?
@@ -4027,6 +4042,15 @@ static void netdev_connect_common(struct netdev *netdev,
 		goto done;
 	}
 
+	/*
+	 * If SAE, and we have a valid PMKSA cache we can skip the entire SAE
+	 * protocol and authenticate using the cached keys.
+	 */
+	if (IE_AKM_IS_SAE(hs->akm_suite) && hs->have_pmksa) {
+		l_debug("Skipping SAE by using PMKSA cache");
+		goto build_cmd_connect;
+	}
+
 	if (!IE_AKM_IS_SAE(hs->akm_suite) ||
 				nhs->type == CONNECTION_TYPE_SAE_OFFLOAD)
 		goto build_cmd_connect;
-- 
2.34.1

