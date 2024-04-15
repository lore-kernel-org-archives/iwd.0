Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3D155A27
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209397; cv=none; b=Cn4LksU+/JZX0HQTYeQ8lwKlyTmdCzylQsrNcYOV3l1FoaOlQUZG+EtKlKwpHyIQqplqNutFrtQ11t4IRKc6tQnwY5xG0CeNVIkkifO6eFsEYfPEOzHgaAqu85BddNrrh6OeOdTJK+nvZWVERp6dTZrtjfgUOWyRhmIMe9FEu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209397; c=relaxed/simple;
	bh=Iy+ojwGdkv3SyJuGE6BXBA19Hq0UUnfSW4oo5EqztpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0nME5OvW+R4U0Qp0/kJ9ZGx1e7dPLQk/5fzJdhj35N2PzwVYILR1l33yRxfzqoHREcnFpJbYTd1/jV5iR/r7j/AU3xRoIpm4UUtfRfAd435hd4Wws+wqGC4qtIn+ulZEesM/JPIox14i7VjsnLNBUxgOtKbABvdFbfkG/+HKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKUPNRA8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKUPNRA8"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78d743f3654so344637685a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209395; x=1713814195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw3PnF0pewxK46H6PlI7dMmkCXgs/NL0bnDpvMH5PFA=;
        b=mKUPNRA84Tj9fcMUb5wFSlxru6TijOfok+xqa16nh5jACw3evrYGEsQJ0wPWqTq6k1
         MMRMqN+Mt6DnuEvG6HzX+9mn/YioU/0EthK7LIwxU8RdZcly6vD09E0S8IK+0af+6FWO
         /iR6BgARDLW6zemfVftZrh/hRriXMbB2XdvifatrwG7n+3grfqDKyQBBa3rRI6+7ykQf
         L5b3CGuYaFgrl3A7Bmw1JNtLXbFmKrfV4c4CPoJMj9J5vP1Ku/0NyTZB6x+kpQqYG9PQ
         jQJ/rj3E+o+klAkA97BSwVOeYmf5ICYYQIheGDOPe/wLW/Pyx7PmIz5eXe2aLun/u6SH
         VolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209395; x=1713814195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw3PnF0pewxK46H6PlI7dMmkCXgs/NL0bnDpvMH5PFA=;
        b=FGo/fuYjYoTCwGLb/2EDbwtds6TIaTMYFEtcCn105SOo0rPmPRkRbQdG1X9M7xIL9/
         eD67QXRTeyUHZ0C8MZfFF2rh89x0m4opR2iqLaXNt38bQp4uuibxHHV4LhBbK8zMe1vw
         WPnYm6MxaV6Y59IzX7OnzPzFDDOgB49tEJqQLXTahhrSVTL7YSOsBbAiUMw2SaVn9rM4
         szblgjtbjGDcTSWggFWK8qIoQJ5x5ZXBybmajaN9rNjZL48GbYi7gujVRnonPD2xxYV5
         vIA2DWCTKKdzJu5d463rtZOnZjApTHn4k2+HZ5PYcnCg3M4fmLpYsLc9twqr0qLsqkGG
         Apmg==
X-Gm-Message-State: AOJu0YxZk8qKsDPFZsyX9t4qnhjjk2NPLR8IANDN1IIOrPxEDjJWxPZS
	uD7gMsVh/TslV8IiPkzc+C0dChGfvZx1KzDZdfl8terz/QBGD9HTigInvg==
X-Google-Smtp-Source: AGHT+IGG+Y2vU8N7Pl4HS1o2FNnpTCbKxIAd7VeG6RD4LmScZapqDznpR3qde4AUm+T+ZXhiSXs2LA==
X-Received: by 2002:a37:e116:0:b0:78d:58bb:e183 with SMTP id c22-20020a37e116000000b0078d58bbe183mr11079747qkm.63.1713209394967;
        Mon, 15 Apr 2024 12:29:54 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id wx8-20020a05620a5a4800b0078ecd71114dsm5003499qkn.69.2024.04.15.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:29:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] unit: fix test-band with new rate estimation returns
Date: Mon, 15 Apr 2024 12:29:48 -0700
Message-Id: <20240415192948.65857-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415192948.65857-1-prestwoj@gmail.com>
References: <20240415192948.65857-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-ENETUNREACH is the correct return to check as this indicates either
the RSSI was too low or the local capabilities were not compatible.
---
 unit/test-band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-band.c b/unit/test-band.c
index 8140b272..855fb67f 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -444,7 +444,7 @@ const struct he_test_data he_all_mcs_unsupported = {
 	.freq = BAND_FREQ_5_GHZ,
 	.rssi = -20,
 	.expected_rate = 1201000000ULL * 8ULL,
-	.expected_return = -EBADMSG,
+	.expected_return = -ENETUNREACH,
 	.capabilities = {
 		.he_mcs_set = { MCS_UNSUP, MCS_UNSUP,
 				MCS_UNSUP, MCS_UNSUP,
-- 
2.34.1

