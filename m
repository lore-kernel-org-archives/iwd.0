Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2B5384
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZHFJsY4"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58dd3528497so963847eaf.3
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403270; x=1702008070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+v5VBIiaB37xH0jA0zADP47MnQyOipE3OWhzinZU5w=;
        b=lZHFJsY4gHHF5UM8i6p6WQew7eK4dqTpztBiNrzWqIrQtUUb7Jd7qQoZ10twswqMAs
         7/0I0wsTgXBWSdKRKQ2CRXzRHBPePifMFLjaS8lzMBbGPhfEnCCQBb9ukb4T039cJhAR
         2/TT2DD8/3fTWPm81JiYjgFwJgRX8Lfzx8GXvB24l6qfLV1cPLLQ1OXbB/YjFllgnQdw
         OVuWCtbL0O95vKs03mI+QRU7jrg3Vej6W8tRp3b6jgK/7sLGQULn9ZqKRTmnTFvpw0dL
         RUxvHTJmfMlmjbhTFlklBormO60pB4AI6jk5T0/pN9GtUuyIwXmA/mhRE8KFM9F1CHlT
         1a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403270; x=1702008070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+v5VBIiaB37xH0jA0zADP47MnQyOipE3OWhzinZU5w=;
        b=wEukxiinQNyer/4x8o0ZBMGLANu2Dm/xRKtEOVdlMU3Fd5jg2/itx0fkoI9q03EoKx
         HD0yihkKLvqRBQ/IORbwCXn+2G/7CTnILoQKzzmCVPGDXRKw+ZbDkwmTMuYEXGGEUCJk
         MPQRoMxs2oJNvvSl2U2RCHmF/QJhpXO3HHw5krTzoXiETaIOs9B0KNYjKnsIOQPnsux/
         QeupKnubD3BRxoLI9Q3cPgQA3dh0ale9cI++cK/AZq+i1l8fP0itrVVatYgsOsLOl1nU
         XryImPjCbF5aY5m3eg5hojTCio7mzonE++nN86QyCeO1pX0wH3L3+4J3bRSuaGTEogTn
         AZQg==
X-Gm-Message-State: AOJu0Yy1ZUo6Op1Qb/nWR9S6oqHIeCG9p8aelmCzfNlFmF4vsmrx4pe+
	fvbyzwkKWdfk/Ivjkk8s4RVBUlKi9JE=
X-Google-Smtp-Source: AGHT+IH/Que1pfoiMx3OdQ6H8QLs2qY17TwKxP3XJRj9M0bRBsOPpCHC/gQuJddVxUb+Fx0CpBtl+w==
X-Received: by 2002:a05:6820:1692:b0:589:db63:bfd1 with SMTP id bc18-20020a056820169200b00589db63bfd1mr2217639oob.8.1701403269746;
        Thu, 30 Nov 2023 20:01:09 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Date: Thu, 30 Nov 2023 22:00:01 -0600
Message-ID: <20231201040020.161143-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow _auto_(handshake_state_free) variables to be used.
---
 src/handshake.c | 7 ++++++-
 src/handshake.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 6b93774ab137..1c5ed2c9bc12 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -105,7 +105,12 @@ void __handshake_set_install_ext_tk_func(handshake_install_ext_tk_func_t func)
 
 void handshake_state_free(struct handshake_state *s)
 {
-	__typeof__(s->free) destroy = s->free;
+	__typeof__(s->free) destroy;
+
+	if (!s)
+		return;
+
+	destroy = s->free;
 
 	if (s->in_event) {
 		s->in_event = false;
diff --git a/src/handshake.h b/src/handshake.h
index 7200c3617b8e..815eb44ff6ba 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -24,6 +24,7 @@
 #include <stdbool.h>
 #include <asm/byteorder.h>
 #include <linux/types.h>
+#include <ell/cleanup.h>
 
 struct handshake_state;
 enum crypto_cipher;
@@ -298,3 +299,5 @@ const uint8_t *handshake_util_find_pmkid_kde(const uint8_t *data,
 					size_t data_len);
 void handshake_util_build_gtk_kde(enum crypto_cipher cipher, const uint8_t *key,
 					unsigned int key_index, uint8_t *to);
+
+DEFINE_CLEANUP_FUNC(handshake_state_free);
-- 
2.43.0

