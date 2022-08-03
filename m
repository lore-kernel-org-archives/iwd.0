Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042E4A2A
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:48 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4470720pjh.0
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VbhjsG56hYxG+dnwRk8YrtA6GkVGJfChcpZxO/mgcsk=;
        b=TtaA45NUCMSU2MIPYT1T/LytkE9t9UTKoYFtNh6zyIljWg/yPEYhHw6R+kMsn86wdY
         ujaU4hsY3uBuD3UkTyhAirddXiW7/vy+YNrEIeVVQH7V7sv8La4qWW1m+Lg604BmKm3Q
         mC/9mP5UzFU1xn8AZ7MVGF3X7diKGW0mTWFOsIe1yilJQQ7Icln8bN4TBAq2R/mf+QwX
         yJhGW27221rXByeflZfVEY99kMorFONeRHAvV/M4KieJdDTHxhYZHTtWHAgR/5JeMY9u
         VOhEvTPUa7Ua3UsG7d9yTfZAK5hTDjCFh2FUQS+ZSmc28dS2BrHRi4eg3wTz0If5i3Qc
         dvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VbhjsG56hYxG+dnwRk8YrtA6GkVGJfChcpZxO/mgcsk=;
        b=pz3gCrGT0QpF50m6INXWZO4TUl/ma25i8hLEUS1nJGX8IC5TyFpH5OuTQRVrPYLJRJ
         s1PD7QhC1t3IFGnEEdtg1b3x/WwYQ9ZhhFlr9cXajGQm4Ku6a6GN3KtL6TLUwvLc18kR
         WL1wS6DjUF1AbdA1s7OZoFh+PPMxRC0FjKOCWBow7OqFS/8+5OqCL9ii7rAIiNAlPVQ+
         /69P/U+Es4ixWBnPO4jbQK2Z52B9w2aDGIV29CKYjlksdBvcHnXTdKcD8k0FRzgJVRCo
         0YzF2ymK92frR9KHR3jJHAWifPluDd4PYwpJkzrI4XF2kKoVPW8Z4h6EqVqudI2I6zJB
         IfLg==
X-Gm-Message-State: ACgBeo2g4xSIZ2tkmB6cxjGCasMbluOkbIICA/mR4SjqfefO94SdzXT8
	DwewBQW54wD8ASSRclesUO4kC1Y5JGA=
X-Google-Smtp-Source: AA6agR5LCEIV46/lzUcysW/YozIk6eliqZ692qsvTzqQ7mo0D32rEeyZtV1qHbXZSpoBigc2SzzEFQ==
X-Received: by 2002:a17:902:ecd2:b0:16e:d87f:d19e with SMTP id a18-20020a170902ecd200b0016ed87fd19emr20680576plh.75.1659562608172;
        Wed, 03 Aug 2022 14:36:48 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/13] nl80211util: add nl80211_parse_supported_frequencies
Date: Wed,  3 Aug 2022 14:36:34 -0700
Message-Id: <20220803213644.277534-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A helper function to parse supported and disabled frequencies.
---
 src/nl80211util.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 src/nl80211util.h |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 9092b204..78470014 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -32,6 +32,7 @@
 
 #include "src/nl80211util.h"
 #include "src/band.h"
+#include "src/util.h"
 
 typedef bool (*attr_handler)(const void *data, uint16_t len, void *o);
 
@@ -484,3 +485,47 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
 	memcpy(out, &t, sizeof(t));
 	return 0;
 }
+
+int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
+					struct scan_freq_set *supported_list,
+					struct scan_freq_set *disabled_list)
+{
+	uint16_t type, len;
+	const void *data;
+	struct l_genl_attr attr;
+	struct l_genl_attr nested;
+
+	if (!l_genl_attr_recurse(band_freqs, &nested))
+		return -EBADMSG;
+
+	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
+		uint32_t freq = 0;
+		bool disabled = false;
+
+		if (!l_genl_attr_recurse(&nested, &attr))
+			continue;
+
+		while (l_genl_attr_next(&attr, &type, &len, &data)) {
+
+			switch (type) {
+			case NL80211_FREQUENCY_ATTR_FREQ:
+				freq = *((uint32_t *) data);
+				break;
+			case NL80211_FREQUENCY_ATTR_DISABLED:
+				disabled = true;
+				break;
+			}
+		}
+
+		if (!freq)
+			continue;
+
+		if (supported_list)
+			scan_freq_set_add(supported_list, freq);
+
+		if (disabled && disabled_list)
+			scan_freq_set_add(disabled_list, freq);
+	}
+
+	return 0;
+}
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 01777195..1d32b700 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -23,6 +23,7 @@
 #include <ell/ell.h>
 
 struct band_chandef;
+struct scan_freq_set;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 
@@ -55,3 +56,6 @@ struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
 						size_t iov_len);
 
 int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out);
+int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
+					struct scan_freq_set *supported,
+					struct scan_freq_set *disabled);
-- 
2.34.3

