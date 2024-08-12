Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859719047C
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487408; cv=none; b=nsiUzP8zjgh3SciUufYXiSlKGEI2adsoa0mv20eo7iFeVwU270ZtBmVG0DORnKTccjVR1AvUq4NMrrwT1Ag9EjnhtvEuN3zqiVPJtaHIqE6nl2VkYO5PwbrChG9ZzGgvwsAokAujJL/9b17Lv6uRYWar2kee3vhW6zvG4hxNi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487408; c=relaxed/simple;
	bh=zuocVqkrXa+FRcB5mO40cgjp0zhv1dupcmY3i74yXTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2prXkZkajPxfmfVTwdA9hjaFTBnHhPm4FB2oMTIuekxAn8CFv7gjEsFTqSp3+mYVU7sYpIk5Myn3dwlTY8vuK1/WwO7USwlXTdAC5TGD0UEnRLo7/vKgJnXCFsT7cLn5g0p0nPO/aJncHUsydpJm8PFSF4lRPI2vPPTvCReuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw/+eyp0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw/+eyp0"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so4935011a12.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723487405; x=1724092205; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB3Eki21XhsNlD3Mfr0DW4smFeZb//ku8IQAOfu1j28=;
        b=aw/+eyp0Z4xLxxGz1aiDn92Mn+Pui8PvIFureJyvdopj+Kr0Jb5FLXczzVHvCmqNJs
         bITzN1PRln9Iv2Msf7FKsxxLOEPSwAhvGkSB7/v9pLHFiTYDDAwLF2PXD81JHZl7cAEW
         BZwTE/McpYOqILOsUUZO0Ag+2wuEBOZpFmCR6CH9w6h+I+3tqajiJq3qeiF3gcitnne0
         NI+OpMgtXqMySzllqk5CxGs51tVZleERittQpE5Q8xHQ0J7A/IF0ysBcVQLryMdC3cXE
         FitMHvPnOebf93spWN3gF18RJt9//qrFAlc9QaxqNEi6CAK98hRnyvDIT4PPp1KabIkc
         Cvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723487405; x=1724092205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB3Eki21XhsNlD3Mfr0DW4smFeZb//ku8IQAOfu1j28=;
        b=CuOZ2vHCPNP6Pbhg6h1f63ryHlLXniXOiiYGo7R8J87VG55Z1JFkRj5EQFQtnuxFEL
         mpsfZu/v9A6KKuHjj3z3tHzlJvqpqAf7yOtWmRuylPgYwn+T52k9XNSFBPex0Sh0mAK3
         jQzg3PV2AvzRD7TDGwZggh3iwBV2YIZg3Rz24Tzklo0SueAqKJtKKMNJYf1RxKzenHTy
         LTNF/wyIhTDVAhpnYmLiMnE1VWufuhGsv3AYnrj3FpAqUVMNvPNpqyYHGghaOk8Yu3NS
         CYxXf+u1i4ntT1bwdCeUHD+ICmUNJv34YJLISnwWtturEJPq6zjhqL2qMrAOLfdf4KOh
         /Sdg==
X-Gm-Message-State: AOJu0Yzr5uQYr1iD9AH1TtBBVOHtkJrduLX+v756UasF2ooq5dRNSniY
	E1PKBb2oDcSLLqChuzAbEHI5IJ/Rx89V9vaQnvsJ9gIYnAjxQN5M7s4RCQ==
X-Google-Smtp-Source: AGHT+IFSms8zJaMxjvhDR1WtJTKFA0jCTl774QNOKKhLihzcRgt6GHlwoOs9NEnk+fCuRnyKMVBiwA==
X-Received: by 2002:a05:6402:40cc:b0:5a1:21df:752d with SMTP id 4fb4d7f45d1cf-5bd44c26d39mr973191a12.10.1723487404867;
        Mon, 12 Aug 2024 11:30:04 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a61e2sm2340833a12.51.2024.08.12.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:30:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: add SAE-H2E test for setting the default ECC group
Date: Mon, 12 Aug 2024 11:29:58 -0700
Message-Id: <20240812182958.175048-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testSAE/default_group_test.py | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/autotests/testSAE/default_group_test.py b/autotests/testSAE/default_group_test.py
index d72c96ca..3b7812c3 100644
--- a/autotests/testSAE/default_group_test.py
+++ b/autotests/testSAE/default_group_test.py
@@ -13,7 +13,7 @@ import testutil
 
 class Test(unittest.TestCase):
 
-    def validate_connection(self, wd, rejected=False):
+    def validate_connection(self, wd, hostapd, rejected=False):
         devices = wd.list_devices(1)
         self.assertIsNotNone(devices)
         device = devices[0]
@@ -29,14 +29,14 @@ class Test(unittest.TestCase):
         wd.wait(2)
 
         testutil.test_iface_operstate(intf=device.name)
-        testutil.test_ifaces_connected(if0=device.name, if1=self.hostapd.ifname)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
 
         if not rejected:
             self.assertEqual(device.event_ocurred("ecc-group-rejected"), False)
 
-        print(self.hostapd._get_status())
+        print(hostapd._get_status())
 
-        sta_status = self.hostapd.sta_status(device.address)
+        sta_status = hostapd.sta_status(device.address)
 
         print(sta_status)
 
@@ -51,22 +51,27 @@ class Test(unittest.TestCase):
     #   - Connect, try only group 19
     def test_auto_selection(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.default", name="ssidSAE.psk")
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
-        self.validate_connection(self.wd, rejected=False)
+        self.validate_connection(self.wd, self.hostapd, rejected=False)
 
     # Try group 19 first
     def test_default_group_enabled(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.default_group", name="ssidSAE.psk")
-        self.validate_connection(self.wd)
+        self.validate_connection(self.wd, self.hostapd)
+
+    # Try group 19 first, with H2E
+    def test_default_group_enabled_h2e(self):
+        IWD.copy_to_storage("profiles/ssidSAE-H2E.psk.default_group", name="ssidSAE-H2E.psk")
+        self.validate_connection(self.wd, self.hostapd_h2e)
 
     # Same as auto-selection but won't retain the default group setting
     def test_default_group_disabled(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.most_secure", name="ssidSAE.psk")
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
         # IWD should then retry but use only group 19
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
     def setUp(self):
         self.hostapd.default()
@@ -88,6 +93,9 @@ class Test(unittest.TestCase):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
         cls.hostapd.default()
 
+        cls.hostapd_h2e = HostapdCLI(config='ssidSAE-H2E.conf')
+        cls.hostapd_h2e.default()
+
     @classmethod
     def tearDownClass(cls):
         pass
-- 
2.34.1

