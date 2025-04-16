Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDF7482
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806866; cv=none; b=ZzBr3ze/JIZzs64mVipl1jDEhEd0PXSyRHxUShT8XhHfl9tHLN3poLvmxR2pjnaC/W0eZBGcVPPsw10esIgIdgUb9JToEcOcRCNUDz3tuocTiD2jl8hpUeruj4GDzZzl79uK4UX16lIyPI5SKA7yCgWg6fQloQ/t8CqlixX+2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806866; c=relaxed/simple;
	bh=yymt/uzSneq8DFh840W85boGL+SB9DQZtQWwuvs+Vik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCOOupBoa7pPtwkGS6+4nvIzBCln549Wi6K6f9ZB9+bp0vNGJGxkWasFgGm1PEmMej6FjI6OrUuP2kiD/33sKzysmWvV2Q5GFvtyGWq8qe7sB+MZjZ5eQcE+LE3VLpY74BCbksMP/MmnJyBDQKMC6HG15A3gL+R9qrjtUX0UqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO7h0cp9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO7h0cp9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736b350a22cso5736016b3a.1
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806864; x=1745411664; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF2R46I8yei2Cp4g8Mwf8i3dtNtDV0Bu7QcIFizyz50=;
        b=bO7h0cp9dhU1xUAwNZQ3mUU0bxS/p4ePENA/FMB/S3j4Y2/IYCb/ZIkrR+rTeRkriv
         StJmy1YIlgrjTzuFM4kfCqNY+caTPGPQkEUZe26nD3YP6pLQwuDZ++BwxyLO/62htHnO
         yRM8pNke52+3xeJZgUQ5ocgmoN6m7ByrMMjz9NBnyv7Cx/Mg1PZnFp4UpJtii1ZV0C1A
         VhIWToBBoJtQ1xs7raB+Ed/g7LNYSPIC9jsXYR9E9LGEz3b1UaTM3YU38arukgIHW1Dx
         yqei8w1BRnSJsj/uwiVXe6s/b4q1LN+grp22hmI69QJArf6ex+L3Z4o03lsg2vncZcg5
         FO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806864; x=1745411664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF2R46I8yei2Cp4g8Mwf8i3dtNtDV0Bu7QcIFizyz50=;
        b=Vkxd603vmFPgvfG40pLdFoaZKy6DMIYuYNbrJwtAk4tFttPrgdPlVT3oRF89HBaMrU
         OGYkrAwXZueQJ69xz8nWjF46PzI2L4+2CpesuzsBHbR+tvVnk9VyIa5jZrHW23hBXs2E
         3qkBiuPA4/TLth4+aTF3+px08bvIUv/DXlu5hcCmQYqlIb0pYvqyDuszbDhJkCzQqEzq
         tFVGuVZb9scULbb1K7wsJy11VLWPACHQwQ6G7Fp8UTbYwDQ+d9wTnT/LXUH1j5H40wqu
         p2Etqz/1csKxdpBDaGphoRUDSfqLN/wpXsSO9k+9mL6fFXyc53LDtyK1kuG9xcYyM7p1
         HzvQ==
X-Gm-Message-State: AOJu0YwuywBQ2/1kMOVweJxX7dfy/C5hH2TTYAy5uaB6FKAkQeJ5TY+6
	YuOY+FOZWlYo4KqKjPvx8TE6h7LD7CFU0vXBhb0SnJy+KVlzmgB7Eoz+lQ==
X-Gm-Gg: ASbGncvJt9UlnhlWNf0pZPm62ENCnMzrXmkLvqIyI/ZkRLLh8hZYPK10/h7mq6le0Bh
	z1RecFoNyI6dLhH9CCVrTofKkKJNwM9U2JgOisTe6YnSZT3b70UWZ+NlTMrb0BrCQp0SFk6LOZa
	AFm2NrzWD44K2Msr3+g2MIlgS3pgNpL8Kx5sYH+2A5UJtk7K74jZWeyslE2jZDLia8a4cFXeeBs
	oCWHPPVRst0+wN7JMmnMAADXXtTeoyXS+kWVgCjVqLERFCxXbga9i7iUMP+Rif9Ovz/bNNolUFT
	AzrSfIBOLuY+de7pr6PE1EQjfmUeCSFcy9cT/gIVu3uv/Tt1WYFhksBFm55nrw5/YnV8j1Fc3X4
	R75hFOmK4abaoFx7ap+uKiRrHhi8=
X-Google-Smtp-Source: AGHT+IFozXHh7JDvCImypBvVgYAtFRZUslMe/l2xQCCgNu1ksg8+UaFIbquNB+SL2h1R3mIfrqvmNQ==
X-Received: by 2002:a05:6a20:e617:b0:1ee:c7c8:ca4 with SMTP id adf61e73a8af0-203b3feb987mr2778949637.36.1744806864491;
        Wed, 16 Apr 2025 05:34:24 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] unit: add test-storage
Date: Wed, 16 Apr 2025 05:34:12 -0700
Message-Id: <20250416123414.114231-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
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

