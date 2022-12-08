Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2912F36
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 23:48:19 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 82so2463218pgc.0
        for <iwd@lists.linux.dev>; Thu, 08 Dec 2022 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0mxRbNDmIrYRHrsZ3PuQADH4hrk850BmhEjhwCS4ac=;
        b=UqojndcLMnCPOqwH1LxZN6zwtOoQo42jm7Zl/t7ScVR5xr1A92uN+dAK/VQ4FTSwb6
         +KPGdtyRC62HEAFHrwNy5NrQE3X4tVvQuguUw3VMFa2r9MWO8v79IKAyg5z4dhB/rCF4
         sZ7Y3ugSIGt/QdoSg6Z4v/az1cfr2TETE9zTuyn7OKzSPcOa7zto9z+mgBg7+QidCums
         sohpMJAjtaZ1Ekwzv2QlZ8MR7n459+0eTf+STJGkoeNcKjfnIkoM75CDT1B6wqcYjf8d
         9rx/6bjhHd0/kUA44LsKnVnufksdQ5KTD0zOrNr4vfcSuaBNH8yQbK0G/Xb6q6vljLVL
         jTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0mxRbNDmIrYRHrsZ3PuQADH4hrk850BmhEjhwCS4ac=;
        b=KY83XpFI8C29bo0k6gTpwAP727NIuRac/JCSeWDJa/owMfyCSjMZnJwWhz6rbxwGVJ
         ZPlJ6JzclSAgdiHzfpXPDa9eGvYhTCPMIEFnyKH8kA7Foh3ANtbyCTi0BFTym3kRCHnz
         4B4Qmt+Bq1qpjymWoQWLsGGR31IY6a2Aq2ZNxZdcB7JIGPBTTNa3G2fPywj+AXEOJI8k
         85XxqyvabNdCt6CGhdayI0UwwZp0vOlzzE9Bz/pb/KozCQxDzDmS9agGUB36HF+usyhB
         /3zMTsZOztcjga5zNA6vhhv2q/SCbf71ifVH406d6Pd8zFyD3CizLxME085Xe7wq8YzI
         VxqQ==
X-Gm-Message-State: ANoB5pmg0YtRD0WTTeVbVjuYwxnGy7lYo9CYACxq56a4TSB/gxluXY9O
	vizUEX71HwDkfaVVRBBwaqUDdupZIcw=
X-Google-Smtp-Source: AA0mqf5BumJoLaS+gltFoiYR4YVhb7jZ8srNACw7xGUFSfZmwXxJhTl31ikMdLfAlthx21Qzfca71Q==
X-Received: by 2002:aa7:804a:0:b0:566:94d0:8c83 with SMTP id y10-20020aa7804a000000b0056694d08c83mr3271589pfm.7.1670543298389;
        Thu, 08 Dec 2022 15:48:18 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b005767cb32fdasm41392pfg.188.2022.12.08.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:48:17 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] nl80211util: populate no-IR list parsing frequencies
Date: Thu,  8 Dec 2022 15:48:08 -0800
Message-Id: <20221208234812.778191-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In AP mode no-IR channels need to be known since they are effectively
disabled with respect to AP operation. Parse these channels into a
separate list.
---
 src/nl80211util.c | 11 ++++++++++-
 src/nl80211util.h |  3 ++-
 src/wiphy.c       |  6 ++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index da36d936..396c82c2 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -502,7 +502,8 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
-					struct scan_freq_set *disabled_list)
+					struct scan_freq_set *disabled_list,
+					struct scan_freq_set *no_ir_list)
 {
 	uint16_t type, len;
 	const void *data;
@@ -515,6 +516,7 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
 		uint32_t freq = 0;
 		bool disabled = false;
+		bool no_ir = false;
 
 		if (!l_genl_attr_recurse(&nested, &attr))
 			continue;
@@ -527,6 +529,9 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 			case NL80211_FREQUENCY_ATTR_DISABLED:
 				disabled = true;
 				break;
+			case NL80211_FREQUENCY_ATTR_NO_IR:
+				no_ir = true;
+				break;
 			}
 		}
 
@@ -538,6 +543,10 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 
 		if (disabled && disabled_list)
 			scan_freq_set_add(disabled_list, freq);
+
+		if (no_ir && no_ir_list)
+			scan_freq_set_add(no_ir_list, freq);
+
 	}
 
 	return 0;
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 44555a25..ce1df2cd 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -59,4 +59,5 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
 int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported,
-					struct scan_freq_set *disabled);
+					struct scan_freq_set *disabled,
+					struct scan_freq_set *no_ir);
diff --git a/src/wiphy.c b/src/wiphy.c
index 10514572..4744e7f4 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1514,7 +1514,8 @@ static void parse_supported_bands(struct wiphy *wiphy,
 			case NL80211_BAND_ATTR_FREQS:
 				nl80211_parse_supported_frequencies(&attr,
 							wiphy->supported_freqs,
-							wiphy->disabled_freqs);
+							wiphy->disabled_freqs,
+							NULL);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -1988,7 +1989,8 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 				continue;
 
 			nl80211_parse_supported_frequencies(&attr, NULL,
-							wiphy->pending_freqs);
+						wiphy->pending_freqs,
+						NULL);
 		}
 	}
 }
-- 
2.34.3

