Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D315AD
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 00:57:27 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id u10so14872185pjc.5
        for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgFT/vdNOaDQFJvkdBXnDmyRH1Hiym7DxY+6HmWGVr8=;
        b=UIlTatzuh8dnfOOrKgv2fsDPL7DFoTsfNgLx2QQIlLHD4lEglstoUZ9IX51GvOU5vM
         R8XpQAWHEDhIZvi2l2Gf1JN9wuBZaIBKxJhlFTeLyHUjnUjUhyot+1EcdmIJiUMUBnnP
         AqJ+VbfV/dzjdiGp+IRACtrBse3u9uaYl1GzOVvVVxZT89+8JA3tZtKi3BNqaoMUQNQZ
         bNPnTSNlJgPUYGxmdtDBJtZD/HNI++n4K4OJuL9+0jCgVuS6Ne9VvxJifWb2Vz/1NeZI
         7rFga23CX54suOekRzML5jTV98FsRFheeby0pXjqqrtAjsKBeZq7jDYOImLb9xdNDILz
         mv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgFT/vdNOaDQFJvkdBXnDmyRH1Hiym7DxY+6HmWGVr8=;
        b=OoaRpkKO8rOeOaWLYp+MEyvDXZyITLDI2z58BmhK8iEIPdvYDnbX2CPv4PD0JyJ9xC
         2TDCeTT1lubioNvcRsz9ATaY66dpPNdVD3Qf3SayWp1r6Nk5nnF/bnqabFsmzZMEMR1u
         z1ZgGfbYpgOEsrYuNOp5E9O58Aj6l1uq1ROHLpv1qKyhStc4Z5K2ttKsA7c2fSbC6i+q
         qzzBToSb5V7LXYSZEqJXjUDyPHiQVIhztvLr5D9GefpE357GthIVaG8f2uD691PDlz8Z
         KE2hYtwtL9R/RXDlElkw4DTH5ZwG3NFOFhDUACUb4SQoAOK5MTGRUAvNdgucPkqcueQ8
         0U4g==
X-Gm-Message-State: AO0yUKWKG0NL1pUQQYKtdKBSYVFqJCmsXpDQ9AyDTZl/JAF2LOfWnBu0
	Ld2tLFDYJEQqlR4qL7XDpRVKv1HObl0=
X-Google-Smtp-Source: AK7set+810JaZFEICuQ/c+6dAq/D7guifx92RWVXjC2UYPaSoR6oALMy2JRzleeoVPcdmg7vJuOf7A==
X-Received: by 2002:a05:6a20:728a:b0:cb:df6c:ba89 with SMTP id o10-20020a056a20728a00b000cbdf6cba89mr7252438pzk.8.1677200246569;
        Thu, 23 Feb 2023 16:57:26 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i15-20020a63bf4f000000b004fb95c8f63esm6801132pgo.44.2023.02.23.16.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:57:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: add DisableHT setting
Date: Thu, 23 Feb 2023 16:57:23 -0800
Message-Id: <20230224005723.1411083-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230224005723.1411083-1-prestwoj@gmail.com>
References: <20230224005723.1411083-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the user to disable HT explicitly in the AP profile
---
 src/ap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index b51befe4..2867e1ab 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3660,7 +3660,18 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->band = BAND_FREQ_2_4_GHZ;
 	}
 
-	ap->supports_ht = wiphy_get_ht_capabilities(wiphy, ap->band,
+	if (l_settings_has_key(config, "General", "DisableHT")) {
+		bool boolval;
+
+		if (!l_settings_get_bool(config, "General", "DisableHT",
+						&boolval)) {
+			l_error("AP [General].DisableHT not a valid boolean");
+			return -EINVAL;
+		}
+
+		ap->supports_ht = !boolval;
+	} else
+		ap->supports_ht = wiphy_get_ht_capabilities(wiphy, ap->band,
 							NULL) != NULL;
 
 	if (!ap_validate_band_channel(ap)) {
-- 
2.34.3

