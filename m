Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C097186E3B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477601; cv=none; b=cP/god/F/jV7Aohij5kk7z4D7AIr6ljhRpcJ13PcZAcAW44AVq7t2OPSmKQPnTFShA9b+bAC1gcYATgW2DTDH3fCzYeWOeA6sugSfZVntSpM16d8TxNn+fMA91HulszDm8gG0C4vMrrK//2YJbT1mRl4371ypF831x8YlxPWyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477601; c=relaxed/simple;
	bh=uogCmoUQVgnF0uaW38LuJljWcL/2D2EDL+jnqvpBV1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5myxruI5SLfs1uke5WAWYeQiaR3xwfEpNMMMY6IQOQhp+ZxE1ZaFr/yVFn0xijB9C1J5XtEPkkLO9bZOjbcXP2LOibqK4HUm07sakAuK2jypXC+vkrvfI5FIl8xd2/kNrZq4FDp9Ae33W5v5leQHc0H1x0LiRjmCxmRjSg5yvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd+UG4Ow; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd+UG4Ow"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso5191670a12.1
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477598; x=1724082398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qky0MQJeJF3LCCWOtjL0pplPriz27AORg7Oa63Y+U0=;
        b=Pd+UG4OwpVcURM5ktAsIXq+28ZqgpdPJf9i/rQq1wu5Oir95+8mlUc/tJP3rQ3/cnd
         NPR42Xlicx+HY5dE5ZwjVBMMNHv2j/NNgoCSGmGQwrvZu+K5Ip7oJqY/Qsn0KVAtiL2p
         kAYiS9tbSP7e+YjWBdaHBwOaZYDGl6z5gEX+wlz+KjwuUpCyxpylVCYZkXY/r8ohfOMv
         w0WbNyrzKNJ21D+lc6uEmYzDNz5KFB9OCMC63JxUhhXwZIf4zNI2kUAmeg5xgokwRmhY
         VDcFBfeBG4Xjdq2npLhOU2DRo61fQ3VjkJlZg1gahUkaoyzMk+E9nW4IUz8yhwfIFJro
         Ol8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477598; x=1724082398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qky0MQJeJF3LCCWOtjL0pplPriz27AORg7Oa63Y+U0=;
        b=LyZuiI6wgkiLZQ/TM/YEmQuicB4xsqtllBEMw147TqO5+DbaI5VFtEFbQcXquZnePw
         JDiXiNjTeSfD9KOvckO99Mkc7Hfq3VKlcPiACsijRAmGKVUgiayiPeczawuLxrTms0VX
         CqYvyNx+SC8E4hAFkY0/oHjeqO7dkXnx9HQ4EDoiSi8OdZ95gUvjQByGvhSR7xlbwAu2
         bIFtxMXQYGvKL2+zHfkBYreF4Wnv/0x83f1fZ/Vq+UZBUEvo3j9oW9lqeu2RGEHc87Oj
         eOc652BViI/7nk19f4A3WNohj8QGL3KRrVUOQiqo1keQFTnjafN9ZFgPmLrRMKHezT2E
         4hcQ==
X-Gm-Message-State: AOJu0YzT7i9WeJ1w3LqGc+6pKRrED6VCutMGbgGKrtFEAZq2gejrUkKS
	jSMFNOhbu6fMxvUZSZusT1CLAmWVEld65yDaSy3UXjUAjo4+u3pybz4k3g==
X-Google-Smtp-Source: AGHT+IEUJmvQHYOLqKqUBFx4P6C9a8islU2TGrN/DtmMMNw2LhF6ggqjwxyDpdp0CN6Dbe+NzH2mRQ==
X-Received: by 2002:a05:6402:34c6:b0:5a2:d970:114c with SMTP id 4fb4d7f45d1cf-5bd44c15055mr537663a12.4.1723477597922;
        Mon, 12 Aug 2024 08:46:37 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/13] client: add BasicServiceSet interface
Date: Mon, 12 Aug 2024 08:46:11 -0700
Message-Id: <20240812154613.126522-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am  |   1 +
 client/bss.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
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
index 00000000..def4de7f
--- /dev/null
+++ b/client/bss.c
@@ -0,0 +1,109 @@
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
+
+struct bss {
+	char *address;
+};
+
+static const char *get_address(const void *data)
+{
+	const struct bss *bss = data;
+
+	return bss->address;
+}
+
+static void update_address(void *data, struct l_dbus_message_iter *variant)
+{
+	struct bss *bss = data;
+	const char *value;
+
+	l_free(bss->address);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		bss->address = NULL;
+
+		return;
+	}
+
+	bss->address = l_strdup(value);
+}
+
+static const struct proxy_interface_property bss_properties[] = {
+	{ "Address",       "s", update_address, get_address },
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
+	l_free(bss->address);
+	l_free(bss);
+}
+
+static void bss_display_inline(const char *margin, const void *data)
+{
+	const struct bss *bss = data;
+
+	display("%s%s\n", margin, bss->address);
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

