Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25024132C22
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005206; cv=none; b=rn0dAe5eCrrjJ0qdHkQLqyVxc+paCQiYooknYYUBr4cLzbODIlwx6N1Vaw2AqrElW9rqCQQ+3+LbxQ6sZ3VaquEoYPNdBZNCXguKk+arQoli68Y8BghYqSTxNmrtsGT/v2wZdlSn0n+jFBr+2rG45KwdeFkK7PqUOepi7RH6xAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005206; c=relaxed/simple;
	bh=LJoLeAE377m3o2ZghzXK0X5F3U1q/K+f/tdKVMdJCSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X8zsGl+wodAWB7uKV95KdpbD6a3+SvVjyxAwjLrp5fY3x6aLySaTSN0w5r736dgMZYsUQTP2fxvMtpSuWSM4SYVI1w7F5A3TnwLj7gRVu/YCE4XbYLG4+Nq/ghYEXlkvKV4lQLRHLFOdDT+qOC1Kbnc3VgmYv6myB8ZMEMitukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGcxrrFV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGcxrrFV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71cb97937so8502735ad.3
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005204; x=1708610004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSyTzFw2oJ1tFpwu8ZYGlCRE54SwLgvuEsRx26RIiXg=;
        b=ZGcxrrFVIgvCBPWzr1MkCi77E/aFAvMsoVK5RY2KZqseHkNfEqQDd20M15XWOGZivG
         1ZEqde+7Hz4m1VQwWiV4hcalg4UAs2i35MbfVzRErOBRkTh9RcgKLCWrhQb0RGoZEWaw
         m/kIXuDlpbCiBYC7ZTVhYqsZoHRMgxu7KEKAfoyYkoDuonK5fAHJaFm3jHgY16BP25pm
         V7NE77myEQ+4fIStBjUFHPGWEs6dtGMiU0Ei1xdxdoQ2dZpp+f/970/u0mDpmoRSHdYm
         OTdkBgvCt6Lh+DWRX3OxjEG01TIlosTL6uw7V+jYLwD6SMIlICntRnrl2kAPrvICkIo6
         WU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005204; x=1708610004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSyTzFw2oJ1tFpwu8ZYGlCRE54SwLgvuEsRx26RIiXg=;
        b=HWmHAKXJmYqp0TnAciYjV1LAXJXwq6UODbN0yng2V2yXuxge2A78m3hK1N/t5iZZnc
         zYYerp2JmaOY/QV3PndHxdlx2zE3Jc59ri4Vtw8J8Llfo5srgNuA+1KQSE6vSQdjIdi3
         +eNm1Ex3crUQgtFzIXzbX5qei24nCHHZUxTPd95VUFITmkdaNh0FRNinOSfhhK7UJ4+L
         jNGVvK4Y2Sqr8xmCHqVhq+3Clf69sH1CwfKoFdtZ5x5f92Ioj7SR/qdI+Zj5o+D/X4oA
         Mvr52KygBEmQCAWH6ii/pDvgs9kcEGXDnFwEFvoenGyNF75aP8JCcUR/U2FUr9HGF4bf
         NSCg==
X-Gm-Message-State: AOJu0YwVTNRceIpWWMGfqpTn1WW/GwJbXuGOsP8NrvY4C6wCoSUXy6nW
	B7QOjcS8pIBOM6TEdve9zY1JU9qncA1uMAZ2LLosXBqI4RIsWmvjSHdipjto5cM=
X-Google-Smtp-Source: AGHT+IFghXYVzo5rMbOSBqC99qCfz5ddJJgQ7TJsvgJFLohKJ0ucADRQ87pvUOtw8d/2/N0hChdVxQ==
X-Received: by 2002:a17:902:d4ca:b0:1db:672e:8e34 with SMTP id o10-20020a170902d4ca00b001db672e8e34mr1957396plg.31.1708005203886;
        Thu, 15 Feb 2024 05:53:23 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 0/5] Using l_notice for low level IWD state information
Date: Thu, 15 Feb 2024 05:53:09 -0800
Message-Id: <20240215135314.1017081-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 * Removed use of station_debug_event for notice logs
 * Added iwd_notice to wrap l_notice:
     1. To aid in enforcement of the formatting
     2. To make it easier to enforce proper notice use during patch
        review, so people aren't calling l_notice directly.
   If we want a separate header for this thats fine, I just put it in
   iwd.h for now.
 * Made notice events constant defines. Using enums would be nice but
   in order to specify and event + formatting string constant strings
   were the only simple way to do that without reading in each
   argument via va_args. If anyone has better ideas I'm open to them.
 * Please don't merge this, I still want to get more events added and
   make sure its as easy as possible to write tooling before we
   upstream. With this RFC I merely wanted to get feedback on how
   we should do this, not necissarily specifics on what events we
   should/shouldn't be logging.

James Prestwood (5):
  main: add runtime flag for setting the logger
  iwd: add iwd_notice for special event/state type of logging
  doc: document use of l_log APIs
  station: use iwd_notice for state/event information
  netdev: add notice events for connection timeouts

 doc/coding-style.txt | 15 +++++++++++++++
 src/iwd.h            | 13 +++++++++++++
 src/main.c           | 14 ++++++++++++--
 src/netdev.c         |  7 ++++---
 src/station.c        | 32 +++++++++++++++++++++++++-------
 5 files changed, 69 insertions(+), 12 deletions(-)

-- 
2.34.1

