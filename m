Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E8286D65
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672595; cv=none; b=nGXnJTmHaqk/atD2z0qdbNxqPrYXSYkX46MAc97tAepWjLKMPQmHO5BIC1tWhzembhj0L7iWybBN+RNvjHepRg/k6xAo37l4+GWMCIw3C5dNjKboNmICdWSooyOcxdhGzkgcaNoDi7gHTgUGE94SJ5Mj2JG2PAZNK6pb+bcF23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672595; c=relaxed/simple;
	bh=yVQ3Cxo/0HIFPTnvfgJSs05HbDHvYhpL/VWLQJ/4Y5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XImbSvhecdCU4iGZUHAMp09AvDVefOscFS5tRguS31qNuR8t+Xh2WpKLprmV/bOiVUoWMndKhHCiExWLD685edJbipRD6zwlOQn8ijpR+mpBMqU602u7Xy2p+eVAq90kPTls/ewNIPpMfudbZ6UkR59/EqjvZlTMWN8GpXLNATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfc+XKw0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfc+XKw0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74019695377so3654176b3a.3
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672593; x=1748277393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBCXrXjTDhyjjX64tuNx6K2Ig7KE5Z1b7t9P8VN6zP8=;
        b=dfc+XKw04Lh31i1aaLHzXK+BMK3pt+aqehKVODMK48TCICsxCcUjVksyRZZjZprNGX
         sxmy18x3vcD0rcIYwDIdTfO5EzqMpphW81NMNTnmzmbzm06l016CmRTacJjzSsvwka1s
         8IcjkXxZ9f0YTgdp1tPO1A2kGua+reb3M5BKTuA5hFg9eX5JdrtsOqsU6ajgfKgjf2zK
         zYDGBkXs/CcCNcWK/ryz9RlsGpxLL6CYYdCl6ozqv/u79ojjtuSudV/7VPa51c1w0L+N
         wsRjS6WqwZB3A7cul/eA065PoPvP8gsUMj7G8wQWII5289gDx6lN5H7nsohjspgJ1G10
         qqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672593; x=1748277393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBCXrXjTDhyjjX64tuNx6K2Ig7KE5Z1b7t9P8VN6zP8=;
        b=VSMiDnbpivvUXqyZdGw42BSgiN6gJ/vBi0EtaXi616AdhdoZFxDOj2mMOg7Kvm/Dg0
         ihMRCxtvZUr0YWIRFaSXI4/WAX1Z8QhPIpJ55E7tTAxc8pI+9whzP5Ed/aPeuRLW/vGv
         yOGK+/tNVYJAAEliLn79xlQO5yKeMw3+bFw2WZOGvRNINBOlntzGq0vq6YNZLSDUdb8R
         OMvkxhRmQja8RFy06thcTvboYoePD/4EgTZu/EZPZaJBhHE4UOlYlwv1T8eNN4rG+OdN
         i2T/kayOWw0ikTSUgRl7wnrZeg7mvB24OK4Xp0Yvq49+UPr2GdtyCd9IOOvnPcQyC0RA
         TM9w==
X-Gm-Message-State: AOJu0YwwxrLLyPzdERyJY1MCx6DEloJ5wFeiSv+b0yAz0Ss/dh42T2RR
	tkTg0vbSRwcskUtNspi8y4eYfkNY6RHQ0Qw1MuIOV8lGuPQP1LoCaexxsBbhjw==
X-Gm-Gg: ASbGncsqOMgiozH5QC6wt2GfJZVEMyN/XrAdQsXJ5dTcvC+MyN603F6Auq2NKgzcRhX
	oiSotTOcQlfDbay0FemnFHYTOFzC4vDqOjqv5YPz0zeD9JIIyhKwSO4bn/U0VDXXVuTyYKLH7yE
	O18niXF3caAPFKOQCFQHSjsCyht56ElXaoFGa5u7WAPJh77M8cLxnHTJ+DZqz0t8DP6nDFHgRNx
	jBJKIB6m0rShJO2i82jT8v9kvGa6oYN/q2VxzebxIvFJsSTLkbL3FSdzxGEsuBN7+KcIFPZArxz
	UlFkbs0jYEWaLtMq5UU/KpTUKpxxJHVnYYeXO0WND4Gph74EBAMlIqz+bjeGnWmv8kFZgitw4WV
	uAbinStZZmC1LypEwFj4Q
