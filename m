Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3D1DEFDD
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288569; cv=none; b=lcZejE9YrZVEciIZW1htUIzoQ7y6ljUHii5FKeb/ZZSwkf3Q0x7Yn4joH89HZByq0l7oRn51oYSyugioWPYDAcVFCbiuAA8e5wXbxQK08ayf7GHES6sAyACuaEtv26TQHhcV0yB2hyRtceuq7y4zn1z2bJ5y8j1xJB4zCx/fq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288569; c=relaxed/simple;
	bh=FeM5etPn+/9Ik4rov9BMJE/8FNN8Ey/Llhupmx56GZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTMiBBQO0poZwWJYyWXFq7f72cJujAAhc2zpXgZiBEznWvRCoe3LdInSRRDLtWoqBAx0a2H3e++dNErP3wdsZj0GcW3pNXT3rmJ3gfy9F9P0W9Gu6ERZaZ7lr6J0WeKSzpyG+QRG9ZQZFF2OxV7RZIMHh038B1nwPfMBlmu+6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnqSrcR1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnqSrcR1"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d40e69577dso14053126d6.3
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288566; x=1732893366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9qQyNPSoNg8ool/2AiTWUUmN9QyDPhQB+lmpas63IE=;
        b=GnqSrcR1IhwJwir4MSEa30jKhWkp5oTbBW+RvLtvSYt1/dTfAOhjSD/jaIKboB4c0g
         8pe7gnfMrkrYJoN/L6bhH2P5nLp3L6IA6UA4rAQHa0X8yIhZrUx/RI0lwn8xnHh5Y+RZ
         xlTElirIObe9bKdxkyuJEt8O6kv2VlH+KOcfvWvgY+j4h5/JrOUfiaQZyUSOXAJliUfK
         Ekign7Mrle1XABZU8k2zIXa7GfDj2+26H1ixaFVX8HH/r1ZGJ7h4I3HZG3yv3X8uOZVN
         XljPFTDRGceRet2VrlWnuWAndDnEAV25Fie7SILpsdXT0+9uXlXio0DFDgj9EbRgqXfV
         /eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288566; x=1732893366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9qQyNPSoNg8ool/2AiTWUUmN9QyDPhQB+lmpas63IE=;
        b=lE84ULzh3U+0DPCm5inLm79DK0ATvYcO/zMuZpS2RLZT+cDS1qcIE7+QADPT/Wqsuw
         ZQMEr+hrGZHRIPr82W5xw+0Vh7xDI5JqRl++ZjVamArzlTLQUTP12Mo65Nt90cVBLGcA
         FZdtRHRVrV+znv6l/ImKAeA9LF9CwMRQMYTkLU67TGDYV+iA9x2fo9N351ynNmYZQwTL
         p0Rta9jZiM4KZNJBCY6vugPQ3ANR3E2qaDXBQ2joheXUw75YsmUm3iDVh6bX3YHyMnFD
         oxQcVIBt+VqAIW103yZXJHfquziJ2NYDvnF/DckFFNb87pNtVtgboth6uiK/ywJCfjUd
         flpg==
X-Gm-Message-State: AOJu0YyBHSwXitLKM/g/SzjyyMoePDPxzKffslnYI73TUeZRGBNpR4+5
	rf7nZrkdab3tW+jXMnFUNYEsKlFeDraVn8t7f4B/ETKumTL0Q3Ree6qskQ==
X-Gm-Gg: ASbGncuz+9ElOu+asCEe5TUTTuqMeQdinMnRr1PHrl1auy+67n2In1ATexzH5dH7wpo
	aRpgJBjjEEm/d1uAjKjr/2FR52YqBW4aBlfIqE8h4H/JJTgg8r+XR1T/3bPoJXVgWGMB3RdEJwj
	tZg85Gp8BP9n6ewbtSItTQ5Y36yK83wGgLFAsZNqak9+wuFdp5OMo39lp6KtzQKqYAxme87ZAd7
	kE4W+aLQpCOOUyvDD9NHE0yY1SjNUcdayjr5r1fWvdNqC5jSFOT0jBCrqW+
X-Google-Smtp-Source: AGHT+IEvD6RkXVnCnhUElLVQPCMb4TVdFe3Apz7GLeTFg/BbJKVkMt1GRpFgDzrrSzroPf0FPZMZAA==
X-Received: by 2002:a05:6214:c6b:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d45112fc0dmr42444336d6.30.1732288566437;
        Fri, 22 Nov 2024 07:16:06 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/15] unit: Add basic pmksa test
Date: Fri, 22 Nov 2024 07:15:43 -0800
Message-Id: <20241122151551.286355-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

---
 .gitignore        |   1 +
 Makefile.am       |   7 +-
 unit/test-pmksa.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-pmksa.c

diff --git a/.gitignore b/.gitignore
index 8af48c16..5fb9145e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@ unit/test-band
 unit/test-dpp
 unit/test-json
 unit/test-nl80211util
+unit/test-pmksa
 unit/cert-*.pem
 unit/cert-*.csr
 unit/cert-*.srl
