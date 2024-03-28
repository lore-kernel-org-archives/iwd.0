Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2683CB2
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635988; cv=none; b=TUXmR6WAJ09bK4h9Y2ETfxho1Y9qlhDdpZlHr8FPoRctGosvzEFjCFZPUCDRdLAegYZ7GuiI/JTDvTE0pIGsQ1HUkeYTgx0YO7MxISsEscuJKc76+04G5MHMOm/F1PCuZNM7srAGdf7TUI1ac1SAdGPEtLJp90GbEriNC6rZLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635988; c=relaxed/simple;
	bh=/W+uRYz9Xe+SN7ZrUQmW/bCUsUWE6bkcvzn4B2Cq4kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qM6L1JvcYDpAJWVlhtdJXTgU2qFQSB6WKau/t5eWC5BlO0WsDas66NeuzkGE1en3uH+2/FonVWa2ODaMmkVfSNIKDruIYlPJalDuXW4s2xcmAb1LCvafqMCuwvGRJzPbCbnKVwTEOw/+CBPUXkgF5oE88LQVlGf/bNVZM6ISRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7+1W57i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7+1W57i"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so800926b3a.0
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635986; x=1712240786; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6qFfDDaHQhcl+dfnHi39RAeEBabv5eZfQg3CHmZJL0=;
        b=O7+1W57iI8bgdw3GrvHRA7SBTG8RnUPP9GZmvN9PzZWq7p+Inu0c1ImJeqPADryvEk
         UBMqEmDJUQT/bFWIlkZ4q7mmp4m/MWv+rW6dj2ltF+HoavB+8Zv+2IvZei/5XlTSf7Pp
         7FdBg7cygaca4qbF/LoPrbhrsdyzC5YOyI4gKnCImf8GD9TN8m0h6MsQA7O2X6ZDPgAJ
         PPEaMLKhcHrMKwtDQ3/e3zDXFhl6Rnn5nhX6QRCsZMlDzSwSBuA4ksVs9oDm2/kSbYbS
         DHfgk3bKHBj1TQAA3tO06Y/+qU9JVS9Ajtnh9JoeHfy91D/8GfnUWZ1UJpqibIfAGKgR
         vkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635986; x=1712240786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6qFfDDaHQhcl+dfnHi39RAeEBabv5eZfQg3CHmZJL0=;
        b=DJ7jSeJ9r1jXbRvquA9PJICLDb/4zNShSKr1zEhd9M9zbgl8DMEHMbaQ9+ZaxA90LW
         dg7PIidHaCeHtJJY8ctMG67VvDDYuVCgTZzmlI83liicGYL0SRuZ44BxOW7BpoDOKx7x
         FphxYDISCAF8dasZk5H8E1ytzW6scNl/JkPxtIDHboPnKD5DpttmiNwQOGw2uwYq0ZX3
         /7/hhOG46TBHBVRH+zmI+iddi742ESruYAYW+UcENSaxvqR0TFizZCxA2sOdWC7WCgEl
         tKNT+T5FF2N+SJtk0HdheDvi3WkFV+IaCXtpaApOuNa3SefJaKcZvll5+3fbkh0pRdN4
         V9Mg==
X-Gm-Message-State: AOJu0YxIwjYq2W2UTu5HltwxIHuEf4I9rzc+crgXC7PrSlmG1/XeYiJ4
	Tx1NV9Pi/RnZvb+epOy5vI1bbFISWSYxQRQSyBVvkmiinWKyes/41oSu6eIr
X-Google-Smtp-Source: AGHT+IEi6+AnfyD5/ZVv8cITcQZaW+wy2SzYVlIa200QaR8ZxRU7OzF1ern1dVzN9MJCOVmpOND0WA==
X-Received: by 2002:a05:6a00:8cf:b0:6ea:df49:c8b1 with SMTP id s15-20020a056a0008cf00b006eadf49c8b1mr1514520pfu.13.1711635985638;
        Thu, 28 Mar 2024 07:26:25 -0700 (PDT)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b006eac81dd456sm1412457pfi.36.2024.03.28.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:26:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] wiphy: add better handling for rate estimation errors
Date: Thu, 28 Mar 2024 07:26:22 -0700
Message-Id: <20240328142622.1490115-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328142622.1490115-1-prestwoj@gmail.com>
References: <20240328142622.1490115-1-prestwoj@gmail.com>
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

All length check failures were changed to continue instead of
fail. This will now treat invalid lengths as if the IE did not
exist.

In addition HE specifically has an extra validation function which,
if failed, was bailing out of the estimation function entirely.
Instead this is now treated as if there was no HE capabilities and
the logic can move down to VHT, HT, or basic rates.
---
 src/wiphy.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

v2:
 - Make all length checks continue instead of return

diff --git a/src/wiphy.c b/src/wiphy.c
index 0d64b1b3..712d20cf 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -989,6 +989,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *he_capabilities = NULL;
 	const struct band *bandp;
 	enum band_freq band;
+	int ret;
 
 	if (band_freq_to_channel(bss->frequency, &band) == 0)
 		return -ENOTSUP;
@@ -1005,7 +1006,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 		switch (tag) {
 		case IE_TYPE_SUPPORTED_RATES:
 			if (iter.len > 8)
-				return -EBADMSG;
+				continue;
 
 			supported_rates = iter.data - 2;
 			break;
@@ -1014,31 +1015,33 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 			break;
 		case IE_TYPE_HT_CAPABILITIES:
 			if (iter.len != 26)
-				return -EBADMSG;
+				continue;
 
 			ht_capabilities = iter.data - 2;
 			break;
 		case IE_TYPE_HT_OPERATION:
 			if (iter.len != 22)
-				return -EBADMSG;
+				continue;
 
 			ht_operation = iter.data - 2;
 			break;
 		case IE_TYPE_VHT_CAPABILITIES:
 			if (iter.len != 12)
-				return -EBADMSG;
+				continue;
 
 			vht_capabilities = iter.data - 2;
 			break;
 		case IE_TYPE_VHT_OPERATION:
 			if (iter.len != 5)
-				return -EBADMSG;
+				continue;
 
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

