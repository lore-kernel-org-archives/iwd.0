Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C621173A
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 16:20:02 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c453379020so108229185ad.1
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696004401; x=1696609201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIH1RY0WPaMMqTIt9nNL0pvIGQdG+LtP5YNfS6RzUBY=;
        b=lJDQCt5iBKELmrC5PVsSA19QqMsyEXzftQCdGwvW2QQVNSaf/edFqnuaqkj4P6003d
         p6qPiLiySdI3YhdTR7U3KWSeWipx6LrtHnaFlgaGA51XP0Njqtttrnkow5jnWv3uRUiz
         O8/160pa5PEfjnWWxAwW89x3s7R2JcetirjmBq4OF5glA1JpGQ/SDkjXepPdlumSZyAF
         yc2E6Kg/8M+G9XIafZbwiLZED6yYv7S2LIwAqtdhgowGtTLqaJFB2yQde/eXVn5VkJce
         pQThJJcdJw8X1mtf1mjWHq8dRH8P5FzBi4lQv44Wkk/D+3ShPmAtEx8mqZdHMl5sH6qH
         WL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004401; x=1696609201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIH1RY0WPaMMqTIt9nNL0pvIGQdG+LtP5YNfS6RzUBY=;
        b=k7dCGm2NhTEXto/TZRn9cSDLXwGjgjMkIswI3cE6nzfoJKIzUzdyr0wzLqr3LeY8Zh
         0ZbagyzGTj0otvZH11gLT63Xo/XUlcYZYmkWPPttOLrwOXBosNCn/ibbE+ZAZ8bUDyrE
         3xc/b3vWQD2Z6UoQFxb/v4VmCPg8ME9AxmuKB4PHcS9FPqgp5q3PamyhlrYNTPte8w70
         MWH/+H2u3gtFPUAf18o5gKeo0fIFunLbomoc6xCPJP/3IZbgrfjO6NU11QgsjeTON+DT
         KCrcyYfP2LP7A8KcGkPzbqBuDjsrN2fj/qbmExIwjuSpRP7/bUCZEF2h6R/T465LqwPV
         Z28w==
X-Gm-Message-State: AOJu0YyIEcYr1OLNjUpI2Wa5q3nrylkLaSXTNIiPkHtIt1XpUHlW0mds
	mN1fB1CPfX6hkf6njSfMKJMYfPk24zE=
X-Google-Smtp-Source: AGHT+IFrSHDrafra778IPkGHU/7g9c8qSfAIwkto3qTts2CkxUQ5cDThDE7vp2QiWGLvRWycEMr5FA==
X-Received: by 2002:a17:902:ea8d:b0:1bf:c59:c944 with SMTP id x13-20020a170902ea8d00b001bf0c59c944mr4766154plb.22.1696004401273;
        Fri, 29 Sep 2023 09:20:01 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm17223766plb.75.2023.09.29.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:20:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] wiphy: make wiphy_band_is_disabled return more descriptive
Date: Fri, 29 Sep 2023 09:19:57 -0700
Message-Id: <20230929161959.3840935-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function wiphy_band_is_disabled() return was a bit misleading
because if the band was not supported it would return true which
could be misunderstood as the band is supported, but disabled.
There was only one call site and because of this behavior
wiphy_band_is_disabled needed to be paired with checking if the
band was supported.

To be more descriptive to the called, wiphy_band_is_disabled() now
returns an int and if the band isn't supported -ENOTSUP will be
returned, otherwise true/false.
---
 src/station.c | 4 +---
 src/wiphy.c   | 4 ++--
 src/wiphy.h   | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index 12823142..7d182e9b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1450,9 +1450,7 @@ static int station_quick_scan_trigger(struct station *station)
 	 * this since its so limited, so return an error which will fall back to
 	 * full autoconnect.
 	 */
-	if (wiphy_get_supported_bands(station->wiphy) & BAND_FREQ_6_GHZ &&
-			wiphy_band_is_disabled(station->wiphy,
-						BAND_FREQ_6_GHZ) &&
+	if (wiphy_band_is_disabled(station->wiphy, BAND_FREQ_6_GHZ) == true &&
 			wiphy_country_is_unknown(station->wiphy) &&
 			known_6ghz)
 		return -ENOTSUP;
diff --git a/src/wiphy.c b/src/wiphy.c
index dcd9e210..fd22f013 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -570,7 +570,7 @@ const struct band_freq_attrs *wiphy_get_frequency_info_list(
 	return bandp->freq_attrs;
 }
 
-bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band)
+int wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band)
 {
 	struct band_freq_attrs attr;
 	unsigned int i;
@@ -578,7 +578,7 @@ bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band)
 
 	bandp = wiphy_get_band(wiphy, band);
 	if (!bandp)
-		return true;
+		return -ENOTSUP;
 
 	for (i = 0; i < bandp->freqs_len; i++) {
 		attr = bandp->freq_attrs[i];
diff --git a/src/wiphy.h b/src/wiphy.h
index cabb21c4..d61516d5 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -111,7 +111,7 @@ const struct band_freq_attrs *wiphy_get_frequency_info_list(
 						enum band_freq band,
 						size_t *size);
 
-bool wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band);
+int wiphy_band_is_disabled(const struct wiphy *wiphy, enum band_freq band);
 
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
-- 
2.25.1