diff --git a/Makefile.am b/Makefile.am
index 7805ed26..598b8f90 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -438,7 +438,8 @@ unit_tests += unit/test-cmac-aes \
 		unit/test-ie unit/test-util unit/test-ssid-security \
 		unit/test-arc4 unit/test-wsc unit/test-eap-mschapv2 \
 		unit/test-eap-sim unit/test-sae unit/test-p2p unit/test-band \
-		unit/test-dpp unit/test-json unit/test-nl80211util
+		unit/test-dpp unit/test-json unit/test-nl80211util \
+		unit/test-pmksa
 endif
 
 if CLIENT
@@ -594,6 +595,10 @@ unit_test_nl80211util_SOURCES = unit/test-nl80211util.c \
 				src/ie.h src/ie.c \
 				src/util.h src/util.c
 unit_test_nl80211util_LDADD = $(ell_ldadd)
+
+unit_test_pmksa_SOURCES = unit/test-pmksa.c src/pmksa.c src/pmksa.h \
+				src/module.h src/util.h
+unit_test_pmksa_LDADD = $(ell_ldadd)
 endif
 
 if CLIENT
diff --git a/unit/test-pmksa.c b/unit/test-pmksa.c
new file mode 100644
index 00000000..4c7111aa
--- /dev/null
+++ b/unit/test-pmksa.c
@@ -0,0 +1,164 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Cruise LLC. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#include <ell/ell.h>
+
+#include "src/module.h"
+#include "src/util.h"
+#include "src/pmksa.h"
+
+static bool verbose = false;
+static struct l_settings *config;
+extern struct iwd_module_desc __start___iwd_module[];
+extern struct iwd_module_desc __stop___iwd_module[];
+/* There's a single module compiled in, so it will be the pmksa one */
+static struct iwd_module_desc *pmksa = __start___iwd_module;
+
+static void print_cache()
+{
+	uint32_t used;
+	struct pmksa **entries = __pmksa_cache_get_all(&used);
+	uint32_t i;
+
+	for (i = 0; i < used; i++) {
+		struct pmksa *pmksa = entries[i];
+
+		fprintf(stderr, "%02u aa "MAC" spa "MAC" expiration: %"
+				PRIu64"\n", i,
+				MAC_STR(pmksa->aa), MAC_STR(pmksa->spa),
+				pmksa->expiration);
+	}
+}
+
+static struct pmksa *make_pmksa()
+{
+	static uint32_t counter = 0xabcdef00;
+	struct pmksa *pmksa = l_new(struct pmksa, 1);
+
+	memcpy(pmksa->aa, &counter, sizeof(counter));
+	counter += 1;
+	memcpy(pmksa->spa, &counter, sizeof(counter));
+	counter += 1;
+
+	pmksa->ssid_len = 6;
+	pmksa->ssid[0] = 'F';
+	pmksa->ssid[1] = 'o';
+	pmksa->ssid[2] = 'o';
+	pmksa->ssid[3] = 'b';
+	pmksa->ssid[4] = 'a';
+	pmksa->ssid[5] = 'r';
+
+	pmksa->akm = 0x4;
+
+	return pmksa;
+}
+
+static void test_pmksa(const void *data)
+{
+	struct pmksa *p;
+	struct pmksa **entries;
+	uint32_t used;
+
+	config = l_settings_new();
+	l_settings_set_uint(config, "PMKSA", "Capacity", 7);
+	__pmksa_set_config(config);
+	pmksa->init();
+
+	p = make_pmksa();
+	p->expiration = 20;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 15;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 32;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 48;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 102;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 55;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 41;
+	assert(!pmksa_cache_put(p));
+
+	p = make_pmksa();
+	p->expiration = 66;
+	assert(!pmksa_cache_put(p));
+
+	if (verbose)
+		print_cache();
+
+	entries = __pmksa_cache_get_all(&used);
+	assert(used == 7);
+	assert(entries[0]->expiration == 20);
+
+	/* Reverse spa and aa */
+	p = pmksa_cache_get(entries[0]->aa, entries[0]->spa,
+				entries[0]->ssid, entries[0]->ssid_len,
+				0xff);
+	assert(!p);
+
+	p = pmksa_cache_get(entries[0]->spa, entries[0]->aa,
+				entries[0]->ssid, entries[0]->ssid_len,
+				0xff);
+	assert(p);
+	l_free(p);
+
+	entries = __pmksa_cache_get_all(&used);
+	assert(used == 6);
+	assert(entries[0]->expiration == 32);
+
+	assert(pmksa_cache_expire(48) == 3);
+	entries = __pmksa_cache_get_all(&used);
+	assert(used == 3);
+	assert(entries[0]->expiration == 55);
+
+	pmksa->exit();
+	l_settings_free(config);
+}
+
+int main(int argc, char *argv[])
+{
+	l_test_init(&argc, &argv);
+
+	l_test_add("PMKSA/basics", test_pmksa, NULL);
+
+	return l_test_run();
+}
-- 
2.34.1

