Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684A3FB07
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322069; cv=none; b=VBsld17zH/Ac2GJzKRfYKEVQEWrkMfDqEUBKI+YLRIY18KMnydka9fvcbFSEXm0WwrYbd4kn5yPOBl1fTuZ6HmiTvi5f8RFQlhhuXMjAe4yoainf6ll+8f5a2pG5QBGgr7W+k/L/9279YgWOxsN6Qg9UH1BuS1kCsTzN+E1RSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322069; c=relaxed/simple;
	bh=dMTqAjczu/YuHI0pRI5UBIDvZ+k7Q+T7xp/BaVl1GZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSie46JE1BgwWfy1QTy7X+PvxOvEQVGWaGT4TjPCX+ybOSw6zzcAXzAjpN+mf/QGC8UFFPtclgoHXOEUauAv3UvyuZspuywYRPewmU8Vo+ZaerXFLJm1pgXirKFjmR46fB4e2vbvrrmoZ8Tc9exP6uzMaVRWXbAFGO+HlJWf4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXx76TJ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXx76TJ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a078ac712eso1108463eaf.1
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322067; x=1709926867; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDhYPFk8DEPjIlyKGdwuIZ7utfc/yywu/kXcmo2L2kg=;
        b=GXXx76TJLoHTlIvqBzNHIXl+ndvGaKTH1sc6CsqlEKIwmVv+MO+n1dcKd3c1Ooae8r
         5J7o+voIOKndgjUeuFqxSKdu/KfR+wxXKRnVjN6BvyVpawDeOwa1AU+rcpep62ZFUkgF
         MjOumBrQ31GQU/wKcQP2GWbRMJCdUQonAMBS74mxLb24kGQh0MyMyPspGNIlpf56Fo+b
         tMZTlzzsLa7hIMAjT5GcPg6pxYe325fGZJEwpZAzx/7+hYq/36QrnTifocXlz7gKgc2j
         i31jB40ZznkFU1P4ud6VDz1HD6IVN64Td7cxRZH92t1VAW0AlaO5McVdB9w5kNXOp4JT
         zMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322067; x=1709926867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDhYPFk8DEPjIlyKGdwuIZ7utfc/yywu/kXcmo2L2kg=;
        b=j+02YsU/0fN25ubKdlu6fiYtrax7jF76sUmoarPmhFFVEmsFau8SvodPz3ygFp9wux
         Kfl9Rv34vhPV/f4Xk2pggfrh4tcB01DLI3olIKwW9C3Iu1z47jowlav6ujxaEAeMmofn
         NzdpiJ2YTPdfrPOp6Q3QkmK1ZrSUowaCFaXla/9J3xSfLixYz3tczo607cDEEFcmulwc
         AZFiV2VZ+hNjKu2FlexbvtujGD4O2ZFiFrWL4EUCbSbtdg4qZaw5juXSUvkHUqIOXox1
         lmmph5tPAvSb1pNaVNkwRKE+dehAW4770kwdYkNg9pstQlQOaY/ntRPmm6pzXTbv/Jjf
         9AnQ==
X-Gm-Message-State: AOJu0YybS1OayVWlo2QNGYGtVow1VzDBfXcN6WQSqqm6TmtFO06qNclO
	hj+BYEMeUj3+gfp5InQyVQT80NkoD4HPAylMShSUISll4qwvF4lnWzEe0WMz
X-Google-Smtp-Source: AGHT+IGGPupPmK9GsnK2+8m87NBBW09zAwTO6NSINyeY64Gp8llCqBKYGsA+iHlx3oCrUIuMZtv6kw==
X-Received: by 2002:a05:6358:998b:b0:178:f895:5978 with SMTP id j11-20020a056358998b00b00178f8955978mr3588018rwb.10.1709322066884;
        Fri, 01 Mar 2024 11:41:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm2162397qvb.20.2024.03.01.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:41:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] monitor: properly mask HE capabilities bitfield
Date: Fri,  1 Mar 2024 11:40:55 -0800
Message-Id: <20240301194056.1665549-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301194056.1665549-1-prestwoj@gmail.com>
References: <20240301194056.1665549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, the bitfield was incorrect and was masking
8 entries (0xff), not 5 (0x1f).
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index bb8cd496..6fe63b8d 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1689,7 +1689,7 @@ static void print_ie_he_capabilities(unsigned int level,
 {
 	const uint8_t *ptr = data;
 	uint8_t width_set = bit_field((ptr + 6)[0], 1, 7);
-	uint8_t mask = 0xff;
+	uint8_t mask = 0x1f;
 
 	const char *he_channel_width_bitfield[] = {
 		[0] = "40MHz supported (2.4GHz)",
-- 
2.34.1

