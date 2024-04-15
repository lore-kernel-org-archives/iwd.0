Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C0B656
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209396; cv=none; b=lm+P0jePuh5eL7OcqKMeZTb36Irt+JL124ceLkQAsFVESqs79JdaRNKAAuZdKoPACYqlFqonx9NdBEewiyJE2+gRQUYmdbpRwK2FOCVLcGjMH+EXzKhxX4Vgn/oVA1pEowjzFfSHAe+XDL8r0gGSmO053Xsa35AJPeC7vYRl+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209396; c=relaxed/simple;
	bh=9e8fXaxoiyGcuJnIKd+Ot45gqR/t7USfEcfrn9EWXl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GarutCmkOq+S56+Sl+Gq3Q/xXs+b1JRJBsv4GgkSLpNhy3KVcIrHD/frakZmMqhWlxfG5ukb8dM54PxFfc99E3FfbkuTERlqd3I38bNsyuQwNfz//T9HYaWtoGdO5WmXCzP+hZiGxG12KW9qYEXffTRuJF3T4z9W2951HZEcasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi1ufK4D; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi1ufK4D"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789f00aba19so204782685a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209394; x=1713814194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxKwqw3e+B3TZiTyFUBpnnUNUraD1JDLJeaUr1aESjU=;
        b=Bi1ufK4DDlZriwR9LS3+9Sh79GugEBK57YByKVCZmmV28zv3dkxbe7CgJK7+9Xmvcx
         zVa2EjFqJqxOR5KaPGECj9T71VErURJkRZLrDQPVmaVwBg9Ka2X9sa2XJA5AKiTQZEFO
         Wv1oLmlkmOvitjOv+rd2tsOiLH/NeNFqcj2nEerjnnImOVG9P0MPOU71quHzD098rPQm
         Xl/h/9cbabVZTpvTih7pBOtt3mCywt+a0RpStfYeJSYT7IgobMdZ2GxDoFzI9HROCIKp
         ++4YqxMH2EKEAu2je7hVpVgJxjs2lhYTgTXEb/FoBkEFp1jj5TA9l1CahZlEu0gVpDkQ
         Q1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209394; x=1713814194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxKwqw3e+B3TZiTyFUBpnnUNUraD1JDLJeaUr1aESjU=;
        b=SJMP8jCqABTQbHK7ovWJFMOZd+NpVBbC/Bxo/Z2eNP8NSDhrbCSYaZJ4fub2bxNBfl
         DbCwaVDGsut6DsumnhNP7Zs0tHQCD491IvCcjcyM3PXk/TxU4P3OqJY/m3+db0/Lesxm
         qbpLmu5/iYPK6LDexNolQIDIUogjAtl7iLmSj3QC4ZIuQMk6auzPCZZVmrQMawhtp+LK
         AAes4J99GGge8MFnZP6ho/vWV7PiqE1BcnoZuf/i7bdkPV4M+goIudibZTAnUsN3Uv9Y
         Z7ImLZuUasZRiW3EkA5GOYgVU9F+mLhdt+ekbN/5UiPwrUWXNS70IctFDD2gcoSgm+ha
         iKZg==
X-Gm-Message-State: AOJu0Yyhk+VDcTXlC96Z1KJOP+pLl4JQoNqY6sql4fELst5koqI6Ta7y
	T6GbaDhtH6l4iqT1Hi/QE0jxEFe8O//QfComDSBT61tskiQKCa2iJKCRMA==
X-Google-Smtp-Source: AGHT+IF40Xp6M8IyKlwMyb0hufBHC3lAMbPPruviS9y6pHXqKS7pPgA59vjg2L49axAe0jm+LIIYvQ==
X-Received: by 2002:a05:620a:110c:b0:78a:5bfa:3619 with SMTP id o12-20020a05620a110c00b0078a5bfa3619mr11036376qkk.17.1713209393884;
        Mon, 15 Apr 2024 12:29:53 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id wx8-20020a05620a5a4800b0078ecd71114dsm5003499qkn.69.2024.04.15.12.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:29:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] band: return -ENETUNREACH for HE rate estimation
Date: Mon, 15 Apr 2024 12:29:47 -0700
Message-Id: <20240415192948.65857-3-prestwoj@gmail.com>
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

This was overlooked in a prior patch and causes warnings to be
printed when the RSSI is too low to estimate an HE data rate or
due to incompatible local capabilities (e.g. MCS support).

Similar to the other estimations, return -ENETUNREACH if the IE
was valid but incompatible.
---
 src/band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2:
 * Remove the -ENOTSUP return and keep -ENETUNREACH

diff --git a/src/band.c b/src/band.c
index 11cd965e..906d6197 100644
--- a/src/band.c
+++ b/src/band.c
@@ -678,7 +678,7 @@ int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
 	}
 
 	if (!rate)
-		return -EBADMSG;
+		return -ENETUNREACH;
 
 	*out_data_rate = rate;
 
-- 
2.34.1

