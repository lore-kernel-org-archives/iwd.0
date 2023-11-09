Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654CD2ED
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXleHWst"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5afa5dbc378so14302217b3.0
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699555775; x=1700160575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znOXvRN19Mh41YaCB70YY+N8penURKD+a3umAUTRSak=;
        b=SXleHWstI0WdtYxrbEyiGRYZjPr8PQasKG/u+8cOH5oc7kw8mFebYwOcZ7micTcWKz
         ZnelDcJOcm1A+xWfHsjlemXICW8UvKC9jAz7KeASwj/FncPDMjBuCY/UmRy7FOEj6eyl
         yVt8mX9Mt4i7klU/ZVtOfbo3oE1gKD9kuNG/dtSgR61N/Nb5ofWqIk+hemaQtCbBMWSd
         97sUjzPrLrkOP89lxvFlVI0veT+2ngwe2HkUfZu5H6GaOa6TRun8VCMjLJrCKIvXF6AS
         h3y0vqlXoMhQjiqk5KN1KVYOl1/n7dblw6M6hdV36cyIszEJNe+KwcuQA3lDR6RVOmd3
         VQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555775; x=1700160575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znOXvRN19Mh41YaCB70YY+N8penURKD+a3umAUTRSak=;
        b=hkWaJHEjhvwveBF2SUdEjQ7/VV/C2fbh/20ggIy5OWZjKHCYZW6ys+Ne2jCfVqQwOf
         Hg7QbM4/EYUdS0ZFRxzmH71MZg65HyJgdWFnLRWZxpQ4Tc8jKRfcOCnLJWTGhn4DdaFV
         30PALOifShoodpCYXCmKujyRdzbvPrO/GIAcauqdSg9E8SA16y0bO5xAkW0vMsoY2fZn
         4owOs5c8lk4wBwMm7kkppo7bFf78u3Mi1DswEOwsNWeToqk8DXLs+hTw+/X6ao0NU6HH
         6111EPfi22eTPzb3ClMp/rklM41uSIPAiRicIB9Hl31uh3xbaeLgzSikoRTNbgPhrwoT
         miCA==
X-Gm-Message-State: AOJu0YxOgG/jWXrzls/uT870aiBuOwifMfgkYaowN7h8oR0YM1AGc1Q+
	Z3BLiqxE52L6egPEOG7YbVfh/76fDxk=
X-Google-Smtp-Source: AGHT+IE4535LUN/AWsK2R6XA0Y0+1pY+sUh0C+2tlxk5d2EwGtCLAUZEjPOTgHPcieoyb0546j+YjA==
X-Received: by 2002:a0d:d490:0:b0:5a8:1ffe:eb4e with SMTP id w138-20020a0dd490000000b005a81ffeeb4emr5989077ywd.34.1699555774972;
        Thu, 09 Nov 2023 10:49:34 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id en6-20020a05690c2b8600b0057a44e20fb8sm7961871ywb.73.2023.11.09.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:49:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] client: Add shared code DBus interface
Date: Thu,  9 Nov 2023 10:49:24 -0800
Message-Id: <20231109184926.52629-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/dbus-proxy.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 0b4fec43..cd1b2305 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2013  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -38,6 +38,8 @@ struct proxy_interface;
 #define IWD_AP_DIAGNOSTIC_INTERFACE      "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_DAEMON_INTERFACE             "net.connman.iwd.Daemon"
 #define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioning"
+#define IWD_DPP_PKEX_INTERFACE \
+				"net.connman.iwd.SharedCodeDeviceProvisioning"
 
 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 
-- 
2.25.1

