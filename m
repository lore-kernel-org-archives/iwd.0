Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23D1E487
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570940; cv=none; b=X9V2L30gDYUewuOlumXCJQC9BCvyA+D7nGNfsWeukaOnJ4xeNGMXpob7PcVUeAXJnAjO7Dni4ioIAruzH8qUrBiu/tM6/ErauGXveRqb68XRoU2GjxxFyPOh6rb8Lx/jfxLX+R1CtpIba2YHFQIgyGefelkCIHdtmKbrwIaxq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570940; c=relaxed/simple;
	bh=z2Gg3/01yO10btu0wXhGJepCAFdiYgl6D83ut+VGLno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssFuMC/PwDvMAxAgfkTy7+0mPEu5ew76sGReE4FHF43u9ty1Z/u3EvdjA4SkcuPonOAQinBOX3iMwc7UjUIit9QEd//lVDkn9Q2NiVoHvkqpJ0uavWjL+rssYSGb1Dz82Td62Y+NneM5Y5dIbN4L4FouwPWCCEkBEFl0YrwWg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARKEthsO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARKEthsO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6900f479e3cso51392956d6.0
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570938; x=1710175738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg4GLwXGvC4XTbfcRqXTaEr5hWMmSsjASYeBFKRX6Do=;
        b=ARKEthsOrwOjIpvttdI6dxa9Z7vtaHF/v1GYOGc0xlulByPB+OZQzOst55+WodrzZ7
         xEJ1caVBFiKFgmh5EMWAWjgk1B2sHGyFEZG+VuDia5gjpFRPnuNa9tGi3sa04Pwy7Cg4
         4nLcyJWDR/JGq4O59ejNQUV606piQu9sQrRNREYQxxjbbMq43F9WYs8TcF3rii1Hdlea
         qHYj+Hm8QFH+Dll580w6D6bOXDNFjkdj7ytCNOc1oELlKy1V4h7IRnvzxeoJvXCOR8I+
         TT+pCPlGAkiPxs2nrfKA5u185BL5m11yhjBo0oi88MRZqqLuvG1hRjtq4xX/bvIDj6Nx
         u2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570938; x=1710175738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg4GLwXGvC4XTbfcRqXTaEr5hWMmSsjASYeBFKRX6Do=;
        b=Q3hIFriitRrT9aa/R7vq2KJcFVGNxVWOcbToWu+d+Rlj0GPGcYtVzo7gn4VP0aeUx9
         61MyrpO40UThf9meKE6TYDhDHra/9kGY3IzW5fBeQYYy6QkNaHZ0+UCBf8XhDR/2vfFS
         j2N3xiQytsw9kiDSbQEcRXdd56SOeOtKy44EMsgvYEKyfAL3A6+sha5gH2KYXbsw/geQ
         FlJ51axz70EYTYJZQCYYkJ2XTtGUXTKij1KiQwEoMfcZj6scFrCSU5eZCWlEO1Fq64+x
         HhNs4WyLM0I2ubi09eom7fmLZdcotsAdAhXHANTvoYdBUW6Ms1p074mYyZ15z+nwlSpb
         Zb3w==
X-Gm-Message-State: AOJu0YwbqsSxB5HgVJzC8jCxQpKaz07PxDldsOrC5ZbCGcKhpMAX8EIC
	tEsfcE5M18k6b3+bEL4NsvQHI07qlg/c+O08IHgPxyPp6ddresAN5vfRKLjH
X-Google-Smtp-Source: AGHT+IHatfjV3QalIJy4sBl4wFf72ZTHOx5a9lkZ4JkYlsaiE1fFF/cv8EhJsnqGcSz7PzzF2QeXSA==
X-Received: by 2002:a05:6214:4a4a:b0:690:50af:f5a1 with SMTP id ph10-20020a0562144a4a00b0069050aff5a1mr9741986qvb.27.1709570938010;
        Mon, 04 Mar 2024 08:48:58 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068fdc55ec7dsm3858466qvb.68.2024.03.04.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:48:57 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] dpp: check wrapped data exists in authenticate response
Date: Mon,  4 Mar 2024 08:48:46 -0800
Message-Id: <20240304164846.1783148-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304164846.1783148-1-prestwoj@gmail.com>
References: <20240304164846.1783148-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 74b4c2bc..567fe8d2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2368,7 +2368,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 		}
 	}
 
-	if (status != DPP_STATUS_OK || !r_boot_hash || !r_proto ) {
+	if (status != DPP_STATUS_OK || !r_boot_hash || !r_proto || !wrapped) {
 		l_debug("Auth response bad status or missing attributes");
 		return;
 	}
-- 
2.34.1

