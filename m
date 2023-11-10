Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80A13ADA
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC0lps9b"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66d76904928so12670596d6.2
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699621096; x=1700225896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR7IS8MqkfjMefzbIaqPeQr/hCOKlml4b7bYxB06kgo=;
        b=EC0lps9bs8J/o0/ANyrH7ktvjEHAcdaN8snmnyp5O2nSAr0J5iqwXp97FyEBFlodNC
         9Ok09JzIYp0DuqhELIP83ybqf8exQUdRgp8GT3aVWWjncNQjOX864vN73nHpC8hP5Gsx
         UmDJ+vvu3Ltf95BpjZkpVWULJXgWY3raLTrcyqnpIJa9yg9ApP1KsqDIkb48qSrk6VcH
         H2D31pIfn1+yyWWR1RQdHhw+YUd94KxNDTThobj4xs+F7xbsw3HXVtP4CawUczbhMwxY
         4nIrrzwvMKJXhO8XHGmo32SmOtqB3J0sG1GYe7zmVLnRhtj3MGSiCNCBpfAXeC4WCBoq
         p52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699621096; x=1700225896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR7IS8MqkfjMefzbIaqPeQr/hCOKlml4b7bYxB06kgo=;
        b=oeMHRxHZAGVNexucwMkwCMT4YlJUAyA3nUDeECb0GJOMZMD2h91M4ar9JLPD0yrpHP
         BUpWKlHU0fIZ0r9HkhCEoLVb3v88kEacMr6prfVM2b7qiUqbG1/nW29pp7i6m5+IgZp6
         zPs4Vcs3kMw/ewX/MsatN7jtDm4u+46iraJ5znJRF+EW6sT9uCyu3OeJtRHLQJMpGttq
         Yj8VU9YhgXeQFUBqt6k5VBwq/kUYx34hH1zEh+XCzbkIuQSPeN2dS/wrpWlg+FExuzG+
         Jn7FlclsfZvVv1v9vkBhGoowjZWFjTXpg7bh2k+uLw72gLrPGPq+5pFtXM2+GZMEoqMT
         XF5g==
X-Gm-Message-State: AOJu0Yyc91vXjPQHagq/sCpS7FVxPddNClUaUj8RFn7nZp7BcivZSrHQ
	ax2IeMKkWVLkevPvETGWPa7fyz7barc=
X-Google-Smtp-Source: AGHT+IGpJfKCLCqcmjLK0sCMCP9Zb8TqcSfpHkJ30b6EXeshriwRemQEOmvb5cRsKUFXtv57jTCR9w==
X-Received: by 2002:a05:6214:e49:b0:66d:bc09:f6db with SMTP id o9-20020a0562140e4900b0066dbc09f6dbmr8257691qvc.34.1699621096557;
        Fri, 10 Nov 2023 04:58:16 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l8-20020a056214104800b0065d89f4d537sm2874512qvr.45.2023.11.10.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:58:16 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] client: Add shared code DBus interface
Date: Fri, 10 Nov 2023 04:58:11 -0800
Message-Id: <20231110125812.69911-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/dbus-proxy.h | 3 +++
 1 file changed, 3 insertions(+)

v2:
 * Fixed copyright

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 0b4fec43..98b0a2a4 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -3,6 +3,7 @@
  *  Wireless daemon for Linux
  *
  *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2023, Locus Robotics
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -38,6 +39,8 @@ struct proxy_interface;
 #define IWD_AP_DIAGNOSTIC_INTERFACE      "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_DAEMON_INTERFACE             "net.connman.iwd.Daemon"
 #define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioning"
+#define IWD_DPP_PKEX_INTERFACE \
+				"net.connman.iwd.SharedCodeDeviceProvisioning"
 
 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 
-- 
2.25.1

