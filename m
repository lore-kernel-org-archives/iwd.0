Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C67A14D
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230344; cv=none; b=ObpjuEE/Bf9qdAuWWzCkOTN07ZHsEyZRF6L8rQKwutmqr70QMSTgcqEj2bodWNrUYw8Ozy3WtkPCt/Fqz+u2t5dhGyZkLlSZ6gYAlFJw9dp+Sp9CBjIqIDDasqUQp6G8L9TTx8z1fKlKL5oFqw0WVNdKV4j/dXCLYlntVV0mnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230344; c=relaxed/simple;
	bh=646KmK1RvSswNlbzZgSinVPK8Ss1ur7oAy9g1npibwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfMH/pxKjmmb+nVwXLYz/ZCkyM6kcLPN86RTg34vncJanHE2LmzuM0Al3Gb9uxOIVdXQDYvd6xjIKi1ht+kQtn3EVYdsw6oNsqi6qaoYRqseGfye2pYBP9Y+ppSNwtCEhw9HnvSCkaemCnXmPdSungQheuS5dg552yDa4xLPW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtYQG2Bo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtYQG2Bo"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c1adc90830so708748b6e.0
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 10:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230341; x=1709835141; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYd4eAmDozTkDrfe+wGEdypkLGh1/izS9K1ey/Woho=;
        b=TtYQG2BochcsrHfM8TJcQf51tP8u9f72GoEMf4AWONKPqcbba11VXkCwa1nEkdDcuX
         G20XJxXcxUYr7GacvWAtyAr2XBOcjG+6FmZjBXP/7kS3TcDCGcaFsERbTExZJQoXokAw
         AVSsk5xxP93MIB8B0JcU0KibN7qcV+yqlS/PuJcQAN5QPbGe1jsP0CA5uep1NYeEMSIu
         zZQxdsPxtw2YWYY6190s70hb7jtlFDy8e+wZeCZ2UK5eZyRPSL0W8hDsdyQk4/hzw0BI
         j+ISIsUIMs7tEph0A4swoWE479iZbK5EK7c0t5JKAn4PfLKx9j97NW9RPHXSwGlMK4ZG
         TXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230341; x=1709835141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpYd4eAmDozTkDrfe+wGEdypkLGh1/izS9K1ey/Woho=;
        b=Zv27BQ4YDB0a6AXxkSyq3S7SRoGojvIXgJgH7CqKa5SLlQyFFgdP+YlUH9aONs2UzR
         cqO5pm+eXPXXupctSrB+O6sqQ3smlh8znd6nTYLpcOJdv6LIJsxHq5GGdadYL4TKc6Y9
         5okdU/hNPixcT05qUDWBD/Pvrye5DJna2ffozAIeTbFiRRiWdjzKrAuf3rfwdglVid3/
         Ft3EKVxvk0C2nS/J+mQg5ZoGGDPJDSq7XA3njqaSGHj3QMnG2PbW+3YVqhS1XZa9YPxZ
         OQNLtaYadkQiD8iFM9wIEtqq6DKBgUQSqw1XovcxIthymiJP7bdUbT44yxg+28f/euJt
         i2mA==
X-Gm-Message-State: AOJu0YywO7af8xOyj+WyjQrL1FX87kid4PxT0lChakSBKwzwVm6iwpRD
	5Zklozi2klUs4sEKEekVKLsmhTtP5NJkvXTPoQq8lwt8tokMAAS1V+CqY9Po
X-Google-Smtp-Source: AGHT+IFv0YgRmFbHLReRe5q9JdTuNH1UG/hAlKhoIb0SMUp6jWSeHCAWVODRu0J8mFwQ8n40I/vrHQ==
X-Received: by 2002:a05:6358:4411:b0:17a:ed6c:3f0f with SMTP id z17-20020a056358441100b0017aed6c3f0fmr3166259rwc.22.1709230341412;
        Thu, 29 Feb 2024 10:12:21 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b0068cc0b46682sm994209qvb.4.2024.02.29.10.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:12:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] ap: check that the last band_freq_attrs was set
Date: Thu, 29 Feb 2024 10:12:13 -0800
Message-Id: <20240229181217.1503555-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analysis complains that 'last' could be NULL which is true.
This really could only happen if every frequency was disabled which
likely is impossible but in any case, check before dereferencing
the pointer.
---
 src/ap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index bce389d3..ee3c4dca 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1247,8 +1247,10 @@ static size_t ap_build_country_ie(struct ap_state *ap, uint8_t *out_buf,
 	}
 
 	/* finish final group */
-	*pos++ = nchans;
-	*pos++ = last->tx_power;
+	if (last) {
+		*pos++ = nchans;
+		*pos++ = last->tx_power;
+	}
 
 	len = pos - out_buf - 2;
 
-- 
2.34.1

