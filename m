Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775632D42B
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253705; cv=none; b=SpaByQOjiR5MDiaA/YRapUAZ4GVk7Y4Kk2mDjBibA1Gk7bM3xQImwqCP2Seeg9N3oqPEUAVSoc6XbHebnrZgQrBiLnKp+Lzz+xDZTDw8ba7YF1hIBjS2rpJ3zkPX9ZuLJ2DaWJAy+Rs43zEonvpqw5omlIQdfCJQ4rZVBYQp3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253705; c=relaxed/simple;
	bh=HYrM5caICRUX+2rNRet/5Kgts34ZKqBnFlZMkzVitbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiR5hd/wrWqec1biW3eKpEi8R9sHYrZ1oprnLOeSORtwpSYiPR9KW3kpTvyI+ovA7ey03buukHioolyalx6epqZfSqIGUaV5hvUF41XwK1ZU0UtSwxmY/piiU8XMfSTchhHDinw8MopeCsspSqYWfkbBnlh3ErQVcwfNBmmpLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svuKCjVU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svuKCjVU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so29857541fa.3
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253702; x=1785858502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=svuKCjVUYG45oNIGUblB6yuwakmi8l/wXxh9cI1morOru3pP8NcziHCxfy4Nra1UxD
         7zthv5H5oeZbu9YwwrElSrm2r90YKtFb/3bDTqD87rgi1s4Q9GNCthV8NAwyEr1aKdQA
         hOLX2mIOSceUOkOl2/kHrYOWbUjWwjGk5JG38R+4BoMwy2dSLd4FyVo7U+en5SKsRbD7
         RFrIOTQ7PMmRN3VawlbQPIfGA2WGz1yZVxkET9t+7+XZ0+ZT0DNxRG3amu5ummNKr4Ba
         eK3+YExRJbs9mElGQIeGLaOiud9lttmaK79ZmFllbiDB9yu+OBTnpvZajtWZudd2cm99
         Es+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253702; x=1785858502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=ikODiTgTRIr1L7ZL9U93T8XzqkAi5R6f4Xw7ck7QppDLWg+OZwY+odpf+yNFaOUAkX
         eCHJosVraRLvSOovwHOavgxKbfwRSKtEmr1oY6XCWsLw+o7Di4wqJfDz5XefQB9V73C8
         4/qFTHdBPHkMJpCjL1JjL8ehHztvxQUm8Z7AT6Ll7r+WxyIGAIRtCOQ4WpBEgaN6U2Vx
         6H49+ED/KV9xyjXjFwlLUmzhdmPyjBc85OWkTCXj/UXZYymsSIWN2VSA+0BgNpWin98Q
         bHDEsm5b2ing74vebi/SNJ7dWaC1FvvYukIzkshPPmar9p5t9nJA/DGZXvkXy/w5QP7l
         INzw==
X-Gm-Message-State: AOJu0YymYb5yDm1sHjsDQsmkSiP8NmILXrl/8ueEFcOiIxM66L9k0Kim
	V/sS/LP6svXP9j7P8EW4qIqX6iAV5pAY2rPqW/sp9lWzLXuvDyKt77RH6L2EAUk7tSXOSA==
X-Gm-Gg: AR+sD13dB7riy+cF09F+lVeXI7v7SQa8zOa3M0NV0hNXh3g5C27lL5QYqlvDuiiJ/XR
	e+HS3tpjuvndH7cue4B6tAPMrW3JPaa/MHxf9BHPOaaPEcNYHO5bxOgvaMPqT4x56v235YUsRrt
	WtGaZyt5maQ0+1/6S3udY3t+1M2MdIoHG2ke5+oCc4D+15yFLsV67PHODTBu4rPs8aw5N5Z99P5
	sH/ouBVfqiZXcnNQdVHmeiUd13n72esbaZQHayDXXo7lyYJrioDubzcjGwaphJ2jrQI104Saf+h
	mANH2rE+18t/+GVw7bAr4TWcP3wFV1T/7zxKbaHQiEIbUNcULkyy5IVQZJWqnT5VzjlTQuuBroZ
	C+N0u3cGpPoS1xkkHLb8cBf3Ms37axynHtEy+XozMDtiv4YllJrM7VRFFLaKCT+RbgsKzttRDoI
	v4+ulfhz4=
X-Received: by 2002:a2e:a902:0:b0:39b:1447:b6b1 with SMTP id 38308e7fff4ca-39f51ed9f1bmr5821761fa.36.1785253702141;
        Tue, 28 Jul 2026 08:48:22 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:20 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 2/5] doc: document BasicServiceSet RSN property
Date: Tue, 28 Jul 2026 18:46:41 +0300
Message-ID: <20260728154729.3485557-3-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Describe the optional RSN dictionary and its KeyMgmt, Pairwise, and
Group entries.
---
 doc/basic-service-set.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
index f827ca02..b4f2486f 100644
--- a/doc/basic-service-set.txt
+++ b/doc/basic-service-set.txt
@@ -8,3 +8,26 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 Properties	string Address [readonly]
 
 			MAC address of BSS
+
+		dict RSN [readonly, optional]
+
+			Security capabilities advertised in the RSN information
+			element. The dictionary contains the following entries:
+
+			array(string) KeyMgmt
+
+				Key management suites. Values use the same names as
+				the wpa_supplicant D-Bus BSS.RSN property, such as
+				"wpa-psk", "wpa-ft-psk", "sae", "ft-sae",
+				"wpa-eap", and "owe".
+
+			array(string) Pairwise
+
+				Pairwise ciphers. Possible values are "tkip",
+				"ccmp", "gcmp", "ccmp-256", and "gcmp-256".
+
+			string Group
+
+				Group cipher. Possible values are "wep40", "wep104",
+				"tkip", "ccmp", "gcmp", "ccmp-256", and
+				"gcmp-256".
-- 
2.55.0

