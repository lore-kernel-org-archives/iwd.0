Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72A3CCE9
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffwlyxM9"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1262185b3a.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140924; x=1697745724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRWWB3Y4Aw7Mwz9wQsPPOcPVfVgRJMlholhMbgFmJjM=;
        b=ffwlyxM9gP2IDRpOzHf4aFuS1uMixB3Ju5gH0teof9SIuIoZm01ZJOGisTuX9Mc9NK
         vLVwWipLydcqNmyOnnfoM4e6chEVhEbwfZAI4JZDMvJB/VUjrcr06Z/vQPvGKGor3Znu
         zBC1YzOmyFhpt7TKxnCPm50R8PMSnhRDd6diTHdh6tPYnr3GQ6jxhUpC8wSxDuLIbi3+
         BPU7VGP27dVTEaG6yTaOTmjwa8tiACuxWrUwyyE1wibyAapDfR3fPt55n6KyPF6pPsDz
         pyOCghNvB/UY+rc52YUyU/GVnRnRn9LFDuVh7xzJ6JdJ17sP0m75r3302udQGdydknec
         RVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140924; x=1697745724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRWWB3Y4Aw7Mwz9wQsPPOcPVfVgRJMlholhMbgFmJjM=;
        b=YGTXUtGcizpAfUSBcvqJdilQfba9cfuH63J5yCMlRCpNOkbRf1RMjNUDm0K+pNu7pa
         dcpcoyHtoi1Bt8jRBjNGs5m/z3wFy8bS92mSi4CLsh23O9x9QfURKKWmwfxr1vLeG3F4
         zLKyspx/CdSt0HKR0/uyjaRsBGegRHHIY3Wz0AYkMsugH6hb8Bv2Y9oeF0QXuIa8kyyi
         rZCC7IB4Pv62D/FG5UWIkAZb3fez5hGUHSJ+svv8hH/t7K3W2fgFF+Q3lBELzLv+4ezL
         4ifsmWl3qwHMTpfjVgAM3e6RmKX5lsTgyl38XsgWk9p5NEPtixfZsohl3CK2RF8Bb9Cj
         Asgw==
X-Gm-Message-State: AOJu0Yx4htKq6uRaoznQHlaSGmyhqrykre9t5Yh9eznXRQBksCkFQ2MJ
	Of5HY+va6NDy628f9InISRVHi157xDw=
X-Google-Smtp-Source: AGHT+IGLpcsnduZzSMuQQ4GH5BQe/FIWQ4PQo7HFNqDH6SGYdhNQ+xsukp9iPkeF01aqFvSI9yqedQ==
X-Received: by 2002:a05:6a20:9152:b0:160:83e1:712f with SMTP id x18-20020a056a20915200b0016083e1712fmr28669842pzc.23.1697140924493;
        Thu, 12 Oct 2023 13:02:04 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/21] unit: update test-dpp with API changes
Date: Thu, 12 Oct 2023 13:01:38 -0700
Message-Id: <20231012200150.338401-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-dpp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 046a1831..c782efba 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -269,16 +269,16 @@ static void test_key_derivation(const void *data)
 
 	HEX2BUF(i_nonce_bytes, i_nonce, 16);
 	HEX2BUF(r_nonce_bytes, r_nonce, 16);
-	dpp_derive_ke(i_nonce, r_nonce, m, n, ke);
+	dpp_derive_ke(i_nonce, r_nonce, m, n, NULL, ke);
 
 	CHECK_FROM_STR(ke_bytes, ke, 32);
 
 	dpp_derive_r_auth(i_nonce, r_nonce, 16, i_proto_public, r_proto_public,
-				r_boot_public, r_auth);
+				NULL, r_boot_public, r_auth);
 	CHECK_FROM_STR(r_auth_bytes, r_auth, 32);
 
 	dpp_derive_i_auth(r_nonce, i_nonce, 16, r_proto_public, i_proto_public,
-				r_boot_public, i_auth);
+				r_boot_public, NULL, i_auth);
 	CHECK_FROM_STR(i_auth_bytes, i_auth, 32);
 }
 
-- 
2.25.1

