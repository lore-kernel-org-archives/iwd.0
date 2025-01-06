Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6361DDC36
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171174; cv=none; b=oJdsX+LqbGnIjiZggzN8PgvQluFB4vnBh3KlIPIj0CCs/2hR1E8X53+hyWt72R1q3RCXxz4obPNOTvWPiliV50DKQ08fzXRZtN6fCN3V68jExqAf6jbZXjAh7hlt5OS3wkUhgAg6M/OOab4cvT5n8k3mvev44d8kiCOc2pez9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171174; c=relaxed/simple;
	bh=rZTewnHC1SOVFadrRe5DEo8j9Qce+0bqyZ7le3y2ldk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0lC+4R975H59HRKIr8zJRbaoH2y8W58UwO2/hCQ0ZjqsWOUFY9W9Qw48E0P4YuxhEkX4TGwEdFi4UH7zuP0BrX5WhUux10/ybbbcrHo41SykIJRiC39idLb8t1TqwdLfXNsWTuX0LR28ZKhE9YiCUkjrVGvkmruRHQtmg74utQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwkyKU1R; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwkyKU1R"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6eeff1fdfso1087278185a.2
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736171170; x=1736775970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecmH1mgPpQaGSLGagbFsUgNlM/6zzM8T/uWnBcQOdpE=;
        b=CwkyKU1Rb2Ze5tBq6Mf2jIZs/Rw4ByvPXw2RobwPISyH2AK0MnALnm67U+2aLZ1M4R
         0Re71ksQ0THP+Hmc1mq9Az3IIIY5MepS2FtofJ0bpg1U7to1DeAriBbRDZ1b6GM64PgB
         qFix87+tit7wQJiDQewyNPUa/1cpYwGr307631Hf8FWv+STcK57LuGRPHhlPCjV+e6sm
         TCrsw83/rTqdfQsVSEcwCsD0/rHmXQDtmmihzep4ARdo3lg+xvnnlbRwmMxSTxBzRCgg
         IkoIEdGTcuEIqHhb08iqqZ0X1TVYaqd5Bud7ZrYcngUzba2iNC6ZzA1NlcwecbpW9x3X
         PNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736171170; x=1736775970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecmH1mgPpQaGSLGagbFsUgNlM/6zzM8T/uWnBcQOdpE=;
        b=uxoPnNjHxk+rN5q+OyyPNH/JzRnH3PRzigFmYuva66JBB1unqwHwrKSJLnsgFnLKLq
         7GA0WBDwhh2hKVNbR3+dA93cpLoFzODWBtsbcB94ueP3oH2hXLvAyKCkxdopMdFZXsva
         wXu/vFWyqkjVBBvSDLWxpJeGxle0ibYRb1R5y8P/i4WiZLAjdK87j3iu8X80B3pUjd+X
         Da6y2Z4y9BJs4oR8eO4tOZQVR/Nz31r0lNBwNVQZfBoC/Nlfc/o5G3qIRDEexcY9OO/t
         CxTmNF27dhHSCH4zo0wGnkiDRJ2NEcSpOE8doM4z1O56GDLLSJIK1l6A4JrKDuVDLYaK
         AE4w==
X-Gm-Message-State: AOJu0YwSO7QDVh9scfnAo7xu3hl0V1cR3lDRy8cz08lvmZx2+Sit3Z0h
	OXR2K1Mv7X5c5s1AXcdx8F+UZeEmMZnDb/2rf+I7/ekRDze36jbJeysCxA==
X-Gm-Gg: ASbGnct/qdc2bxAjDBcLpU9vKlkkzQEBNYDZyN0/Y54r2ols1A6lyZifOMyOPbPKEvM
	3lfsl1gD3eG9TXZ3AfsY4/afdd0ZTqzwciiMR7853eLmIA1uBJ+Dd+IW+KphgXIRzYBGZYjr2LW
	UztMtoFTWeg9HDv9wJfHll5aZX8xLRiBgdbdVsONSoT5KMdOJGSgAm/4N7XxtdeoGhLO6eJsWdS
	GikvAWOBJjFI7n2lIBA72+kuabz9BnY3Yn69oQnyKFVTg3sCVMhYIVVgGy4T3tlChoMU/CtzSEl
	2nIMjECC8RlQulM=
X-Google-Smtp-Source: AGHT+IFb2ap45JHaLkc9PNeJBbRr/KJ0od0cfj4x0HG54oclHh3XlktfwtdlVuVI55rZdQc5NG1ddA==
X-Received: by 2002:a05:6214:234f:b0:6d8:f611:3af0 with SMTP id 6a1803df08f44-6dd233af13fmr907301576d6.48.1736171170160;
        Mon, 06 Jan 2025 05:46:10 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4efd18sm1502806685a.128.2025.01.06.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:46:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] handshake: don't print NULL pmksa pointer
Date: Mon,  6 Jan 2025 05:46:06 -0800
Message-Id: <20250106134606.115334-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is undefined behavior so if no pmksa is found don't print.
---
 src/handshake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index f73f91d1..bee76b26 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1272,11 +1272,11 @@ void handshake_state_cache_pmksa(struct handshake_state *s)
 {
 	struct pmksa *pmksa = handshake_state_steal_pmksa(s);
 
-	l_debug("%p", pmksa);
-
 	if (!pmksa)
 		return;
 
+	l_debug("%p", pmksa);
+
 	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
 		l_free(pmksa);
 }
-- 
2.34.1

