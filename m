Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD4212D83
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299310; cv=none; b=sEI4FCiX4O0RrwDN/HEMBa++9KHYVVNFaoSEue8jf+hba2XHanR5DBsgspHR/3+C7SFxyHKblAi2gHbRL0ijQW5GMMfdZ2DpFnZe+WgWeeEw3qr6wLP8K2cXA4/TAVdN/4+dxf1nM2muZsAJGhkr7qlXBiMOE1sMdtY6XijMSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299310; c=relaxed/simple;
	bh=tgPr4NGXwTlWGbAp9TFqrokXf07klcsBdl3gb+UcWXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jXWuV99x/Dg2hhLvO1/dOLP8Xs81je/5Mbg1Y0fR3YRj94F0+4VFLdHvijb1XJjaltGoq3l9BSAvQ7+XshD8AztKkZ6cqt8celkWNIZBvq0ywoJ94b9Rx2CJj3+gr9DNDCtMfODyYrIPFBv7bIdjBiTD3psijxs6io7RPvqGbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rue8JejN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rue8JejN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246648f833aso30231675ad.3
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299304; x=1756904104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCyatbTYcsGW//zE8UzVyFhyTehSicjlzqSG40krq1k=;
        b=Rue8JejNxh+N0bjI3MXLz2LHFu/vI9o3Smc6LBhGndlqG7ZemX6z4gDSae+vEobZg1
         Ds8gHhAg/rXoL2yjT4WomiyrbS58+Zq0llQUJiOCV27FJWDAr4gSTjk7EYeXAxgJBxJD
         8Ta2pkkUvDDIrzMOtvJe5JuSjcsKpXrB1kdMkryu3x3vXitCGkTGkO46UGKfzn5PuTbj
         9/vllMIScTJAlk8d1UIpeBBmTAx+4n8754ah4qczVwEiagnlIoej/UeWIWSKbky+dOOr
         FH8LqrCUMpXS7VZIHJBOfyhmNJq7MM8tnOoWTdNQullVuL6eZUue2Mi+OvSwIw8N7RI5
         TIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299304; x=1756904104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCyatbTYcsGW//zE8UzVyFhyTehSicjlzqSG40krq1k=;
        b=ZfAlpkdWSy5J2pIaqvn4oPLkyvSCDaHhJFt3wWbbH0DJT7YIIPxEiJ9+GiqBg1Yvww
         1yl0cFxMcOaAP/lkBmLSCpeRyco+7MyXXmiMj3P+EYQ1tSIaIwmeCmuPrnxMlKzNNzkV
         jKLDWHB4rLyQccza6L0xV7PIfItRtfag9EwpAf2a/PnyQT0YM7jZ+J9hkWqDMe3FMS06
         UIhDeSgMpSqU89We5xGm/5aULsR7ibh1K6X/DhPi1FzU/ws50yqxCyWKvjmI29CUdgNZ
         OQDeAoZxmuX67/bFxoQ42WX2k2Ka8DYjiaVmEQ2UZRNsNb/F77ZoyiaCiNR7H7JJnSaP
         4i8g==
X-Gm-Message-State: AOJu0YxkJPODnipcm/6eGbue/MOJRe7+plz5nFPl9c4NDECvvtZxCqEH
	gaWQF6aHcszRE4dipNQlB2RHbOxayyLRqak7nJEKR7ZnPmYpW4cKGaA+2A+Niw==
X-Gm-Gg: ASbGncsw1hmrNdLSjLspwCogEECQHDz7xDGmpIQ1RckTtrZsg0C0RUrs9ZUqT9//nHU
	ojfF0D/G0hC4ZTWnA5Qp4WG+pwSOeeDLv96VFd3I9xFG59hiDeNCMagDEqszUTWxf8f8+7Myb8m
	riqUJ4gCynIFX5whF6B0R4QvGI79xnGhbyoa+717tXmBfsN9mEez9KWZ96e0xYTMyU33LukCQ0E
	Rsz/FcUOmpLBTVu/locWVm50DVp2IV3KqesbKTxCkJwyA7Yq8ngOvdD8Ws6Wd4r9QbRSYKHMkQB
	lvUolmTxsEDpfC5AWstoALT5bnhT7ZXUqiKj6AOzPsE1fcfWXeysnpqlZBM5NTEJad1TFCEQvZt
	qNb7EZD3X+KkH7YuvadetGUdPVlp7BzqB/g3D57BSqa36EWL6yU5tjI67HtNepFufSBBnJTNYz3
	eddt+UOVy/dXvei9CJJtQ=
