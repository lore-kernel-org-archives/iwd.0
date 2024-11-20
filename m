Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7919EED7
	for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106471; cv=none; b=W0emDf5ADa6UWSkkC6grwVES/ozUae2t9o6qQiFLIo+cvQYcVO6b1jyXWisbGZ1hdpx83L2z+BNbe5VJbR6QPbaW4Tonfpb/3R1ym63fjhdkz9UQLY9FoG1AQ9Q7VCnH9Jx9bxvn2DoCdEytgG78qI2y8K6aAIEm22oKVKVx7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106471; c=relaxed/simple;
	bh=YnwtdCGRMF7x+SNw+RtndWficPrQZ0LYRjj64IJNzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OyfOr4Qc9XOjv9I46GSqkO/V2xwuZ6m58FyU5fD+2ENPV6CAYWXyz8n4KG4UG1fSbPtPkdRE1ckyw+lLtaA5cdu3RxV4hoNJCrE5s9MuRelc9235pTO85JKOsQ5y3fDb/1lVH8FaDvuuW+RYiFJAXDaR+hp0bMP9KwSUqWb41KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=newwGJtl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="newwGJtl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so49716265ad.3
        for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732106468; x=1732711268; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8ih+IafpKjggtIc5IF4N7jWsB7ermU4oeyGhK/Y95c=;
        b=newwGJtl9OecSb9RZaUJ7YXBFybDNcMiwQmKrYayl1+5NbFLS6o5cKxGnAMFoLWPxR
         N+O0niLm3OCEx0jZfKuWrsub64E9/n41mWLl5Vpu4U/z01Umz34QBkU2/Qq+nreeaoPh
         N/JmP4bdBudGhee6GyDxyxxDOk+Q9f5LPfGNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106468; x=1732711268;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8ih+IafpKjggtIc5IF4N7jWsB7ermU4oeyGhK/Y95c=;
        b=DYqfqtpz0vKJpQtlEfS3/1a23EdDxTvPHf/9QV4QdBJ64ZwNd6oKA2tz7Y2uQQy1AO
         3lDIbQfGcGBaHYeH3wvKhU1iMmaLErQRbz6viFHMqtZBhM8RjeUt+BxbUKewf2olNPjh
         gKuh+HtQojM4zfKgElKIog9PQ1L6oH2ZLvD03c0GLmycc8a79a/anEnzuK5MrtpNbada
         bCiPk1FmhLSOpqZ2QlBfPY3r5o2ubnoQQ2CTTFwEvNGWTs8xtWmQVMdeMECVVWTveYs8
         L6hVcIKfYQkSLmIRhZ83e8hv2yaxDNvpe3K4brHnWZNPmiKnYTbHS7DadDJd9RID3Zbw
         GnHQ==
X-Gm-Message-State: AOJu0Yw3uRS/FXtGGrckloO94ufXT6L/Ann4VUr/jTF9EBwTu8G0GNlL
	PmfYxoQfqEa+Q5r9hdyFFL+UvIeb2ycoU2R17Sh84nB7Gl2P5MypH5rwAIRVspHy30vZ0G2apjr
	g
X-Google-Smtp-Source: AGHT+IGDur9M+bkYoE73kEKNO44kkWFXLPg+12eRdZ1nqsHekIG1PBAGnKB+Pxa+pCmlGAKsLE76hw==
X-Received: by 2002:a17:902:c94a:b0:20c:5404:ed69 with SMTP id d9443c01a7336-2126aeb10c8mr27865725ad.31.1732106468539;
        Wed, 20 Nov 2024 04:41:08 -0800 (PST)
Received: from c8d99ad60702 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2121859c307sm57891665ad.238.2024.11.20.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:41:08 -0800 (PST)
Date: Wed, 20 Nov 2024 12:41:04 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: iwd@lists.linux.dev
Cc: rudi@heitbaum.com
Subject: [PATCH 2/2] anqputil: fix -std=c23 build failure
Message-ID: <Zz3Y4LB9MPT25udE@c8d99ad60702>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `iwd` fails the build as:

    ../src/anqputil.c:134:24: error: incompatible types when returning type '_Bool' but 'char **' was expected
      134 |                 return false;
          |                        ^~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 src/anqputil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/anqputil.c b/src/anqputil.c
index c0e0307e..724ff22d 100644
--- a/src/anqputil.c
+++ b/src/anqputil.c
@@ -131,7 +131,7 @@ char **anqp_parse_nai_realms(const unsigned char *anqp, unsigned int len)
 	uint16_t count;
 
 	if (len < 2)
-		return false;
+		return NULL;
 
 	count = l_get_le16(anqp);
 
-- 
2.43.0

