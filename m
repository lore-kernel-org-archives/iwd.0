Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB61C1F07
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055333; cv=none; b=SEYje0vycwDm4pb0+O02+aq3vRt3zyBtb65L+BeZfn40k+urnJgaGeL0j5wcsQHG0AWW4tDo/RkmZ7ER1ccTcazx/4MNEEHgHhXU24+eFbtKqRepmFkgiCCY0+jD4J2FaNBjEbj8PG6pn2Ev8AumM7xG8+UCh0SbVV5kEI57V70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055333; c=relaxed/simple;
	bh=kPK7/9WqtzQZYTEBwh7hkwLTWfXqWichUx3OxKTK9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5rmjlcVQ8Xopmt3W692kcs58lGODA5hwuE/D12lg2+1Uvo6Y+gJgqnOZFhA6I+ojFgFDhHJe1LE6Tm33VDVujAPIUoQWtzVUkztuh27kCcA5KctZgA5wlFMXYHx9jrHXktcQTsiem4AiT8zywRnDHq2oErlqiDiMOJxDux3/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd2Leipc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd2Leipc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso12391415e9.1
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732055330; x=1732660130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMg3F78xKP0dufEpCoF4rGmF+iies/QcTJm6ddjmS2o=;
        b=Nd2LeipcpOtz5kmZHSN/kP1yZ44oCGXIHwJvTfY8EhI0uM7vrHU3f4UjXNvZvX6k3G
         k5bRlyUfLK24Qawprh6KB7+zIJlLq7KFUqtVjVZY+mt2srB8ucPd6AOgpFzq6Ee7zRp0
         KCGoaD9miunrjOormzBmZfA42UeRHk80LkKOcjDRO8o6gXgxoKh1UOIZUpxby+8ZBEg8
         unezDMUjkPBUc/99po/ffo4wc4t718Q5Wrwhi94cJB2NsA+dGvi4ObAxzLiKj9vE57LL
         9j7l3Vx/Se2IXWOFSCozJeFMBOuZv/oxy0cyv/PrV9mqYbbSbXiVgbub6w2RLpg2yDUU
         1XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732055330; x=1732660130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMg3F78xKP0dufEpCoF4rGmF+iies/QcTJm6ddjmS2o=;
        b=oOkuq7RH6FBmr49fOgVxBvv3t3rB/NOPlC4BkPyum8G+RcCLSGY69JbPMDp6hJcX3Q
         RVXSQ3jxggTwZCWi0tiR8CI9gMPQVJfzLH9/Tzw/WccfsHsgL3NwEOFhaqFG+5ueUmfO
         AQc4KRIx3iEoeNjXdTzkpYxePvaoYfRb7XZc4riGG0gFlIIdgLeWgxxixOR5x+vUObfA
         N7X/lnRQw2Ne9s38CQtiRAvAPpWge++vmp3K+dWyHy4cgYn5fQ0uPFKUkiybia9BuXn2
         Z75MKBqhy2/ZSTz8Z8nYp3QwN2kVRGXm92NHD0LbB7Wj7eHl2crKoSRbZGlxL4z2/OWP
         fqeg==
X-Gm-Message-State: AOJu0YwEQ/jN77dVe6K7XVUHiP+Z5185M0qmhyen2CXrc03cSMypcOvs
	Vl2q3FhdneK7oXpJIXS0sasVZe0LAjibRTZ5IH+VCQ1KbNuhzrVc
X-Google-Smtp-Source: AGHT+IGKm0St7eEWLfxMLboQr+O76Vr8GvpCFOdyYVYYFyUJqp0gky2zhK0/Pitg9CEr6O6i97dxdQ==
X-Received: by 2002:a05:6000:184d:b0:37d:50e1:b3d3 with SMTP id ffacd0b85a97d-38254ae51efmr275777f8f.20.1732055330236;
        Tue, 19 Nov 2024 14:28:50 -0800 (PST)
Received: from nz.home ([2a00:23c8:a613:101:729c:d1ff:fe4f:94a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933cbfsm436311f8f.67.2024.11.19.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:28:49 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id 2426824C06BAD0; Tue, 19 Nov 2024 22:28:49 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: iwd@lists.linux.dev
Cc: Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] wired: fix -std=c23 build failure
Date: Tue, 19 Nov 2024 22:28:46 +0000
Message-ID: <20241119222846.784719-1-slyich@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `iwd` fails the build as:

    wired/ethdev.c: In function 'pae_open':
    wired/ethdev.c:340:55:
      error: passing argument 4 of 'l_io_set_read_handler'
        from incompatible pointer type [-Wincompatible-pointer-types]
      340 |         l_io_set_read_handler(pae_io, pae_read, NULL, pae_destroy);
          |                                                       ^~~~~~~~~~~
          |                                                       |
          |                                                       void (*)(void)
    In file included from ...-ell-0.70-dev/include/ell/ell.h:19,
                     from wired/ethdev.c:38:
    ...-ell-0.70-dev/include/ell/io.h:33:68:
      note: expected 'l_io_destroy_cb_t' {aka 'void (*)(void *)'}
        but argument is of type 'void (*)(void)'
       33 |                                 void *user_data, l_io_destroy_cb_t destroy);
          |                                                  ~~~~~~~~~~~~~~~~~~^~~~~~~

C23 changed the meaning of `void (*)()` from partially defined prototype
to `void (*)(void)`.
---
 wired/ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/wired/ethdev.c b/wired/ethdev.c
index a933cc18..ed128006 100644
--- a/wired/ethdev.c
+++ b/wired/ethdev.c
@@ -312,8 +312,9 @@ static bool pae_read(struct l_io *io, void *user_data)
 	return true;
 }
 
-static void pae_destroy()
+static void pae_destroy(void * user_data)
 {
+	(void)user_data;
 	pae_io = NULL;
 }
 
-- 
2.47.0

