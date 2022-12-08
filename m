Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5180A481
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 23:48:20 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id q1so2414373pgl.11
        for <iwd@lists.linux.dev>; Thu, 08 Dec 2022 15:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwIPX9bbyRBJ9GAUhiMDkxeqX6k978DcUsJ7JFHVGdo=;
        b=ZKF+Xo14VsuR91UGC8vv7wAYBlYj6iAt3N17nhgBA2BgDHJxGr1AEV0jDbES7KUGc3
         HY2xSJSSdGf8xFff+yJJuCUS5GToY3vwqV7Vs2NZAC88LXh66xfAma/6n1mmMK/CFp7Z
         X0VtqCgEnPb4DxfmNyvl7sSGeMvWe5y/SLKt4Cj6fD9NgYt96LUPFJ09OcPI5PFn0RHL
         v7vskYjnlYVDRc66cKal9+OhKJUynacbErl/UFy7ORJHC0P8WfXmfV+gr1+8O519/ByP
         WAK+BmGHG2GkaNl2+0DMaFiUNc5DribP6KK1ST8s9+quG/t/c8BqVSjzHrL/MD2ttfIA
         LNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwIPX9bbyRBJ9GAUhiMDkxeqX6k978DcUsJ7JFHVGdo=;
        b=np4qukEniMqXzEcPLG3vWL87EJ9hawIHzOM0c00/QYd4RqfPwMyrjlpPJNQa+qKRse
         k6SQvtOToTekza38nPxEB21uVBWDt06WoNd+pFGKrfobdA237iz1flGt5TdSSJjfZLdz
         67uHYtr9dLiLcSDrhOP56roDujFVoc8/Wmp+KtKn7gR4GJgxIED4mV0Ke4ZGipPrcz7W
         u39p5E0RkpNGj0jQ1I/vKQT+Eb1bufljXTWiRfIZSUvRuKa1wYpvU1U84tR8RFcGvnwZ
         3T+WJJXhMg0LgXRIUBJn5CMX7CXIGtGxNz4wIVzECpXP3N0EBSiCn8tOlJLBhH9E9uHr
         S6cQ==
X-Gm-Message-State: ANoB5pk+PnTeQ0M17emu0JtCvpmvbPEvvCYYq+I0YNFbqS/QN5aXLmv6
	9fT7r84TB1MmD8DfCVfeqsrsLZclAm4=
X-Google-Smtp-Source: AA0mqf43Bc1NY3c+yBgIqbBYzoHEjhxH+DxMUt8evjz5XlCrK7OtOLJOszIvU9ao9W2pYdg9QWw15Q==
X-Received: by 2002:a05:6a00:705:b0:566:900e:1023 with SMTP id 5-20020a056a00070500b00566900e1023mr3099181pfl.3.1670543300103;
        Thu, 08 Dec 2022 15:48:20 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b005767cb32fdasm41392pfg.188.2022.12.08.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:48:19 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] wiphy: add wiphy_get_no_ir_freqs
Date: Thu,  8 Dec 2022 15:48:10 -0800
Message-Id: <20221208234812.778191-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221208234812.778191-1-prestwoj@gmail.com>
References: <20221208234812.778191-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to supported/disabled, returns a list of frequencies which
were flagged as no-IR.
---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index af0443bc..593679df 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -499,6 +499,11 @@ const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
 	return wiphy->disabled_freqs;
 }
 
+const struct scan_freq_set *wiphy_get_no_ir_freqs(const struct wiphy *wiphy)
+{
+	return wiphy->no_ir_freqs;
+}
+
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy)
 {
 	return wiphy->ap_probe_resp_offload;
diff --git a/src/wiphy.h b/src/wiphy.h
index f8de7e0e..40aa75fa 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -99,6 +99,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
+const struct scan_freq_set *wiphy_get_no_ir_freqs(const struct wiphy *wiphy);
 bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
-- 
2.34.3

