Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A25155A27
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209395; cv=none; b=K3vBIhputTJhx7yY7XLcWU8VFdQYbH04hH7FZGxhRNY81ybyOozGgN74nnqJj0bGIy4pRF2oG5NWj2TFMHzSuNjqPrb/e4JzVMeJDFh4TkGKMJkMp4pJ6DipvTRdHZzLG2Vrhg5uLMAtw+o0PIDJSkUYYdaKgMsm9wdTIqsdaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209395; c=relaxed/simple;
	bh=JYUd1YnwzQR5fAxaQrB+vFPKMGMlev6sSku8tQpQPmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZjow1NYcq6DioiTmvLwPUzOxeyNk7kUHRlZIr4D3SMh8CMNIUk5Qo3G+VcU+hk4PbaKcq2MYjdQol6cuZlLijhAOXed8iVE7xT/1VvZjsLoV3cusaj8y2YDbHQDZtdG0mklTd4ajWqwK+OZrERXJNmV2y0Cw30W+wVhcx40a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs5Be+In; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs5Be+In"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d54a3e462so262837885a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209393; x=1713814193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE/16RdkwukYb4JDJ7+P5wfWqu1kgtUy20qtG5TQS/4=;
        b=Gs5Be+In7surjZAsmVE1O4S9+M9hfa16rKYzauhiUu5uU91ea9TopJfk8xlGIMGRv0
         YdVH2KzIHXK8MhJWUj2LyOE08vHWlrUsGqUt8stdXMv+ToqgT282+jsUp1kXIHtGKW+J
         X1NmesFCMCBHh1q4r+bnFbH/RNY5tr85SGLUh45eL+d4gft01u+mnqQ+JxkSoI7i4Z7f
         96S2bEd+TYe+53lU6wbGhL0JSasbc0U7znW6NH1Emx9u3xttEkmSK9716EzaLGuIIXj3
         tgR2WU9q1PJwnxb1CaXUMFGKQnaR/OoglabzgqNCcf7t10Qpqh38TcEfgeGli6zPxZ3m
         nkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209393; x=1713814193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE/16RdkwukYb4JDJ7+P5wfWqu1kgtUy20qtG5TQS/4=;
        b=e8EQYmtj3nX9iaU84peNZ+xRr1uUmRdN+5N/TQw1vBrJSxQ3pXRMQ5h5SvyDZT6Svp
         glqq322UD92wcWufy9VHQIJ611DJW6KHKMVaKxfNqDaAjr3V3e+C9H85GO3HlLFc5bCb
         nRtjNCjUvQvlgTz6HFoavI3c1ZifoqjqqR2PtV3DYNTDCCzm6jyFQZ/LSuoaZKhAtn0B
         bI02gAudAT0aX47pfMHeFf0M18+EUv8HQrSiM0TBFgFKXmw4HifWpXPcCI3H/pElsO5n
         81JsiQ05j4HyZLuwfWgLDK/nzkiUVQsTEpDke1qdLuu+K5bVAHiJoOzXZvt8r0glHE7A
         FGtQ==
X-Gm-Message-State: AOJu0YzIDXGW8vojuqiDJ6subJEsyqjTybmeefL4YZsjeyfBAJtuLGNR
	FUFpKaTys4IqJUeUSqRCDh2JFnzKNhJ4CFagCOosB+RDOjYOuRDIZ52Uxw==
X-Google-Smtp-Source: AGHT+IEryFjzgf+3xao6oLWel26TVacBaZHOjgntI6rvNTOc1HHDt29zWrd6DpI5Y9i2be4mFtZaNQ==
X-Received: by 2002:a05:620a:3d1:b0:78d:69d6:43ca with SMTP id r17-20020a05620a03d100b0078d69d643camr11889447qkm.25.1713209392845;
        Mon, 15 Apr 2024 12:29:52 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id wx8-20020a05620a5a4800b0078ecd71114dsm5003499qkn.69.2024.04.15.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:29:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] wiphy: handle -ENETUNREACH for rate estimation
Date: Mon, 15 Apr 2024 12:29:46 -0700
Message-Id: <20240415192948.65857-2-prestwoj@gmail.com>
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

If the RSSI is too low or the local capabilities were not
compatible to estimate the rate don't warn but instead treat
this the same as -ENOTSUP and drop down to the next capability
set.
---
 src/wiphy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

v2:
 * Check for -ENETUNREACH

diff --git a/src/wiphy.c b/src/wiphy.c
index 8f5e46bf..fb36ebb2 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1056,7 +1056,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 					out_data_rate);
 	if (!ret)
 		return 0;
-	else if (ret != -ENOTSUP)
+	else if (ret != -ENOTSUP && ret != -ENETUNREACH)
 		l_warn("error parsing HE capabilities");
 
 	ret = band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
@@ -1065,7 +1065,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 					out_data_rate);
 	if (!ret)
 		return 0;
-	else if (ret != -ENOTSUP)
+	else if (ret != -ENOTSUP && ret != -ENETUNREACH)
 		l_warn("error parsing VHT capabilities");
 
 	ret = band_estimate_ht_rx_rate(bandp, ht_capabilities, ht_operation,
@@ -1073,14 +1073,14 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 					out_data_rate);
 	if (!ret)
 		return 0;
-	else if (ret != -ENOTSUP)
+	else if (ret != -ENOTSUP && ret != -ENETUNREACH)
 		l_warn("error parsing HT capabilities");
 
 	ret = band_estimate_nonht_rate(bandp, supported_rates,
 						ext_supported_rates,
 						bss->signal_strength / 100,
 						out_data_rate);
-	if (ret != 0 && ret != -ENOTSUP)
+	if (ret != 0 && ret != -ENOTSUP && ret != -ENETUNREACH)
 		l_warn("error parsing non-HT rates");
 
 	return ret;
-- 
2.34.1

