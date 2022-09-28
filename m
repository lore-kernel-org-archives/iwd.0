Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609846AA
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:43 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2166583pjh.3
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mH+2tEKM0QvgpSlUZkjBHC8qg1IQlSWtGv7qFLPmc6o=;
        b=kBvZdnWiaKWpJAaWvsVtRTy8o3LX93H9gqniqR/HLEsoWQVugtR/JZcCfT0PJUvRyj
         XMTwdIeAX1CvEyVlZ9+ju2w5nE/yrFbplTe3eKfiYSav2th7Heih1rd8zOMvGv3U1Nmk
         eGhQtZTDZBlIfTh/IEQJqjsDzJUt1x6eFUVELur7NkonD/wYkFN5fmnjhwqYcFoBIig0
         VjfFwIGOsN21QdHsrSeip6iWdscJ1tU6lqnSZrcXy1IlcyD4jrWCSrBVtj/uepUq6P8i
         axh9KtkIcVgZEw4hrCWQzy/rBIBEVat4hUpQ/uF+wCwTGaepg8yBzhCEauQJ6sfnUVgu
         Wtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mH+2tEKM0QvgpSlUZkjBHC8qg1IQlSWtGv7qFLPmc6o=;
        b=FuwMYL5QzFqDcOII1Im0L7xotXqBPWk7YBgBOzEFOuaYZk6QFQqpAYvoa3Xt0ZMaDq
         97bCx/XpguEIRE3x/kdGxq8i/CfWBskLNsjQncwhrT0QBSfN6o9221DltiKcHWmIG5Ft
         8dI/a1N7pEWJ2cT3x6xSPnO5wDlgV2Hn7A/xbtmKh9BUlGrm+7Z4kVapTGQzCDYSSbA9
         nB83Wlg05XPFI1I03fKE4k47l3pj9i9H2KhSWZvw32yZ9Sxlcie6a34sY4qICuZgrn2z
         r9aAOvTKfJSg7Md4I1GPj5ZdU/YbSdd7vEBlMPSss/wqavh9Q24KcZxjFhGfHVcjpWuE
         9o6A==
X-Gm-Message-State: ACrzQf0C3LMG0AgD02bTrvo9oS8usu8+IR7tPX4O8w9QcV3UZOoUcTbc
	oCF+EIDEu8WhGzh+wWOdRXyR7dRxQ/Y=
X-Google-Smtp-Source: AMsMyM7MV3EdHn3YwAZFKv8lyHwuIu/p+DrIRZn6cUjv2Hz9ASwEuivD67pGgKxUjLJlbw2rMJIOSw==
X-Received: by 2002:a17:90b:3d04:b0:200:9d93:f6f with SMTP id pt4-20020a17090b3d0400b002009d930f6fmr11149727pjb.185.1664383003093;
        Wed, 28 Sep 2022 09:36:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: update uses of wait_for_object_change
Date: Wed, 28 Sep 2022 09:36:36 -0700
Message-Id: <20220928163637.344656-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928163637.344656-1-prestwoj@gmail.com>
References: <20220928163637.344656-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes waiting for DeviceState.roaming, which is now done
automatically by wait_for_object_change.
---
 autotests/testFT-8021x-roam/connection_test.py | 3 ---
 autotests/testFT-FILS/connection_test.py       | 3 ---
 autotests/testOWE/connection_test.py           | 3 ---
 autotests/testPSK-roam/connection_test.py      | 6 ------
 autotests/testPreauth-roam/connection_test.py  | 3 ---
 autotests/testRoamRetry/fast_retry_test.py     | 3 ---
 autotests/testRoamRetry/stop_retry_test.py     | 3 ---
 autotests/testSAE-roam/connection_test.py      | 3 ---
 8 files changed, 27 deletions(-)

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/testFT-8021x-roam/connection_test.py
index d3f8e2c6..356a9af2 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -37,9 +37,6 @@ class Test(unittest.TestCase):
 
         device.roam(self.bss_hostapd[1].bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FILS/connection_test.py
index 5d60bf4d..28aaa955 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -70,9 +70,6 @@ class Test(unittest.TestCase):
         #rule0.signal = -8000
         device.roam(self.bss_hostapd[1].bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/connection_test.py
index 391d8cf5..1fdc990a 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -53,9 +53,6 @@ class Test(unittest.TestCase):
 
         device.roam(hapd1.bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         from_condition = 'obj.state == DeviceState.roaming'
         to_condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 2206f120..7a135e95 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -52,9 +52,6 @@ class Test(unittest.TestCase):
         else:
             device.roam(self.bss_hostapd[1].bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
@@ -76,9 +73,6 @@ class Test(unittest.TestCase):
 
         device.roam(self.bss_hostapd[0].bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 0 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/testPreauth-roam/connection_test.py
index 02d03361..87799df1 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -48,9 +48,6 @@ class Test(unittest.TestCase):
 
         device.roam(bss1_addr)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # TODO: verify that the PMK from preauthentication was used
 
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoamRetry/fast_retry_test.py
index 373f3d45..d380b2e3 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -91,9 +91,6 @@ class Test(unittest.TestCase):
         rule0.signal = -8000
         rule1.signal = -2000
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoamRetry/stop_retry_test.py
index b5eb6f77..e46b79d7 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -67,9 +67,6 @@ class Test(unittest.TestCase):
         # connects to BSS 1
         rule0.signal = -8000
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index ac44b4b2..ca7234a6 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -39,9 +39,6 @@ class Test(unittest.TestCase):
 
         device.roam(self.bss_hostapd[1].bssid)
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
-- 
2.34.3

