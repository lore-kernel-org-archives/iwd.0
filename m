Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4010171BB
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:28 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4718ddce780so851432e0c.1
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152707; x=1690744707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkmYn90lspl4Jo0rxWLI4greE7O9KpYSttOsfQ4hBbo=;
        b=D+bg6pFu3rG6/UB34b3BUMmT7WNTd5K7BOLJMfAaHKMqCVr08wuUFbIonEuT8tbQ2M
         eWuqQxpOyjXJZgp/5Rgkvt6akRs8bFgMTPUVrCNW2RjQO/GxtdBVVDoZc9lS9UYYGvdN
         5SwmROWvo1psoKJ7R0IMtCp6cFhEWpC2A6JFUVJ1t4f02XZCrxmtgTwFhZ1inlUF8XFL
         3RLmJfpB1XtkrnfTCXAqrWMBrUFd6D7xwuIlpGWYpgIdL8CtfRcJ0Zbu7+Ek+sq3nIBB
         H2hb3hYEMJ4cwYWVSUZxbn2+XvoJY+Z84yHsM6qbYjY4m4AyisGsVUg1725k5aiYVl1r
         8vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152707; x=1690744707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkmYn90lspl4Jo0rxWLI4greE7O9KpYSttOsfQ4hBbo=;
        b=ljRb9gmYQ3SbX9rFLLriIku9x+9E0uffY8RcciWosE46OoeySrM9V3N8WZhyVPXNRC
         P0Ib2praZvXbwDSuuBmayPU33NGvTUhHz4WEOc4wzd0tSETSJrC+4JuB+uSBawzaOMgg
         k1xNCYfyDyj3yrDs2wb4ybmnfiGY4cn98DzXT70qSlCb6u5jpJz5Dt67PLkMGyiRqRZ9
         iBgLnMkASH8sRWpbmy/F3vU7/uSO9lx9kVBGchNb6RtSGcJtiJ9r3E6J1s7+Ywn/Zz+r
         k5POzeN7sxiLFJ5dzm6xqwC3x26gOkZiisvqWRTqfdGtOY9IxidRboedGYJTXdshVETr
         TFnQ==
X-Gm-Message-State: ABy/qLalwLxe0WcaVTbGMKI6bqFXbjJgx4koQE0NBViiVabJP4kToCgo
	OX+JAAxq9w1vgtBAOfwpLxf3bv5z1ig=
X-Google-Smtp-Source: APBJJlEH63LhWWKgwPTiSgCQzNIC5gQ0JZeZ3+uJ1gv/Pe/Hqo/DenEuc5HB5po2ElpKwEZ8xzTdKQ==
X-Received: by 2002:a1f:de82:0:b0:471:5110:49e8 with SMTP id v124-20020a1fde82000000b00471511049e8mr2488921vkg.4.1688152707346;
        Fri, 30 Jun 2023 12:18:27 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/5] dbus: remove iwd.h dependency
Date: Fri, 30 Jun 2023 12:18:09 -0700
Message-Id: <20230630191812.2884637-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630191812.2884637-1-prestwoj@gmail.com>
References: <20230630191812.2884637-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require a compile time flag to set the service
---
 Makefile.am |  1 +
 src/dbus.c  | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 401d2ac5..2fb03aa9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -268,6 +268,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
 
 src_iwd_LDADD = $(ell_ldadd) -ldl
 src_iwd_DEPENDENCIES = $(ell_dependencies)
+src_iwd_CFLAGS = -DDBUS_SERVICE=\"net.connman.iwd\"
 
 if OFONO
 builtin_modules += ofono
diff --git a/src/dbus.c b/src/dbus.c
index 1e0021f2..4ffa4db1 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -30,7 +30,6 @@
 
 #include <ell/ell.h>
 
-#include "src/iwd.h"
 #include "src/dbus.h"
 
 static struct l_dbus *g_dbus = NULL;
@@ -38,99 +37,99 @@ static dbus_agent_shutdown_func_t agent_shutdown;
 
 struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".InProgress",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".InProgress",
 					"Operation already in progress");
 }
 
 struct l_dbus_message *dbus_error_failed(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".Failed",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".Failed",
 					"Operation failed");
 }
 
 struct l_dbus_message *dbus_error_aborted(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".Aborted",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".Aborted",
 					"Operation aborted");
 }
 
 struct l_dbus_message *dbus_error_not_available(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotAvailable",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotAvailable",
 					"Operation not available");
 }
 
 struct l_dbus_message *dbus_error_invalid_args(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".InvalidArguments",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".InvalidArguments",
 					"Argument type is wrong");
 }
 
 struct l_dbus_message *dbus_error_invalid_format(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".InvalidFormat",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".InvalidFormat",
 					"Argument format is invalid");
 }
 
 struct l_dbus_message *dbus_error_already_exists(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".AlreadyExists",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".AlreadyExists",
 					"Object already exists");
 }
 
 struct l_dbus_message *dbus_error_not_found(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotFound",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotFound",
 					"Object not found");
 }
 
 struct l_dbus_message *dbus_error_not_supported(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotSupported",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotSupported",
 					"Operation not supported");
 }
 
 struct l_dbus_message *dbus_error_no_agent(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NoAgent",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NoAgent",
 					"No Agent registered");
 }
 
 struct l_dbus_message *dbus_error_not_connected(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotConnected",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotConnected",
 					"Not connected");
 }
 
 struct l_dbus_message *dbus_error_not_configured(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotConfigured",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotConfigured",
 					"Not configured");
 }
 
 struct l_dbus_message *dbus_error_not_implemented(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotImplemented",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotImplemented",
 					"Not implemented");
 }
 
 struct l_dbus_message *dbus_error_service_set_overlap(
 						struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".ServiceSetOverlap",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".ServiceSetOverlap",
 					"Service set overlap");
 }
 
 struct l_dbus_message *dbus_error_already_provisioned(
 						struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".AlreadyProvisioned",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".AlreadyProvisioned",
 					"Already provisioned");
 }
 
 struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg)
 {
-	return l_dbus_message_new_error(msg, IWD_SERVICE ".NotHidden",
+	return l_dbus_message_new_error(msg, DBUS_SERVICE ".NotHidden",
 					"Not hidden");
 }
 
-- 
2.25.1

