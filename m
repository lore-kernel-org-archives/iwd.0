Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD581482F8
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320811; cv=none; b=joieuL8nuZyj+L72ASant5dsHMEvYS/CPyOLczutzw3TWz7gUwr4IpSNTKf0cK5SVpRFfQbbtbcf6BKh1I+2hI3tPTZosD7AsA8WSpEWJzYxPgH85MzQP1kpdzbSdWn8UrI0HeKOeDxkFO3g5GUDrQqR/GghqvMm/BgJHoFiQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320811; c=relaxed/simple;
	bh=aN0GS/eB6all4xDAa/Tzsg3Zwk60lecIW4QrPGFpgU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyakUWZpYtafJ72fnxi0bbmME5zUZzEAumDFonzDH8USre3YyZqHhsN3MXkVcEaPpjzikbb1ByxIeSfztLE5RYPR2bHIE2jRmAJHSnzpeWwiKMTeuiEPP5d0TFmuRt6QvaBmFcfrsCtuAXq73hVkBPZSFMEj3fZqpRambJo3qSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqhApJwB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqhApJwB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d10so45291815ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320809; x=1719925609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+FQS0cnw/y+Ndkc1EwDfHBGbMpY9IQFB0Xs/Fy5F6g=;
        b=jqhApJwBBQx3IJHNsNxvCy1uUsI84KsQ1pevEIywhYLq692YMTMoA0PhpMVq7avNuq
         nlTK2lOAljiyVdGGS8bZWVAPQFVsnqrur0EMUbmequZjvedjfjeNuq5/c+Nt+szDwUcy
         YJ0ow32DBPaDvE74lZPHufkSGZHcZyVp1IK2cPyCIgjjCpWMPgyH5YVFcIaQFbPLatwH
         LeOFfce5zkpAYj9K+iJKXnsIOORJ7MShh6UvI7qPSCr4aIR/2hu7PNOY3Tk+fovTF1x0
         SsX7et36RcJVtK2Ol1cEnBi7lH9j0YrURWvjwn4fHuboisfyOndH0bAGzj5Qcmule9Td
         X04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320809; x=1719925609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+FQS0cnw/y+Ndkc1EwDfHBGbMpY9IQFB0Xs/Fy5F6g=;
        b=ULaWwjrZSFrKW+UVluteqrzO3zqtBjydgU28E9OgG3kglEUoKcrXm5O9Bou5hnD9Q0
         ExIHu/CY/UIdhnrLkk/XdOgZejOoZLrkimtoi99XWSI1x1/0Kja0zHpOUnzctlOwPcEK
         0TUFhTGGuZO/G9irLjPC85yO8o2ZEv3tNFZGRJr4olfBxuWYZ+UInePfBOTxUFy5c+2Y
         3OmC09McSzm3SsQEgcLpB+gCT8GmMMV77v2RylsXBVMIr/kBJ+Md1cVEMQhMyii9ieDe
         gyJsHabnH8ztcZHZooknY+OGvnU81FJH9sJm9fNdvCY27UiYTatvgF0Hr/PmRm5YOA42
         pEeA==
X-Gm-Message-State: AOJu0YyFmkUZlTHLZs7wqhO/dxdKKqXOKygOaU7C1+e4XstZJxEyW3Za
	XjTuhAddxd9ghjHOQeFaSlhX8aVpo01TeaX0rZkDRlCiupCn8FU2FIfUug==
X-Google-Smtp-Source: AGHT+IExavZECHWpnL2VAZHYWaujwKouRridi4Izh6e2CHzGb6U7Iqt+PM1eLbtk4q797DUc73PVaw==
X-Received: by 2002:a17:903:18d:b0:1f9:aa05:878f with SMTP id d9443c01a7336-1fa1c7f72fcmr108709615ad.0.1719320809166;
        Tue, 25 Jun 2024 06:06:49 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] auto-t: add test for a deauth coming in during an FT-roam
Date: Tue, 25 Jun 2024 06:06:24 -0700
Message-Id: <20240625130624.385553-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625130624.385553-1-prestwoj@gmail.com>
References: <20240625130624.385553-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testPSK-roam/failed_roam_test.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 8cce8bb5..60bcf366 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -149,6 +149,21 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.disconnected'
         self.wd.wait_for_object_condition(device, condition)
 
+    def test_ft_deauth_before_association(self):
+        self.rule2.enabled = True
+        self.rule3.enabled = True
+
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(self.wd, device, self.bss_hostapd[0])
+
+        device.wait_for_event('ft-authenticating', timeout=60)
+
+        self.bss_hostapd[1].deauthenticate(device.address)
+
+        condition = 'obj.state == DeviceState.disconnected'
+        self.wd.wait_for_object_condition(device, condition)
+
     def setUp(self):
         self.wd = IWD(True)
 
-- 
2.34.1

