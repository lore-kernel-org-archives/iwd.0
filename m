Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFFA4690
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 17:40:45 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2470644pjk.2
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP5ozEYDb+OqZwDWUj3ioyXYoCX1WPhXLvlZm8lSR+Q=;
        b=TpVdnwEXlDVMRmKl73oL1GR353BFpECuBbqIxLZ9rjKu9R9XVvIoBEiQe5OYhFmmWq
         P/MmudfauI00DCmNNAYlSf0F9J3BoivkOjpc+GM61uILb2OsBO9hlmfCvv0u/Xa0bUID
         TJYSyNWQq2IubkZDlIHQ/lG73wxkXjk1NQPLx3GyEJutojq1Kv+tj2C9NCtA3LtADmqD
         0T2MqIblSlya6NinGIknXPdipz+qF17eMRXom0EazAsmpEj4B42WftK5AZYTuc2hy7lp
         NtP1x+iH5C9taES0lkooSzUFShjLxx8CLkZqD+mW3hlsU4BNOLYMnZdZnZkv8zFCPUvb
         CuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP5ozEYDb+OqZwDWUj3ioyXYoCX1WPhXLvlZm8lSR+Q=;
        b=gjHxPetsTtuKpoXeJ2ysRN4E6qRWEYiP4bcs4TumKAPqVzJ4LDmiER77/7DjBvtSM/
         ps63s8unlIkvrmNGlBi0aeIWSKFCIqZHIWjAqzaF+PZcMRYLyXd2m/aaMpCWL9SbUhYQ
         4j5HKmapgbOjw8meksH1nFryS9/rIuVKjM0yb1WvPyL7HmEfpvgAMs4/8fKOCpMBjUQM
         jECjhdgkBTgiBVddx56JWVb/50Ce4YGqO/MKtm8feIBOKX4TGLAzEcmY+mXANXAmPRvJ
         tZADCQnNDg5wXxuyUL/PNZtRTqsIK3nwNGo+KxGiQbdAyqho3DGTwEuvUkhak4h74V8M
         IN+g==
X-Gm-Message-State: ACrzQf3zWCtuEZRlBMJ43BHkeXckUTbv+lv/HuE8720praq0VcnrKhMX
	KJWtC5tkT3plAVpbAAduOLf+2uMTIGQ=
X-Google-Smtp-Source: AMsMyM4JijfNBF7xjT6x4huzJPwge0qJwJPAbBW7bkiei55XDmmJ+QlVdLB1i10y5h+qZhpIcY9joA==
X-Received: by 2002:a17:90a:1b43:b0:203:70c0:9f60 with SMTP id q61-20020a17090a1b4300b0020370c09f60mr11531624pjq.184.1665078044368;
        Thu, 06 Oct 2022 10:40:44 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b00176a6ba5969sm12479671ple.98.2022.10.06.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:40:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: speed up testScan
Date: Thu,  6 Oct 2022 10:40:40 -0700
Message-Id: <20221006174040.823577-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221006174040.823577-1-prestwoj@gmail.com>
References: <20221006174040.823577-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test was taking about 5 minutes to run, specifically
the requested scan test. One slight optimization is to
remove the duplicate hidden network, since there is no
need for two. In addition the requested scan test was
changed so it does not periodic scan and only issues a dbus
scan.
---
 autotests/testScan/hw.conf                | 9 ++++-----
 autotests/testScan/periodic_scan_test.py  | 4 ++--
 autotests/testScan/requested_scan_test.py | 6 ------
 autotests/testScan/ssid_hidden_1.conf     | 4 ----
 autotests/testScan/ssid_hidden_1.open     | 3 ---
 5 files changed, 6 insertions(+), 20 deletions(-)
 delete mode 100644 autotests/testScan/ssid_hidden_1.conf
 delete mode 100644 autotests/testScan/ssid_hidden_1.open

diff --git a/autotests/testScan/hw.conf b/autotests/testScan/hw.conf
index 660c874e..54ae50c6 100644
--- a/autotests/testScan/hw.conf
+++ b/autotests/testScan/hw.conf
@@ -1,10 +1,9 @@
 [SETUP]
-num_radios=6
+num_radios=5
 start_iwd=0
 
 [HOSTAPD]
 rad0=ssid_hidden_0.conf
-rad1=ssid_hidden_1.conf
-rad2=ssid_open.conf
-rad3=ssid_8021x.conf
-rad4=ssid_psk.conf
+rad1=ssid_open.conf
+rad2=ssid_8021x.conf
+rad3=ssid_psk.conf
diff --git a/autotests/testScan/periodic_scan_test.py b/autotests/testScan/periodic_scan_test.py
index 77dac373..eb53b312 100644
--- a/autotests/testScan/periodic_scan_test.py
+++ b/autotests/testScan/periodic_scan_test.py
@@ -12,7 +12,7 @@ class Test(unittest.TestCase):
         'ssid_open': False,
         'ssid_psk': False,
         'ssid_8021x': False,
-        'ssid_hidden_1': False,
+        'ssid_hidden_0': False,
     }
 
     def set_network(self, ssid):
@@ -58,7 +58,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        IWD.copy_to_storage('ssid_hidden_1.open')
+        IWD.copy_to_storage('ssid_hidden_0.open')
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testScan/requested_scan_test.py b/autotests/testScan/requested_scan_test.py
index 26e44ddd..021f64ed 100644
--- a/autotests/testScan/requested_scan_test.py
+++ b/autotests/testScan/requested_scan_test.py
@@ -30,12 +30,6 @@ class Test(unittest.TestCase):
         devices = wd.list_devices(1)
         self.assertIsNotNone(devices)
         device = devices[0]
-        device.autoconnect = True
-
-        condition = 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-        condition = 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
 
         device.scan()
 
diff --git a/autotests/testScan/ssid_hidden_1.conf b/autotests/testScan/ssid_hidden_1.conf
deleted file mode 100644
index cc11803f..00000000
--- a/autotests/testScan/ssid_hidden_1.conf
+++ /dev/null
@@ -1,4 +0,0 @@
-ssid=ssid_hidden_1
-hw_mode=g
-channel=1
-ignore_broadcast_ssid=1
diff --git a/autotests/testScan/ssid_hidden_1.open b/autotests/testScan/ssid_hidden_1.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_1.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=false
-Hidden=true
-- 
2.34.3