X-Google-Smtp-Source: AGHT+IGftuZR6kC/WMt+zn6yUbsiM8wQE/864BfYSABdDamgsuvBkES8C4Xd3RikFzD70I5UvFsbUg==
X-Received: by 2002:a05:6a21:7303:b0:215:fc29:51d8 with SMTP id adf61e73a8af0-216219f0819mr22685702637.32.1747672593376;
        Mon, 19 May 2025 09:36:33 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bae4sm6401731b3a.43.2025.05.19.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:36:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] station: utilize the AP_BUSY blacklist for denied auth/assoc
Date: Mon, 19 May 2025 09:36:23 -0700
Message-Id: <20250519163624.198865-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519163624.198865-1-prestwoj@gmail.com>
References: <20250519163624.198865-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically for the NO_MORE_STAS reason code, add the BSS to the
(now renamed) AP_BUSY blacklist to avoid roaming to this BSS for
the near future.

Since we are now handling individual reason codes differently the
whole IS_TEMPORARY_STATUS macro was removed and replaced with a
case statement.
---
 src/station.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 71f4db99..2b6a18f8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3522,13 +3522,6 @@ static bool station_pmksa_fallback(struct station *station, uint16_t status)
 	return true;
 }
 
-/* A bit more concise for trying to fit these into 80 characters */
-#define IS_TEMPORARY_STATUS(code) \
-	((code) == MMPDU_STATUS_CODE_DENIED_UNSUFFICIENT_BANDWIDTH || \
-	(code) == MMPDU_STATUS_CODE_DENIED_POOR_CHAN_CONDITIONS || \
-	(code) == MMPDU_STATUS_CODE_REJECTED_WITH_SUGG_BSS_TRANS || \
-	(code) == MMPDU_STATUS_CODE_DENIED_NO_MORE_STAS)
-
 static bool station_retry_with_status(struct station *station,
 					uint16_t status_code)
 {
@@ -3536,19 +3529,37 @@ static bool station_retry_with_status(struct station *station,
 	if (station_pmksa_fallback(station, status_code))
 		goto try_next;
 
+	switch (status_code) {
 	/*
 	 * Certain Auth/Assoc failures should not cause a timeout blacklist.
 	 * In these cases we want to only temporarily blacklist the BSS until
 	 * the connection is complete.
-	 *
+	 */
+	case MMPDU_STATUS_CODE_DENIED_UNSUFFICIENT_BANDWIDTH:
+	case MMPDU_STATUS_CODE_DENIED_POOR_CHAN_CONDITIONS:
+	/*
 	 * TODO: The WITH_SUGG_BSS_TRANS case should also include a neighbor
 	 *       report IE in the frame. This would allow us to target a
 	 *       specific BSS on our next attempt. There is currently no way to
 	 *       obtain that IE, but this should be done in the future.
+	*/
+	case MMPDU_STATUS_CODE_REJECTED_WITH_SUGG_BSS_TRANS:
+		break;
+	/*
+	 * If a BSS is indicating its unable to handle more connections we will
+	 * blacklist this the same way we do for BSS's issuing BSS-TM requests
+	 * thereby avoiding roams to this BSS for the configured timeout.
 	 */
-	if (!IS_TEMPORARY_STATUS(status_code))
+	case MMPDU_STATUS_CODE_DENIED_NO_MORE_STAS:
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_AP_BUSY);
+		break;
+	/* For any other status codes, blacklist the BSS */
+	default:
 		blacklist_add_bss(station->connected_bss->addr,
 					BLACKLIST_REASON_CONNECT_FAILED);
+		break;
+	}
 
 	/*
 	 * Unconditionally network blacklist the BSS if we are retrying. This
-- 
2.34.1

