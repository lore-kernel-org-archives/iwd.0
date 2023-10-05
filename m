Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9331A265
	for <iwd@lists.linux.dev>; Thu,  5 Oct 2023 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfEfe/74"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-69101d33315so747130b3a.3
        for <iwd@lists.linux.dev>; Thu, 05 Oct 2023 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696509040; x=1697113840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFMfkA1FObSYFJsVjW+0HtkYidI3Dh/zmRItt8JXEXU=;
        b=RfEfe/74Sq1B2GP4p1sJco/KzdYW1kDnVLbXEY0178qNqCjRodMdmdV/0Y8rCV2/sC
         12oFlK0GbxNBPkQc6i5ZDaLcIXzZDhufYO+/tVf511HGVttfxATtlGv9opVLe74QI4Zd
         5YOBCr56t/TwnLJV9bI0/pvOBWAvXlD0TiVLQk+i0AT/xdYpWp9/afab2cENgWpOa9la
         /lmgWshOufFjzV5uMZqyM+6ifN2+2yAIuyriL2ir4mZGiyIbvdo2qwbwogmds0eLNBO/
         Vui64gp8RIUOv5TUnFaWx7TsT9ef1n7ssnnrjTZXm4XRmcBlWzD1+NkYHPqyM5AAw30s
         XplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509040; x=1697113840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFMfkA1FObSYFJsVjW+0HtkYidI3Dh/zmRItt8JXEXU=;
        b=qZsIwnh0J7+RabiVMFW/EBVvgFDmmq/8n90Gg382EDjum1Y7W6wFM/WYP7XwvQnOoM
         dLLzIs2hSoXxU6ZTWGRL1v/PMjG0KGE12lPrrOHOllepZkNTKXWu89rIkRpfzDWyTHf+
         tBkRf5eJ6PBVdJtx/Hk08H3hf6OPSAO96berH030/Lh/PLVId2xwZzpC5y04xvMuIwWi
         /Ep7uaOmGqLNMLdCbKv1SSwuHDyMaOFgg4HfHv6V/p0UhMINIDOy2bJozqVX5e5ae5lC
         MXjLtwc2+CHCs96d82S3kdKBMzQsOaoG/1ZdzNAmR4t+tv8LWXsNGW+3Ipyjm5zuaBJ6
         iFRg==
X-Gm-Message-State: AOJu0Yzo31kGMMrC3k2nX6EvjHnij37MOzMrYsPPM6hJ5+ebdcfosc7g
	B6JTgFx8ZZFY09wMUvaoz97TVr9OnEA=
X-Google-Smtp-Source: AGHT+IG1gbqdGQ8hs2m815SLafbYkON82iFjss9fDPZ3g1eGntNuepX3kQtx3JfLmgejDMkygtRugQ==
X-Received: by 2002:a05:6a20:3242:b0:14c:6cd9:bf9d with SMTP id hm2-20020a056a20324200b0014c6cd9bf9dmr4427364pzc.35.1696509039501;
        Thu, 05 Oct 2023 05:30:39 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001c75a07f62esm1553830plb.34.2023.10.05.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:30:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] RFC: PKEX support for DPP
Date: Thu,  5 Oct 2023 05:30:34 -0700
Message-Id: <20231005123034.15802-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This only documents the DBus API for now to get an idea of how
and where this module would live. The current plan is to keep
it in dpp.c. This module is getting rather large but all the
infrastructure exists for offchannel/frame callbacks and
state so it makes sense to keep it there. The plan is to add
some additional states to dpp for PKEX which would happen
prior to AUTHENTICATION and allow the PRESENCE state to be
skipped.

PKEX would be used via the two DBus APIs. PkexConfigure would
start listening and wait for an Enrollee to send a PKEX
exchange request. The enrollee would be started with PkexEnroll
and initiate the exchange. PKEX would proceed and once done
DPP Authentication would start using the boostrapping keys
exchanged.

For convenience/security the PKEX key could be specified in the
IWD provisioning file (part of the Security group). This would
allow IWD to encrypt it and avoid the need for some other entity
to store the key in order to call PkexConfigure (e.g. if not
initiated by a human entering the key).
---
 doc/device-provisioning-api.txt | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index ac204f46..c8b2e4a5 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -57,6 +57,50 @@ Methods		string StartEnrollee()
 						net.connman.iwd.NotSupported
 						net.connman.iwd.Busy
 
+		PkexConfigure(dict args)
+			The 'args' dictionary (a{sv}) contains parameters for
+			the PKEX configurer. This can be empty or contain the
+			following dictionary members:
+
+			string Key - The PKEX key. This is required if not
+			specified in the network profile already.
+
+			string Identifier - The PKEX key identifier. This is
+			optional, but if used both the Configurer and enrollee
+			must use the same value. Can also be specified in the
+			network profile.
+
+			uint32_t Timeout - A timeout (in seconds) for
+			configuration. This is optional, but suggested to
+			prevent a device from indefinitely configuring
+			enrollees (if Stop() was never called).
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.NotConnected
+						net.connman.iwd.InvalidArguments
+						net.connman.iwd.NotConfigured
+
+		PkexEnroll(dict args)
+			The 'args' dictionary (a{sv}) contains parameters for
+			the PKEX enrollee.
+
+			string Key - The PKEX key. This is required and must
+			match the configurer's key.
+
+			string Identifier - The PKEX key identifier. This is
+			optional, but if used both the Configurer and enrollee
+			must use the same value.
+
+			array(y) Address - The address of the PKEX listener. If
+			not specified a broadcast address is used.
+
+			array(u) Frequencies - A list of frequencies to
+			discover on. If not specified channel 2, 44, and 149
+			are used per the DPP spec.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.InvalidArguments
+
 Properties	boolean Started [readonly]
 
 			True if DPP is currently active.
-- 
2.25.1

