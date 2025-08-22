Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFB2BFC85
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892290; cv=none; b=XvwWdjaZV/PSZ8E6KDTSSuao8LJezvlmUevuvRfEInw3Mlo7ZvKVA6Vc61fTXgdSHW/vmSSFw/1F8ehtYb3QZ0jVyL8HkQouu3p6KXpx3L9uyo3IA+yt07ZMlAtxSj5+bzMBztdyq3QRono3XLFGY+11bGcLZFM4eUGGO4N1dTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892290; c=relaxed/simple;
	bh=zHodGmiACMKtja2sI/c2sx2Ut8iWapasDNDjjvcev3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Syc3MpKlKTfaRQtnhzVjiUJYJ8EpTF/e9OsQzWK8kQ4WTMrXvqNSqXacrq/35/GlWcNfdQ6BZ30tG5C82M0zsv3XArLcdrV6W/2iEd9qkGwXf2PKCrLpfJPOgsKAZ2T7YRR512IX5cFE63daD378ZStJ9aWGVSR9ZWW+KR1FoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFl6zFxO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFl6zFxO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87035a7c3so344651985a.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892287; x=1756497087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HciEYYMFw8TA78Kifuwd8QXml8tIhdpt77QYIaEDuow=;
        b=iFl6zFxOwPxGby9P81i2Ha1sWjX8KxMiZ9iZ+IKY+1b/in/Zuk/p6fuGhmsPwMjYeC
         18q2CErgoWfF9sTkhdH6N4azJ4s66PIRSqszNJYdVUEoJ0Av7KQcyPKrxpEtW9dXo/EL
         C1tjjWu+N2Q1jVT2E1PpgYFdodaZllprw84uOze2oKm7ssMjlcRjEYL0W/OX9288TxOL
         3DDK80pcxy/9gAJWFiBgRe+ljoD7/flKh+bXs91aYlS3eEJevgkhp8PPPFL4YSUcLyGW
         ATG7vFCRrZSKmv7KqxCbpqshN/3pwd6qriU9bS+avUpxVZqpxRqyBCFpffk3PFjDDCHp
         gXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892287; x=1756497087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HciEYYMFw8TA78Kifuwd8QXml8tIhdpt77QYIaEDuow=;
        b=NvRzEfmaB6P/BfAMzrE6H44tieU3cAa/b6IJCfN8bg7IZnb6i+EWBlscWasiipX2QA
         4WK4C3UYOOp3KJuRWZVQJiV5j6ygzfbQZCyCDFnMsfDeOJ4mBBo10MlV1cm5ZHuEHKUj
         b4FJyhOHqaT25CyLSZx2wWVUCGHZagWaOv4MR18zaiFCxxxfiD1rGqI0Y0SIsZZ+y1gq
         GC/IlJDez3lToRb8BI/LY4VAwcV5UTJTc9f1RLVj+qkqU6Zy0ot8gXKdt8f05RubhWfa
         op0zmX2fXLLNR9QRVj/BN9jHl/TDaotKjFppRM6swK6DOtZRHcNk1qmgXhxzUD+qOLKn
         K/Jg==
X-Gm-Message-State: AOJu0Yzq32CUzv6zZ9Mu0plNs0QVgonkx7gd0iECAsTwH70QmREOlKEK
	/1fTrUCyqVgr8jH0BuxOEdKjteGG8cKl5unbWY7Kq7VbY+41nidsD42XUSZMXQ==
X-Gm-Gg: ASbGncsb0fFpxM0IYcn1GCRiTEGg9sqW3YvdNFAekLW2JOTL+Gnk3PLd8SP+Mx5XDI6
	GehRxJDJ6YXhyx+m6aOPZU62aZHmZRjRdgfO3Q8nDX03RjTuIStAUtA3FTACJZmQ9pvXbHr9lPF
	jfS+lNGghBDBgW5apAEp9N4oeV80OPd0GX5RG+Bxm7Ll+cXDvJ6ANiZLResKOlR+fa7m0/ZuQD6
	yyz/LWLaToRahYw6TLIHvDrPeSSeKvktmr/vc3tlwCuxvdQzq8F7HciJhbxsW9XZfw0PAo7ZBYu
	RniDCS5e+d3aotUyYEi6k1y98KRQtLLEz5pczEzE4rnfawuzJujDnxAT9hkY1nS7gegdEYSPVCe
	LwUNNCDW96OG9FybKurFnxh6etgmJBZdMAH8Qzs8nP78=
X-Google-Smtp-Source: AGHT+IGET+Uk/rp20PEcy6jahANLzo1X3b7FzmBUWbYl9QAzEUruPD+ZJjNf24fznloFFH/Dr2Ra5w==
X-Received: by 2002:a05:620a:390c:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7ea110688bfmr531396685a.50.1755892287623;
        Fri, 22 Aug 2025 12:51:27 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/15] monitor: add Cisco Meraki as a printable vendor
Date: Fri, 22 Aug 2025 12:51:07 -0700
Message-Id: <20250822195118.271122-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 7924f6f2..65437dc8 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -404,6 +404,7 @@ static const struct {
 	{ { 0x00, 0x50, 0xf2 }, "Microsoft"		},
 	{ { 0x00, 0x90, 0x4c }, "Epigram"		},
 	{ { 0x50, 0x6f, 0x9a }, "Wi-Fi Alliance"	},
+	{ { 0x00, 0x18, 0x0a }, "Cisco Meraki"		},
 	{ }
 };
 
-- 
2.34.1

