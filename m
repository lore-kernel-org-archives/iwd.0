Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A594403
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 21:04:53 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id o3so12460039ple.5
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4Vb/9MaiYA8Jj7ZuBhIlEdlToU6LSNTvQjfje/tpvQY=;
        b=fvV+c51XLSptNCgzXED3e4CH7MYJfxNXzfHT9PFnwXbx3DbkpbcoZlxlmG7RZt/uo0
         YroP2Tkn2vCnBtljvfjAwSW+Pv5evOwgJjVvx0FKZ0kpps6ROf4A3IzUgjo4goULEjjc
         KR4HvGuzo80MAuPA7X8UriTDc4Z01CLDAr1DBrY3myLQ6u90r3jyuPF5j8KetZDsDIo2
         uQzCTmI+zyS79iQ1oOFneBR6a0bw3PmJYgAoX8u3kcojW01autxDy23i9b6xL9RRDWzL
         cLn7k75WVBOIVWVUEcxcPiscizIAkytYjkMFkeQyTqwb/gLEYTEQQsH9wSdZUergYwWe
         1okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4Vb/9MaiYA8Jj7ZuBhIlEdlToU6LSNTvQjfje/tpvQY=;
        b=5EIADO/tHoI8ThozruFY/ak2pvEFqBNCK/f3rwwD/3xhMdB3T5anhy75zZoiYViJJP
         Uv6hSx0UHwOopqzkH3S+txvhRKqP3fGKh21TnBqzQEceuj9kX30lkqt0Vmvbuam7t6Fd
         YmCjD6rLAuIPzgQoGs596NY5mzYYvIaMK2+BTHdWZAbHRP2ACBlzv6cjrX2r0ld1eKPa
         vnYRdOe7MQhMfSajH3Js3L8GbYVytrjkQyiPkQn4PH7ihaL+6lkkC9xhpHsgqnl1mHCy
         /idrcpVne2tCTLoGpNISbnG5jmheWvGNog7RWQZWnCNdDQ+VSDysQpyXlD1Z9oldbazU
         x2Uw==
X-Gm-Message-State: ACgBeo2GYAYEqMYQW2Bow3icMIsraOYZh4lEg/kIhp+O95vVEWmAyLXF
	UmGmqThVO0djB2BfIp/WBjRcYgVgmu4=
X-Google-Smtp-Source: AA6agR7lTjYScgupoehRUpF9wUSXbEe7AVdukhX38+gcb2i+whX+S0auyT005I6hQ9LiGOw0gE3J/g==
X-Received: by 2002:a17:902:b684:b0:16e:e4b1:631c with SMTP id c4-20020a170902b68400b0016ee4b1631cmr24984723pls.88.1660079092602;
        Tue, 09 Aug 2022 14:04:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902904800b0016d23e941f2sm11161706plz.258.2022.08.09.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:04:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] monitor: add support for HE element
Date: Tue,  9 Aug 2022 14:04:49 -0700
Message-Id: <20220809210449.158256-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809210449.158256-1-prestwoj@gmail.com>
References: <20220809210449.158256-1-prestwoj@gmail.com>
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
index e880ca1e..4210c46e 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5539,6 +5539,24 @@ static void print_band_rates(unsigned int level, const char *label,
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
@@ -5552,6 +5570,8 @@ static const struct attr_entry wiphy_bands_table[] = {
 	{ NL80211_BAND_ATTR_HT_AMPDU_DENSITY, "AMPDU Density" },
 	{ NL80211_BAND_ATTR_VHT_MCS_SET, "VHT MCS Set" },
 	{ NL80211_BAND_ATTR_VHT_CAPA, "VHT Capabilities" },
+	{ NL80211_BAND_ATTR_IFTYPE_DATA, "Interface Type Data",
+			ATTR_ARRAY, { iftype_data_table, ATTR_NESTED }  },
 	{ }
 };
 
-- 
2.34.3

