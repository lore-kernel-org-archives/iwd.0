Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E47328B8
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 12:41:31 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c451541f23so103761495ad.2
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904891; x=1696509691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USqwvpXESzvG8tqUOH7kTr8KSNigfK06yyXHTjF2Wpo=;
        b=jB6CmRq2mPS61SfyjJwDqaVy30yUrpdNPecBpZANg0MmomBU5oNKOWSVdAjiA7tRJJ
         qchO4eS9ocGqbd/aANJoejBn16v/zx4ifuknuCH7qXNThfZCvF2SSfKxQuQcvIgk+IpB
         Q10JznfT6XhxTRGmSkiGl8YQI0XNuiVq2+I7kvkDb41JZH9w6NDGABlDXij/257DRB7X
         evjePm8YhB7XyXLnl7B2KQxI1nh3NGzyfNsXXWEPcdFBAuM7eRdoDtNsCLwKDQTCI7HH
         lI0xLEYBrYAO0a6B0Y7WJERZis6abz0Z5CernO3vEFJAm7fkzGMCBrFZTOYBtSihTHTq
         qlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904891; x=1696509691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USqwvpXESzvG8tqUOH7kTr8KSNigfK06yyXHTjF2Wpo=;
        b=IwlM8brjcGOiu+844UswaJbCzy18sE6WRrChdPJIjLQ983xzqo8sLM955+uUu1cIT+
         T3fJ9ewLDq6wxZPeEcjN77hwuXmAxM/hElJL/5ksBtkMAYzGg1yaW6q0r3Pf3OwSiIeX
         GYyI1II2yxG1mXVAbUdx8UH8qMX2qmaGB3yX8bnIvzYfeJJzB3lZmaF2aXIm2bomMOzZ
         MjoXIVGq25A897wl3smbhWziqB288Qd0JgTgCIXa8N4y9pLp/wBxJDKWiF7kBv6Dainu
         mkVEOmto1OKcjmOVfEyZVLJp0mXt8enTCt43E/J1avI6S5Jx8g/f2d0EfWQIJGDa15IH
         aeug==
X-Gm-Message-State: AOJu0YyxYh+K0J3gF1zVT7G1fvGmLyKsUoz+uwSSnAF69by9WF2hNM4E
	L8xFpWCGCLQS9kDsfhvRYOziaCdXAKw=
X-Google-Smtp-Source: AGHT+IE08JoKn6Soxv9WUYcSBRE0CW6CEeC5BGnA7eyiyiNfL9XEblyCB4gWXPhwt/Q55x2j0V2wWQ==
X-Received: by 2002:a17:902:b282:b0:1c3:2ee6:380d with SMTP id u2-20020a170902b28200b001c32ee6380dmr1098591plr.48.1695904890938;
        Thu, 28 Sep 2023 05:41:30 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm14983105plb.25.2023.09.28.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:41:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] scan: filter user-disabled bands for periodic scans.
Date: Thu, 28 Sep 2023 05:41:26 -0700
Message-Id: <20230928124128.3793788-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928124128.3793788-1-prestwoj@gmail.com>
References: <20230928124128.3793788-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support user-disabled bands periodic scans need to specify a
frequency list filtered by any bands that are disabled. This was
needed in scan.c since periodic scans don't provide a frequency
list in the scan request.

If no bands are disabled the allowed freqs API should still
result in the same scan behavior as if a frequency list is left
out i.e. IWD just filters the frequencies as opposed to the kernel.
---
 src/scan.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

v2:
 * Simplified how the freq set is built. Instead just clone based off
   supported and the band mask. This retains any currently disabled
   6ghz frequencies without having to create a new set and merge

diff --git a/src/scan.c b/src/scan.c
index e6c105c0..93047a6b 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -987,9 +987,43 @@ static void scan_periodic_destroy(void *user_data)
 	sc->sp.id = 0;
 }
 
+static struct scan_freq_set *scan_periodic_get_freqs(struct scan_context *sc)
+{
+	uint32_t band_mask = 0;
+	struct scan_freq_set *freqs;
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(sc->wiphy);
+
+	if (RANK_2G_FACTOR)
+		band_mask |= BAND_FREQ_2_4_GHZ;
+	if (RANK_5G_FACTOR)
+		band_mask |= BAND_FREQ_5_GHZ;
+	if (RANK_6G_FACTOR)
+		band_mask |= BAND_FREQ_6_GHZ;
+
+	freqs = scan_freq_set_clone(supported, band_mask);
+	if (scan_freq_set_isempty(freqs)) {
+		scan_freq_set_free(freqs);
+		freqs = NULL;
+	}
+
+	return freqs;
+}
+
 static bool scan_periodic_queue(struct scan_context *sc)
 {
 	struct scan_parameters params = {};
+	struct scan_freq_set *freqs = scan_periodic_get_freqs(sc);
+
+	/*
+	 * If this happens its due to the user disabling all bands. This will
+	 * cause IWD to never issue another periodic scan so warn the user of
+	 * this.
+	 */
+	if (L_WARN_ON(!freqs))
+		return false;
+
+	params.freqs = freqs;
 
 	if (sc->sp.needs_active_scan && known_networks_has_hidden()) {
 		params.randomize_mac_addr_hint = true;
@@ -1007,6 +1041,8 @@ static bool scan_periodic_queue(struct scan_context *sc)
 					scan_periodic_notify, sc,
 					scan_periodic_destroy);
 
+	scan_freq_set_free(freqs);
+
 	return sc->sp.id != 0;
 }
 
-- 
2.25.1

