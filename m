Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AF216E01
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824840; cv=none; b=pbsEacudTYvp0axYoYJeQL9D3kUmVQnuB9fHa6tLKVPefBxEYgV1v6eaWx2gZGH3QoK3V4YRv1LpX5fWQL8GL/MPMjOrYjLmGdULuGUhUvPThiVWoGQCHoTDSJxdGU6hmlW99vN70ee0fFWZ0+5qt0kgo9FEyC1W5iia6DnuSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824840; c=relaxed/simple;
	bh=PJCRjMHXOzjUyI+h359JuFpD4UQLpHdmu1IbT2Xsnvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NlH/AQ0s5izq31SOAPlwrHbjdvdYkGeRgByxT8aFYDGyMppdihggmVRBn7N/ONRBhH6mmtZqHmtT1gOirT825Yc8bITNykBUDcoHuT734UNCfyk4RIemRs5fLAQSNzgZQz5Plj+qDDK2tCLER34+HNxqErQLcKjZezGPlSJ+DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFvmbeip; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFvmbeip"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c336fcdaaso11297085ad.3
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824838; x=1745429638; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4/M3gh8nVjAPqDlnPb5o+BaWwzQmHT1Kz5inX7ttb8=;
        b=VFvmbeipsvVV7FHyyGcsi69eU4RqwSakCc5kJBFgvFSzhXaO/6JI6/OdJ5FgiX72iq
         /ED4ki2EMJHcX9ej3ETTnhR8+iyG9wV1QOtbK7gQkgkoWV1GEhBnxYptEfBN+dyWOVMS
         rZTwyQ0NQFoFDHv+1ma+dki5SVQcwV2iTsYZXXYQgLmwEti+Rn9Cfbm0N9rVuMvvLvnx
         bddJA2Cb/hJyuzaB2kXncp92LWj+0UayIpW+aXRxPm966PXmdNKzUuxEIvQLaMqbmi5A
         MTT3yOAb0qFOQ42H4MZwdxRTQQlvc4HFEId7pdMOrfNjbBR95VkB23erHm35Y4UtAWPF
         nV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824838; x=1745429638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4/M3gh8nVjAPqDlnPb5o+BaWwzQmHT1Kz5inX7ttb8=;
        b=KEzoQZ5UUWFmnWwT/FgF1hfu5KAtFYZbxwoSG6vTdSfnvUAHxQhx4tGTLURQ4rcLeX
         JmGPW84Msl9x5okzExZ08DYDsKsGnZ7Wi3kPRRvT0vuT4vO2CqaRL9MT6C/aOAxW/Z92
         mPievSQ6Uc47ikXsLPOVcr5iGN3cRp6zjQzcjHYOkYhvqcyNuM8MlwJsBaGyfj0FQh+v
         kV3voR8pyelwxmJwE0bWxDUq4MoDun+ylDwU+3hfoOrOMe8qeZAxAv4s1WpjMuFRnkWd
         qMIOj6D/L13Q0uK3LN9G4Z3OTbCYQm/lO5iZLAYvPJ4FRAaSmYnmYQNAaWYoK8u7FGtZ
         qzSg==
X-Gm-Message-State: AOJu0Ywjt2Q1nPPZ6IC1YTl1W0bsTIKlLF2+TuthPZknZUcfCdI+/Mu9
	fOTxYfhM59qoG0cZxhKBTFNkuDBFX5aH6Eq5RF3xNFvU1H1kv9clvaWJsQ==
X-Gm-Gg: ASbGnctjxj2dzfv7oufm0JBJMZnX6BAyAQZVCmJY6UqiESj7TFF/GqvoW00aAgeUr7F
	zKlx9ac+luC//9Fg1K+5muXH5RbNKc9t2gNT/Mp3dwJIBOp0Lxp3wOWC7jNjsM62s3gT5IcK2/D
	9gCgNdKk/hB0by9turmcykzPypCLh5P485N6LF+TC0JtfZG4pDn+l96EvEdp+4ZM2e/R84wTO6V
	MH0rQ9wXX6nrLnv4xkvTk8Xc+EXlGvLadcCiBSa1/RFvIpot3YuzRIxs5kRCGRR/+cJarBSDNm5
	Ibr1WobT6oyGbuZoPoda3UUN+akNYufJqiHKNn14bgVSMuPVaAc=
X-Google-Smtp-Source: AGHT+IHtZPz5z8NoLfoFtinwANCSUaQ0rljCC+gE6/Sep59W9TrtMrpfv0U1fRrAHutudvZnIYg7Kw==
X-Received: by 2002:a17:903:41cd:b0:224:10a2:cae1 with SMTP id d9443c01a7336-22c3596d603mr37416935ad.37.1744824837790;
        Wed, 16 Apr 2025 10:33:57 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/9] monitor: add size check for interworking IE parsing
Date: Wed, 16 Apr 2025 10:33:41 -0700
Message-Id: <20250416173345.136025-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: e0c9b684 ("monitor: parse/print HS2.0/WFA IEs")
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 14a29eab..7924f6f2 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1915,7 +1915,7 @@ static void print_ie_interworking(unsigned int level,
 	size--;
 	ptr++;
 
-	if (!size)
+	if (size < 2)
 		return;
 
 	/*
-- 
2.34.1

