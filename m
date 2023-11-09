Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8D199AE
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL9/IWaG"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5afbdbf3a19so14279747b3.2
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699555776; x=1700160576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhtUbUqim0p2WsMPNzmmAE5aRHVzyjnusK5BTRhmFMI=;
        b=FL9/IWaGjTNdrJWqVshoZLWfTfxcdOgs5OPt8QzWY5pxWnZo2cZ5ehVwn/irKIdNSd
         weHtGOCaQScxPM1iNHgrDVbSuNTyI6wfWFkIyIyMRWBFwnYOq0oIDZtGrCGidPgSEfUE
         Swg2owWY1v3nAN3bZqt6OxoxFQCkTpo3JCE2pjVNojg0gyTrgZmixqERvJfTX0VIdZwh
         aTU9MLI+/cyMaOE0+tQm9twqH2C3tWCfKz20W6jt7sFX9Ava0I2T0x7S2jwKxzXcENlH
         TG8Sx+2cg1I+XKM4E4R7/gBNwHUq6OtADqBoQm/b6tAKhGZjHrLUo6EM56dfS18lxI+b
         xXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555776; x=1700160576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhtUbUqim0p2WsMPNzmmAE5aRHVzyjnusK5BTRhmFMI=;
        b=VVWmUPT46kX9BISUrDA5Be9PwjHloVMIJAWNT8ieGpQE7Gs+wM28Dxxwu0EFMudFfG
         L0yG5fuNs6rd2OQl+MHi3XPplrX8o3YAFrAIcfbAFcHI+NDCfywx2MMe/1CJQhvuig1g
         TBKU0TsYw/Denm/DgmDMsT0c0rmCh2jCXulUm4z6IIzsohcd5LjuzegqQS9YwLSes1zz
         lkvulbN8J8LEVbZJbPkQszI+IRK46HtbAyQ+KwxTC0IuDhHkHhLo1QOZ4OrLqmSmc3S1
         WMG7YTv9Z3TCx5Djsmq5fcCNpx+wUnMUtykPGIsVLmYGB10vlKkVDGwTGzGfKbS7GsgK
         7rlw==
X-Gm-Message-State: AOJu0YwAQu/heMeOo4SmivLHDeO3nfHANi0BhH6YSQHcKGUn0toUqrt/
	J8trhbLnQFVs8SJx26olirR8gJ42YVE=
X-Google-Smtp-Source: AGHT+IEgJxTWGhWMMpBBekmsWadoMM/fAHpS3JwG5ntq8EYYhBpML4Ybxef3HWp2EWibm/cwOXRURw==
X-Received: by 2002:a81:9107:0:b0:583:307d:41bc with SMTP id i7-20020a819107000000b00583307d41bcmr5750999ywg.27.1699555776229;
        Thu, 09 Nov 2023 10:49:36 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id en6-20020a05690c2b8600b0057a44e20fb8sm7961871ywb.73.2023.11.09.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:49:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] client: add helper to call method via builder
Date: Thu,  9 Nov 2023 10:49:25 -0800
Message-Id: <20231109184926.52629-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109184926.52629-1-prestwoj@gmail.com>
References: <20231109184926.52629-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was no way to call a method with anything except basic
arguments. Add a helper to use a builder to create more complex
args.
---
 client/dbus-proxy.c | 36 +++++++++++++++++++++++++++++++++++-
 client/dbus-proxy.h |  9 +++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 42b8427f..de252427 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2023  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -629,6 +629,40 @@ bool proxy_interface_method_call(const struct proxy_interface *proxy,
 	return true;
 }
 
+struct l_dbus_message_builder *proxy_interface_new_builder(
+				const struct proxy_interface *proxy,
+				const char *name)
+{
+	struct l_dbus_message *call = l_dbus_message_new_method_call(dbus,
+						IWD_SERVICE, proxy->path,
+						proxy->type->interface, name);
+
+	return l_dbus_message_builder_new(call);
+}
+
+bool proxy_interface_method_call_from_builder(
+					const struct proxy_interface *proxy,
+					struct l_dbus_message_builder *builder,
+					l_dbus_message_func_t callback)
+{
+	struct proxy_callback_data *callback_data;
+	struct l_dbus_message *call;
+
+	if (!proxy || !builder)
+		return false;
+
+	call = l_dbus_message_builder_finalize(builder);
+
+	callback_data = l_new(struct proxy_callback_data, 1);
+	callback_data->callback = callback;
+	callback_data->user_data = (void *) proxy;
+
+	l_dbus_send_with_reply(dbus, call, proxy_callback, callback_data,
+									l_free);
+
+	return true;
+}
+
 void *proxy_interface_get_data(const struct proxy_interface *proxy)
 {
 	return proxy->data;
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index cd1b2305..94625b85 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -90,6 +90,15 @@ bool proxy_interface_method_call(const struct proxy_interface *proxy,
 					const char *name, const char *signature,
 					l_dbus_message_func_t callback, ...);
 
+bool proxy_interface_method_call_from_builder(
+					const struct proxy_interface *proxy,
+					struct l_dbus_message_builder *builder,
+					l_dbus_message_func_t callback);
+
+struct l_dbus_message_builder *proxy_interface_new_builder(
+				const struct proxy_interface *proxy,
+				const char *name);
+
 void proxy_properties_display(const struct proxy_interface *proxy,
 				const char *caption, const char *margin,
 				unsigned int name_column_width,
-- 
2.25.1

