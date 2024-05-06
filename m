Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE32A934
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956591; cv=none; b=GVGW7ilUlsIOs90PSggSjVRGPkXacD95KTwl/G2+9j7SrBGBPpYtiCs53eSLeJXXrYZgrM3ugk51BLFLjjkaaVjMoQP35+LwLecgJrRQ/ZUth8Ij2rwN+ivhM2F1ve122x/0hkEHqYvriLaPCwb+4/BClu/xe2P9z+yet99RYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956591; c=relaxed/simple;
	bh=cRkHBy2uD1YnFwVVq3Mdddj1F6MNIx9//mM6zwBi0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEeTribXrk/fkfOn0IP/FqPxg1o4x+keToeoXK/3uxLN4s6UcuUIADzgvUffb2rn7SK9NtcOLLAFWMND/xkptrJUg2yg09hXxtGbf4IRpmFHrXjgHg826ZSSZxKQcB1cW6uF2Qkz8vJcFZKGuFEl7shm8xk75PBK0tfNSaXXpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QccfYH9D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QccfYH9D"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4603237e0so612939b3a.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956589; x=1715561389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07folLyvhfiD5Dm79rxRPKnpxAOoFCM++kQlgQBZgfs=;
        b=QccfYH9D2SQNlVFFJygiXz3hx5h/+CaT99/Dv0EX/7oJ2gBJCHsw+GeLUM6/3KSIcm
         9vaSTE11NiAGp8z082o4ma5X6XXP5bk9DMzbJYFkJ8c2Zb2sPYycFS2FajZOAVyrK+EC
         9dhc0TFQrpsn1zs1WnQGPbZNQ1fETu4cJ8EOg0BqQksNCCMvB2zFfcEhKdzPFKAtPmbN
         LzcSjdcS9eZpYVv7z1f/UTPtQC5hQtPW5K55zIJsRVVMJUN2IdjPkXilvLj3mvV40QuX
         vBViWgcVYOpTvd+LD4o4r5xqO/omXVOQhn455+tsKvjEF1iMaxTPUq0kRAlhUjQmi1WH
         gxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956589; x=1715561389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07folLyvhfiD5Dm79rxRPKnpxAOoFCM++kQlgQBZgfs=;
        b=gkYTb9rG89leCmbsCFpwSjWOEziR4XGdZDn/OTLHDy01tGRwAYfg8nfK9cubmG8PUr
         4hxy9OXRmXbstopDy4La8kaJJi53Vy9dmJXuzlfSWHXE6IBnSBGV7wwdJ3kHYLhWKIqS
         wzqT/6DeBj5eLz65zOcgbCMnF1UDXq2OkEWOUQJ9M64NjPEyD3sw+qPW1zupsb6+n9MK
         pXD0KxyhHd6y9pJk920ByEu3sHR7nv7QUNJ94/2llx/gIhx1dnORpj59sY/n9uEgYUFi
         Y9kcfqJuZC2fWEoKNAKleQyiAlkA+D6SMYdf93+GBwPVWmBHJ1gPJMAES8YgLK8fb7DG
         hhnA==
X-Gm-Message-State: AOJu0YyIXQhcGz7I/xKeGd0ODKXH4H1K+7CFxO3HtPaJl1r68hraYZyO
	DjJl0mw74F/HHSj4W/M1WRzS669EbpvVOYB+GtgNDjnfWsMdrY98AVPJvA==
X-Google-Smtp-Source: AGHT+IGV0SE8hGBYdhBoT/+5o5/mkZhl0OMNjQwt9jWDiHVBK8wZj9pKXd5VuMN63FEl4ffHHl6VeA==
X-Received: by 2002:a05:6a00:3a28:b0:6f4:4b35:d7b5 with SMTP id fj40-20020a056a003a2800b006f44b35d7b5mr12242369pfb.1.1714956589535;
        Sun, 05 May 2024 17:49:49 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id kt20-20020a056a004bb400b006ee1e2eedf3sm6578093pfb.27.2024.05.05.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:49:49 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 11/18] eapol: support PTK derivation with SHA256
Date: Sun,  5 May 2024 17:30:34 -0700
Message-ID: <20240506003518.320176-12-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support PTK derivation in case the negotiated AKM requires SHA256. This
is needed to support SAE in AP mode.
---
 src/eapol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3ce14d5c..a9b4f3ba 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1560,6 +1560,7 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 	size_t ptk_size;
 	const uint8_t *kck;
 	const uint8_t *aa = sm->handshake->aa;
+	enum l_checksum_type type;
 
 	l_debug("ifindex=%u", sm->handshake->ifindex);
 
@@ -1571,12 +1572,16 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 
 	ptk_size = handshake_state_get_ptk_size(sm->handshake);
 
+	type = L_CHECKSUM_SHA1;
+	if (sm->handshake->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256)
+		type = L_CHECKSUM_SHA256;
+
 	if (!crypto_derive_pairwise_ptk(sm->handshake->pmk,
 					sm->handshake->pmk_len,
 					sm->handshake->spa, aa,
 					sm->handshake->anonce, ek->key_nonce,
 					sm->handshake->ptk, ptk_size,
-					L_CHECKSUM_SHA1))
+					type))
 		return;
 
 	kck = handshake_state_get_kck(sm->handshake);
-- 
2.45.0

