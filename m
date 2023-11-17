Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA393033E
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYzFB8D"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso1980336b3a.1
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 08:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700236821; x=1700841621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3srW7WtWJoYPnRcjk5XubzsXgiqAXdE+waCWGZwmu2I=;
        b=QxYzFB8DVAgC5+uUHl8VR+E+6w6M002o7Iqm0bO+lmbL+Of0fRkJMyMOpx57MM54Fx
         adYr/4b3SWs7q8FVfDLuNgVh1kbxiQ8OweNZM5A2oqlKoCpg8LzVPLrwTQ6wQ7JzmL17
         /XJczWAGADQmgMWCK8mEIM5g2omzXNJB+N8C+a4C8+gkEcFKaM8MuIsxarFzoi1sbsnA
         Sf3QcTSYeG05ZAn2wwFk2Mp3WqOKULmYpM0ed6CNnOEynqXl0hhxiktkhK0FgyO8h2c3
         nuy9j+ndOcve4OONvsGzk4fIsPD8fXQSMBKiFT/rhECCwOmyPXTJpWn2yoTzpCbD+7gC
         xxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236821; x=1700841621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3srW7WtWJoYPnRcjk5XubzsXgiqAXdE+waCWGZwmu2I=;
        b=dZkhS2hqRxjFRPGo+7qmfNoxAaUoV4XMUlC2EHyEd3B2hYnaYjA+5MZ+G58Rkc5I+X
         zxdMgLqb428lX+AGse4uc4C5YbIEhA4/5c1Ow83ABbyGkVMBXSEc9Vt13IKN6DI8CLrn
         rglVF9LgkL6OM+wUiA2vtmtBnGPrBfKu1ZcsZmdy1PZ+bbm3LBIv70u90zrIUwEv/xIz
         LSuvqXQE6oxyZ3n16HaJYVpfvwYDavwCuMyL4IPUxhz0m+KMQ9v1fS+wYlkYpM4PKRQP
         OvXMe0+Lgw2RtyqVjjgQvSi6Z/IMDj9ax7AxkWY/3gTbRO5X3LAYg/RyJT4sVnrjtBiH
         WthQ==
X-Gm-Message-State: AOJu0YxXvhF1o9r4qnI2MGzAJXnKVRwKl+SMvysBEieQsLsmAJM2j9u2
	lDD8Xw7JgRgI/xDRbpmjJggeZ8bHjZnk9Q==
X-Google-Smtp-Source: AGHT+IGUX4UC4EEbzdrgQA1RuIJIrjXY1AthFOhgzKLThVKilRIDHrzH+mFr5jIKOoRjaPhb9jMZpw==
X-Received: by 2002:a05:6a20:1592:b0:187:c184:58d0 with SMTP id h18-20020a056a20159200b00187c18458d0mr5635107pzj.46.1700236820715;
        Fri, 17 Nov 2023 08:00:20 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b00688c733fe92sm1559431pfo.215.2023.11.17.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:00:19 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] doc: document additional NotSupported shared code return
Date: Fri, 17 Nov 2023 08:00:16 -0800
Message-Id: <20231117160016.81253-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117160016.81253-1-prestwoj@gmail.com>
References: <20231117160016.81253-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/device-provisioning-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 9994aef5..6cf16fb8 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -109,6 +109,7 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 			Possible errors:	net.connman.iwd.Busy
 						net.connman.iwd.NotConnected
 						net.connman.InvalidArguments
+						net.connman.NotSupported
 
 		void StartEnrollee(a{sv})
 
@@ -156,6 +157,7 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 			Possible errors:	net.connman.iwd.Busy
 						net.connman.iwd.NotConnected
 						net.connman.iwd.NoAgent
+						net.connman.iwd.NotSupported
 
 		Stop()
 
-- 
2.34.1

