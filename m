Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1615957D
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795426; cv=none; b=Ps7U926lnYM4EVnEtMmrgoD+Ge1zk+a4T0N+3mau6VfBPYfBPtqpwnxCk6i2250/wJRK/i8GofrZA5Q1dyrhhAmK5LqMFSbUNOvieLU73bTF+u6+6kYFaVp13rdTd91eQSWVY5HdnFk7/vAPA+3KTUiiwfURJA72G48imDFDrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795426; c=relaxed/simple;
	bh=aWZf5BZ+gJrzy2D0n1Nj0FZYfEulOHc1zL4WlJpvhC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRnoCxSuXWH8DC21aDE8U6JN5SVwFMz9jhPLjUHAvROsf8LcKIEIQauHjIRr7QftxZuPZsP8Ogvzk3a+YGFBb9jFw/5otgyGE98m27sTA/astipZryO/vKch2DKk9KZQ9NRXe/kVs/bayMQMjjOwX/PDKXZpGnB4ztgafUINXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhd5VtOX; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhd5VtOX"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e612437c09so771775b6e.2
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795423; x=1730400223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8T2BlYDnTx14jdAyDmjwkwpNbG5iqC/fFpU4falIY=;
        b=dhd5VtOX7+K2YO87fNqV633Lf/zc5bNp2ubTDeEvLb45Q+qI3bkrfnFeZ542atqX2S
         fatxck5vgmXHgDfoT1EkwShd9nfXJt94DTYJqJPKIQfa6J3cegyEHRqj28990r4hQdEw
         frLtPzal8jRelFz7JJ/+spPfCksTyDAHYjc/DoIoIn0tpCyK5e8LHbkxQzz7LL3JDTcA
         f6dB4QnssYfXbOZZDwCCPufghH5Gq6FWuelWbC2nTi0sizyHYhYJ+gTc7K3VgAXiiDgT
         E8ZE0L1LUYeMBf9Dbph6iLWHM6hkll4REFb1aDUWdqAGQjwmqkd+Ljt2BOMwHtQ2L2bb
         PeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795423; x=1730400223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy8T2BlYDnTx14jdAyDmjwkwpNbG5iqC/fFpU4falIY=;
        b=ZqJFowEn70rzysG76bYjUzDPdwXmxVrsj37SsP2SLL6EySW5q1w1D4GCWMQLOVP3Qo
         RUYN2bvEpMTIsRI3kEz8weOkZ6lZUq8Mhtln4GC+HGDacLyOeLFt5bbcn60LQioMqSJn
         Als+NW39zdhwUMPunNKgsJSMH38JHuFQgz0TiCDQGmOJItogMc4ZbWddNC0yDy1NdUOP
         16MyoDoHYcS86jHol08W6g0Q8updJ9TYg2lEaMpu/Zy1ZeAtL0XblSxGxg5RuHM16VAW
         N0TvrilzH3ERPHWEaQhA1Au0NLm6mvIRUJ/0A9I2VDw1nEuy6APQMyhUEL7pKtodTpm5
         LdcA==
X-Gm-Message-State: AOJu0YygiomuPm/p51Q7HlFozExRBmdIBJ/0KcXdegtvO+nFTvKgxk4j
	kPz1P2YIuLknCU0Hg7rHlBqZV7D/aybwLeJEP13ct1cbqWgEjTLQOouFYA==
X-Google-Smtp-Source: AGHT+IG/Uq04mk5befYrV8DgkGY/eZSwFyRJWN7EaJRc9hgwokwSN+Kemf4VJQzDEX/2jp4SydhKKg==
X-Received: by 2002:a05:6808:38cd:b0:3e6:773:c99e with SMTP id 5614622812f47-3e62452d03bmr6506509b6e.21.1729795422935;
        Thu, 24 Oct 2024 11:43:42 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e26c2sm52954116d6.121.2024.10.24.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:43:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] unit: add test with list of known unsupported frequencies
Date: Thu, 24 Oct 2024 11:43:38 -0700
Message-Id: <20241024184338.186018-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These frequencies were seen being advertised by a driver and IWD has
no operating class/channel mapping for them. Specifically 5960 was
causing issues due to a few bugs and mapping to channel 2 of the 6ghz
band. Those bugs have now been resolved.

If these frequencies can be supported in a clean manor we can remove
this test, but until then ensure IWD does not parse them.
---
 unit/test-band.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 606bb854..edf1e02e 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -683,6 +683,26 @@ static void test_conversion_fallback(const void *data)
 	assert(band == BAND_FREQ_5_GHZ);
 }
 
+static void test_unsupported_freqs(const void *data)
+{
+	/*
+	 * These are frequencies that were seen advertised by some drivers
+	 * but that don't match any global operating classes IWD has. They may
+	 * be valid, but IWD should not parse them correctly without added
+	 * support in band.c.
+	 */
+	uint32_t unsupported[] = {
+		5920, 5940, 5960, 5980, 6000, 6020, 6040, 6060, 6080,
+	};
+	unsigned int i;
+
+	for (i = 0; i < L_ARRAY_SIZE(unsupported); i++) {
+		uint8_t channel = band_freq_to_channel(unsupported[i], NULL);
+
+		assert(!channel);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -750,6 +770,7 @@ int main(int argc, char *argv[])
 
 	l_test_add("/band/conversions", test_conversions, NULL);
 	l_test_add("/band/conversion fallback", test_conversion_fallback, NULL);
+	l_test_add("/band/unsupported freqs", test_unsupported_freqs, NULL);
 
 	return l_test_run();
 }
-- 
2.34.1

