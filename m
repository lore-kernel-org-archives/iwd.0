Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5419F461
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179508; cv=none; b=DhAiery0S0ycEl7g9yeLD1Qw7NUJpHKhy5arZoiuQLMEAOBjVHfVYCRB7ixypROZp6oN84X1Zn5VE9FA29zKBLB7A1hKgKpXnmOVuOu66d1BaIPLk1vNYWMLThptNS8dKdfDiGbeDguu+MHY8wApGJC2mqpcPsO3WJJuvhXI5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179508; c=relaxed/simple;
	bh=G+L82sQPPxrEqHgqh5jXmNuPooVV+zU+PCd3EsCfQdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKTISB/SmPAelCdIVgaU3hi8S5SxU8NFkm4hXmzHhn0/U16tACQmWM6J96VJmajA7yxKlFjc2s0hNUFTixJibh4tpInA2v3bSeQ05XIGQQty+IdsxXgt85G1GS0P5v853BNFQEX/IkghyDfa/424Tw0xRfXnsTUlAMjqSZ41tZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3e28qnw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3e28qnw"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c3567a143eso44528196d6.2
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179505; x=1727784305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az0dXyE+Pl03OZ00DQO15WEsqalnygBrkTisyrdcAH4=;
        b=S3e28qnwiZgmsDk1KOObIFl9T4E4JC3DgPWIYyAmFof9NnpullihLiJeLMHavbpEcx
         DJgyRXN3xn+a9rMCeJ4bY+m+nvd3W95xSpGuGoLKz/jZVW8rUwmqcEfcYApe+PgZpL5g
         crLfzR9P5zUBY9uG/U8Nu/BkZKsr6zT9gF4g5GtEMh1Vtvf9W11mPM7DVCwxEwtJ5KcP
         +7r+Sot5LGc7W3dtG9H4Mf347zFsdbLOIBkbCHAZNXSKEsz1Me+6N9+ZPOEaMY3ESSSP
         qSwQzogQ5b6K/+GRaIFjmwA8UYFw2g6TVE0gDknyaWks0NTtvezo7Pub+Q1iBTeIffZT
         TqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179505; x=1727784305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az0dXyE+Pl03OZ00DQO15WEsqalnygBrkTisyrdcAH4=;
        b=OLYQLRrcOaKNek3wN5BLcYMY8gSSm31P0IFgOjHi1OttQzI8iVvhEnefA4K/fjBkOJ
         VOM6pZjVf5dxV64ZCI23udOkC42vH0zD8CRxLhnKK9oDPiOWKW+D85IaXnbiyS55dMai
         lrLN7d8oVkolLQp3I2l09JLa05Wj9/XzjeeKpxZfLCCkzCjQ8OyeO/2Xa9zR5jqdb8yI
         kaUlE7UYfP4FHz+yh/hse+NEX48lI7fbQlT/TVfoPnORNvkNyYsEdQJNhURR1CRT3qqG
         4QEmV+Gsx92qrl/V46P6pi+R9qSwQ4swLQkBOHuEkh48b0D0IQ38YGscyPOQ355GA+U/
         4+TA==
X-Gm-Message-State: AOJu0Yxa4j8IUaOeRnkLKrvVAWwjMICP6s8Q3p7fgwkpo2TFIEHvCoW0
	k3tMoJbH5K42/p7VRQluj0Rneb6xIZRhU1SG9ncqVJKxbvtMoFAf6d2e/Q==
X-Google-Smtp-Source: AGHT+IHVpe1CyPTb9Up0xhn4Dcoaobz1WzdbF6ehulwbjGcUtGmEVlE63oPtBpc03Dhvdt6neR9SlQ==
X-Received: by 2002:a05:6214:448b:b0:6c3:657a:cbb9 with SMTP id 6a1803df08f44-6c7bd59bb2cmr270423066d6.34.1727179505174;
        Tue, 24 Sep 2024 05:05:05 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/16] dpp-util: check the AKM is "psk" before further parsing the object
Date: Tue, 24 Sep 2024 05:04:39 -0700
Message-Id: <20240924120447.251761-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dpp-util.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 62db2081..2e4b181b 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -196,6 +196,7 @@ struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 	_auto_(l_free) char *akm = NULL;
 	_auto_(l_free) char *pass = NULL;
 	_auto_(l_free) char *psk = NULL;
+	uint32_t akm_suites;
 
 	c = json_contents_new(json, json_len);
 	if (!c)
@@ -229,23 +230,28 @@ struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 			JSON_UNDEFINED))
 		goto free_contents;
 
-	if (!pass && (!psk || strlen(psk) != 64))
+	akm_suites = dpp_parse_akm(akm);
+
+	if (!akm_suites)
 		goto free_contents;
 
 	config = l_new(struct dpp_configuration, 1);
+	config->akm_suites = akm_suites;
 
-	if (pass)
-		config->passphrase = l_steal_ptr(pass);
-	else
-		config->psk = l_steal_ptr(psk);
+	if (IE_AKM_IS_PSK(akm_suites)) {
+		if (!pass && (!psk || strlen(psk) != 64))
+			goto free_config;
+
+		if (pass)
+			config->passphrase = l_steal_ptr(pass);
+		else
+			config->psk = l_steal_ptr(psk);
+	} else
+		goto free_config;
 
 	memcpy(config->ssid, ssid, strlen(ssid));
 	config->ssid_len = strlen(ssid);
 
-	config->akm_suites = dpp_parse_akm(akm);
-	if (!config->akm_suites)
-		goto free_config;
-
 	if (json_iter_is_valid(&extra)) {
 		if (!dpp_parse_extra_options(config, &extra))
 			l_warn("Extra settings failed to parse!");
-- 
2.34.1

