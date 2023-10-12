Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020D3B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0N6Kdz0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c9b7c234a7so12226745ad.3
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140930; x=1697745730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugoc02Q2FpoXZFBiQ5BqiLP0/t/38mCaTnl1KA/s1cs=;
        b=k0N6Kdz0M2PKs1XJ3xMPvMLgUarGLmHALshnRNc0kIT0N36ugf1Zc3DukfpCC6w7lU
         D5b95ebl03BAdTWkKpAuuiA2udUKhlGq2DRSRNfyPudNkSdcO22e0opwW2qpPGcB/BJ6
         Le9AR5vnrmGiC49EmS+IxFJPteEXK1s/esS5eDTjzAEKjG1jLgAEtq6868l77U3K8x8n
         5PMvbiFz6+4oEDBHfWIq3t+CA6rR3hugivjrYcMTRf0SNNwUe6rBZ6BvDuDn5kOZMCuS
         +fcnQSg/btxJx3Z9a4edWjR/AmCyULQKIvHGsCfnErmT8K6esFX+yoA/s2lIl9jOtHoO
         qe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140930; x=1697745730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugoc02Q2FpoXZFBiQ5BqiLP0/t/38mCaTnl1KA/s1cs=;
        b=OE7OHAl7/ATNgTpwkFCA9uNId/Kg3WyRbNz+E4EfHP4AxUnKZv2qgQoqWCwQUOsFmM
         +aCv2FOPfnj0Y+PjW5/JJ8R0Ed9pucB6YHj59nOATTxgG+kerbl3V5Ww9qst+Mnv9HWc
         bUXM/o31DAzY44cthndOzlqFIgK6wXNTICwA6CUnSb/WqaHb/4FVXaw7WKXFmy0Vpa8v
         yOvYikJmsTKOZ0wNbdHFKq6UzavWjc4PB4KkBO0/zTNyA+95lQjQO6fm2OzJ1DH2brtP
         J4r3LuqukT7FC6jKdszXcbuXRmg9/fdMvfaUW+ZTGZOmA0HUHrifzD5o4xUwLX/PDp0M
         UABQ==
X-Gm-Message-State: AOJu0Yw0ceF2is94dlV5ClG+7Zr9EYftLmviB2ZAFul7D+HKhHtj7fAS
	QJIevD4ZXzTJCv1tR7hPERt1g7itc5E=
X-Google-Smtp-Source: AGHT+IE3TAMMdDaXralKE4bKVopYGUw+RcAbv4dTpXE0o1UmanppAItmyqa0RzOTckTMPn0cSiZ/Dw==
X-Received: by 2002:a17:903:2348:b0:1c5:fab7:70ac with SMTP id c8-20020a170903234800b001c5fab770acmr32698741plh.27.1697140930095;
        Thu, 12 Oct 2023 13:02:10 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 16/21] dbus: add SharedCodeDeviceProvisioning interface definition
Date: Thu, 12 Oct 2023 13:01:45 -0700
Message-Id: <20231012200150.338401-17-prestwoj@gmail.com>
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

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index 00c2df57..cff64ae2 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -44,6 +44,7 @@
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
 #define IWD_DPP_INTERFACE "net.connman.iwd.DeviceProvisioning"
+#define IWD_DPP_PKEX_INTERFACE "net.connman.iwd.SharedCodeDeviceProvisioning"
 #define IWD_NETCONFIG_AGENT_INTERFACE \
 	"net.connman.iwd.NetworkConfigurationAgent"
 
-- 
2.25.1

