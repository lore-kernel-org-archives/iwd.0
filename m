Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8813EFEF
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054489; cv=none; b=ko9GHcLOi8Z5FqygPDv3exRIWzIL4lroIgdTG+Cy+3VcGS6f9OxA0wmA2KNOvJKkuUhRd9+pEpbf4xE7YCCnm5GNVDWh2M4AtlFy+lm/VlZYwpCwBcEb/7hbK3TczcNYU7OSgjs/3fEml4Uj+0mZJZ0BuHQOlM+JO4imlNgK+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054489; c=relaxed/simple;
	bh=QYPChKO2IT//p8Y8bYRw1wgLZc0+lNetof2iHHvWbBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmoNOdXW13YNP2TB9GG3c9jM0ajL1PUEQact7OjE0QomQpyr4lblJ0YRUNBEP/NeyUXdRoJhbA6AqMR4DE7XlBregGj2c/UZkbrPp6/Hkr+tolX15uzAABSWPnMm8JrPelf5FroFbj8jspd+vniyycql5ubi5kmpa6X4GBBXgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaqtvT+w; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaqtvT+w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1dd2004e1so11236985a.3
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054487; x=1723659287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD6bGMHugkOp/VqZ1DEnFMr3LTXFdwVCGAwhUtKdOBI=;
        b=DaqtvT+wDxP+HHosm3OmbXDB8KeS6d/r3vzl4HCylWMY/c9D0fPVrsWn8ulqRpGfGK
         bonuTqSrgXkN4R9sFNGnajkNpsin+CTcy9qR3zXnYZ3dF0skV/5OJWPH0NLHVp/8cNmw
         599j1TYEIFnnX7Tq2RI3YTIcYrxu867mwR6bW8vD0A3EX1/P2t+0Lmx/PvAx04qmVnmQ
         S+oMjheRBFgalB7n+lBOEUHfkuMwHLlmQlfMfRaGN2YFapRIwXikWYiH5SWf0v0DUrbA
         bNOFstBC2SVz4XgzjelklDyg4TX6vhBUvCYNeDbY5AwMN4hCrp9ym0edfq7HkrL7jbhf
         4mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054487; x=1723659287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD6bGMHugkOp/VqZ1DEnFMr3LTXFdwVCGAwhUtKdOBI=;
        b=cm9MTp/AWksLhraVZ7hV68B/uK8w3eQ1jnhbk/UOrdIGlO1SiDkw55wUVFfgauNSXx
         iPXgTUCRerUYxZxL7Pqdp+wJ/k7smUUtFRTLAHA2WwGueWXgVn3H2xqsMxsWTxJMpqpX
         yDXPOkhrJgkYo1IPlm8XXmsJKD8a0q0vt8hLBO5VW8XJtiQp6Q0Nm7Yu7VtZrnnURcEy
         gToEk/NfY95x9kts/m3XJ2Ewg1K+1slwMmOVDCbJHiI+F8NTphT9dTQNC0x0Nhvzoi/N
         7SoX3YawjVxdLorHG8j0GO8Y+rOzM5t1sgyeJb4zuoGFOySUiNXkl4lgei0yRb+GbpAZ
         obYg==
X-Gm-Message-State: AOJu0Yze1EoO6ilYnkf9vnDPTkgHtvbsM1RbnSGcdu5r7+D1u4KExrf9
	8NbSIWafEhydnHcRQqi5dcxyDcrNfFSD97v9McgRWXrFumBF6BNDAsIUpw==
X-Google-Smtp-Source: AGHT+IFRXotYxVQzzWqz4zppJO0hhPhJEnju5fIhwv9eBtLi4ueT/w2w37/iCRdiFDFCdKDci5USZg==
X-Received: by 2002:a05:620a:4045:b0:7a1:e9f9:d4fa with SMTP id af79cd13be357-7a34ef3ab54mr2225805585a.31.1723054486919;
        Wed, 07 Aug 2024 11:14:46 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/14] client: add BasicServiceSet interface
Date: Wed,  7 Aug 2024 11:14:25 -0700
Message-Id: <20240807181427.170515-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am  |   1 +
 client/bss.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 client/bss.c

diff --git a/Makefile.am b/Makefile.am
index 0c152216..d438a5ba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,6 +319,7 @@ client_iwctl_SOURCES = client/main.c \
 			client/daemon.c client/daemon.h \
 			client/dpp.c client/dpp-pkex.c \
 			client/station-debug.c \
+			client/bss.c \
 			src/util.c src/util.h \
 			src/band.c src/band.h
 
diff --git a/client/bss.c b/client/bss.c
new file mode 100644
index 00000000..273831a5
--- /dev/null
+++ b/client/bss.c
@@ -0,0 +1,110 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2024, Locus Robotics
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
+#include <ell/ell.h>
+#include "ell/useful.h"
+
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/bss.h"
+
+struct bss {
+	char *bssid;
+};
+
+static const char *get_bssid(const void *data)
+{
+	const struct bss *bss = data;
+
+	return bss->bssid;
+}
+
+static void update_bssid(void *data, struct l_dbus_message_iter *variant)
+{
+	struct bss *bss = data;
+	const char *value;
+
+	l_free(bss->bssid);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		bss->bssid = NULL;
+
+		return;
+	}
+
+	bss->bssid = l_strdup(value);
+}
+
+static const struct proxy_interface_property bss_properties[] = {
+	{ "Bssid",       "s", update_bssid, get_bssid },
+	{ }
+};
+
+static void *bss_create(void)
+{
+	return l_new(struct bss, 1);
+}
+
+static void bss_destroy(void *data)
+{
+	struct bss *bss = data;
+
+	l_free(bss->bssid);
+	l_free(bss);
+}
+
+static void bss_display_inline(const char *margin, const void *data)
+{
+	const struct bss *bss = data;
+
+	display("%s%s\n", margin, bss->bssid);
+}
+
+static const struct proxy_interface_type_ops ops = {
+	.create = bss_create,
+	.destroy = bss_destroy,
+	.display = bss_display_inline,
+};
+
+static struct proxy_interface_type bss_interface_type = {
+	.interface = IWD_BSS_INTERFACE,
+	.properties = bss_properties,
+	.ops = &ops,
+};
+
+static int bss_interface_init(void)
+{
+	proxy_interface_type_register(&bss_interface_type);
+
+	return 0;
+}
+
+static void bss_interface_exit(void)
+{
+	proxy_interface_type_unregister(&bss_interface_type);
+}
+
+INTERFACE_TYPE(bss_interface_type, bss_interface_init, bss_interface_exit)
-- 
2.34.1

