Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B32146D6B
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788403; cv=none; b=mfBsP5JV6YeOvskZNFYYWa5glO6BlhifcDhS8MmeBdNRr1oZBAO5zKqCNj5tGSKDWxsqOZzshMnH50HTiYrC3szM6e2vgbTLl0F8ExkOBYnfVfi5OrOZfopImEaXz/ldi5dUFd3tKfgAlXjAsgaiOO3YfOHO9GGhai8cWUM6dmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788403; c=relaxed/simple;
	bh=8FhNKcp2yYtADPiPblTSNPjSCdsWWfUNmRESfk0qHjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXRSWoaq+YwV4JBleGYBVlq8PWEp/P2m4JTFoxwk7r+DCf9sW7Lr51tvm0ewne4ueUNRI1XGEWiz5VsWIOZM4Q4W7A/8/4Dy+HAfhePnTdtmgAHOina4eSI/5JjWKTGZ+U8msddFgJTymv+qJCEdye5mbiyh8Ny3/7Z/UySAev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQScGp8W; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQScGp8W"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609beb631aso6897631cf.2
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788400; x=1730393200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khiGYbzWNTkEvqgnakMZwWnE+0L7jJKY2aEROv4oWEg=;
        b=fQScGp8WK24g7EnMA5q4MFvZzBBYoWetTFxB5ESJ5XtLWlm8cdgRqvNrsAry8BOeN5
         LompaiVhTxLiR29fazzg801D9DVp2IrUXQo1wGJ3a1Sia0AfrWu7gciD9U3SIQF9UaSA
         XCTgdoBk03wXefG72v+X3zksxpbsAyNru0eJiL1TXu36kyimHBycm8FSfcyeW10M+PLB
         zcN4Ux77wYU+yLcuZdnpIn/wZTbjdem8JkegYpeyDFB0lT4ihIjs8SBCJDz9QYHjrotU
         LmSuDCwj2LpWHC/iy2xS9m7yKDOj4LR3K//0WItdqfeKzQBWvIJbfDILYmux9vqycEUv
         r8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788400; x=1730393200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khiGYbzWNTkEvqgnakMZwWnE+0L7jJKY2aEROv4oWEg=;
        b=B0hdzps8fAL5nxWsI74yNx1oM3zZT+Co7UvwbK2lJTEHK6rgreHdXIgX2NrhtRGHIK
         BLoeyVqL3FhZO0g3CImt4iH6w3P7UE0C32Cfrh/NHKnue00VYgZD0Fs7ZmX6+No1aWN8
         N5dWjxyC7IGIfPFKVYfsNVCnBF4mSO/TgB4OxKp01P9dcqgo7Q2T01BAohy1clbdfVfJ
         yCvCzjXbdwWn+xrfLQp9y5cbWoxZ1kWRFXNC5ze3RLhtnMd81RDswhB4RM0tYkbWaQff
         0NZ4Y3qVlnR3L1KimPG2iKF8pOSTHODRlbBT2gdDzd9etD+8kPsdwW53+O5+Vc0tO04k
         6Vzg==
X-Gm-Message-State: AOJu0YyyH1wQLUgFpwg5nT19RBueWCmMl/X60HFjH/Iu81gJ8+RIF13O
	5fhlBl2meuAfaKW/30UMkqP55ny/adqoyDJeScNFqgWqA5K3DQ8bLxYbBA==
X-Google-Smtp-Source: AGHT+IGQY0ztRhk/s9Sm34YrRuKbe6C8dPdEVlQrYnfGzZM1Bbjze2gnZI+axyMBdEY8mf/rHtYfpQ==
X-Received: by 2002:a05:622a:1992:b0:460:a730:3176 with SMTP id d75a77b69052e-461145afd8dmr96355461cf.11.1729788400271;
        Thu, 24 Oct 2024 09:46:40 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4611a19be2csm16893901cf.70.2024.10.24.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] nl80211util: check band when parsing supported frequencies
Date: Thu, 24 Oct 2024 09:46:32 -0700
Message-Id: <20241024164635.176631-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024164635.176631-1-prestwoj@gmail.com>
References: <20241024164635.176631-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the frequencies/channels were parsed there was no check that the
resulting band matched what was expected. Now, pass the band object
itself in which has the band set to what is expected.
---
 src/nl80211util.c | 13 ++++++++-----
 src/nl80211util.h |  4 ++--
 src/wiphy.c       |  7 ++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 7590f90c..0fdefddf 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -697,8 +697,7 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
-					struct band_freq_attrs *list,
-					size_t num_channels)
+					struct band *band)
 {
 	uint16_t type, len;
 	const void *data;
@@ -712,6 +711,7 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
 		uint32_t freq = 0;
 		struct band_freq_attrs freq_attr = { 0 };
+		enum band_freq out_band;
 
 		if (!l_genl_attr_recurse(&nested, &attr))
 			continue;
@@ -752,17 +752,20 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 		if (!freq)
 			continue;
 
-		channel = band_freq_to_channel(freq, NULL);
+		channel = band_freq_to_channel(freq, &out_band);
 		if (!channel)
 			continue;
 
-		if (L_WARN_ON(channel > num_channels))
+		if (L_WARN_ON(out_band != band->freq))
+			continue;
+
+		if (L_WARN_ON(channel > band->freqs_len))
 			continue;
 
 		if (supported_list)
 			scan_freq_set_add(supported_list, freq);
 
-		list[channel] = freq_attr;
+		band->freq_attrs[channel] = freq_attr;
 	}
 
 	return 0;
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 67fd7d7b..9f28b089 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -26,6 +26,7 @@ struct band_chandef;
 struct scan_freq_set;
 struct band_freq_attrs;
 struct handshake_state;
+struct band;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 int nl80211_parse_nested(struct l_genl_attr *attr, int type, int tag, ...);
@@ -95,8 +96,7 @@ struct l_genl_msg *nl80211_build_external_auth(uint32_t ifindex,
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
-					struct band_freq_attrs *list,
-					size_t num_channels);
+					struct band *band);
 
 void nl80211_append_rsn_attributes(struct l_genl_msg *msg,
 						struct handshake_state *hs);
diff --git a/src/wiphy.c b/src/wiphy.c
index d57d657a..d2793491 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1706,8 +1706,7 @@ static void parse_supported_bands(struct wiphy *wiphy,
 			case NL80211_BAND_ATTR_FREQS:
 				nl80211_parse_supported_frequencies(&attr,
 							wiphy->supported_freqs,
-							band->freq_attrs,
-							band->freqs_len);
+							band);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -2288,9 +2287,7 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 			 * theory no new frequencies should be added so there
 			 * should never be any stale values.
 			 */
-			nl80211_parse_supported_frequencies(&attr, NULL,
-							band->freq_attrs,
-							band->freqs_len);
+			nl80211_parse_supported_frequencies(&attr, NULL, band);
 		}
 	}
 }
-- 
2.34.1

