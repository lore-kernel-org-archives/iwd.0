Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB25190661
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138970; cv=none; b=SjsUWL0llpBP8EKtjzB283NBNPnMRDZqQnN2kmn4PoxxEuGXP7HFpYx1FWOpuFLQjlzMd/he3tFvVQDvF0DvwoX4gCxKdpITHwdHWC0RmQYcrzeWFYMwn5tSmrcbzTAP0hhYYmZhNlNZgJc0mQvNGiRU6tt1kg3mMUj0wxCXIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138970; c=relaxed/simple;
	bh=uogCmoUQVgnF0uaW38LuJljWcL/2D2EDL+jnqvpBV1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTJJtfYjtJfXYSLA7zH4XdfSHSgNPHPSUsPwWhYfoCaHXp/jR+/Mzx82opz899D7bI7Ix5XkNpORe1nfTHRlsId5c5Vdl4S4+PxaB9Puxb6hwFcxfzgafZw1u7jFyzD9HSti5Y2oK3wqYzyYa7Wiqv46+Ucy4+W9Eu/QfZx1rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2KnSDP5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2KnSDP5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso11002055ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138968; x=1723743768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qky0MQJeJF3LCCWOtjL0pplPriz27AORg7Oa63Y+U0=;
        b=J2KnSDP5lm72OVan0gFmv7OkCX+UESQlUGX2VxLiL7VrZUUkzMXWqnqE2h8XBAdjFE
         VMh7F3T2aO6lLz+Emazyr/JrD5KVYlw0YHUqeloPx/ND/0XFSLrWyzA0ifcayZFEtlSs
         N6RyGZAZBzqsx0kqTOd6axMfHFiyzGd7/2vemXQ0iYN64KjqZhHR6EXPvq3IT6WQPsh0
         SanAbB7OepA3RLJ1XSdfsyl7lIMA5GcWJAaYcnQ6od2JPQrVx55NNmeIqn6Uia/o7CP5
         LfgNPQiRXxXZ+DX34kudPuK0sjPCG0WtP3+6x8avsYpFS4Qt3d2UQIPAa+I8LdfQpmVU
         5zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138968; x=1723743768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qky0MQJeJF3LCCWOtjL0pplPriz27AORg7Oa63Y+U0=;
        b=lUGmwPKQ6agRtTHS5ZrSmxtkJQDY/cg0NV/t/Yd5oi2O+wLmZnBam7VpnMDDU3/PlZ
         GxbV4ohQXGgBmbKWwBCVESz0ZKia81fLKV7pqrUaW+gGyUKSEa9xnM9QSZjX+dCKHHmw
         HxdqwlvbGKwE1NRk/amSPEL4+8+XLJhDyp+imn2BuNkjHgVGWGZ6pZ5XKMrRZDx5FC0d
         vD9KkOf42CP3eSMLk7IcJjLoC/AUPm2Rc+t6QzMatMuZm38v4KqkexTK6SbnTvveRI49
         NqQ00f6rsz0vNMn96kyIYjrhoI9ldOzkF1n7zr/+9/JepNAyNnNCYrr6PMgKzKI1GLwg
         7Exw==
X-Gm-Message-State: AOJu0YwS9AlGxdBmdDxdA68hZ6iiCjMvPom9nR05iDZCiJlxnC/pHTGq
	wgoVTR8aBefAtouW4CB2E80CoBmS9SH2HIpJd+gyvTU7CNxa0ODU/jZyxw==
X-Google-Smtp-Source: AGHT+IGpLhNkFvEeGQq7+EEEPBJXsBfhEuticx/YoP8I7NJQVmAZCoBTIaK7DSr6sWITnUixVZPYnA==
X-Received: by 2002:a17:902:e745:b0:1fd:6c5b:afcc with SMTP id d9443c01a7336-2009522047cmr33244435ad.8.1723138967926;
        Thu, 08 Aug 2024 10:42:47 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/13] client: add BasicServiceSet interface
Date: Thu,  8 Aug 2024 10:42:34 -0700
Message-Id: <20240808174236.218750-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
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

