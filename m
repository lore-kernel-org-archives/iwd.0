Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA740C03
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSAKADyu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77f42ee9370so17264985a.2
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 06:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957654; x=1702562454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=YSAKADyuGzJvsf1PZo+l+IXIOQpsGVl+1IW1eByjr4Fjfb4obA5tDK1c2yZK6nN3La
         5akEjMFAOkvY1zI42YneRZnqM34l3CtARmN/VI7GNeo12LGKnrKUpCiabcrHtEyotHTS
         xDMido4TPjmv8394K4ODsgZc7kxM2f29utb0FS34/o31Y1SCfbclJwuxOYGvIM5QYrmi
         CB08OQxyyIDuhgcvR06sDuPwmEqGbR7PYBNg6ORVrhz6+w8jYjK9zsceegJz1CXmT5Fv
         hshLKSUxA3o8xsgPKMd0YVV6L7/60rjPo+jr/cFSVY10DfMLOAgAjBEXvIT7MWZqkZqq
         evtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957654; x=1702562454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=crXCQahgBU6DVgrPtmIJ+xYhVu87GFEfmyAnFxYm9SChjaxpbOK5gsSTn+q7DQONmD
         /dXLsDBml+NdGjGCCj8XxDGuQiK1xdCu4QzB1NPCR28X44jFM2/tPwac/iJJuD7lSuMB
         daUf9eDvtxrDuaWSYd8tgxt5JmGQKWsKQI1DvBBxiQKamPLRGi91NGPSls46HBNvcPZI
         VowQN2V//WpRkuAwmU4YlsaDm8/ubY3wzPDpJdwqu2izYfambm+fcou0z/NWEGy7smKE
         HWLwC+7ChrhP1u4DN83+U6jANeUFNuwTg8D8wwb3nq7zfvkhuHpuaKqgBdCKkPLXYrRO
         HmNw==
X-Gm-Message-State: AOJu0YzmsGSV1BiaOrXC2pk2rzuUub966iuYSSFaRK/agfIz/PTO1qUC
	6QP4cq5PGFovfv0OjbZt9x8MAoaDb88=
X-Google-Smtp-Source: AGHT+IEhcLXHEMKoMBa6+3sp28zGXwlgAeq4xO3Z11Uv9AglHIeSo0z8utuKIU84YhfZ4uJBGW9ipg==
X-Received: by 2002:a05:620a:15a4:b0:77f:d39:ea3c with SMTP id f4-20020a05620a15a400b0077f0d39ea3cmr1214456qkk.87.1701957653794;
        Thu, 07 Dec 2023 06:00:53 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id px24-20020a05620a871800b0077dc1476413sm407699qkn.131.2023.12.07.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:00:53 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] doc: document [Security].PasswordIdentifier
Date: Thu,  7 Dec 2023 06:00:47 -0800
Message-Id: <20231207140049.2614514-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207140049.2614514-1-prestwoj@gmail.com>
References: <20231207140049.2614514-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.network.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 719853fa..734dcfa1 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -199,6 +199,12 @@ connect to that network.
        required if the *PreSharedKey* is not provided.  If not provided in
        settings, the agent will be asked for the passphrase at connection
        time.
+   * - PasswordIdentifier
+     - string
+
+       An identifer string to be used with the passphrase. This is used for
+       WPA3-Personal (SAE) networks if the security has enabled password
+       identifiers for clients.
    * - PreSharedKey
      - 64 character hex string
 
-- 
2.34.1

