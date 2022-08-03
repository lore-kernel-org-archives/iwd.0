Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391294A26
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:50 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id gj1so2743269pjb.0
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NpoyemVTlNKehaXUxvOkt9SURP9ikXhmcLrY3JDMLFg=;
        b=R/2JDI14FXRJHhpRa4xhohyKKO4NeGnQtk5QH+NRP08/phQTMenZXI/1/aB8gKxJLK
         p4EWW2un3+qFeq3WGKJw5VrzM45nGVSpSjDRwdcFnSShLGbVeCkW0DvvwI2PzN44GOwP
         MjE4W8yGmofOC+uoXccMuN2NWO5a8yOXGJsfRMWcb/vDK5cbrjgaGjvnJdJBkYRWOKWx
         o8jmpbVAHbpeYgXQQcFLCQn4wCZMlJrTQD0oQFFNxW9bTMkyIYA9cvRCcrBlt5qu+4zT
         C3iskpizaMIVUyMWO4dDvmaAph5Zjsc4cyr9YQaVCE1KMCieY6ui2YuB1/oGpeh+uJ5N
         ekBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NpoyemVTlNKehaXUxvOkt9SURP9ikXhmcLrY3JDMLFg=;
        b=Icq7dQ4UgoTfob+dx7t0gNmrZYwtZ1eHBNcGcYCgXLwXqGfCX19DmBC0PRgxVJeTcb
         qHy3NsN0TrpLaJlON0ThrMHcVsjO73oRZ6Idl+uDqf2da2LQCeouDi3yS3mnBFBE8MiH
         hjnesY5QUFTK6B/+CkB57uVDFUOnfD7X27mLTkhBV2/i3OnASyPNwWLLyOFlAICTFbUz
         4ELkVg8hsQBIBJkXP0HaG+CvsOwBBth5vS/326yGAoxXy+2ye2v9vQEZ4LXacpYQZ787
         mvGJDwXJ+eniysrDCyCOtcn7Gi0yzkbL/eZBqjMX8NWJJQ9NyjNgUOKaNQZCSg743xnp
         mBHg==
X-Gm-Message-State: ACgBeo1lplwlHpSLUY5kv9A7MiJLoUxImlRCn+kGWAQ0gLR5HJ+IQXdZ
	g+mxDWONz0AEiJcd1wK6c9nAFKiwud8=
X-Google-Smtp-Source: AA6agR71Jovm70PdSD7wU3Cr//xoICXwJ0BAja5zteofMryuF5cbHPXF2Do2qrYgP+kIZi31IK1RTg==
X-Received: by 2002:a17:902:ca0b:b0:16d:d562:42dc with SMTP id w11-20020a170902ca0b00b0016dd56242dcmr25099505pld.26.1659562609448;
        Wed, 03 Aug 2022 14:36:49 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/13] wiphy: use nl80211_parse_supported_frequencies
Date: Wed,  3 Aug 2022 14:36:36 -0700
Message-Id: <20220803213644.277534-5-prestwoj@gmail.com>
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

Removes the parser in wiphy and uses the helper instead
---
 src/wiphy.c | 44 +++-----------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4a778699..3a6cd48c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1190,42 +1190,6 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 	}
 }
 
-static void parse_supported_frequencies(struct wiphy *wiphy,
-						struct l_genl_attr *freqs)
-{
-	uint16_t type, len;
-	const void *data;
-	struct l_genl_attr attr;
-
-	while (l_genl_attr_next(freqs, NULL, NULL, NULL)) {
-		uint32_t freq = 0;
-		bool disabled = false;
-
-		if (!l_genl_attr_recurse(freqs, &attr))
-			continue;
-
-		while (l_genl_attr_next(&attr, &type, &len, &data)) {
-
-			switch (type) {
-			case NL80211_FREQUENCY_ATTR_FREQ:
-				freq = *((uint32_t *) data);
-				break;
-			case NL80211_FREQUENCY_ATTR_DISABLED:
-				disabled = true;
-				break;
-			}
-		}
-
-		if (!freq)
-			continue;
-
-		scan_freq_set_add(wiphy->supported_freqs, freq);
-
-		if (disabled)
-			scan_freq_set_add(wiphy->disabled_freqs, freq);
-	}
-}
-
 static int parse_supported_rates(struct l_genl_attr *attr, struct band *band)
 {
 	uint16_t type;
@@ -1445,16 +1409,14 @@ static void parse_supported_bands(struct wiphy *wiphy,
 			band = *bandp;
 
 
-
 		while (l_genl_attr_next(&attr, &type, &len, &data)) {
 			struct l_genl_attr nested;
 
 			switch (type) {
 			case NL80211_BAND_ATTR_FREQS:
-				if (!l_genl_attr_recurse(&attr, &nested))
-					continue;
-
-				parse_supported_frequencies(wiphy, &nested);
+				nl80211_parse_supported_frequencies(&attr,
+							wiphy->supported_freqs,
+							wiphy->disabled_freqs);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
-- 
2.34.3

