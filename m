Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7821110
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgSSscGR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cc329ce84cso39792305ad.2
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699885980; x=1700490780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJPufJknNSkjCqoVwzFryN5LChMX9+VklA1OTY6hHGQ=;
        b=EgSSscGRfgwZtnnt4Fx7EdK1eG0HYyUHifsfvV4iqQgjGO7MrW/E8pa6j5/tatb2b0
         OJKL8EE4lPpSxVxCuixnLJTcBuHO9y0H5sFpmVHhTWhx/KLZ3agldE9vAl/gsQppDeea
         lnlxzOwFFyW0Q2jGtkfNGpG3AUxXFbooWIp70QKBITYqArmHb9bEMXo5I/EGTOzqqtsm
         NumvZ+17PrAdY6FLZrU7RJnjAQ8Qp3hoQ+lKu9EJoKDl5d/pqpOzZZnrX6amoezttRpB
         AcudETxWwGnAnwV8RmMUIS3UK0SAf7nQTiPJihkcBP2DbGHd/Tg2qSN9p0uNRpMTwgVL
         Qkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699885980; x=1700490780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJPufJknNSkjCqoVwzFryN5LChMX9+VklA1OTY6hHGQ=;
        b=pTN3r2awbBcfvR/yOPZt6dOoHLLkaPAEgSIJeCaP918fi7AEKwysfMp2qDStd7whD4
         EvsPIUDqfIC8aBlHAedz6oIrWk3EPCQStNSQOg+e9h4QXP9T8VjqXD3lxyzIlfHCt7b5
         PBGyQctVTXxs+UimeBwDSk7aPJLUe35wvje7k28v9gMIee+//O8OURP0y/pyNBoGtSSl
         aKd0Y89O2aFO5gKV3cYWNTUFxK3hPES/b0F46m6OMexR3MgwGBcbwyKQS0DcxYM+Zz/V
         lRTPwFCbXxSf+4BUmThQs5ONrApWzbJEr6mtAnOhNP4DCExyUCH2Ic7SMVzhlgyIUUbD
         8WxQ==
X-Gm-Message-State: AOJu0YzvgcspJHwmWayTsjkVbWtIxV+Qf9zCFuuot5XfzdOxzuyHhgrl
	c1aKmkAzIM+3S+mKU1Jscggnpj1vE2w=
X-Google-Smtp-Source: AGHT+IENHft7ODvJRm+vF922QtrzDH1K/6006+sheoygoQYgpy+fdMSbCoRhKG6zGFCKH1z0F97oFg==
X-Received: by 2002:a17:902:e885:b0:1cc:5505:fff3 with SMTP id w5-20020a170902e88500b001cc5505fff3mr9415051plg.30.1699885980509;
        Mon, 13 Nov 2023 06:33:00 -0800 (PST)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001cc25cfec58sm4071496plg.226.2023.11.13.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:32:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: get DPP PKEX test running reliably
Date: Mon, 13 Nov 2023 06:32:55 -0800
Message-Id: <20231113143255.278191-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113143255.278191-1-prestwoj@gmail.com>
References: <20231113143255.278191-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tests do not pass due to some additional changes that have
not been merged. Remove these cases and add some hardening after
discovering some unfortunate wpa_supplicant behavior.

 - Disable p2p in wpa_supplicant. With p2p enabled an extra device
   is created which starts receiving DPP frames and printing
   confusing messages.
 - Remove extra asserts which don't make sense currently. These
   will be added back later as future additions to PKEX are
   upstreamed.
 - Work around wpa_supplicant retransmit limitation. This is
   described in detail in the comment in pkex_test.py
---
 autotests/testDPP/pkex_test.py | 56 ++++++++++++++++++++++++++++------
 autotests/testDPP/wpas.conf    |  1 +
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index a568e619..6c5cf054 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -21,6 +21,11 @@ class Test(unittest.TestCase):
             self.wpas.dpp_configurator_create()
             self.wpas.dpp_listen(2437)
 
+    def stop_wpas_pkex(self):
+        self.wpas.dpp_pkex_remove()
+        self.wpas.dpp_stop_listen()
+        self.wpas.dpp_configurator_remove()
+
     def start_iwd_pkex_configurator(self, device, agent=False):
         self.hapd.reload()
         self.hapd.wait_for_event('AP-ENABLED')
@@ -38,11 +43,51 @@ class Test(unittest.TestCase):
         else:
             device.dpp_pkex_configure_enrollee('secret123', identifier="test")
 
+    #
+    # WPA Supplicant has awful handling of retransmissions and no-ACK
+    # conditions. It only handles retransmitting the exchange request when
+    # there is no-ACK, which makes zero sense since its a broadcast...
+    #
+    # So, really, testing against wpa_supplicant is fragile and dependent on
+    # how the scheduling works out. If IWD doesn't ACK due to being on the
+    # next frequency or in between offchannel requests wpa_supplicant gets
+    # into a state where it thinks a PKEX session has been started (having
+    # received the exchange request) but will only accept commit-reveal
+    # frames. IWD is unaware because it never got a response so it keeps
+    # sending exchange requests which are ignored.
+    #
+    # Nevertheless we should still test against wpa_supplicant for
+    # compatibility so attempt to detect this case and restart the
+    # wpa_supplicant configurator.
+    #
+    def restart_wpas_if_needed(self):
+        i = 0
+
+        while i < 10:
+            data = self.wpas.wait_for_event("DPP-RX")
+            self.assertIn("type=7", data)
+
+            data = self.wpas.wait_for_event("DPP-TX")
+            self.assertIn("type=8", data)
+
+            data = self.wpas.wait_for_event("DPP-TX-STATUS")
+            if "result=no-ACK" in data:
+                self.stop_wpas_pkex()
+                self.start_wpas_pkex('secret123', identifier="test")
+            else:
+                return
+
+            i += 1
+
+        raise Exception("wpa_supplicant could not complete PKEX after 10 retries")
+
     def test_pkex_iwd_as_enrollee(self):
         self.start_wpas_pkex('secret123', identifier="test")
 
         self.device[0].dpp_pkex_enroll('secret123', identifier="test")
 
+        self.restart_wpas_if_needed()
+
         self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
 
     def test_pkex_iwd_as_enrollee_retransmit(self):
@@ -52,6 +97,8 @@ class Test(unittest.TestCase):
 
         self.device[0].dpp_pkex_enroll('secret123', identifier="test")
 
+        self.restart_wpas_if_needed()
+
         self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
 
     def test_pkex_unsupported_version(self):
@@ -121,15 +168,6 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
 
-        self.assertTrue(os.path.exists('/tmp/ns0/ssidCCMP.psk'))
-
-        with open('/tmp/ns0/ssidCCMP.psk') as f:
-            data = f.read()
-
-        self.assertIn("SendHostname", data)
-        self.assertIn("SharedCode=secret123", data)
-        self.assertIn("ExactConfig=true", data)
-
     def test_pkex_configurator_with_agent(self):
         self.start_iwd_pkex_configurator(self.device[0], agent=True)
 
diff --git a/autotests/testDPP/wpas.conf b/autotests/testDPP/wpas.conf
index 521fb29b..19df4350 100644
--- a/autotests/testDPP/wpas.conf
+++ b/autotests/testDPP/wpas.conf
@@ -3,3 +3,4 @@ ctrl_interface=/tmp/rad1-p2p-wpas
 update_config=0
 pmf=2
 dpp_config_processing=2
+p2p_disabled=1
-- 
2.25.1

