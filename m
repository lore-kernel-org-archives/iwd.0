Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28D32ABCD
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061576; cv=pass; b=LFPR2DSAcYWrO53VsYMExbDQBvdrL3xVTTRHjIkWJ/FuBfQMehmXJ4IfTKcdOMv+FeMracKKRE8ukX8LQqAr/SAYHDm5kvDmEIpnqGcpSdneJVQGeVQYBPNOQMwiljFhcL/sOYc0cL0zXkHwxCYbSjRhNDMdLzqR9gGAfZECKbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061576; c=relaxed/simple;
	bh=W+F+u5+clgF6ULYf6ydhTCAgsTogDMIexlFBh6m1LGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEGeKggLRStaEjpPbmmAkPYPpEhPgfOwQuLkUJY44N8PLDQjvIWOI7xc9esF5NZHw92E/Y20nSgMcyjHQTdyWf6DHPz87kdtwE6Nt+GUaSHK+N6cDGzvdHSeifQ7pilfdkm9tp3YVfrXXeII71RHacFBsxupSzk2tsiyiXy0Yxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INLXilZk; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INLXilZk"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c4436d02cso7858241cf.1
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061574; cv=none;
        d=google.com; s=arc-20260327;
        b=eCm6b/jOxjvOfDth/RN8jYl/L5igKNyCHHx+UG+dAnxIQCGryaH5Q0yFeGVIgAu5uK
         Udsp5G3MZE/4jiv/ntROoMMFaQbDChZw3bIPMfqFkNWz3joNEwEc/7tcs/5IWqD47Ih+
         cFrG1vOh3gVlVwicrpjmuo3JaFmVdVY73yqerzGoX3nR24+7O269OPTt6Aykvo4sicqJ
         zaIplQPDj8OjsyLi3aMGjbN1qYOuYJhBb5eJAzvhmdr4t+4cHMpCEYecsyVQTE//k9AY
         1IO1u//6fWoSz3f9xo/8t+/toHfmUp9ofS0q7bhUl2tIwPmzQoNio2A5thqoEzxAbPsH
         o/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5952Ku/c3CrBMP/n5nyyA7lgzw9ThRLWtc2xcPHwCcY=;
        fh=lOB+NE21i+DlK11xqGcqr6uTCV2U6X/qbNGHyNqUyZk=;
        b=HpLbU7y+h2VVj2UD/YRSAOK5kjazNHWPAD3mSX0uq4K8iJiVx/7A91NAKAXaVDW+pP
         Bvrl3TWTLiTZ5iQN1ghu3+qGejdqn2cDBYHoG6VFHpKItzN7EfiFXwM4ods3j/TpYpJ6
         Tc/3TgUE8DMcUKE3RTto4GKPOLD4i/oBisEaYUgTF3CJ+ci5aYBzYB3zySqe4eS9ueHK
         z67/J/wfSV5yrc5R83vWTED76gmKFrcgeMhppJoLicwinT2ChlTsNxpnZzKvst7lBHG1
         3A7N1qL3Bv56sXHXssY/GZuGT5BLjwUazk9f1CDnrhA5mrRRFyDs0sGLoQem3YdEjNuk
         O0dQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061574; x=1784666374; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5952Ku/c3CrBMP/n5nyyA7lgzw9ThRLWtc2xcPHwCcY=;
        b=INLXilZk+mPeqn6NraSM5Lldrk6tizyzuDEpZAgpcWXB3+pUGmRMb1aEFcfULk94ji
         nKeWudB70iOeahvfrby4ziGOnTov8b89E67Plnem8jkcBQzUUfAMsgskcUAylrrZwHKE
         Ikj14rBgmHPm6s9KXsexYhx+Y9zh+auyM+mUqXU2J74o+6mHhGD+g8sxZv8L94HB2ytj
         18C0bc48WaXw+QVsAFmg7TieLxgbq/SdKt3dI8fM57KN5lsmp1uBhlS5pFqTzG0+GQjA
         mbUC+NtnnciB1JotHKAUIAmQllZiJ3+3iLCmQ5VclNO5gbU1TEpWHkDAaXTtBJcH81Rm
         J84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061574; x=1784666374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5952Ku/c3CrBMP/n5nyyA7lgzw9ThRLWtc2xcPHwCcY=;
        b=innSOPEw8eZfXCw3PneNiu1DxI7by4Dh8H4hQW8qt2QZT5agqKIN5RQ3YS+BZTz2up
         Y1JOzvCWc93stPSLzmqqP775UfTbelKXo43fet0Vw0YxODpYmRXyVLFdMpO6lorNyV/K
         AHmeDVJzEaDHWOxdLg7QUWE+SNEA5+KQ5YjRy6OXHiRgyDywbV6hPrnwRxXxJMB3P84R
         XWZSfXn57CwOLMh6cNgSf0m2m2VcdKB8M82YEpNSdkIDTdTIFbxYQOD4jNM6amI979rW
         FlTh25+aazDtMzAtqCdU++DYrTKTN0WNWicrUq7R7AI0gVSX2rBQ0Te2tz+1BHjjOWmw
         R7+Q==
