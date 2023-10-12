Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1693C6A9
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaJtQQOd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-69af8a42066so1103689b3a.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140919; x=1697745719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm9ori2QRIFOTp/oCZLnpkkk/QtPez7Wn8BEmLoJbFo=;
        b=FaJtQQOdnyiiyIzYpYyN/wmKsUgrWmyUr5r0li0/QB5NGGOfJpcPky9cvLzTPJvfLD
         3QWIqMCmqJ99YL6aDt2LDn75pX7j9C2TWuUAE6sCUuw2bMvfxzS63+/eJ8GJtxa7fEgF
         jLkqDkyBH1FFO1RGV9RnqZn2R4h/NXSaSDYYCRIOOSQ5jxvRM+b+H8IFXhHP0aj+cSzK
         zwfUffbl4xq9u2R+PMusV5DKNdCmWqPVbQtUWZcp/DsvRffLYBKxRAWFaGvPr631kI53
         f2yv8H2ZmGr0Rz0zXIBGx3LtT1efAnk2+B2N4+6wWGoOEpOuUvmSBbfFUBeNZiPgh4v4
         EKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140919; x=1697745719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm9ori2QRIFOTp/oCZLnpkkk/QtPez7Wn8BEmLoJbFo=;
        b=RIIVZ4VCdAU4/8aTSBzV6s0BTWao/i8v3EvIc+GR6Kp+kepVpkjNx/BNjOKK3tAYph
         F1RdTiUpRLD0CVOy7jf7vK2ytLN3uX/yEMzWBA+JCUG4GoiVa9t1QmC84Hpgc4kQnYZT
         nxRHzd5T2R7Kxw4gZjQxTwR0noEdF8us6flSgBaNqN4zY1dX4LY7z0+ewCytM6jWkUmO
         waXjZq2jpK0u9fmzIVjF4xBgs8qGX63Q0pN27g/zt4wfstFtbh1aCApwNTHBPfpXS4IM
         BIs84hYMGU7d6c7WsmlNQq3ggFU23veesLMReBalBqT/Eu52sfu+b7Q3ZBAZXqvbFkyN
         5i8g==
X-Gm-Message-State: AOJu0YxfMBxliuuz/3IaOeSr+VHZHYBagn7zzWDnHyBNrqmJJ4WEsiYC
	kZKh7NykpP6praSl4x1HOMfC9QsrgiM=
X-Google-Smtp-Source: AGHT+IE2j/lwLCDpK6BD2ZzDdL1JN/cjWTYFXqJp/6k3FDyAflKeWXuiqsFO5oV6iLiF/H+p+1RX8A==
X-Received: by 2002:a05:6a20:3d01:b0:14c:446c:b188 with SMTP id y1-20020a056a203d0100b0014c446cb188mr27444484pzi.37.1697140919514;
        Thu, 12 Oct 2023 13:01:59 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:01:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/21] dpp-util: fix typo "COMMIT_REVEAP_RESPONSE"
Date: Thu, 12 Oct 2023 13:01:31 -0700
Message-Id: <20231012200150.338401-3-prestwoj@gmail.com>
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
 src/dpp-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp-util.h b/src/dpp-util.h
index a3ddd452..94fe595a 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -43,7 +43,7 @@ enum dpp_frame_type {
 	DPP_FRAME_PKEX_VERSION1_XCHG_REQUST	= 7,
 	DPP_FRAME_PKEX_XCHG_RESPONSE		= 8,
 	DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST	= 9,
-	DPP_FRAME_PKEX_COMMIT_REVEAP_RESPONSE	= 10,
+	DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE	= 10,
 	DPP_FRAME_CONFIGURATION_RESULT		= 11,
 	DPP_FRAME_CONNECTION_STATUS_RESULT	= 12,
 	DPP_FRAME_PRESENCE_ANNOUNCEMENT		= 13,
-- 
2.25.1

