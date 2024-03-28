Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF814294
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635986; cv=none; b=QrTx9pPoG7wqTVFbv0mjMVZH713h6kAsKB7QDuKa0lNwbBmQ7BHun0uREEprRwzukMtiUBCVDXWEredVo70fWhGVGwHoxBa7W4jU3WghbDTDXKSbGhrG+686GKjAFgdemVuF+3lKhZgrd93txhoRNtlkmqem4gFNIULbafOMXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635986; c=relaxed/simple;
	bh=jgeUEzg2kaUgbJEfU4Qff6iM+sLQ4Ep0ug7ZdG2tQPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/hnNe1+afwYX/ewLfVLk/PAuxJmPQjlHXWwRA+PPUAd0FLxcAvY/ks+tWfp2sJt5CsZjxFfFwDlqSY7J/x4EHrIW9prngEUgDeyIoqZmzu2//vR7FwCUN1tzZc8CZrb+3JllY60aH7vAw4y3ZBWUjtMeHWRL9woBlUeB1QWabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmdDEBRd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmdDEBRd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6c0098328so847984b3a.3
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635984; x=1712240784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6/LQEbj47XgO1NSTRnIcQMXt+T1PN8lsmLYGnxkXkg=;
        b=YmdDEBRdc4KD9d7OyPNDyFAhvnqgdnVOLTL6m+iSSRZkldKE8LS/qnwVjDFYN8u/qQ
         iixEyNSYgSwI1QrZlCv3994yk2pnEKlKTSdf4WFPoWdngUQNDaL/vOxgp9bpqSrg/Bv7
         BzPhdswMlE/H7GF/uSdfJBuz9pYoWNP0L2x0Pt3FnhLsacp6970A17P+sAauG6KT+Il/
         YWhNckD9q60EwOw1+Ma7J4y0f5RU5dsBuu4g548gO6WiQI6CFgCuAdk/Vy3AngLr8FDE
         6u+FX5pQCSNIVB4OSpfAge692M9K5XeI0cvt4Z1RdbUTKl4rrpjrQvp/pT9Rw4ObxTux
         vpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635984; x=1712240784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6/LQEbj47XgO1NSTRnIcQMXt+T1PN8lsmLYGnxkXkg=;
        b=vYQ44UCspvge47xgwzW9B3zN/zyEd7g1M/5Rd4VePS/Fx6K4BbyAB1jvqesXe2jP+e
         qf5fURKhK2n34oBmOcg8h2kv6uEIOtzGRahg1xbFQH4GYV63aRNcMXj/yKDTrHvluJZw
         /Z5/iz+lswIQ8aDttymvPUoM6LIshU/pvXz5HZKYowSe3vGEuS7IUdykwkY5O5h3Rjok
         2A3rmJgbb/LSn/nasgNPpY9ESx5lKqVFg2czKjfRZa0rujdKZ5K26Na1vIBvwcf6WXEf
         65m9rVSVJxOZdLk/hoqZb5FataKiSrsbrHaxbPLdSFCLq1gWgo/QAmi5UIY95kVUXN2N
         BWYw==
X-Gm-Message-State: AOJu0Yw2QnNeE0QNUgXr30eQ23n6jK+rjFIZKnw1XVYOJDLneJdncEuq
	+yAu4qux2QYVpHMuD5rTDuS0AMcpP6BPFHb+PDY54gbZ+O5QcgzHHxgfciL/
X-Google-Smtp-Source: AGHT+IGD/unRKVryyictJA0hgQYp5Rev8PQ6KGN3pDHPQObEav73ZzUod0+6NbIgEL2AkXx7hhfzLg==
X-Received: by 2002:a05:6a00:23c8:b0:6ea:8775:a66d with SMTP id g8-20020a056a0023c800b006ea8775a66dmr3658491pfc.1.1711635984059;
        Thu, 28 Mar 2024 07:26:24 -0700 (PDT)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b006eac81dd456sm1412457pfi.36.2024.03.28.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:26:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] band: make HE/no-HT rate estimators return more descriptive
Date: Thu, 28 Mar 2024 07:26:21 -0700
Message-Id: <20240328142622.1490115-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the IEs were not provided return -ENOTSUP rather than -EINVAL
or -EBADMSG since this just means the AP doesn't support those
capabilities.
---
 src/band.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/band.c b/src/band.c
index bf40f789..11cd965e 100644
--- a/src/band.c
+++ b/src/band.c
@@ -90,7 +90,7 @@ int band_estimate_nonht_rate(const struct band *band,
 	int i;
 
 	if (!supported_rates && !ext_supported_rates)
-		return -EINVAL;
+		return -ENOTSUP;
 
 	/*
 	 * Start at the back of the array.  Rates are generally given in
@@ -607,7 +607,7 @@ int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
 	uint8_t width_set;
 
 	if (!hec || !band->he_capabilities)
-		return -EBADMSG;
+		return -ENOTSUP;
 
 	for (entry = l_queue_get_entries(band->he_capabilities);
 						entry; entry = entry->next) {
-- 
2.34.1

