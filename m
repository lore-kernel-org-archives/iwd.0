Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64B134BD
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704025; cv=none; b=qdaW0z63zMjDnXYaTW2nGM4wPSPVYPeW1ho8Ci13xh6xzsr9miSRB56SjG9LxU6l9bOW9bloS1cDNCZPEp1M2iVt4h0KAy0XxhNCO4DosvW6Cbo/tPHfirdkjOt6HWBGzOokMihnuzeQ5dBuaWA/nU3acS6xkHTMY6yLqXkBtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704025; c=relaxed/simple;
	bh=5JaKa7XswDeLp/H7eDcv/gbdrRBQy8+VZJgXy5jvH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYb81JDx2HU2KSqUXwOIISV3o2ZiK5fQ4s0E3OvlUVGr9f45WH0QvnoUQHcA6SR6066YOTBlwX3i2CT7YTjIonAmcnqZfrowXkqYomwNSorez0PzDt/3lGLXmI6e4jJAReTLC1Vvx+OLB+clHTw66CMUnTUZCO3ljz+23ue87a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnxLhp+g; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnxLhp+g"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f103b541aeso1008067b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704024; x=1714308824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1ZoSr21MYoeKBvlARhQMn9pEsip9RAifE2zpohqtDg=;
        b=KnxLhp+gyS+KTGGBgRW5kTcDyramM2LWj/ncupL/SiBR3pfCz7yRzCv6xlKIIr3ihg
         faInbvEXJOna3EHhvANs/sh+nqPTN7L2qIHlAgjFLw/07aOkEQlublE+WyR+X53DhLG8
         L6TZ0A62MGNU5BfYQXLbppFfUwZNtOdJoQDTi7E9kTP7mE4GDtfk5VQRBZ1PLLfIjcB/
         1B6qKq4R1jIbORUvoMPzle0P/zPKCh09xV707CEF3MGQn1+ljfEnSwv2z/YaFkGM2N1w
         caWsaKtnjxfLX6c9QaQYs5D75/tvfsfpUTBXmpmH5vuuXNtYIq2/2kYdj9E+7HygRHUv
         GiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704024; x=1714308824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1ZoSr21MYoeKBvlARhQMn9pEsip9RAifE2zpohqtDg=;
        b=m2U53bloZK7uXa6nLUsi+kHyPxq6HXBRNoE2JbCHrOqrkA7wop1rK0BI0KvQEESSdQ
         WuzTabJ26LUCUpznq+Fugf81pk1HQRw2HnU0266ubAgZg7BTRyohbT0iPIbmWEZJf9cN
         fLMsq9XTc/i9rl97AnkgKW6qvTvK8Yp5I01/7HWzNDjuPFKi7+x9tZsPlDEv9SjpE2Qo
         Lyrv7OEb7wC4+lc+Jl5gdjXuCNRUgRejHHXL5SfVO31g8riKVm28Z65Uzypj48e0UFEA
         9pA2KbaLGHEvATaMEcrcE5l61QtICgHpQeVg91elmpeRFeG1QxOjMB0P8qevZJZH+aEo
         6/qQ==
X-Gm-Message-State: AOJu0YycxNQBSjnGCBNP2AMLOyl0W+5QVKgVJVQRX/IwCtHpq0nbzTpB
	W2/YfamzpzLUC3zn/RoAV66IzdDZQuDEOmnirmnrg8RGAZZHsUz8vl4JYbALcLM=
X-Google-Smtp-Source: AGHT+IEOgN2XBz/6q6YmJ1Hh6AGeldaBnjo7Z1e/RJUjf8QHW1DpXW3uf/6ISJZL3G6f55wGGCUNOw==
X-Received: by 2002:a05:6a00:2e02:b0:6ec:f84c:902c with SMTP id fc2-20020a056a002e0200b006ecf84c902cmr8934966pfb.24.1713704023821;
        Sun, 21 Apr 2024 05:53:43 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm6114686pfr.38.2024.04.21.05.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:53:43 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 06/11] sae: verify offered group in AP mode
Date: Sun, 21 Apr 2024 05:50:36 -0700
Message-ID: <20240421125050.6649-7-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a Commit frame in AP mode, first verify that we support
the offered group before further processing the frame.
---
 src/sae.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/sae.c b/src/sae.c
index 2c97d94c..8a1e311a 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -214,6 +214,18 @@ static int sae_valid_group(struct sae_sm *sm, unsigned int group)
 	return -ENOENT;
 }
 
+static int sae_supported_group(struct sae_sm *sm, unsigned int group)
+{
+	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
+	unsigned int i;
+
+	for (i = 0; ecc_groups[i]; i++)
+		if (ecc_groups[i] == group)
+			return true;
+
+	return false;
+}
+
 static bool sae_pwd_seed(const uint8_t *addr1, const uint8_t *addr2,
 				uint8_t *base, size_t base_len,
 				uint8_t counter, uint8_t *out)
@@ -1029,7 +1041,8 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
 		return -EBADMSG;
 
 	/* reject with unsupported group */
-	if (l_get_le16(frame) != sm->group)
+	if ((sm->handshake->authenticator && sae_supported_group(sm, l_get_le16(frame)) < 0) ||
+	    (!sm->handshake->authenticator && l_get_le16(frame) != sm->group))
 		return sae_reject(sm, SAE_STATE_COMMITTED,
 				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
 
-- 
2.44.0

