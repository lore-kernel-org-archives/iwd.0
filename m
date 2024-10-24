Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E549652
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788402; cv=none; b=slBaRSBz8oUj+aaV6XNtKycD725lGNFCm9oAM4Lej2xglnnR7r1IN+2PvUK7ERG4f3OgDARVHygEJk5vwOQq5n3LzrYiYzUUzsRlGLiM5gSfde/9xX47uM7dSFtWL2kLZeH/pzfjMHQx/Am4Y75VyUOiFBeHDA43uns1GBd7H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788402; c=relaxed/simple;
	bh=IhL2zv0AcQlomJBD2wCPsazNDogCOglhE1riBuNflEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nbl/UWd4DNNHj3/uEyBDA7hlC5vOTQ4ipjSa3Np4BtnPBlJxoleJkjVlpDkMqBfDq5AGUeU++MjHSsirCxNchrU4hJcBRwnh49c8q8/MbcShpG1FtgRFnagZZUOYPLuK1AbCTJG6EBLHOavdx0nTGTD52zLI/E5JiaRkL0ueuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwhAdVj9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwhAdVj9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460dce6fff9so7536361cf.1
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788399; x=1730393199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FevfuVyxuZ1qPPZzJ7wX/yreqxQXzM7LyohybtWB90=;
        b=IwhAdVj94iVUA0vHCve3vTR5lu27G/ccVvpJtCAUCyP7e2SqPAZsYpNxXWv4dYSvlk
         nZ9dMq822y4hcBFcs4yWjpXBfUc9eTsDTJpC4JDf5e4O/7aasVu3fgjPeChQQk2Inmm9
         8GpYAMT/ASQwQSVQzuRsnmgnLTXgbR3vWkPozvZv91P6IM1tpyiUmmmFWevJkhXqJC2Z
         jnqt7jFyt0x0IuixaV7mKrA4CYEsryBBPX4vO5U7mvBamkZqC4EHKTdAeNeX5b7cHCae
         /Z71qedoJIiXXddYObN/vzIZQzFsNh6OyKL/Qn0V60znXkyl6N4JQe5a0cutlMkPddFo
         D/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788399; x=1730393199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FevfuVyxuZ1qPPZzJ7wX/yreqxQXzM7LyohybtWB90=;
        b=GA92A4frEIueXZ+ovxlNUG46EOrWIIalF737tmwP+gRy+jwkoyyfhPMgUcd/gsNVJD
         L9nfhRkbiacmlN/xbuPjkhaHw7lsmqW7TFpn5PAtq59/ECSsdvxkg4Gyc2/yCpSNEouO
         HGGlPfBCuhx4X3T3hM3UZfUMPbt6NH7o44Tlixpx+ZML4ptGo9lb22rxLFtMCph30jsU
         GYH6bN5SB+dKHV7H5PqaEe1G90eUplh4bgNBkPB4LM9c0xlpluimWvv00qpIGuMyqzds
         nCH++ze3Hjjf2DetMnklP5OXS6PxGNq4/r6fDAymhOnsGeZeupJihQvcndpLELXa0gFW
         4FNQ==
X-Gm-Message-State: AOJu0Ywu7JpmCKHQjrKs4iyXcUV6lXfw0fK1ETyV845HCzLk9TnNW7wD
	rW/S6W2GvPl4OOWlPMznZKPLPnGU8aS8psr3egJkvf2SKTLvjp+7p2BB/g==
X-Google-Smtp-Source: AGHT+IHcuOeqaZygevGjHT290k79xBx0/bFOEtvwyBZ6WuBaoaVFKxGetB7I0le2JQMzS+jjmvDkgg==
X-Received: by 2002:a05:622a:c6:b0:460:4027:601 with SMTP id d75a77b69052e-461145aae23mr110725151cf.6.1729788399122;
        Thu, 24 Oct 2024 09:46:39 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4611a19be2csm16893901cf.70.2024.10.24.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] band: correct oper class 136 starting frequency
Date: Thu, 24 Oct 2024 09:46:31 -0700
Message-Id: <20241024164635.176631-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should be 5925, not 5950
---
 src/band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/band.c b/src/band.c
index 14daeb37..4e8eb9b0 100644
--- a/src/band.c
+++ b/src/band.c
@@ -896,7 +896,7 @@ static const struct operating_class_info e4_operating_classes[] = {
 	},
 	{
 		.operating_class = 136,
-		.starting_frequency = 5950,
+		.starting_frequency = 5925,
 		.channel_spacing = 20,
 		.center_frequencies = { 2 },
 	}
-- 
2.34.1

