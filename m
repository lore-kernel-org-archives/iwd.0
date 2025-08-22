Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344A2D63EC
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892291; cv=none; b=mQabR5ZRBrLfal3bPu9HZN5UjO3/1j4ggdrQ53LB9/Geb17RZJg0PIrUBbmMZomBb6BZiM0UOnFfyDw2W6UxlnWzosAv9DNXHSBfUsmnV4CBCf1vrO9A5Mf+fgdpXpu3IEQIjwHCIEjVpODK85ZIRpFCpAMbkm12junKZVe1IRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892291; c=relaxed/simple;
	bh=0n2CUyItqgE8AKx092aPJZCtKGtORzXBcz7RxNul8mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK4xYTQbSERv4Vjdn/+9ITfLABVr1gyDY/Pi5f9uAhwCmwwg8S7HgJkvtppLtV0NPr0Z80i2G1B5wFKOdntOB9kbsu5YyAiKYX3o35IbJ9JCEFiVhQNc/KvHAD7YIv6f1T33/CVfRbvlX59bwVmW4+lRtCi357kKIf8LTMzjRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqc93OIu; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqc93OIu"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109919a09so30652411cf.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892289; x=1756497089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fecgAv/k4Fjpt1xjKmJ2n4P8YBLKIu/8Xci8DqBnTrY=;
        b=Hqc93OIuStlhSieKDPesy7FHAlJWDARWZalsjV15609BOQ2gpkMN3dlPZ1gEXMgqUl
         L/9ACa/L0ICHND4SD68lIMid57q/9ujaGK+UhgKikMds5nIA9cLfQc2c5hH6cazxUV09
         yNfnIN5cjraUdqItJ/npcr5SLKK8YM1zU/tnW2ebzh7kajQPm/nY13MkuyvZ3yZOlqKg
         y2NWhkmbQWdQYuUOl9VcJ/KI0Ogq1ZAIwcvcFtK1EM8mM7wEpHEFM+52FL7FEvAQh5iJ
         t3PxOX8uYWbcCICTecSHNCR9w+9z2iylsZbjxqaeGnGz3qxPmfY7WvUJCnEkg2IGSNhY
         UcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892289; x=1756497089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fecgAv/k4Fjpt1xjKmJ2n4P8YBLKIu/8Xci8DqBnTrY=;
        b=jDktEB0C5w9RusWWF3qi3zUg3MhLXyfi6n+8ZzscOF6UrnV25SHcjcbuvVGzwmXVbW
         lMM0XU44mF+Mvd7nyBOt6YFrx2L16OEBzC0MDsHK65Px/Qf1GNU/+o9+xW3p1XaKDJCI
         gidSk33gUFCIOMOToC/cYRB3N7H090IYLA2g8/0ap2WUmt03P0KlYVOK+S+70sEiYgHU
         W2+UOTfesENWPZeYxcxH3HaW381gID25KMvYzrD1+F/qsU8du0rjkyX73Cl1KFp5kjED
         PQ7GSv/JN8n3kFWwkzL+5RaSH0QvofhrRMTN/BfAa9SJjk2XZFx6bpXHEPfj0Ofv6deO
         a0cQ==
X-Gm-Message-State: AOJu0YzQ18/rEOf04kjzDyJaAgeS5ZeE82lDnj2DDCeZUiF9JkpYcyz3
	ouAsaoIfyd59NwH4M7FgfWG3iTW+Y05gVUskhTMOUNlHW4pw1E83Ercu2fYPaw==
X-Gm-Gg: ASbGncu3PKSNjw00BxU1qdDEntM+ncyCF4zW8ghIuJasj3ajWGRDmwrgOSJe5UssM8l
	29IYNE4IjzBtYChSrD8CjpFohkW8NXWJCjGJ7tHjh6m9XOHY5k1ZITGgN6kDj6UJfcKw6rq/QhJ
	7r+/addkIvM4BnvK+9rESjuy536ONUHPGRTBMsNQwq6jpOyJjH+oAq4IvidlTnb+w9z7XhMBcT3
	o8mq9NpPEmiUURKLGoJPOm57Kz+m6oSCk0JAnl+03Os4DoM+q+CHBbRsWUearTOq/s/O1uirua8
	7tRhezLbWv91cjil95vXSq4dXSWhL2yuffaUg3fFEDsPceXj6cskR/UySn795mjlcY6tWX5YfVw
	lWiNNBnRIYUuIJxhxle6WZ1xB3MervvCb
X-Google-Smtp-Source: AGHT+IEntg1RhA04oQF31xTEU5kwXpzuN+G9Kb11eyiNvu5IJ4OL8O52meE6udNQYNFDhjoRxneTnA==
X-Received: by 2002:ac8:7f4d:0:b0:4b2:8ac5:257e with SMTP id d75a77b69052e-4b2aab5cb98mr56644441cf.69.1755892288843;
        Fri, 22 Aug 2025 12:51:28 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/15] vendor_quirks: initial skeleton
Date: Fri, 22 Aug 2025 12:51:08 -0700
Message-Id: <20250822195118.271122-5-prestwoj@gmail.com>
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

This module will provide a database for known issues or quirks with
wireless vendors. For now the list of quirks is limited to 32 as
that is the size returned in the bit mask. This could be extended
to 64 in the future if needed, but of course the goal is to never
reach that level.

The vendor_quirks() API is intended to be called from scan.c when
parsing vendor attributes. This will lookup any quirks associated
with the OUI provided and a mask of quirks will be returned. This
can be repeated against all the vendor OUI's seen in the scan. The
result is then a bitmask containing all quirks for that BSS. This
can then be referenced later during various operations in IWD.
---
 Makefile.am         |  2 ++
 src/vendor_quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 src/vendor_quirks.h | 25 +++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 src/vendor_quirks.c
 create mode 100644 src/vendor_quirks.h

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
index 00000000..ccfcb444
--- /dev/null
+++ b/src/vendor_quirks.c
@@ -0,0 +1,53 @@
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
+	uint32_t quirks;
+} quirk_db[] = {
+	{ }
+};
+
+uint32_t vendor_quirks(const uint8_t *oui)
+{
+	size_t i;
+	uint32_t ret = 0;
+
+	for (i = 0; i < L_ARRAY_SIZE(quirk_db); i++) {
+		if (memcmp(quirk_db[i].oui, oui, 3))
+			continue;
+
+		ret |= quirk_db[i].quirks;
+	}
+
+	return ret;
+}
diff --git a/src/vendor_quirks.h b/src/vendor_quirks.h
new file mode 100644
index 00000000..758073b3
--- /dev/null
+++ b/src/vendor_quirks.h
@@ -0,0 +1,25 @@
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
+#include <stdint.h>
+
+uint32_t vendor_quirks(const uint8_t *oui);
-- 
2.34.1

