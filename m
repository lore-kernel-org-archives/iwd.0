Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2520B202
	for <iwd@lists.linux.dev>; Mon,  2 Dec 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151288; cv=none; b=s1u0Ssm5ohF2d4U1xXJRNRMqiygI8G9fUP7MjamxpJHz6Lk93r3OgRza62HHtOr/4waPvHg/xUBeAuuGL5Hf2pJvxdBCaYh7n+Rwz8Lc7WRl52ZzQZhkGBau2pwzwRTe7yyBsBtNTqrtJfKAPCg3wsEUPQ1ymsfmsU2ADvPtKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151288; c=relaxed/simple;
	bh=2Zi4/vqFtxByKs/3VxDoJnY99JyExLX1mp2WF7lSBr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbPVWbtZSzZuj5X0tw+k/ClcN2iG59tKP7pXDcO1fNghBrsQGJfap2kP9KJ7WL5Nh+plhWzueboLzBPg2v1eP4gDdsriaerhKjUY8ZFZcvC+7iwBhwWTpNLOfI0rG29Gp9xiYMkF5p2qh69vUgxI7NuSAIyHorwtLuRTv16ybD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0KsbNKE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0KsbNKE"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3072996a12.1
        for <iwd@lists.linux.dev>; Mon, 02 Dec 2024 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151285; x=1733756085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTf38Av7Y42HfeDckzjvAA0AbIrAstHrD8Hg1EQv/xY=;
        b=N0KsbNKEMreg4BcVWh2vjVVITsqPkrb7y/GEoUUe/MCrlnumoMt40/jiwrR9mkZRg9
         +3uwbD0fEVCLXZKTLnGTBKfCxrfNKQAR1Ftx7uLRP3CTcwfuOMYqW9iOqMLgtd14WYGz
         CURtGFVbccJfSw8udtI2/xmvNApQ/hqDBugb54yjJvbnW+xq1XzGDkoVguPKz88928Gv
         8yTYjwoHfSGPdwe/cieigj1XDVNj6hWyPpKpcHpzaplm6FbcJG3Y/+9JbT0mXVbwWGoo
         fxwIUm2mWmdHvLX3tOlSJOSoN87vmH4ZLRvjxl3JxghLjZxazUQbR5eNS3kThm6FLGdJ
         54Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151285; x=1733756085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTf38Av7Y42HfeDckzjvAA0AbIrAstHrD8Hg1EQv/xY=;
        b=aGM0Ay6PURiKliTrrvrDa1foVzPF2gjIBjnvTYvTL/eo2YaAEd21i1e6jpKpa2xc01
         JI/Na1igHOnqiYvkbhNwQOsJuU+QGm1WnZNHMfcvFJP+hob3kMfo6wMzGl79gyvAiTeR
         CNkRkB0swi961nTPDdDSsLmPiCxMvfXD//q7obKP4aqSU74+jcy7vFH0FGnAQLqu164x
         G7ICEUEI10nYKjrjbae3ViiTgd3KHgamaLq5YhKWSW325yUw0ZBWurp0xI25LF4Za1go
         izrBJIZuZ9dAacsoovdlmoIBbtx2Hfd66qL/TaRP+A3ptAiFJiC2+gqpbjPcjPGXq+6D
         jXtQ==
X-Gm-Message-State: AOJu0YwNwXwm8shtWPdlXLaYZePIErSSDPtOxGJ3MpaktRXhj+b9TF3B
	AE7xlytG5JbJvxSYTGY9pIlDZYhoqLsxoaQ7MNv6jkT/cy+TI/QPGzBqmA==
X-Gm-Gg: ASbGnctU9y8EQOFC1bhqYQGnyDd18oxI/++SXiLAxP+kNwH1+aRPaQfKLwYn2bkf4fk
	exy0cjOEVoY6G1LiSfzqypHwhVsNmciEMnhl42zGpQ8yQWFPGyUGcwKpGk2i5wHdM4M6B66SsIs
	k6NdlyQO93gqJUWX8NKbiu/k/Zn89BYSVhB+V5ZONci9+BTPSFJqm4/hi2SKLbknacZVJ+vvVFB
	SnVDv+U6DMNgFcwXAVguEP1DG0ydRpeWkjX125RZc7F/K4dG5s7Tzek9iGiGXy1jbjdFA/TBU3K
	2NOfPchg
X-Google-Smtp-Source: AGHT+IF/xdUxoejCZZnUiPqJ8UOE+m/5QJ+22Yr06T8Vm0fEfQE4XRtDymdDmgIAlZSG2CkzKlwy2A==
X-Received: by 2002:a17:90b:5289:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2eea127bc24mr9125998a91.36.1733151285528;
        Mon, 02 Dec 2024 06:54:45 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6cec695csm5592474a91.2.2024.12.02.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:54:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] monitor: track current PCAP size
Date: Mon,  2 Dec 2024 06:54:36 -0800
Message-Id: <20241202145438.282998-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202145438.282998-1-prestwoj@gmail.com>
References: <20241202145438.282998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will come into play when support for rolling captures is
added to iwmon.
---
 monitor/pcap.c | 10 ++++++++++
 monitor/pcap.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/monitor/pcap.c b/monitor/pcap.c
index fb29eea8..b13a29f3 100644
--- a/monitor/pcap.c
+++ b/monitor/pcap.c
@@ -60,6 +60,7 @@ struct pcap {
 	bool closed;
 	uint32_t type;
 	uint32_t snaplen;
+	size_t size;
 };
 
 struct pcap *pcap_open(const char *pathname)
@@ -152,6 +153,8 @@ struct pcap *pcap_create(const char *pathname)
 		goto failed;
 	}
 
+	pcap->size += len;
+
 	return pcap;
 
 failed:
@@ -188,6 +191,11 @@ uint32_t pcap_get_snaplen(struct pcap *pcap)
 	return pcap->snaplen;
 }
 
+size_t pcap_get_size(struct pcap *pcap)
+{
+	return pcap->size;
+}
+
 bool pcap_read(struct pcap *pcap, struct timeval *tv,
 		void *data, uint32_t size, uint32_t *len, uint32_t *real_len)
 {
@@ -279,5 +287,7 @@ bool pcap_write(struct pcap *pcap, const struct timeval *tv,
 		return false;
 	}
 
+	pcap->size += written;
+
 	return true;
 }
diff --git a/monitor/pcap.h b/monitor/pcap.h
index 1705b33d..5b797cf3 100644
--- a/monitor/pcap.h
+++ b/monitor/pcap.h
@@ -36,6 +36,7 @@ void pcap_close(struct pcap *pcap);
 
 uint32_t pcap_get_type(struct pcap *pcap);
 uint32_t pcap_get_snaplen(struct pcap *pcap);
+size_t pcap_get_size(struct pcap *pcap);
 
 bool pcap_read(struct pcap *pcap, struct timeval *tv,
 		void *data, uint32_t size, uint32_t *len, uint32_t *real_len);
-- 
2.34.1

