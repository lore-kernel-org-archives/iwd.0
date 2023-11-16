Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCF39FE4
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1uB6G9U"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f00b95dc43so590413fac.3
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700162133; x=1700766933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5p7Rgi5L+nZrByKZkLl2tNJctmiQjmc/zPDM+w8NMT4=;
        b=O1uB6G9URHb2htZzB8c4SOtNlEyYaUznaNeCEKxoaUeTt+8/78wAFHzCnBS1smTySb
         RsPtFhDz1tFH6aZS/Kw9JgpbBsnl+FEM/gRJCohPBvrJ6+kUZ7CRKFaQyjB0Ngd7/zas
         4FLbIA9SJ6BB2jh/aih/mSGtaKaHqyF+R3D4FKac53ZF51Ag0WZ1+U9haPskCioAce0K
         ratKBwi/2RKujbrOafaE4UMP6UEWw+mxH/sACEsUE+cucyEksizfqXvjiUhFCvPReebv
         UQo7HKQggxIYo61neACHeB6Qgro8tsBJICJzJAIizi2/4QH6PvThR4pL10qMPpY1kXE4
         HJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162133; x=1700766933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p7Rgi5L+nZrByKZkLl2tNJctmiQjmc/zPDM+w8NMT4=;
        b=crK9R8hgzAHbS2jdWH1L63npfbloDdU0+QWmEGBJlVVdupDE6go3fiswlNvtOjcWK8
         ObPH8fApP1+nkppCGao0+OIBec8zPlfZgJiRi6H+DAN3P0hPUH4STQqTryUAhfwXFPBC
         0sloRMwr+c4TkT0P0CNLP3jzEEXB6k9D0tfurL/EiL0jyRyh5YhotL9GRgzHUTcYa452
         VaMyDJn4gBvYqyNLy86FSo0OIUBxbWE07mp3vU42HL2uqh9rT4bYqHuFv/F1I4JDvp4+
         pA+NeopN38aOgYEEEr7byeyJ4zTzgQsUWGcObqtE4vp9Zzg16dmHgJCQUm7yQC0Aj2Kl
         v/gA==
X-Gm-Message-State: AOJu0YwhZqekheRZJTGM2Pb2CnzMQTOGfVNT53F1OKL/XTgg4No824b9
	b3IZrTddVlyMGmbMPgQKa6EI0nLC6So=
X-Google-Smtp-Source: AGHT+IEqn9zJKJBTPFwBM2zatEUEgT8MNqNwCXa+mft7n1LPotqDI2RsUS4Z+gQ32J9qkq6Ezd38yA==
X-Received: by 2002:a05:6870:ac8f:b0:1ef:81dd:34b3 with SMTP id ns15-20020a056870ac8f00b001ef81dd34b3mr21500445oab.59.1700162133280;
        Thu, 16 Nov 2023 11:15:33 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8660e000000b004198d026be6sm4376qtp.35.2023.11.16.11.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:15:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] dpp-util: store SSID as string, not raw buffer
Date: Thu, 16 Nov 2023 11:15:26 -0800
Message-Id: <20231116191528.364340-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nearly every use of the ssid member first has to memcpy it to a
buffer and NULL terminate. Instead just store the ssid as a
string when creating/parsing from JSON.
---
 src/dpp-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp-util.h b/src/dpp-util.h
index 053caf8c..0724ee44 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -112,7 +112,7 @@ enum dpp_attribute_type {
 };
 
 struct dpp_configuration {
-	uint8_t ssid[32];
+	char ssid[33];
 	size_t ssid_len;
 	uint32_t akm_suites;
 	char *passphrase;
-- 
2.34.1

