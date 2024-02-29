Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B038DEA
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226467; cv=none; b=NjlJgrU/7oCvHcjD8vM6PkJZLddteUC2JuE9CvY17luvUgWTfdBgJkKIJzNIRM8qmtqsl44vsALl/BP/22LELoUWEzZIY4+QB9jTs7fHI85gGav2IP51AcIjaY4m55J8I19cWyZJ87kUMvj1NhC7Pg7uI6cUsyqhDB8adCYPIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226467; c=relaxed/simple;
	bh=wRYzg7yNMn9DQbF3UoF29TqwcvPYF9V6bNpt/QXS8wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlQG6EJcGFrHpt6P/JkpwPoUflp3/K8XIQY1V0vZnGYqcJK8eBJfr9tBMx/Bls4XQ+Rp/+l0jj50gPwPS97GKp6TfgTkHyHlAEO+aPbFZIV1StWyTB4PmbigYwZlvB/8obrMiULj6FbY0gNpxrsWsxkc2gyWCR0/N898fldmaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by5ESrh1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by5ESrh1"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42e4f706847so7495601cf.2
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226465; x=1709831265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDPK0JaDzZBZaoki4cfQ9zQ9FiyzXFmTKABH146snPQ=;
        b=by5ESrh1VlDkoVWKSwypjWdWsW5ujZI2Wg8wsOioVna2kJvUh5KVN2XMkKyDMnFkIH
         4Msei4gcH9n1QnVbhZDqMJNzEZNWPS7N/jaVWixD5JXjukTKDVb1vdKcgTYHihz2QpFS
         ucT/YwTpJd9wohxjJLZbkrZESOgFMMmiTI2O1mX5KBiGBG9VSai1hnDWqXvvt0Qmen1F
         FtBRt5qugyI44UQfOItCNk/IHiCldEv7D2yKcewJJ/UrhYCLvi6bhjELNV0GMyHkqDJn
         lkseb4+8sm1ZRIdFiNrmZoWx7yCg8O0qY2a2zc9x9KKTszM1KItbRDJ7gQsmKNfYgJUS
         96aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226465; x=1709831265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDPK0JaDzZBZaoki4cfQ9zQ9FiyzXFmTKABH146snPQ=;
        b=tXOGJYFjSnBcyByTvJgOPKGrNRAFXAsXdJ/5b4KVULgGCNoho46nyI/wg1rjkNTzh8
         fcjC60IegirNoBKPOLl6ZOSHPgUt8KhlNZ0eZ16uu79uDfUn6FIHXalpoOa/D4GsPEqt
         LcD61ltp6d52sOBp2rM2vT7l/4DcZfoVEDFcSAV1YVLMVqCyVJM/QrvTZhsUmzSTqcbB
         ttFNqBGZFjoaEZ7Znb/izEfPqN4C6xwIwq9yEjMSicUAZtf4yXrrC+5UDw5bveRlINF/
         6M0r9YUtvKM09TIlr7od4UHja54mSh3LqHd/DLTi84Qb4LIHRuODnPYVoQVTrtUBXnpl
         J4Fg==
X-Gm-Message-State: AOJu0YwtY95DcanHdHxAq86heePAsKG6MLuCMAdqCkI6+izank2Z4DZt
	7Gd/7rRVbX4j47AFWhgfZqhBTVta/NmlMdvgtlmtf3RGa58kiCbusXiDWo3b
X-Google-Smtp-Source: AGHT+IGS8hKFIeKbUX3fCViPPScbjsmqaR2KGKtPPVZHlKdot3sLMj3yu6arKPJJGgbkiubaWncAhQ==
X-Received: by 2002:ac8:6b06:0:b0:42e:b981:6f9a with SMTP id w6-20020ac86b06000000b0042eb9816f9amr2343528qts.45.1709226465107;
        Thu, 29 Feb 2024 09:07:45 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj36-20020a05620a1da400b00787fd080d28sm697415qkn.74.2024.02.29.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:07:44 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Alex Radocea <alex@supernetworks.org>
Subject: [PATCH 5/5] p2putil: check length of client info description
Date: Thu, 29 Feb 2024 09:07:34 -0800
Message-Id: <20240229170734.1498918-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229170734.1498918-1-prestwoj@gmail.com>
References: <20240229170734.1498918-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A length check was missing which could cause a out of bounds read.

Co-authored-by: Alex Radocea <alex@supernetworks.org>
---
 src/p2putil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/p2putil.c b/src/p2putil.c
index c90810e5..d1f114d0 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -376,6 +376,9 @@ static bool extract_p2p_group_info(const uint8_t *attr, size_t len,
 		desc = l_new(struct p2p_client_info_descriptor, 1);
 		l_queue_push_tail(*out, desc);
 
+		if (desc_len < 24)
+			goto error;
+
 		memcpy(desc->device_addr, attr + 0, 6);
 		memcpy(desc->interface_addr, attr + 6, 6);
 		desc->device_caps = attr[12];
-- 
2.34.1

