Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FC8BEC
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 21:27:51 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id x2so3509447plb.13
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuED8hgi3vXuhWEkFgP3OzGEZjJVvhZrHP1iY6mcbpE=;
        b=R6ApBN5kYbCN0oE2cTpkMUqdpCpVPgpI6pW3d2M4FZKvPBx6pG5wtO1f7/+DT6HcJ3
         1Hq9U3N6LtlzF+9EKPBnNDVQveGum/tPXCTHSYE+O643ZC7e9uXg/92sIQFgQtw+Iq+4
         A4yRDRCD2c93L/k4EUHBZZkrm8Qra/+Bku1xBYCluVR+froPdLOtmuPyq8m+UyevBN7f
         cWNvtpbYtav2GxSHQjAGF63tFiPwD1XLLij8BFZPn0TOgdeUvXNMZIWUnPyX3EDhz17X
         RdFOiDBo/zKP7Vh6yTExR50yHyGU2OWpkEgWkIb/EHUAfA+WbKR1ecrQt+WNcDMQux+r
         V8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuED8hgi3vXuhWEkFgP3OzGEZjJVvhZrHP1iY6mcbpE=;
        b=LY2eswnxiSVrrcuIFX3ECzaIjS1vvvzxK6IbUMNixtRMZIVkyueyO6Rx+rjWN+p1V+
         fR5sAGHzp2qk0snL3xFXdYYwRJTiz07aQXQC4yYJkY7fFJsPXanW2yW9Szne0dpF4i2V
         2cPwL6hWX7M3iwYq5auvyc2/7z3w8fMY5rvjPeTHQYBSkEuiKPhOjQie82u8MC6ixiMm
         T2K7b5sei5g/ja4qlHKhF0u9hLShwvjZxf7gyz/2QYMw2CdRknVl/xYc1QRk37vsVCZx
         T0yOse2IztHKgiy8/x9a/sxHqYHEcbc5U+n6YRypAXO6+8H2cuQv0B6PunoyH1thda3h
         SCAA==
X-Gm-Message-State: ANoB5pmjnLiJ/SHyvLql5XRGb1dH1B6aQmpmfZEqvlTIs5jk4i3Axapi
	BHTLzLX9kMfmn/tDnTZSFIQrg0KmDjs=
X-Google-Smtp-Source: AA0mqf52qtlGp+CeCF9w7o9tUr14ewzzDAHynCKye8k9KmTXByHaJGLcfCbqM5rVnF7cT/P5D6+DVw==
X-Received: by 2002:a17:902:c94d:b0:189:b36a:5448 with SMTP id i13-20020a170902c94d00b00189b36a5448mr48132198pla.44.1671226070414;
        Fri, 16 Dec 2022 13:27:50 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b004785e505bcdsm1905404pgz.51.2022.12.16.13.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:27:50 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/8] ap: use wiphy_get_frequency_info
Date: Fri, 16 Dec 2022 13:27:40 -0800
Message-Id: <20221216212741.1833286-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216212741.1833286-1-prestwoj@gmail.com>
References: <20221216212741.1833286-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace disabled/supported frequency list with the new
wiphy_get_frequency_info()
---
 src/ap.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 32d9e1c4..a9027f79 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3174,9 +3174,8 @@ static char **ap_ciphers_to_strv(uint16_t ciphers)
 static bool ap_validate_band_channel(struct ap_state *ap)
 {
 	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
-	const struct scan_freq_set *supported;
-	const struct scan_freq_set *disabled;
 	uint32_t freq;
+	const struct band_freq_attrs *attr;
 
 	if (!(wiphy_get_supported_bands(wiphy) & ap->band)) {
 		l_error("AP hardware does not support band");
@@ -3191,19 +3190,11 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 		return false;
 	}
 
-	supported = wiphy_get_supported_freqs(wiphy);
-	disabled = wiphy_get_disabled_freqs(wiphy);
-
-	if (!scan_freq_set_contains(supported, freq)) {
-		l_error("AP hardware does not support frequency %u", freq);
+	attr = wiphy_get_frequency_info(wiphy, freq);
+	if (!attr || attr->disabled) {
+		l_error("AP frequency %u disabled or unsupported", freq);
 		return false;
 	}
-
-	if (scan_freq_set_contains(disabled, freq)) {
-		l_error("AP hardware has frequency %u disabled", freq);
-		return false;
-	}
-
 	return true;
 }
 
-- 
2.34.3

