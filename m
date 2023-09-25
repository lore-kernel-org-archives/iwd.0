Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC01C29A
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:44 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59bf1dde73fso90727247b3.3
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668083; x=1696272883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gznMpBSuIGSoPLrozDk4KrZiUfnRaSfloj5Jc7inXDY=;
        b=ZUVQPHJcuxTp3vWhxNydhCT/SCoLtVnF17JLYaT5wwZo0zhICbfjEw2xvEjOplhHUH
         fSot6YjGXrAG/5XFZv0MUBc2i4UtMEC5pUOgOD9RNDFJaUovgc+H4z5ygoZESwPy6r5g
         jRBXoHqOzlAZzgbz51vIcHwyLbWH7DnP/wgISIMuMZrD1b03JMJjMnpc335vxYlXf54U
         F6GZ1axwnSTqMbf6tgrNe9P4cLY7yaSzozDZLf2LL8cq+4oJXZDde1cXBWtyNmEqjU0v
         +Wz6iUIf0ajeW84BAplItz0b9H6BswOlttRtV8xyuTVPzwmFUM24GuKrMFqJBJkqWG3S
         GL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668083; x=1696272883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gznMpBSuIGSoPLrozDk4KrZiUfnRaSfloj5Jc7inXDY=;
        b=El0Fhfu0kegOkbOVERZgPNs8TlxmzZmp4UGuX5MTOaPY+cYOehjcCBA68UaUXI/tz3
         dnioWO10PdErzWJfUyofIm0e6X8ePzQ8TH7p9BUjyHYZAdbmmHtiZ9Em3fEgzScvY053
         RfFRFJ0APaxhvk1kLS5O1b0+UvQUcaT0lDi2xnVp30Ra4CTJjZipn671fh91sSNkGeTZ
         lZoD6wwGOsfpbLkA5gLGSp6TljjaELzTGIvOdJDLKYgO83wjZdji+atbOulz+8+x40hd
         nH9PWYG/0cTAh1p65uU/P4oLTJNf7WuiOyJDFjrZFUuLsoC7ey7/Qb2jpMIejOKM2lpO
         6bog==
X-Gm-Message-State: AOJu0YwtLBKNjuq0b3TAhuVGCILss10azH+XXKahG3Zxt77HDYnZUKZJ
	4pcPmlJ/WhyfwqUMm3AUiTWCYsmo2SQ=
X-Google-Smtp-Source: AGHT+IGpNtDgpKBdKnku5zFb8/I0ybCona2ocXLuTKSiZrU99rjM90E1dIijpEtrj0QjV40TgMnl/w==
X-Received: by 2002:a81:6dc2:0:b0:599:da80:e1eb with SMTP id i185-20020a816dc2000000b00599da80e1ebmr7993095ywc.24.1695668083337;
        Mon, 25 Sep 2023 11:54:43 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] wiphy: add wiphy_get_allowed_freqs
Date: Mon, 25 Sep 2023 11:54:18 -0700
Message-Id: <20230925185422.2242494-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is more or less copied from scan_get_allowed_freqs but is
going to be needed by station (basically just saves the need for
station to do the same clone/constrain sequence itself).

One slight alteration is now a band mask can be passed in which
provides more flexibility for additional filtering.
---
 src/wiphy.c | 15 +++++++++++++++
 src/wiphy.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index ccff701e..dcd9e210 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -500,6 +500,21 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 
+struct scan_freq_set *wiphy_get_allowed_freqs(const struct wiphy *wiphy,
+						uint32_t band_mask)
+{
+	struct scan_freq_set *allowed = scan_freq_set_clone(
+						wiphy->supported_freqs,
+						band_mask);
+
+	if (!wiphy_constrain_freq_set(wiphy, allowed)) {
+		scan_freq_set_free(allowed);
+		allowed = NULL;
+	}
+
+	return allowed;
+}
+
 static struct band *wiphy_get_band(const struct wiphy *wiphy, enum band_freq band)
 {
 	switch (band) {
diff --git a/src/wiphy.h b/src/wiphy.h
index 9f24d171..cabb21c4 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -100,6 +100,8 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
+struct scan_freq_set *wiphy_get_allowed_freqs(const struct wiphy *wiphy,
+						uint32_t band_mask);
 
 const struct band_freq_attrs *wiphy_get_frequency_info(
 						const struct wiphy *wiphy,
-- 
2.25.1