X-Google-Smtp-Source: AGHT+IFD99cS5GEHnIyrbnLP7QMQaTyg//rZ2q/eQc0afxYOexMSk1oqvMNKUaG7BWWr1goonm0ptQ==
X-Received: by 2002:a17:903:24f:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-2462ef8e7c5mr245627145ad.55.1756299304145;
        Wed, 27 Aug 2025 05:55:04 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/11] vendor_quirks: initial skeleton
Date: Wed, 27 Aug 2025 05:54:51 -0700
Message-Id: <20250827125501.477908-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This module will provide a database for known issues or quirks with
wireless vendors.

The vendor_quirks_append_for_oui() API is intended to be called from
scan.c when parsing vendor attributes. This will lookup any quirks
associated with the OUI provided and combine them into an existing
vendor_quirk structure. This can be repeated against all the vendor
OUI's seen in the scan then referenced later to alter IWD behavior.

In the future more critera could be added such as MAC address prefix
or more generalized IE matches e.g.

vendor_quirks_append_for_mac()
vendor_quirks_append_for_ie()
etc.
---
 Makefile.am         |  2 ++
 src/vendor_quirks.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 src/vendor_quirks.h | 39 ++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 src/vendor_quirks.c
 create mode 100644 src/vendor_quirks.h

v2:
 * Use a bitfield structure rather than enums/masks
 * Rename API to be specific to OUI matches. Potentially to extend
   in the future to match MAC/IE's

diff --git a/Makefile.am b/Makefile.am
index 92adfa6e..c01cd4c4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -274,6 +274,8 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h \
 					src/dpp.c \
 					src/udev.c \
 					src/pmksa.h src/pmksa.c \
+					src/vendor_quirks.h \
+					src/vendor_quirks.c \
 					$(eap_sources) \
 					$(builtin_sources)
 
diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
new file mode 100644
index 00000000..18a9ba7a
--- /dev/null
+++ b/src/vendor_quirks.c
@@ -0,0 +1,67 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2025  Locus Robotics Corporation. All rights reserved.
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
+#include <string.h>
+
+#include <ell/ell.h>
+
+#include "src/vendor_quirks.h"
+
+static const struct {
+	uint8_t oui[3];
+	struct vendor_quirk quirks;
+} oui_quirk_db[] = {
+	{ }
+};
+
+void vendor_quirks_append_for_oui(const uint8_t *oui,
+					struct vendor_quirk *quirks)
+{
+	size_t i;
+
+	for (i = 0; i < L_ARRAY_SIZE(oui_quirk_db); i++) {
+		const struct vendor_quirk *quirk = &oui_quirk_db[i].quirks;
+
+		if (memcmp(oui_quirk_db[i].oui, oui, 3))
+			continue;
+
+		quirks->ignore_bss_tm_candidates |=
+				quirk->ignore_bss_tm_candidates;
+		quirks->replay_counter_mismatch |=
+				quirk->replay_counter_mismatch;
+	}
+}
+
+const char *vendor_quirks_to_string(struct vendor_quirk quirks)
+{
+	static char out[1024];
+	size_t s = 0;
+
+	if (!s)
+		return NULL;
+
+	return out;
+}
diff --git a/src/vendor_quirks.h b/src/vendor_quirks.h
new file mode 100644
index 00000000..b5d726ca
--- /dev/null
+++ b/src/vendor_quirks.h
@@ -0,0 +1,39 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2025  Locus Robotics Corporation. All rights reserved.
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
+#ifndef __IWD_VENDOR_QUIRKS_H
+#define __IWD_VENDOR_QUIRKS_H
+
+
+#include <stdint.h>
+
+struct vendor_quirk {
+	bool ignore_bss_tm_candidates : 1;
+	bool replay_counter_mismatch : 1;
+};
+
+void vendor_quirks_append_for_oui(const uint8_t *oui,
+					struct vendor_quirk *quirks);
+
+const char *vendor_quirks_to_string(struct vendor_quirk quirks);
+
+#endif /* __IWD_VENDOR_QUIRKS_H */
-- 
2.34.1

