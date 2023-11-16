Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB463A4
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4w+QzK4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41c157bbd30so6869351cf.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 10:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700160307; x=1700765107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIMhsRX5I6Zmn3n6vGAdEXdvE08DpBxwEnnneJtPlQM=;
        b=c4w+QzK4qfR97ah1i1SRypWx9tI3sM9Y1ZKzvuB+pIGAU4loCCNfpg+XfwDC8Ib9Wn
         0imq3b3OKj+lqybdgrxOwCsqd9YCabRIJaoJWAZVFjtY5cXWpDmoosZoASZgujrXSlba
         wz2+I72G4Je6+yo/fhPF4g+mOlw4faTKLPvbD8ikBFiG0tgmB1I29fYyuQ9QlIgLXDsK
         pvyE6ju3gFoTlIgUfzODBu+CTeP04Hk8i23hWQ5504DM92ciBOp/7xzW2zKCxBj2raym
         ruomVNWoscinJtSjSPNaI+5axgcRczPhyd3BwigUSgoO4C5uUJ2QF7p95RVmjg4n7F9F
         WfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160307; x=1700765107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIMhsRX5I6Zmn3n6vGAdEXdvE08DpBxwEnnneJtPlQM=;
        b=feWKmzv9wVinaANSaGA0kjIPvgaPBih4087ilH2RjuKhBUmQpD3LGHJkgMmrcTM1QS
         Aq7qcGnbtva83mTJiUrVi90eOSJHhlmMcJVwpaYk+ET633bQDW9r35R3Shctngi7rShr
         jUe7QVbJamk0ob9X1xJZ0B9JxgK+BC1+m2nhoIZVhWj3LpaXYNGY2qApnKbP/DpJpThc
         AyzKJha2ogiJ6vYWB4UwG19xjsFV9Fh6JpqHZM/faLm3aHa4qHvX5C8BNPAuEk/Y+Ey8
         VIegKnOEi0rv0KE8JF1Qx8+/7vSxDGxMF79/GNZ/eUR5QJ8ZS3oQN92tKq/bYHjznR8E
         y92w==
X-Gm-Message-State: AOJu0YxIRtWcZjJnpUtXLkTwY90cmPr14pEz+oPLjRcF0S8GuvDxk+tK
	jIbQRQl175vgiUCBXj0y/aAA6KglvJc=
X-Google-Smtp-Source: AGHT+IHf80TYDy+TV3DrZa+t9NK+y3c/10AT72E0E7cm5LZ1o8KXfnLdNVgNWYDoZzn5/UWEdacQmA==
X-Received: by 2002:ac8:5d05:0:b0:417:bd2c:2683 with SMTP id f5-20020ac85d05000000b00417bd2c2683mr12758875qtx.19.1700160306503;
        Thu, 16 Nov 2023 10:45:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b7-20020ac84f07000000b004196d75d79csm4533261qte.46.2023.11.16.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:45:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] dpp-util: store SSID as string, not raw buffer
Date: Thu, 16 Nov 2023 10:44:57 -0800
Message-Id: <20231116184459.292601-1-prestwoj@gmail.com>
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
index b5fc029c..222ba053 100644
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

