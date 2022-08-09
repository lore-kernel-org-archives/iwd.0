Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023C4693
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 18:48:11 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso18524260pjo.1
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DQ9SFN96wr9VZA9gLupqLHzJJW2TZ7neyOqY6kogg24=;
        b=JdsVkX1rOFpRzy50vKBsBlh4zN1FIHGZef1jvRHUZJUJai8PGXCPGx9QbbqqU2ADxr
         yVQNAehCAzOYRra2aWRjy63n9BS5BM4rfeVMweYJQSm8Xd7EO+ezChxOisM1xGZsRUmC
         DUtn7Kb315pUtB1o05uoX9MHhtIp+7YCXxLSHWFc/Y7/Y/CqUOePNIweADhuckRE7AU0
         jdhflaReZU+hj4MT5tgz21be7vQviY8fzxYe5l7OraSLVINcXktEJufrN++/nUvwZWYW
         HP4ZtxXXPwcUPexi8A8EE9oM180XKnlbcpgumyVGVMUr1LRoy+lCmykU/PSWwE279awS
         u3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DQ9SFN96wr9VZA9gLupqLHzJJW2TZ7neyOqY6kogg24=;
        b=HrjS2KNB0xgVsrSxM9XGGrFdBsUhrSonjYkZH/138yXWi2oermc8Pgi7OPp1rva+NB
         1u9T6PomvDXhf04vqxNmNXkJITkc3Vp/wvtVLrLjazOPZ8O6eiTnelf2M26vdoIyzQot
         aRUh1WMVDNW6c2gMVCbZIerJ7kQ7yj3V6VXEvmOteNzgPLg8ZzSi2OiaXhFPhWVRckAU
         cNgFoWrm68i0atjS7MuNrNs7Hi/kvL6iklyHhSQytl0KcSNj1mW4DaaL8jIXx7myvM9e
         5VgeQA3KfyGlmVRcXnNo2HJPxXWTL+H7CsUWdtRzBindl+gRye9YMcC84IXQOeijXtIX
         GCkg==
X-Gm-Message-State: ACgBeo0+GoCm/j6bA52bMqKZOHBG9/8rQqR58zWrYThgvS3BvZveDnEz
	QOlRiGO9hGq0gEGLqx5rqUFagl9074o=
X-Google-Smtp-Source: AA6agR4gwWU8TOe8gSkU5P4PYULGGgWjVVYPbdU0jL84Z1gkZHIXNAFPacFX+ysJq+6ECw4Vy7JcwA==
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id g3-20020a170902868300b0017131147678mr1115748plo.172.1660070890801;
        Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016a0bf0ce32sm11403157plg.70.2022.08.09.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] monitor: add support for HE element
Date: Tue,  9 Aug 2022 11:48:07 -0700
Message-Id: <20220809184807.147780-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809184807.147780-1-prestwoj@gmail.com>
References: <20220809184807.147780-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for the HE IE.
---
 monitor/nlmon.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index d7327abb..2a68d0dc 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5540,6 +5540,24 @@ static void print_band_rates(unsigned int level, const char *label,
 	}
 }
 
+static const struct attr_entry iftype_data_table[] = {
+	{ NL80211_BAND_IFTYPE_ATTR_IFTYPES, "Interface Types", ATTR_NESTED,
+			{ iftype_table } },
+	{ NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC, "HE MAC Capabilities",
+			ATTR_BINARY },
+	{ NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY, "HE PHY Capabilities",
+			ATTR_BINARY },
+	{ NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET, "HE NSS/MCS Set",
+			ATTR_BINARY },
+	{ NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE, "HE PPE Thresholds",
+			ATTR_BINARY },
+	{ NL80211_BAND_IFTYPE_ATTR_MAX, "Highest band HE capability attribute",
+			ATTR_BINARY },
+	{ NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA, "HE 6GHz band capabilities",
+			ATTR_BINARY },
+	{ }
+};
+
 static const struct attr_entry wiphy_bands_table[] = {
 	{ NL80211_BAND_ATTR_FREQS, "Frequencies",
 			ATTR_CUSTOM, { .function = print_band_frequencies } },
@@ -5553,6 +5571,8 @@ static const struct attr_entry wiphy_bands_table[] = {
 	{ NL80211_BAND_ATTR_HT_AMPDU_DENSITY, "AMPDU Density" },
 	{ NL80211_BAND_ATTR_VHT_MCS_SET, "VHT MCS Set" },
 	{ NL80211_BAND_ATTR_VHT_CAPA, "VHT Capabilities" },
+	{ NL80211_BAND_ATTR_IFTYPE_DATA, "Interface Type Data",
+			ATTR_ARRAY, { iftype_data_table }, ATTR_NESTED },
 	{ }
 };
 
-- 
2.34.3

