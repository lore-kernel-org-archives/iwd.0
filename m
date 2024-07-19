Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE620145B32
	for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413174; cv=none; b=uI/Fd022/54Ko6iP3NUvNPJ/20GmCwdhitDHxDqn3V9JEnwVY46/srNpPhhT/IDlZuBD6VvzVQyVmJa5OJ9Nb7mBpuYjbu1lW3nequ7cNezQQ7RcBVhLJWXevA0/CiTpABS+qcTAoCNxcZpzSK2PUyKc8aziRyXx8R8+DCKh1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413174; c=relaxed/simple;
	bh=5p5mxDQd1yC58tDQQPv8FDBhI5WyP6gCwRS6nzjzjy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5KHVY5DjUKGFZXLMoGX8DATJ5oQ+9cyqfvHm6W5c9o8WrghEVpXndsTNgCeJyoi25zgBRZVahAtHQGWj2+sGfV/q1yB7bKgs9tJKqEBDDO0cGOhyM1xdyR/WlE65lOnjFH/lbBTZqeVPEjtv2jRrgNAbqf+OZQvZ0BVO4kUSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF/4IIDj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF/4IIDj"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so12550736d6.1
        for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413171; x=1722017971; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjBf2ep2Dc6h5RWzrq6gbLC8DBexaXb2Y4eo9NWRI90=;
        b=CF/4IIDjzyKcixTc++nZ9xoh8CREYl2gatmvMW+AuMsOyV344B7Q9kluTU2m2AVekp
         JWfp2hGgXLcW8JMehU5joAxgqKtDkHmYwW+ySnbE2baWDCscuU7BXwM45s+9sj1D6rqa
         wsb3zxVNpy9552NU7JLKvmHj/I6L4PaYKVdx7fPe1lvbBHKeJXhPuv1nofaP1z+fpT7a
         HCM+DNwh9GdTXWSwmYutcAA1jIOYbt6el7qhHd29JXk+FkEFVEWqKmqBj7BWc3DCQk43
         QAw6i9xEIlfU7sPaq4LZNW0mIhIWqmNGh+Q4Vlljr8GHSIxKuWSStnsWuuiNP66PIGJ6
         Gknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413171; x=1722017971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjBf2ep2Dc6h5RWzrq6gbLC8DBexaXb2Y4eo9NWRI90=;
        b=KVsrV8OBb/UipMiHLc0LcqVzzgG9ok+mTLoH/BqhN9SOn2ksgZ/bUiJ88HtCsycs+i
         VRTQ3clQief1p+dSEqCvJwcm2InDlRy/9jH2LosWfGDZEU87EjcIlAUbz+BNPTPyYMQL
         QxEVhAxoAHdM98/YKQ6yVonS/pHjJzeZD95ygyl4M5Q3JGBPUMOyIz/AzrKwlEZweS8l
         rttMJh1Of55QiUQnVaNkAlVHbTnzYwrAVwJhqNzoP5Fb1oK9XRl+8Pm0Jf9ZyC/PdYVV
         nZPH7ebqYiiHDVg3v8Osw93ZzUtoENbvRc7xjJ4z0NVoJKLkBbxxanCbuvt9Me+OFY5R
         0j2w==
X-Gm-Message-State: AOJu0Yxl13U3i+XPcUwvlzb6ctj2ZHBvYEeKrN5BqZ0mGvBgj2kJ3RxG
	c952DziKrXuVBXAfg4gsLIQosjzxyomyvW8mzGuV3cjcXlCrIOZMWXEfJw==
X-Google-Smtp-Source: AGHT+IFZOqt/iNHg3o0f3ndW5FcLX7eg6ZuhKBFxUNNqvPY5a3Ru9Fi6fLqlQrI7JRHK9MNT5DVp+g==
X-Received: by 2002:a05:6214:29ea:b0:6b7:a3f1:3251 with SMTP id 6a1803df08f44-6b95a794074mr9477156d6.51.1721413171471;
        Fri, 19 Jul 2024 11:19:31 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.170.153.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9cb02esm10589106d6.91.2024.07.19.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:19:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: add test for DPP starting while connecting
Date: Fri, 19 Jul 2024 11:19:26 -0700
Message-Id: <20240719181926.3888420-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719181926.3888420-1-prestwoj@gmail.com>
References: <20240719181926.3888420-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testDPP/pkex_test.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index db355225..f3124290 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -4,7 +4,7 @@ import unittest
 import sys
 
 sys.path.append('../util')
-from iwd import IWD, SharedCodeAgent
+from iwd import IWD, SharedCodeAgent, DeviceState
 from iwd import DeviceProvisioning
 from wpas import Wpas
 from hostapd import HostapdCLI
@@ -210,6 +210,24 @@ class Test(unittest.TestCase):
 
         self.assertIn("SendHostname=true", settings)
 
+    def test_existing_incorrect_profile(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+        IWD.copy_to_storage("existingProfile.psk", "/tmp/ns0/", "ssidCCMP.psk")
+
+        # Start connecting
+        self.device[1].autoconnect = True
+        self.wd.wait_for_object_condition(self.device[1], 'obj.state == DeviceState.connecting')
+
+        # We should be able to start DPP despite the connecting state
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.start_iwd_pkex_configurator(self.device[0])
+        self.assertEqual(self.device[1].state, DeviceState.connecting)
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
     def test_existing_hidden_network(self):
         self.hapd_hidden.reload()
         self.hapd_hidden.wait_for_event('AP-ENABLED')
-- 
2.34.1

