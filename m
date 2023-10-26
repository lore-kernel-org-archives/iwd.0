Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE03CCFD
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkeYEIK1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-777719639adso98217585a.3
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352030; x=1698956830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaCMVsCA3Skgdtdb5dzbkLzo703uc9kuRvL75iohSOg=;
        b=SkeYEIK1T24ub4gi8TdY970yr4Fyk9gLy4qn9vY+mIDrU5tpJmq5WcgB3X/8bmCHdM
         3Q6ZJ9fsarMGCrTu5ngcO8CuS0V8RbwiFFCTsITKXKERdY7/c0fV/OWvgWA5hldw9qoD
         91dSneXwf9EPJ9kPwuhe3ppwFuyaUxBqJnEVk+UEFwlr5BncIa+BU6qBoNyP03sRFKte
         VLHfNwt22q//9+F1sfba9F0gVcZJEz5q2jD3S+u66Aizd14UpF20WWkQNkOVrakLEj4k
         dqWzNB2oMRkhEbsjV355NP9wg6+EJlYeQhOBON3H/kGRMLJ7Y9QrMWGwKYmXPQITDdNH
         PGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352030; x=1698956830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaCMVsCA3Skgdtdb5dzbkLzo703uc9kuRvL75iohSOg=;
        b=suRf3MME3AhgfQ7+vnlDuaPkAnHF5RqzwxLk1s7RA34jvbUqVluXM4s3ynmSugjqVn
         rb/IPWWVwxhT+Vl/+46nvv3eUSmTG+HxvXihfKYUlJUtENwxT/A9ZNaxnCTjcAuozQf6
         lhUtjYVHpvtA0U0PliiK9x1pY+mf/5l6A/iSryIGd+QovsggzhexA8A0j2G2SINY4dX0
         xqwqiM/8fZxi6maMHjPmA75v1vpuKxiZ4xCHqv9nuZ7URnve7L2Ne7S+wFOMWRb2/GE6
         bOS2yQ2KTsSVK6XIiSRc/tqiT0w3G8kyAqiyji//EUSupkAXrZlhKychBVZ2WajUJ3Ki
         KGAQ==
X-Gm-Message-State: AOJu0Yy3htxPsmU4wKXNAsRUgCKSIpP0D976+zTrwLhXSS2Orw7/Orn6
	/UTNrHkZo2jwbknnsY6DyHqacRhWm8A=
X-Google-Smtp-Source: AGHT+IEvjnZWO8RLpSpXter1eF2jGBp7I7nOCNxZO7cGU5+Nt1zi2yxmLmAEu52tIHBVdioHTXBcEw==
X-Received: by 2002:a05:620a:1373:b0:778:912b:6014 with SMTP id d19-20020a05620a137300b00778912b6014mr410939qkl.37.1698352030132;
        Thu, 26 Oct 2023 13:27:10 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/15] dpp: check configurator role in config request frame
Date: Thu, 26 Oct 2023 13:26:45 -0700
Message-Id: <20231026202657.183591-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We shouldn't ever get this frame as an enrollee, so disregard
---
 src/dpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 23b17d01..edf5b797 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -914,6 +914,9 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 		return;
 	}
 
+	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
+		return;
+
 	if (memcmp(dpp->peer_addr, frame->address_2, 6)) {
 		l_debug("Configuration request not from authenticated peer");
 		return;
-- 
2.25.1

