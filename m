Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE9174CA
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:29 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so758350241.3
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152708; x=1690744708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR0UCwxjNvHPDUk8Nji2A/eyakBNMaau6nNBC8zdj3M=;
        b=T6Ux5f1yHnLqk3bfRzIeS0HLoYjP+GJLUtQyVq9R0t5amOhEqSFM9trqIgPcb/gmwW
         6biItFY1JsidtxxkiquxR1F6xI77Tr+3Q+W8/rPlR6n6Pmss66giArVinc+qGxoQs03Y
         EpcB/zZjag/qYHGsiK3j4GQ7t+iLMvQ4XRjUikG6LCgC1O4K4Zi22IIrbhnZ3ZDQdAHq
         I/exQR43eMed8ItVTImtuGLKC3d/XVqtKZVwNqtbKn9C9hNhZCQVEZM6zcyqNZMLo0cQ
         zjojqI4wwDpZRIGwp+/jEPGGcJ9VgofeQt9XUv7RRzJJ6daQOmsByKYv3qzfn9LvgojA
         KC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152708; x=1690744708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR0UCwxjNvHPDUk8Nji2A/eyakBNMaau6nNBC8zdj3M=;
        b=gjodGd+BD+tke2xafSsmeMsJCr9DvuO+q/txbLEkmgHSzzdjyhpULX64h0e4M/+QBz
         b1LIWHPwVNtKJIjEZd1YN6zY/eehXlts9X3Khhg+dGIb9VSRzbjqi3T5WJ7Kapccd46d
         8xBNqzeoXPTguBImKziAAlYuM8hycY7Q2n0w54CT8vE2ut9eMAjibU45NnmKisdaLggC
         k2iN+frdWWzVzHB87zpkgiQTHDw8O1YISpbHKYduVfnz39Vdo+QYIgxdvIYLjgJIUKna
         AQJsdPgtDcP2u8eamVrBFjpzkXlKcp46VcgCuApQqCtoJHZ5PowgfKEzl68m623viD4L
         AqLg==
X-Gm-Message-State: ABy/qLbpMmojZBTCEpwPLcY+14wHnynsJwnANAFoLJ/zqXlwOaXcNaR0
	Dm7uoHsEhzjSqU5FT3tOTF/xY2dxFSo=
X-Google-Smtp-Source: APBJJlHjgyM5pY1sEBgu6XGB5LaiVQM+zFEg7KmXr2Iqx/d1SbWe1LcL7mHKaLNqMajVbRo8dTigeQ==
X-Received: by 2002:a67:f345:0:b0:443:92a5:f454 with SMTP id p5-20020a67f345000000b0044392a5f454mr2236908vsm.26.1688152708473;
        Fri, 30 Jun 2023 12:18:28 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/5] hwsim: use dbus.c module
Date: Fri, 30 Jun 2023 12:18:10 -0700
Message-Id: <20230630191812.2884637-4-prestwoj@gmail.com>
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

Use the dbus module from IWD and remove duplicated code.
---
 Makefile.am   |  5 ++++-
 tools/hwsim.c | 24 +++---------------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2fb03aa9..fcdd342a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,8 +405,11 @@ tools_hwsim_SOURCES = tools/hwsim.c src/mpdu.h \
 					src/storage.h src/storage.c \
 					src/common.h src/common.c \
 					src/band.h src/band.c \
-					src/crypto.h src/crypto.c
+					src/crypto.h src/crypto.c \
+					src/dbus.h src/dbus.c
+
 tools_hwsim_LDADD = $(ell_ldadd)
+tools_hwsim_CFLAGS = -DDBUS_SERVICE=\"net.connman.hwsim\"
 
 if DBUS_POLICY
 dist_dbus_data_DATA += tools/hwsim-dbus.conf
diff --git a/tools/hwsim.c b/tools/hwsim.c
index 5cb28624..402b3622 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -45,6 +45,7 @@
 #include "src/crypto.h"
 #include "src/nl80211util.h"
 #include "src/nl80211cmd.h"
+#include "src/dbus.h"
 
 #define HWSIM_SERVICE "net.connman.hwsim"
 
@@ -541,27 +542,6 @@ static const char *interface_get_path(const struct interface_info_rec *rec)
 	return path;
 }
 
-static struct l_dbus_message *dbus_error_failed(struct l_dbus_message *msg)
-{
-	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".Failed",
-					"Operation failed");
-}
-
-static struct l_dbus_message *dbus_error_invalid_args(
-						struct l_dbus_message *msg)
-{
-	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".InvalidArgs",
-					"Argument type is wrong");
-}
-
-static void dbus_pending_reply(struct l_dbus_message **msg,
-				struct l_dbus_message *reply)
-{
-	l_dbus_send(dbus, reply);
-	l_dbus_message_unref(*msg);
-	*msg = NULL;
-}
-
 static const char *rule_get_path(struct hwsim_rule *rule)
 {
 	static char path[16];
@@ -2867,6 +2847,8 @@ static bool setup_dbus_hwsim(void)
 		return false;
 	}
 
+	dbus_init(dbus);
+
 	if (!l_dbus_register_interface(dbus, HWSIM_RADIO_MANAGER_INTERFACE,
 					setup_radio_manager_interface,
 					NULL, false)) {
-- 
2.25.1

