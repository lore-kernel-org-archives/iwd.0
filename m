Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B324CDE0
	for <iwd@lists.linux.dev>; Mon, 12 Feb 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763686; cv=none; b=RFc+KRbxXW+OvImO9oMBuI0Ml9LUI+x5NG/3gYlRNjXrKdM4r4hH2zNoOlswOm7ypeXQMbTjNV8n4isSNF0QhNIAuFhMOnPpdGOBjpHNqJpD+/1J1c1O06jSCJGMCUexrd/dQZ+ACwzsYErSGh46r+1KMQFMQkpA0HiwlJ3uAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763686; c=relaxed/simple;
	bh=CARarsnlMNGlDd3YpNPVxb7K6LTia5S1RaovZuCKa2A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VahVWe6kDpDVJFsYoRyKK0p2KIddvkvZnwIhIRZsaRs9gqbduhF8AeyCKGRNi4qltE9udrxTxXsWVFozuzw8ozy4BQkZowRLWAA2UeH4W2ot2Wez4dx3q20XpgRwFa/F6UDAXpblNtR7DXt6sOag2vEM2Au6nXbmADdG3XgoN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=AcjI7nME; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="AcjI7nME"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TYYP42ZCnz9svR;
	Mon, 12 Feb 2024 19:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=MBO0001; t=1707763672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BmtP6gwFEgelpe+Pf/jQojBeCOXllucZ8lkSJhrOkCA=;
	b=AcjI7nMEP04BbEotyKdBBO4GoPCCXVckhMUFikCEuBH5yQbp4jncsYOBMXxwhKzhHUukUy
	99Hl+hm9KGRXEVK1LoR08A1J+o2HnxMKANp8pBSGqght7OldOxVzQPGLd3gmrHti1DkXKw
	1gZclORIpxmNH0x09xq5zaq0ShgUrwOs5Si9NTUwJkXIJdY3jt0S6rS/9SBunMLXjCulPG
	+rTzenWLLToLSJApW1bZr+lvwuVPawVylqGrIbCTgEvZr2hs3ymSThu123V+LNv4xjYP7V
	Ht41CgnXndmLCUflp07p63tqP5b4Vj6MfRjddWF6HZ5b0KYqSo6+Q2DOd3QRWg==
From: Clayton Craft <clayton@craftyguy.net>
To: iwd@lists.linux.dev
Subject: [PATCH] wiphy: include libgen.h to fix implicit def. with musl libc
Date: Mon, 12 Feb 2024 10:47:47 -0800
Message-ID: <20240212184747.30422-1-clayton@craftyguy.net>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYYP42ZCnz9svR

This fixes a runtime segfault with musl libc and GCC13. musl dropped a
basename prototype[1] in string.h, causing GCC to define it implicitly
with the wrong function signature. The correct basename definition based
on how wiphy uses it is in libgen.h.

For context, see:
https://gitlab.alpinelinux.org/alpine/aports/-/issues/15622

1. https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
---
 src/wiphy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3258b761..9d9c6c22 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <limits.h>
+#include <libgen.h>
 
 #include <ell/ell.h>
 
-- 
2.43.1

