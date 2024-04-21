Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F31772D
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704051; cv=none; b=Stx4mEdc1APRdFEXlxAE4HvzyFwt5sEm3krvnptQIn8YDL6gq3jfMbLJqqG1YI+jg5ckj4/XnHoVJ7+16dj2njTrgqAPzDD93muaDWeV0qhB1bRZXdCR/MKsAO8SlNBs3UMN1kEdFc0RzZArZu5RPy5yvaUAqPr0hCptO4Q1AjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704051; c=relaxed/simple;
	bh=2ICwD8LyaS27Ec2QG4vWlF1Xt45cr0o3QPTwyfFVok0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6Z0jJatGGY23fAmE3xGOI0Y9vIRMKm0uo8prEQXAUKqfyZGjJTdoQNpWDPiVda8d9OF1l35NJdH9dDlEAfgEAGm9SGIGGGw8012wUheSLeULRI6Olk73itqXEdJXuWruzM3DlGhgY4gdUWkUtTAGbgS3DKLM+LElJOPyGBVyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRcCXnIr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRcCXnIr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecec796323so3645008b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704049; x=1714308849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naU7Lyu1k5xtNysxMGI2m4bg7w8Id9aqwjGgjWeYPZ0=;
        b=WRcCXnIrVTWhBI4QTGHYx8g56snWCpxpJyK3eGV+P/kXJFE6ZPJt2zoibIsuEVuM/4
         JVPY4W/RvPLo5PnvK6MxFuZFf8+MimlGal5k/FQCMoLF1ATWeUMGqk2u4NYR8fPOvav5
         2R0CtKGCxiKdWvqD7ssZp9c0kS+IDc+MTxKw+NRT0Md+ktf7ywWncA6dbiUEH/8a0MjT
         q228UrPaOjvyByjDrU9tXAH+RIIeq7dyRcMpvYq1O65AxWiQQGvSYlZTYxGbtgCGY2CR
         1B1/JMZSqS0OwFaSiPv5r6COTWDHBD2sRZKXBynuzrU0KqIsdwmLRhLlOUvlGWlbFdrR
         PApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704049; x=1714308849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naU7Lyu1k5xtNysxMGI2m4bg7w8Id9aqwjGgjWeYPZ0=;
        b=mbgWs37ObYjElmbc/s27aJtr7jJg3fZY3GdjuKQ0Vy7rFVZ2Khb6eI6Yi3xtQkjlGq
         FId8s2vngE8vwSMUthP93b0S8zDMMtl8zmeFrbK7nXdIQSROkoOouL7sn1Vq3pOfrfcg
         NVQNnrEY4pu++7QjMVmXDgBqzU3AugXY4Auh/QYvz4g++UgoKV4BbmECZA8onVBzU8wE
         tuQwIYmNUZrxIUI6IEBatESYjELITQtBo4TzTucM3Bp4Mvr1AG2s/8rm7z6RLDhGra68
         n3lUpgXlANdGOD5okeJWxQRotSIVreROv5jg2hHLhlBz5ODd8gwV2VzQHCH7pP/bVAiX
         z8Bg==
X-Gm-Message-State: AOJu0Yx+BubD3uY8buGctsLPSRkUuS7dDkfMwEQrLsyHW4R8sPWAjJBQ
	WY0QBLYVrCcxSNuOCqsPhDS2ebZ5+rfm/hVABZoy7un7lFjWp9CrRDkxvir4lEY=
X-Google-Smtp-Source: AGHT+IGpmNTzoeiuITSUPOa1C+Cb5mOXvQxETUO85ubYpEAWj5gamW+N2zuJCJPEZ6qAtHTvd6soLA==
X-Received: by 2002:a05:6a00:188b:b0:6f0:c214:7974 with SMTP id x11-20020a056a00188b00b006f0c2147974mr9481494pfh.12.1713704049355;
        Sun, 21 Apr 2024 05:54:09 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id z25-20020a637e19000000b005f80aced5f3sm2742541pgc.0.2024.04.21.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:54:09 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 10/11] eapol: support PTK derivation with SHA256
Date: Sun, 21 Apr 2024 05:50:40 -0700
Message-ID: <20240421125050.6649-11-brandtwjohn@gmail.com>
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
2.44.0

