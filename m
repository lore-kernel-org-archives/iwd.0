Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04B3D390
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dli7XKeS"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-778927f2dd3so93299385a.2
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352048; x=1698956848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugoc02Q2FpoXZFBiQ5BqiLP0/t/38mCaTnl1KA/s1cs=;
        b=dli7XKeSKcGKvXW8ft1wSFkewVSvB0c9wl0f+0o7edBYGiuAP42+uvBpJDkc6Ryd+S
         ScEAfOq621J+uUilaGoI0pgNj7NurKktRJvHdtGb0mBmGJai9MpT2I9bilVmI4IakoVx
         g3i9Xpz4dGlpAGYokJcV41Nq3a/5KJRkLxP6jVbbr4xIAqBYPnYwHBEMDp3h+C+5Atk7
         Gz8J+sqTISxy/0oU2OkDXxa/isH/ed7A60IY58e10I8197bLUdeASE9Cw0odYQfthm5j
         OQdZsZDMLGV7LDH40YA2kNgFENw/DmHOEncmguYtJ1rPg/l/ZYOXe69T7VT+Z0mCO/Uf
         EDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352048; x=1698956848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugoc02Q2FpoXZFBiQ5BqiLP0/t/38mCaTnl1KA/s1cs=;
        b=SZOdUrOjXO2eGWig9orE+ENfbbWXMSePnGBtUxvTey0Kpp6ts2slMBwAvbG3t+zh4f
         6cXpIDCCRuBaUlbsn/hJDrzN7Up53l6XUFZY7PfeATiYLHA7F0KNbyEYBzeDpq5MPMGk
         5IOTxwP+b2doph4bjRQr1bCvMYZsATAf7/qNzUWd2zvueNzjz5tz6qBMrvZ+C0L8KHr5
         YPFhbQgZR7kgleGPby4NVutccNTLsgWYrRCWexh6t7vecghwJq1HfLm6k2PBjarlfVJ6
         nqsV2qnY8nXYnacR5PVRwroLCUODo8dPn680/IUbSsn1cZ51/kBBSw8nzzT1VhLkhIoZ
         g/+Q==
X-Gm-Message-State: AOJu0YwrNsOr0BNJN3KnDjhvaeC16kLk/Z2UnpaoOl17+UE1vztsZegi
	aRByXfhPpOicGatjrxeRIGfv4unjVZg=
X-Google-Smtp-Source: AGHT+IF5dT8kN7vk7AByOcAL1Ytw93ZfPdx64bPHRFHHGtPwrwYriGMi9BJL8z1A5mSl/0QxIUrbtQ==
X-Received: by 2002:a05:620a:1794:b0:775:9f9d:2c36 with SMTP id ay20-20020a05620a179400b007759f9d2c36mr404306qkb.54.1698352048024;
        Thu, 26 Oct 2023 13:27:28 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 13/15] dbus: add SharedCodeDeviceProvisioning interface definition
Date: Thu, 26 Oct 2023 13:26:55 -0700
Message-Id: <20231026202657.183591-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
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

