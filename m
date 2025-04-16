Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF22165EA
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824844; cv=none; b=M2bHN8T/sCfb1vpjKAo1CIYvNzxTVzB10CEOEaSImM+AUekgobPrQoWgAoGpsqA17i+mI08vdfgANkR7ILA6/6BnFvSLTam6ZjEcrptAKUIbfXo3DR9TcCpt5dy9efME+CWFdnjmZrseb2nQjhRUL8yc7TkdT+r+iCxRLfy+IEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824844; c=relaxed/simple;
	bh=yymt/uzSneq8DFh840W85boGL+SB9DQZtQWwuvs+Vik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ivv6MN9L2vyqRrFNuSlaytfkmUYK939/Vg+Y8PSU0EcEHvEdNR4JPQdWR460lu28WTjfUDPvnFiEwvICITdeRk1/nM76zC87/Q9xRlhUKZ6pgdZe3amBRWFhST49tpYdZhbv5pbSF4CYkgI0ufqDrANNMs4YsEtEwd7pMmc9S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M75pcKx5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M75pcKx5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso7170600a91.3
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824841; x=1745429641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF2R46I8yei2Cp4g8Mwf8i3dtNtDV0Bu7QcIFizyz50=;
        b=M75pcKx54LPWKB8mO6FTqLlJkkZ26b0I8hZkmUhfZ2NVN2fCi/VIFzgmQ4Lbm58dDN
         m3ADGvw5tE8pksvwMH7YUKFs6ORPNUdeJfsfTAw6h/ZSbpLqdRNkBq/zB0yqSWyrl0VU
         5n10ASLNyCc3OgGYkukIOBLThWpVTK2CRgtvsfhVwtXXmObi8Me3ulpG3yOGR2060hoM
         IL2CKE00FwepmmJFv20wNBJI30FjkRbYXXoKiK6dXN23Lr6qcZuugdHP1wP11Ag9mK0H
         rwybnA5gj63wtE/3Hn3sp5TBQwFeePcEg3Ll885jLDCLzD/fDhiMsXE843pfg3YV21P7
         WT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824841; x=1745429641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF2R46I8yei2Cp4g8Mwf8i3dtNtDV0Bu7QcIFizyz50=;
        b=eWmwVvLp6zsKSFdswzZ1vqAe1AL0/5mwC+/wkaubDOzHrwUQ0X/2u4qtQcXD3+wG3t
         J4BKpz8lA7+3aO4MP5i6maivbvSuFtvHJML4q5zcK30muvr3ZmGjrX0UrDYlIT+pOm7U
         5OsSBUrLo/CzPftG/v7SFqajsHfG0gXNMcPU1uL+Fq1oB7t+UTzpUTgGI8HyxpmgIizN
         nvEFErg0k9oogdHMUXSNsYfe0Uv4Cd+mm2sHwuxvJdW/K+Y0+aQg4HanViR/1l1R9mUc
         kH2OEdYOsBLLMcWjZRIJ7BkLTTURpOTDro8kAEDXfsUhDko9Cyhd1WOUAtFgiriH4foG
         8egw==
X-Gm-Message-State: AOJu0YwJ6Dp8wax6hA68Mpoo0N3sb8Uk1DnoWBbP/u36ULUC4Uit8kSW
	R/eLKrLJWeLoinxM2OzgRofU7OXLAawgaRFe77qvKki2dO+8v/qBqGXlVA==
X-Gm-Gg: ASbGnctTQpbOPPTILej1j3n7/J86/8MXAWqhkyIaMmSL9oLDPDEkl/3QVMOn5pJoIfV
	MaDXNMtCvjCLKWdHQPvkw6LoRPW6mo5Xp5+ZW3BEse5G4jsCHjLKJ9dIAlzDC1lKYgw/+jA5Ccx
	BUV+W8HuD01ebYkJLkbr3CLH12PVvNeMaylrLW5svXZnYEbuq0fsCATNvv43GqDTahjN2c0J/mW
	rWJvBIfmBw5qfKkLEcZCUfM8tiGpiTEpqRP9RRSJyfu+uWvo1UkSdePRVFKZtZ3YvSjoOD8/Q55
	8QKS5n8ZzNueuhh751OqcmJ5r9HaJtxB12BAq80lk4MaJotbbamKDwWi3HtT+Q==
X-Google-Smtp-Source: AGHT+IG0RlyiZY09A0AjSvW1Kyryi7foM5zQ7L1oviEFsgCazmWDRho1pFKAZzMh6TOMUT7ww/f6Dw==
X-Received: by 2002:a17:90b:1f8c:b0:301:1c11:aa83 with SMTP id 98e67ed59e1d1-3086415e1a9mr3844541a91.28.1744824841306;
        Wed, 16 Apr 2025 10:34:01 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:34:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/9] unit: add test-storage
Date: Wed, 16 Apr 2025 10:33:43 -0700
Message-Id: <20250416173345.136025-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, a single test for __storage_decrypt that ensures an
invalid length fails as expected.
---
 Makefile.am         |  7 +++++-
 unit/test-storage.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-storage.c

diff --git a/Makefile.am b/Makefile.am
index 6404bdbb..92adfa6e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -441,7 +441,7 @@ unit_tests += unit/test-cmac-aes \
 		unit/test-arc4 unit/test-wsc unit/test-eap-mschapv2 \
 		unit/test-eap-sim unit/test-sae unit/test-p2p unit/test-band \
 		unit/test-dpp unit/test-json unit/test-nl80211util \
-		unit/test-pmksa
+		unit/test-pmksa unit/test-storage
 endif
 
 if CLIENT
@@ -605,6 +605,11 @@ unit_test_nl80211util_LDADD = $(ell_ldadd)
 unit_test_pmksa_SOURCES = unit/test-pmksa.c src/pmksa.c src/pmksa.h \
 				src/module.h src/util.h
 unit_test_pmksa_LDADD = $(ell_ldadd)
+
+unit_test_storage_SOURCES = unit/test-storage.c src/storage.c src/storage.h \
+				src/crypto.c src/crypto.h \
+				src/common.c src/common.h
+unit_test_storage_LDADD = $(ell_ldadd)
 endif
 
 if CLIENT
diff --git a/unit/test-storage.c b/unit/test-storage.c
new file mode 100644
index 00000000..c40518e6
--- /dev/null
+++ b/unit/test-storage.c
@@ -0,0 +1,55 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2025  Locus Robotics. All rights reserved.
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
+#include <assert.h>
+
+#include <ell/ell.h>
+
+#include "src/storage.h"
+
+static void test_short_encrypted_bytes(const void *data)
+{
+	struct l_settings *settings = l_settings_new();
+	bool changed;
+
+	l_settings_set_string(settings, "Security", "EncryptedSecurity", "012345");
+	l_settings_set_string(settings, "Security", "EncryptedSalt", "012345");
+
+	assert(__storage_decrypt(settings, "mySSID", &changed) < 0);
+	l_settings_free(settings);
+}
+
+int main(int argc, char *argv[])
+{
+	l_test_init(&argc, &argv);
+
+	storage_init((const uint8_t *)"abc123", 6);
+
+	l_test_add("/storage/profile encryption",
+			test_short_encrypted_bytes, NULL);
+
+	return l_test_run();
+}
-- 
2.34.1