X-Gm-Message-State: AOJu0Yw5S80aB93ZNUeuTY8RWTuA59OA3ak8QPiS4o5g0Br6gmKhe+0R
	r+5jaGSnm16smFcmUl1SBptvzKiGlYKioGyIk8z0/4n5jkOqExq8j5PxeUVcWX1fb3XhMTK2ksS
	awLzP+pC+Wcax0dZ0YI3v9AMk0VGqzWTvL6ZJ73ih6w==
X-Gm-Gg: AfdE7clZRx1F+NlmVwhKSsez/ea2Sw8Oaz5pKvbf14IFEwyzsKhZvOn4aQZHtYLb2Ez
	LSybXjO8ue3c+GyNITRlC4uMQT6AZO9eTZDrStjLl5w6Jc/ro95yrTPZAvC5gjHNxFpX5m79TB4
	RrstX10f1Hr1v8AsSZV6SphUQcqm/3jl2o/YuzjCST5vHr5d8ian37ACrwNzgkWLEv5lV2fjpkN
	RNlMz+7N8NgQioSVUgxvZkMcfqP/XUz9UTSAF3+ymxLQnKys0FJkSfA3iH4oJmgFMGisOzoRA==
X-Received: by 2002:a05:622a:411:b0:51c:1daf:196f with SMTP id
 d75a77b69052e-51cbf261911mr145706121cf.58.1784061573610; Tue, 14 Jul 2026
 13:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
 <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
In-Reply-To: <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>
Date: Tue, 14 Jul 2026 23:39:22 +0300
X-Gm-Features: AUfX_mztuXE46UDAOy8R5XY4qDH6u7ejzAwgX_dM3h2Tgwaj2iQ86muLceu8oEk
Message-ID: <CAMq8zosKH22wMSpTR1tHBMroZjjV8FMxtLNAZBJ+KYS36jCQFw@mail.gmail.com>
Subject: [PATCH 3/3] auto-t: test BasicServiceSet RSN property
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Verify the exact D-Bus key management and cipher capabilities for
WPA2-PSK, SAE, and transition BSSes.
---
 .../basic_service_set_rsn_test.py             | 70 +++++++++++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |  9 +++
 autotests/testBasicServiceSetRSN/ssidSAE.conf | 11 +++
 .../ssidTransition.conf                       | 12 ++++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |  8 +++
 5 files changed, 110 insertions(+)
 create mode 100644
autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

diff --git a/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
b/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
new file mode 100644
index 00000000..20e0b62c
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
@@ -0,0 +1,70 @@
+#! /usr/bin/python3
+
+import unittest
+import sys
+
+import dbus
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+
+BSS_INTERFACE = 'net.connman.iwd.BasicServiceSet'
+
+
+class Test(unittest.TestCase):
+    def _get_rsn(self, device, ssid):
+        ordered_network = device.get_ordered_network(ssid, full_scan=True)
+        network = ordered_network.network_object
+        self.assertEqual(len(network.extended_service_set), 1)
+
+        path = network.extended_service_set[0]
+        proxy = self.wd._bus.get_object(iwd.IWD_SERVICE, path)
+        properties = dbus.Interface(proxy, iwd.DBUS_PROPERTIES)
+
+        return properties.GetAll(BSS_INTERFACE)['RSN']
+
+    def test_rsn(self):
+        device = self.wd.list_devices(1)[0]
+
+        rsn = self._get_rsn(device, 'ssidWPA2')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'wpa-psk'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidSAE')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidTransition')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])),
+                         {'wpa-psk', 'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.stop()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        Hwsim()
+        cls.hostapd = [
+            HostapdCLI(config='ssidWPA2.conf'),
+            HostapdCLI(config='ssidSAE.conf'),
+            HostapdCLI(config='ssidTransition.conf'),
+        ]
+
+    @classmethod
+    def tearDownClass(cls):
+        cls.hostapd = None
+
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testBasicServiceSetRSN/hw.conf
b/autotests/testBasicServiceSetRSN/hw.conf
new file mode 100644
index 00000000..a43062d9
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/hw.conf
@@ -0,0 +1,9 @@
+[SETUP]
+num_radios=4
+hwsim_medium=yes
+start_iwd=no
+
+[HOSTAPD]
+rad0=ssidWPA2.conf
+rad1=ssidSAE.conf
+rad2=ssidTransition.conf
diff --git a/autotests/testBasicServiceSetRSN/ssidSAE.conf
b/autotests/testBasicServiceSetRSN/ssidSAE.conf
new file mode 100644
index 00000000..2ec9ae61
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidSAE.conf
@@ -0,0 +1,11 @@
+hw_mode=g
+channel=2
+ssid=ssidSAE
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_groups=19
+ieee80211w=2
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidTransition.conf
b/autotests/testBasicServiceSetRSN/ssidTransition.conf
new file mode 100644
index 00000000..00170772
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidTransition.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=3
+ssid=ssidTransition
+
+wpa=2
+wpa_key_mgmt=WPA-PSK SAE
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
+sae_password=secret123
+sae_groups=19
+ieee80211w=1
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidWPA2.conf
b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
new file mode 100644
index 00000000..d706142b
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
@@ -0,0 +1,8 @@
+hw_mode=g
+channel=1
+ssid=ssidWPA2
+
+wpa=2
+wpa_key_mgmt=WPA-PSK
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
-- 
2.55.0
