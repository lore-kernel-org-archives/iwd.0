Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD892D63F9
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892297; cv=none; b=bYWDCuzrNTJOfACzfm3/IjJz6K3XFdSCGMjRHkgruNmfFtQn9jORgP9ZWBS2lvESCfdpSZ2zxW1rinJTP0jhCyOru+64k9ILOVmlMWGixL5KHlceXQA7hPe0vAAvM1mgX9MgPMguX2eY7Cvem6grZkfnLPWA8lHpsnYOTzXu+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892297; c=relaxed/simple;
	bh=TaTyCBoQgG26iZcJwG1UdimVInZFZN+hDffkdbN6cow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTZVsEmJiaIzkLDAmEQGlETHaMdreWM/LHmuWx7v4Aa98sThnGK7R9XpvaLicNmkfbZbqR4Q2MfODegA5Zl27ZyqSvmAiILyELipMtssgbtZycbQYA3BzdTTflzBci13BJZkFYnlO7r1tAj+7hYxSLMob2RxfQew+xaBdlr1D1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y10dxH9L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y10dxH9L"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109a95f09so18622231cf.1
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892295; x=1756497095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXdRUI42odTAmXHZIGtzNaB1DSLhy64OmrIbnPr4w2U=;
        b=Y10dxH9LNynORD5Cr9oRKf82OhxhaEIPngXTHWtYEzY5NNGBXTmzdPT5YiKa49itmE
         69vzC8bofL/GWE+/UQqPtQ5ADCx/WPPbfFM2IY95r26ZeOrO4GwOPYMgC9KKtjT4BDA/
         AP6+4V3NcC8MjPmK496NOxw3nuYOoV1PZQp1/06w9Vos/EornI0HUbJzIQzlPWYJOa9J
         6QELQFMuPHQA+iWhHbXH0erx086G+DnHvwwaDIqi2ZRgJvHDSnnB34esoZK9WNmuWcCa
         ULCcS8aNBc90bCk0KvY0CW8/uVsrXphhy62gwUWKcLxuKtvrn8DM4Mm6nKwtjhW3riX5
         dH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892295; x=1756497095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXdRUI42odTAmXHZIGtzNaB1DSLhy64OmrIbnPr4w2U=;
        b=HYyqO6EaUB5P6S6CZwnq5NLyOwgjXv+CEFvHNa8xkI8hiiGYoCc9qO/14Inh9gnBL7
         cI9P62/vCrOWZjTXFOOJhcjptQAQBLuq+hYZk3qHSSVuJSl82n4jVuYSf9zMLXHAirAE
         cRNWdLKf3WrIyN9d0jvYihqk943et9M3MGsS+Zpolcs5Wbo8CTlE2y7Hni72YL8y27Nk
         o1oEs8KbuERia8gWNBs/8kD5k0NPrJGE2HvSenfSWaKCRNidhE/nmWnXGxhfLLxcMYG+
         jIn7uzWRrQaZu/HSH9Y0r6vYLcXY2OjlYOSncaawN1ShDs5SYbsBudTJlgBT6hrdwvuH
         CK+w==
X-Gm-Message-State: AOJu0YwxWHIcIC8j4o2kS8CIC2Cw3/LzpFu2sFfHV0vzU8Y3Nyrhwr0I
	Guv/AJAXLbQ5fPmYJJbHfZZjrJaNBoUsezuPG6Vc6jW/B91G2YJcYZ06gSJ9ng==
X-Gm-Gg: ASbGnctNjyxsj5gzsCKZi2ggoSA+3UVpJpywzXqJnUJtMq7mCArrNvtnc/kHsyIyjP0
	MdYacw6BGiHbG1ANWltdgm9557sVAEZVXLiffQpFVu1cGOXPrye+IJpmExAl/SS30isNsMpMho/
	15QM2UnhYPMOVqZmD0pFdQ2/A5/Kxhz1TO7b12eTvNbuu2VZ9BrcHDwDgwIPsyR9BMZH7d1ckoB
	wasmqYMTUb5LeBWZReJx7jwgD3TXhh3iyD30tLndkEQWhe4cWM8zq4OxvPzHeDXI+tCpKhcn/aF
	z1SEEviV0/evCYOer9kBPZlqGQKHu7mTOPdoYi8K8PD84c8BlpeovsytNTBxsOhpCkRgLvlr9q5
	VFuJ6rNP/zOjhCpoO8RR/v16J9PoE0jQ7
X-Google-Smtp-Source: AGHT+IF6n5swsRjwMMYYIXNSPJ4yzeU0ErWJsXVUDzZESjj1QbCl+ih5AL44fDgfK17JxnVoXSmSng==
X-Received: by 2002:a05:622a:199d:b0:4b0:7ad6:ea9c with SMTP id d75a77b69052e-4b2aaa6e769mr39309101cf.31.1755892294922;
        Fri, 22 Aug 2025 12:51:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/15] station: set vendor quirks into handshake object
Date: Fri, 22 Aug 2025 12:51:13 -0700
Message-Id: <20250822195118.271122-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index a4c3e7d1..339ee73c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1446,6 +1446,8 @@ static struct handshake_state *station_handshake_setup(struct station *station,
 	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
+	handshake_state_set_vendor_quirks(hs, bss->vendor_quirks);
+
 	/*
 	 * It can't hurt to try the FILS IP Address Assignment independent of
 	 * which auth-proto is actually used.
-- 
2.34.1

