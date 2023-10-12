Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF43CCE3
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHk8PcBh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c8a1541233so11330075ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140926; x=1697745726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6bi+WsV1NR7GZ3XaqKp2BXeDK3clIwQguZqUYG2Pvw=;
        b=JHk8PcBhcif20Bog41WboGGQu+KjowO2uwUgN2+013yVwiJAIjIRba7OhIBjVX1BuL
         uCJbKCbP9DkKsg+5EbwfQ5y2Iina2iOvwWDBLYKJmUNPQTj5QdQbuom6WyqXOPBkXrpG
         3v8SS8+zDPpQsZw8l/8ra4bOUqdCDZHIdt2Arw5pWZE9RyFckzXc9JIr2By2HXTHlUNf
         k1kLx33Kug7JjrJ95OrsTHqVDH5fxfyqh/upB7qx57or9CG3loEbgWQMItWzlLSMvRvZ
         QQXzc/kpiEhyH7U4Z55HSOw/Ftw+8aNShJkfkdHJSfWSbeJX3vy7Lev+M6SERNmNCv4s
         zSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140926; x=1697745726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6bi+WsV1NR7GZ3XaqKp2BXeDK3clIwQguZqUYG2Pvw=;
        b=YW/rTLGTHANws4UHYKq7qPDgT/Xv1geeq+raYI7IphdLeI0lSmk2qbiDECRgf2vfIT
         P17PvDgrPQUDYeIoq323cWAX/4Ozt22NY2kY67iDkwcZ5As2bMbcA/JTSygzMZJ8R7Ez
         MVHk1LUhYnMO6iKmgtCLbCkpLae2AnAiMvLrQFmPKJimODk53RPdsOBzedi51v+Z66UX
         RnRWrcENHydVXNidfomXnxu2XWK76AUgtNevP6iRcdig027pfyK2hn41Ktm0+QyTTyc9
         XiYczAc0B6Ugm7/pq1TiY0QVSRypJylEO0N3lFqaSsoirefwAR5kyueUNiY7n/BqHKWJ
         8ZeA==
X-Gm-Message-State: AOJu0YzT0qm2yqLXlL+QFLAL+IzveERSf5Mz0AgI6bW+IXJ5OxXg363M
	AA8onStWxIJvRylSgmWpd/2agCNA/JA=
X-Google-Smtp-Source: AGHT+IGWM4gh13cZcrlaXRg8v/P6H6Ih/EDmqfN+eQelblPyOKa9aKBnWwi1WAFuerwdHoYe379Qcg==
X-Received: by 2002:a17:902:f103:b0:1c9:e378:3a82 with SMTP id e3-20020a170902f10300b001c9e3783a82mr1808960plb.2.1697140926039;
        Thu, 12 Oct 2023 13:02:06 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/21] doc: PKEX support for DPP
Date: Thu, 12 Oct 2023 13:01:40 -0700
Message-Id: <20231012200150.338401-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PKEX is part of the WFA EasyConnect specification and is
an additional boostrapping method (like QR codes) for
exchanging public keys between a configurator and enrollee.

PKEX operates over wifi and requires a key/code be exchanged
prior to the protocol. The key is used to encrypt the exchange
of the boostrapping information, then DPP authentication is
started immediately aftewards.

This can be useful for devices which don't have the ability to
scan a QR code, or even as a more convenient way to share
wireless credentials if the PSK is very secure (i.e. not a
human readable string).

PKEX would be used via the two DBus APIs on a new interface
SharedCodeDeviceProvisioning.

StartConfigurator() will start listening and wait for an
Enrollee to send a PKEX exchange request.

StartEnrollee() will initiate the exchange.

PKEX would proceed and once done DPP Authentication will start
using the boostrapping keys exchanged.
---
 doc/device-provisioning-api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index ac204f46..4c0ecb28 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -71,3 +71,33 @@ Properties	boolean Started [readonly]
 
 			Indicates the DPP URI. This property is only available
 			when Started is true.
+
+
+Interface	net.connman.iwd.DeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+		StartConfigurator()
+			Start a PKEX configurator. IWD must be currently
+			connected to a BSS and have at least the
+			[Security].DeviceProvisioningSharedCode option set in
+			the network profile. An identifier can be set with
+			[Security].DeviceProvisioningIdentifier.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.iwd.InvalidArguments
+						net.connman.iwd.NotConfigured
+
+		StartEnrollee(a{sv} args)
+			The 'args' dictionary contains parameters for the PKEX
+			enrollee.
+
+			string Key - The PKEX key. This is required and must
+			match the configurer's key.
+
+			string Identifier - The PKEX key identifier. This is
+			optional, but if used both the Configurer and enrollee
+			must use the same value.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.InvalidArguments
\ No newline at end of file
-- 
2.25.1

