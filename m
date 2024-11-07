Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDE212654
	for <iwd@lists.linux.dev>; Thu,  7 Nov 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985982; cv=none; b=bx6PHC3kJGcmASVV/EwXsvkkzc/ZTxoko6S5c8dQ9pgKVJHLdxrMQ1KLyV5l77JrYMTfLNk7cE7UD+ppEOf5XyCCQF+uEYIr+LvNe3041EH7SEqNBEwVtxZPnHmMTvcyVix66dKFEFTZ1JYESFuAC2Kl1PwaOnGM+yJMtiEpJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985982; c=relaxed/simple;
	bh=BTgi3JdQ4ZYF4V4Y8cFxrNT1QW3i2Um0fz8QcZZG2Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gD+ST+k7RWksgsKi3YRBXKT15JBAHYTM9dxH9g0BNx4hQJs4Zrb7cUPemyZm+NYEk51HkOFP1e6b4m3ZvOe1PG7V/neFHc+V0SR+E9VMRj1kEsa+BfrPBJUYXJt83aP0BAKzBucjKIlI7ZIoy8lG5inStFugGuIbIogWwwI5Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhVUlYNN; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhVUlYNN"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-288d74b3a91so632980fac.0
        for <iwd@lists.linux.dev>; Thu, 07 Nov 2024 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985978; x=1731590778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OIOiNwawrZtth2J1mIY/ABHvGV7S2JYWiwjVvxfwzM=;
        b=DhVUlYNNTSSrdOAevSw8/FsZ+i7IyIfLxm/b45H7meD3S6Eqcqz7Ao+cCOM+JE46JD
         EFpIFW1H9MXs599d4mqi9UWT6fceZ8DU+rWVDLc7kgoQTcaCvJLimkkTesoSavqCvaBt
         qW9Xzig/MkN0Jnl++k82JR39fu/yWfGnOhNMsCYFLeNLVePR8xuFHqFg+fd9ts+/uSb5
         kSsKRhAAy96xeZgyaD25exJXBgZJvhPgR9hzVJvGRGk7sBZb2EogwZDJa3OTcWhVdlzd
         VfJ1vTO5zKKfowUPQ3L30VlRZAWVAXtKgs4QEZLrYdokT4Ayl+J74s1NQmrRTXwYBSzF
         FcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985978; x=1731590778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OIOiNwawrZtth2J1mIY/ABHvGV7S2JYWiwjVvxfwzM=;
        b=R/R3mHdEg4k/+q10vKtLPxWlLrJsWsaaSoS9Uoz+vIBxE6iBZ93jgTwtu9AVZcRO7c
         SMQeEv6fEyf5ncUO8OmiF/8CJDSIajwc6GclMB1TuNy5gJuYbShijgoOOJrC/huxbfjt
         JIt+mHc4bWCmyqzX5/kjIIuiDCICUTajevTSkiICJ7NHajPURpuLaUsJjHM0YEusLEyk
         evycSfCM+88RXMxdTb9733SUi7pFzMYvEmG+6eW7qb8tSvS3z1cSaCLTfN9IG1glo3hY
         +JyctyfhcaHRNCmQ2T4gI42DfblW838+LOr2sH2j/hZEzRavckXvVUrbEsZ/aki2WsEA
         Eatg==
X-Gm-Message-State: AOJu0Yxz1kAU75LoTlkbxR9GKG2tKyR6r92E9wsxOySq2x8L0TZFXNJE
	c4HqyhDDtTEMyfGKTab/XaPvslyKXPtOgyZGaZLX4XQida5w+Oc0y1P/AA==
X-Google-Smtp-Source: AGHT+IE1FsGDq94F1fjZbygBf2yPJlXKAjFqDNX27mpSL7YII6e/kLL3ELpGthsdL0On5UHfPNTpzQ==
X-Received: by 2002:a05:6870:1d1:b0:289:2126:6826 with SMTP id 586e51a60fabf-29051dba441mr40426003fac.30.1730985977042;
        Thu, 07 Nov 2024 05:26:17 -0800 (PST)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644036sm1344385a12.66.2024.11.07.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:26:16 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] treewide: fix spelling mistakes
Date: Thu,  7 Nov 2024 05:26:12 -0800
Message-Id: <20241107132613.1463237-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 TODO                                                 |  4 ++--
 .../testConnectAutoconnect/8021x_network_test.py     |  2 +-
 .../testConnectAutoconnect/open_network_test.py      |  2 +-
 autotests/testConnectAutoconnect/wpa_network_test.py |  2 +-
 autotests/testEncryptedProfiles/connection_test.py   |  2 +-
 autotests/testHiddenNetworks/exceptions_test.py      |  2 +-
 autotests/testHiddenNetworks/open_network_test.py    |  2 +-
 autotests/testHiddenNetworks/wpa_network_test.py     |  2 +-
 autotests/testMFP-Options/connection_test.py         |  2 +-
 autotests/testNetconfig/connection_test.py           |  2 +-
 autotests/testRoamRetry/fast_retry_test.py           |  2 +-
 autotests/testRoamRetry/stop_retry_test.py           |  2 +-
 autotests/util/iwd.py                                |  6 +++---
 autotests/util/wpas.py                               |  2 +-
 client/diagnostic.c                                  |  2 +-
 client/network.c                                     |  2 +-
 doc/coding-style.txt                                 |  4 ++--
 doc/device-provisioning-api.txt                      |  4 ++--
 doc/hotspot.txt                                      |  2 +-
 doc/p2p-api.txt                                      |  2 +-
 doc/station-api.txt                                  |  2 +-
 doc/test-runner.txt                                  |  2 +-
 monitor/main.c                                       |  2 +-
 monitor/nlmon.c                                      |  2 +-
 src/anqp.c                                           |  2 +-
 src/ap.h                                             |  2 +-
 src/dpp.c                                            |  8 ++++----
 src/eap-tls-common.c                                 |  2 +-
 src/iwd.network.rst                                  |  2 +-
 src/mschaputil.c                                     |  2 +-
 src/netconfig.c                                      |  2 +-
 src/netdev.c                                         |  6 +++---
 src/offchannel.c                                     |  2 +-
 src/p2p.c                                            |  6 +++---
 src/sae.c                                            |  2 +-
 src/station.c                                        |  6 +++---
 src/storage.c                                        |  2 +-
 src/util.c                                           |  2 +-
 src/wiphy.c                                          |  2 +-
 tools/iwd-decrypt-profile.c                          |  2 +-
 tools/run-tests                                      | 12 ++++++------
 tools/utils.py                                       |  2 +-
 unit/test-cmac-aes.c                                 |  2 +-
 unit/test-hmac-md5.c                                 |  2 +-
 unit/test-hmac-sha1.c                                |  2 +-
 unit/test-hmac-sha256.c                              |  2 +-
 unit/test-kdf-sha256.c                               |  2 +-
 unit/test-prf-sha1.c                                 |  2 +-
 48 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/TODO b/TODO
index b3a03bd6..d57ccf78 100644
--- a/TODO
+++ b/TODO
@@ -110,7 +110,7 @@ Wireless monitor
 
 - Subscribe to all nl80211 multicast groups at startup
 
-  It seems the nlmon packets are limited to actual subscribed mutlicast
+  It seems the nlmon packets are limited to actual subscribed multicast
   groups.  To get a complete picture of all the nl80211 commands and
   events, it is required that iwmon adds membership to all multicast
   groups that the nl80211 lists.
@@ -234,7 +234,7 @@ Wireless daemon
 
 - Implement Enrollee Session Overlap Detection after WSC Protocol Run
 
-  WSC Best Practices v2.0.1, Section 3.15 describes an enhacement to detect
+  WSC Best Practices v2.0.1, Section 3.15 describes an enhancement to detect
   PBC session overlaps.  The Enrollee is asked to perform an extra scan without
   the PBC request in the ProbeRequest frames after EAP-WSC completes
   successfully.  If another AP in PBC mode is found, then a SessionOverlap
diff --git a/autotests/testConnectAutoconnect/8021x_network_test.py b/autotests/testConnectAutoconnect/8021x_network_test.py
index 199ec90b..45d98244 100644
--- a/autotests/testConnectAutoconnect/8021x_network_test.py
+++ b/autotests/testConnectAutoconnect/8021x_network_test.py
@@ -11,7 +11,7 @@ from iwd import IWD
 
 class Test8021xNetwork(unittest.TestCase):
     '''
-    The bellow test cases excesise the following connection scenarios:
+    The below test cases excesise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testConnectAutoconnect/open_network_test.py b/autotests/testConnectAutoconnect/open_network_test.py
index 0af66923..2ff1c106 100644
--- a/autotests/testConnectAutoconnect/open_network_test.py
+++ b/autotests/testConnectAutoconnect/open_network_test.py
@@ -11,7 +11,7 @@ from iwd import IWD
 
 class TestOpenNetwork(unittest.TestCase):
     '''
-    The bellow test cases excesise the following connection scenarios:
+    The below test cases excesise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testConnectAutoconnect/wpa_network_test.py b/autotests/testConnectAutoconnect/wpa_network_test.py
index 0c8512f4..34ca555e 100644
--- a/autotests/testConnectAutoconnect/wpa_network_test.py
+++ b/autotests/testConnectAutoconnect/wpa_network_test.py
@@ -11,7 +11,7 @@ from iwd import IWD
 
 class TestWpaNetwork(unittest.TestCase):
     '''
-    The bellow test cases exercise the following connection scenarios:
+    The below test cases exercise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testEncryptedProfiles/connection_test.py b/autotests/testEncryptedProfiles/connection_test.py
index ab5a0ae7..eb7fd7c5 100644
--- a/autotests/testEncryptedProfiles/connection_test.py
+++ b/autotests/testEncryptedProfiles/connection_test.py
@@ -104,7 +104,7 @@ class Test(unittest.TestCase):
 
         self.assertTrue(self.profile_is_encrypted('ssidCCMP.psk'))
 
-    # Tests that a profile that doesn't decrypt wont become a known network
+    # Tests that a profile that doesn't decrypt won't become a known network
     def test_decryption_failure(self):
         bad_config = \
 '''
diff --git a/autotests/testHiddenNetworks/exceptions_test.py b/autotests/testHiddenNetworks/exceptions_test.py
index 55e3c603..762cfc94 100644
--- a/autotests/testHiddenNetworks/exceptions_test.py
+++ b/autotests/testHiddenNetworks/exceptions_test.py
@@ -12,7 +12,7 @@ from hostapd import HostapdCLI
 
 class TestWpaNetwork(unittest.TestCase):
     '''
-    The bellow test cases excesise the following connection scenarios:
+    The below test cases excesise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testHiddenNetworks/open_network_test.py b/autotests/testHiddenNetworks/open_network_test.py
index e306e8a4..92038e05 100644
--- a/autotests/testHiddenNetworks/open_network_test.py
+++ b/autotests/testHiddenNetworks/open_network_test.py
@@ -12,7 +12,7 @@ from hostapd import HostapdCLI
 
 class TestOpenNetwork(unittest.TestCase):
     '''
-    The bellow test cases excesise the following connection scenarios:
+    The below test cases excesise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testHiddenNetworks/wpa_network_test.py b/autotests/testHiddenNetworks/wpa_network_test.py
index 21045539..49c54ad2 100644
--- a/autotests/testHiddenNetworks/wpa_network_test.py
+++ b/autotests/testHiddenNetworks/wpa_network_test.py
@@ -12,7 +12,7 @@ from hostapd import HostapdCLI
 
 class TestWpaNetwork(unittest.TestCase):
     '''
-    The bellow test cases excesise the following connection scenarios:
+    The below test cases excesise the following connection scenarios:
 
     Network config is
     present at start time:  Connect:  AutoConnect:  Result:
diff --git a/autotests/testMFP-Options/connection_test.py b/autotests/testMFP-Options/connection_test.py
index 21cd8058..2e0f9a3c 100644
--- a/autotests/testMFP-Options/connection_test.py
+++ b/autotests/testMFP-Options/connection_test.py
@@ -11,7 +11,7 @@ from iwd import NetworkType
 
 class TestMFP(unittest.TestCase):
     '''
-    The bellow test cases excesise the following MFP option setting scenarios:
+    The below test cases excesise the following MFP option setting scenarios:
 
     IWD_MFP: AP_MFP:  Result:
     0        0        No MFP, connection succeeds
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index aed35bee..86168787 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -137,7 +137,7 @@ class Test(unittest.TestCase):
         # since (T2 - T1) / 2 is shorter than 60s.  It is now about 10s since the last
         # renewal or 5s before the next DHCPREQUEST frame that is going to be lost.  We'll
         # wait T1 seconds, so until about 10s after the failed attempt, we'll check that
-        # there was no renewal by that time, just in case, and we'll reenable frame delivery.
+        # there was no renewal by that time, just in case, and we'll re-enable frame delivery.
         # We'll then wait another 60s and we should see the lease has been successfully
         # renewed some 10 seconds earlier on the 1st DHCPREQUEST retransmission.
         #
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoamRetry/fast_retry_test.py
index d380b2e3..9bb36622 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -17,7 +17,7 @@ from hwsim import Hwsim
 class Test(unittest.TestCase):
     # Normally the time between a failed roam attempt and the next roam attempt
     # is 60 seconds (default RoamRetryInterval). Test that we retry roaming
-    # faster if the transision looks like this: LOW [roam] [same bss] HIGH LOW.
+    # faster if the transition looks like this: LOW [roam] [same bss] HIGH LOW.
     def test_fast_retry(self):
         hwsim = Hwsim()
 
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoamRetry/stop_retry_test.py
index e46b79d7..4b0dec4b 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -15,7 +15,7 @@ from hostapd import HostapdCLI
 from hwsim import Hwsim
 
 class Test(unittest.TestCase):
-    # Test that we do not periodically retry roaming if the transision looks
+    # Test that we do not periodically retry roaming if the transition looks
     # like this: LOW [roam] [new bss] HIGH.
     def test_stop_retry(self):
         hwsim = Hwsim()
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 83f2d9ef..e9101d75 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1481,10 +1481,10 @@ class IWD(AsyncOpAbstract):
 
     @staticmethod
     def create_in_storage(file_name, file_content, storage_dir=IWD_STORAGE_DIR):
-        fo = open(storage_dir + '/' + file_name, 'w')
+        f = open(storage_dir + '/' + file_name, 'w')
 
-        fo.write(file_content)
-        fo.close()
+        f.write(file_content)
+        f.close()
 
     @staticmethod
     def _ensure_storage_dir_exists(storage_dir):
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 0b127672..f7ecc979 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -237,7 +237,7 @@ class Wpas:
                         ('' if go_intent is None else ' go_intent=' + str(go_intent)))
         self.wait_for_event('OK')
 
-    # Pre-accept the next GO Negotiation Request from this peer to avoid the extra Respone + Request frames
+    # Pre-accept the next GO Negotiation Request from this peer to avoid the extra Response + Request frames
     def p2p_authorize(self, peer, pin=None, go_intent=None):
         self._rx_data = []
         self._ctrl_request('P2P_CONNECT ' + peer['p2p_dev_addr'] + ' ' + ('pbc' if pin is None else pin) +
diff --git a/client/diagnostic.c b/client/diagnostic.c
index e1bd9784..92a6126a 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -186,5 +186,5 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 	return;
 
 parse_error:
-	display_error("Error parsing dignostics");
+	display_error("Error parsing diagnostics");
 }
diff --git a/client/network.c b/client/network.c
index 7431183b..2883e8ed 100644
--- a/client/network.c
+++ b/client/network.c
@@ -219,7 +219,7 @@ static void network_display_inline(const char *margin, const void *data)
 
 	display("%s%s %s %s\n", margin, network->name ? network->name : "",
 			network->type ? network->type : "",
-			network->connected ? "connected" : "diconnected");
+			network->connected ? "connected" : "disconnected");
 }
 
 static void *network_create(void)
diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 882de026..8ea6f0de 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -322,10 +322,10 @@ M18: Use appropriate logging levels
 An appropriate log level should be used depending on the type of message
 being logged. Logging is done using the l_log APIs in ELL:
 
-l_error   An unexpected condition ocurred. These are generally fatal to the
+l_error   An unexpected condition occurred. These are generally fatal to the
           current connection/protocol that is running but not generally to IWD's
           overall operation.
-l_warn    An unexpected, but non-fatal condition ocurred
+l_warn    An unexpected, but non-fatal condition occurred
 l_notice  Should not be used directly. This log level is reserved for special
           event type notifications which is handled by iwd_notice().
 l_info    Information that is expected during normal operation. l_info's use
diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 6cf16fb8..41decd6b 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -135,7 +135,7 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 		void StartConfigurator(object agent_path)
 
 			Start a shared code configurator using an agent
-			(distingushed by 'agent_path') to obtain the shared
+			(distinguished by 'agent_path') to obtain the shared
 			code. This method is meant for an automated use case
 			where a configurator is capable of configuring multiple
 			enrollees, and distinguishing between them by their
@@ -196,7 +196,7 @@ Methods		void Release() [noreply]
 		string RequestSharedCode(string identifier)
 
 			This method gets called when a shared code is requested
-			for a particular enrollee, distingushed by the
+			for a particular enrollee, distinguished by the
 			identifier. The shared code agent should lookup the
 			identifier and return the shared code, or return an
 			error if not found.
diff --git a/doc/hotspot.txt b/doc/hotspot.txt
index b43b0dc6..e333d355 100644
--- a/doc/hotspot.txt
+++ b/doc/hotspot.txt
@@ -5,7 +5,7 @@ credentials for your e.g. cable/cellular provider, or via a dedicated account
 like Boingo. Lots of these services also allow you to roam between networks.
 
 The underlying authentication is standard WPA2-Enterprise but Hotspot 2.0 adds a
-'discovery' stage to identifiying networks. This discovery is done using ANQP,
+'discovery' stage to identifying networks. This discovery is done using ANQP,
 which queries the network for additional information to determine if the client
 has the credentials to connect.
 
diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
index b10c51ed..94d6b270 100644
--- a/doc/p2p-api.txt
+++ b/doc/p2p-api.txt
@@ -56,7 +56,7 @@ Methods		array(on) GetPeers()
 			between requested threshold values is a compromise
 			between resolution and the frequency of system
 			wakeups and context-switches that are going to be
-			occuring to update the client's signal meter.  Only
+			occurring to update the client's signal meter.  Only
 			one agent can be registered at any time.
 
 			Possible errors: [service].Error.InvalidArguments
diff --git a/doc/station-api.txt b/doc/station-api.txt
index 707c6834..f56ea03c 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -166,7 +166,7 @@ Properties	string State [readonly]
 
 		object ConnectedAccessPoint [readonly, optional]
 
-			net.connman.iwd.BasicServiceSet object represeting the
+			net.connman.iwd.BasicServiceSet object representing the
 			BSS the device is currently connected to or to which
 			a connection is in progress.
 
diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 70eaa539..19caac5d 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -218,7 +218,7 @@ supplicant running IWD:
 #~~~~~~~~~~~~~~~~~~~~~~~~~ hw.conf ~~~~~~~~~~~~~~~~~~~~~~~~~
 # Lines starting with # are ignored
 
-# 'SETUP' is a manditory configuration group.
+# 'SETUP' is a mandatory configuration group.
 [SETUP]
 #
 # Total number of radios requested per network setup. This includes
diff --git a/monitor/main.c b/monitor/main.c
index c560db77..fc22c777 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -578,7 +578,7 @@ static int analyze_pcap(const char *pathname)
 	printf("\n");
 	printf(" Number of packets: %lu\n", pkt_count);
 	printf("     Short packets: %lu\n", pkt_short);
-	printf("  Tuncated packets: %lu\n", pkt_trunc);
+	printf("  Truncated packets: %lu\n", pkt_trunc);
 	printf("\n");
 	printf("  Ethernet packets: %lu\n", pkt_ether);
 	printf("       PAE packets: %lu\n", pkt_pae);
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 66df08a4..ac594c3c 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1658,7 +1658,7 @@ static void print_ie_vht_capabilities(unsigned int level,
 		[21] = "TXOP PS",
 		[22] = "+HTC-VHT Capable",
 		[23 ... 25] = "Maximum A-MPDU Length Exponent",
-		[26 ... 27] = "VHT Link Adapation Capable",
+		[26 ... 27] = "VHT Link Adaptation Capable",
 		[28] = "RX Antenna Pattern Consistency",
 		[29] = "TX Antenna Pattern Consistency",
 		[30 ... 31] = "Extended NSS BW Support",
diff --git a/src/anqp.c b/src/anqp.c
index a3c3d7ed..09b999ea 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -234,7 +234,7 @@ uint32_t anqp_request(uint64_t wdev_id, const uint8_t *addr,
 	request->anqp_cb = cb;
 	request->anqp_destroy = destroy;
 	/*
-	 * WPA3 Specificiation version 3, Section 9.4:
+	 * WPA3 Specification version 3, Section 9.4:
 	 * "A STA shall use a randomized dialog token for every new GAS
 	 * exchange."
 	 */
diff --git a/src/ap.h b/src/ap.h
index 94d6c04d..2e0bca76 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -79,7 +79,7 @@ struct ap_ops {
 					void *user_data);
 	/*
 	 * If not null, writes extra IEs to be added to the outgoing frame of
-	 * given type and, if it's not a beacon frame, in reponse to a given
+	 * given type and, if it's not a beacon frame, in response to a given
 	 * client frame.  May also react to the extra IEs in that frame.
 	 * Returns the number of bytes written which must be less than or
 	 * equal to the number returned by .get_extra_ies_len when called
diff --git a/src/dpp.c b/src/dpp.c
index f7989d2b..95c11f00 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2001,7 +2001,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 
 		/*
 		 * We have a pending agent request but it did not arrive in
-		 * time, we cant assume the enrollee will be waiting around
+		 * time, we can't assume the enrollee will be waiting around
 		 * for our response so cancel the request and continue waiting
 		 * for another request
 		 */
@@ -2722,7 +2722,7 @@ static void dpp_handle_pkex_exchange_response(struct dpp_sm *dpp,
 	}
 
 	if (version && version != dpp->pkex_version) {
-		l_debug("PKEX version does not match, igoring");
+		l_debug("PKEX version does not match, ignoring");
 		return;
 	}
 
@@ -3438,7 +3438,7 @@ static void dpp_handle_pkex_commit_reveal_request(struct dpp_sm *dpp,
 	dpp->peer_boot_public = l_ecc_point_from_data(dpp->curve,
 					L_ECC_POINT_TYPE_FULL, key, key_len);
 	if (!dpp->peer_boot_public) {
-		l_debug("peers boostrapping key did not validate");
+		l_debug("peers bootstrapping key did not validate");
 		goto failed;
 	}
 
@@ -3598,7 +3598,7 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 
 	/*
 	 * Only want to handle the no-ACK case. Re-transmitting an ACKed
-	 * frame likely wont do any good, at least in the case of DPP.
+	 * frame likely won't do any good, at least in the case of DPP.
 	 */
 	if (!ack)
 		goto retransmit;
diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 0374845e..10358700 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -165,7 +165,7 @@ static void __eap_tls_common_state_reset(struct eap_state *eap)
 	 *
 	 * Drop the cache even if we have no indication that the
 	 * method failed but it just didn't succeed, to handle cases like
-	 * the server getting stuck and a timout occuring at a higher
+	 * the server getting stuck and a timeout occurring at a higher
 	 * layer.  The risk is that we may occasionally flush the session
 	 * data when there was only a momentary radio issue, invalid
 	 * phase2 credentials or decision to abort.  Those are not hot
diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index b178c20c..892c6eb8 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -209,7 +209,7 @@ connect to that network.
    * - PasswordIdentifier
      - string
 
-       An identifer string to be used with the passphrase. This is used for
+       An identifier string to be used with the passphrase. This is used for
        WPA3-Personal (SAE) networks if the security has enabled password
        identifiers for clients.
    * - PreSharedKey
diff --git a/src/mschaputil.c b/src/mschaputil.c
index 3470004f..7a4927ba 100644
--- a/src/mschaputil.c
+++ b/src/mschaputil.c
@@ -82,7 +82,7 @@ bool mschap_challenge_response(const uint8_t *challenge,
 
 /**
  * Hash the utf8 encoded nt password.
- * It is asumed, that the password is valid utf8!
+ * It is assumed, that the password is valid utf8!
  * The rfc says "unicode-char", but never specifies which encoding.
  * This function converts the password to ucs-2.
  * The example in the code uses LE for the unicode chars, so it is forced here.
diff --git a/src/netconfig.c b/src/netconfig.c
index 4e8fa0d8..cd19217c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -622,7 +622,7 @@ bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
 				struct ie_fils_ip_addr_request_info *info)
 {
 	/*
-	 * Fill in the fields used for building the FILS IP Address Assigment
+	 * Fill in the fields used for building the FILS IP Address Assignment
 	 * IE during connection if we're configured to do automatic network
 	 * configuration (usually DHCP).  If we're configured with static
 	 * values return false to mean the IE should not be sent.
diff --git a/src/netdev.c b/src/netdev.c
index 2eebf457..e86ef1bd 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2169,7 +2169,7 @@ static void netdev_set_pmk(struct handshake_state *hs, const uint8_t *pmk,
 				struct netdev_handshake_state, super);
 	struct netdev *netdev = nhs->netdev;
 
-	/* Only relevent for 8021x offload */
+	/* Only relevant for 8021x offload */
 	if (nhs->type != CONNECTION_TYPE_8021X_OFFLOAD)
 		return;
 
@@ -2281,7 +2281,7 @@ static void netdev_qos_map_cb(struct l_genl_msg *msg, void *user_data)
 		return;
 
 	ext_error = l_genl_msg_get_extended_error(msg);
-	l_error("Couuld not set QoS Map in kernel: %s",
+	l_error("Could not set QoS Map in kernel: %s",
 			ext_error ? ext_error : strerror(-err));
 }
 
@@ -2354,7 +2354,7 @@ static void netdev_get_oci_cb(struct l_genl_msg *msg, void *user_data)
 done:
 	if (netdev->ap) {
 		/*
-		 * Cant do much here. IWD assumes every kernel/driver supports
+		 * Can't do much here. IWD assumes every kernel/driver supports
 		 * this. There is no way of detecting support either.
 		 */
 		if (L_WARN_ON(err < 0))
diff --git a/src/offchannel.c b/src/offchannel.c
index 77a0625f..0c7ddf63 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -293,7 +293,7 @@ static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 		 *  - an event coming from an external ROC request (we just
 		 *    happened to have also sent an ROC request).
 		 *
-		 * We can't tell where the event originated until we recieve our
+		 * We can't tell where the event originated until we receive our
 		 * ACK so set early_cookie to track it.
 		 */
 		if (i->roc_cmd_id != 0 && l_genl_family_request_sent(nl80211,
diff --git a/src/p2p.c b/src/p2p.c
index e55cb76a..676ef146 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -2217,7 +2217,7 @@ static bool p2p_go_negotiation_confirm_cb(const struct mmpdu_header *mpdu,
 
 		/*
 		 * Start setting the group up right away and we'll add the
-		 * client's Configuation Timeout to the WSC start timeout's
+		 * client's Configuration Timeout to the WSC start timeout's
 		 * value.
 		 */
 		p2p_device_interface_create(dev);
@@ -2549,7 +2549,7 @@ static void p2p_go_negotiation_confirm_done(int error, void *user_data)
 
 	/*
 	 * Frame was ACKed.  On the GO start setting the group up right
-	 * away and we'll add the client's Configuation Timeout to the
+	 * away and we'll add the client's Configuration Timeout to the
 	 * WSC start timeout's value.  On the client wait idly the
 	 * maximum amount of time indicated by the peer in the GO
 	 * Negotiation Response's Configuration Timeout attribute and
@@ -2951,7 +2951,7 @@ static bool p2p_provision_disc_resp_cb(const struct mmpdu_header *mpdu,
 	}
 
 	/*
-	 * Indended P2P Interface address is optional, we don't have the
+	 * Intended P2P Interface address is optional, we don't have the
 	 * BSSID of the group here.
 	 *
 	 * We might want to make sure that Group Formation is false but the
diff --git a/src/sae.c b/src/sae.c
index eb463484..3305dfdc 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -258,7 +258,7 @@ static struct l_ecc_scalar *sae_pwd_value(const struct l_ecc_curve *curve,
 	is_in_range = util_secure_fill_with_msb(is_in_range);
 
 	/*
-	 * libell has public Legendre symbol only for l_ecc_scalar, but they
+	 * ELL has public Legendre symbol only for l_ecc_scalar, but they
 	 * cannot be created if the coordinate is greater than the p. Hence,
 	 * to avoid control flow dependencies, we replace pwd_value by a dummy
 	 * quadratic non residue if we generate a value >= prime.
diff --git a/src/station.c b/src/station.c
index 4b7aace5..71dc4c21 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1381,7 +1381,7 @@ static struct handshake_state *station_handshake_setup(struct station *station,
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
 	/*
-	 * It can't hurt to try the FILS IP Address Assigment independent of
+	 * It can't hurt to try the FILS IP Address Assignment independent of
 	 * which auth-proto is actually used.
 	 */
 	if (station->netconfig && netconfig_get_fils_ip_req(station->netconfig,
@@ -1915,7 +1915,7 @@ static void station_reset_connection_state(struct station *station)
 	/*
 	 * Perform this step last since calling network_disconnected() might
 	 * result in the removal of the network (for example if provisioning
-	 * a new hidden network fails with an incorrect pasword).
+	 * a new hidden network fails with an incorrect password).
 	 */
 	if (station->state == STATION_STATE_CONNECTED ||
 			station->state == STATION_STATE_CONNECTING ||
@@ -3095,7 +3095,7 @@ static void station_roam_timeout_rearm(struct station *station, int seconds)
 	if (!station->roam_trigger_timeout)
 		goto new_timeout;
 
-	/* If we cant get the remaining time just create a new timer */
+	/* If we can't get the remaining time just create a new timer */
 	if (L_WARN_ON(!l_timeout_remaining(station->roam_trigger_timeout,
 						&remaining))) {
 		l_timeout_remove(station->roam_trigger_timeout);
diff --git a/src/storage.c b/src/storage.c
index c70554df..843581fd 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -535,7 +535,7 @@ int __storage_decrypt(struct l_settings *settings, const char *ssid,
 
 	/*
 	 * Load decrypted data into existing settings. This is not how the API
-	 * is indended to be used (since this could result in duplicate groups)
+	 * is intended to be used (since this could result in duplicate groups)
 	 * but since the Security group was just removed and EncryptedSecurity
 	 * should only contain a Security group its safe to use it this way.
 	 */
diff --git a/src/util.c b/src/util.c
index 8c690fc0..a4a78fb6 100644
--- a/src/util.c
+++ b/src/util.c
@@ -276,7 +276,7 @@ bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix_out,
 	/* 'i' will be at most INET_ADDRSTRLEN - 1 */
 	l_strlcpy(no_prefix, ip, i + 1);
 
-	/* Check if IP preceeding prefix is valid */
+	/* Check if IP preceding prefix is valid */
 	if (inet_pton(AF_INET, no_prefix, &ia) != 1 || ia.s_addr == 0)
 		return false;
 
diff --git a/src/wiphy.c b/src/wiphy.c
index 7512c84f..c286bb48 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2286,7 +2286,7 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	}
 
 	/*
-	 * Another update while dumping wiphy. This next dump should supercede
+	 * Another update while dumping wiphy. This next dump should supersede
 	 * the first and not result in a DONE event until this new dump is
 	 * finished. This is because the disabled frequencies are in an unknown
 	 * state and could cause incorrect behavior by any watchers.
diff --git a/tools/iwd-decrypt-profile.c b/tools/iwd-decrypt-profile.c
index e71b56b4..87d5d1cc 100644
--- a/tools/iwd-decrypt-profile.c
+++ b/tools/iwd-decrypt-profile.c
@@ -75,7 +75,7 @@ static bool secret_from_file(const char *file)
 
 	fd = open(file, O_RDONLY, 0);
 	if (fd < 0) {
-		printf("Cant open %s (%d)\n", file, fd);
+		printf("Can't open %s (%d)\n", file, fd);
 		return false;
 	}
 
diff --git a/tools/run-tests b/tools/run-tests
index e043965b..44209eeb 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -119,7 +119,7 @@ class VirtualRadio(Radio):
 	'''
 		A subclass of 'Radio' specific to mac80211_hwsim radios.
 
-		TODO: Using D-Bus to create and destroy radios is more desireable
+		TODO: Using D-Bus to create and destroy radios is more desirable
 		than the command line.
 	'''
 
@@ -400,7 +400,7 @@ class TestContext(Namespace):
 			# just given to hostapd/IWD as they appear during
 			# discovery.
 			#
-			# TODO: It may be desireable to map PCI/USB adapters to
+			# TODO: It may be desirable to map PCI/USB adapters to
 			#       specific radX radios specified in the config but
 			#       there are really 2 separate use cases here.
 			#       1. You want to test a *specific* radio with IWD
@@ -482,7 +482,7 @@ class TestContext(Namespace):
 	def start_ofono(self):
 		sim_keys = self.hw_config['SETUP'].get('sim_keys', None)
 		if not sim_keys:
-			print("Ofono not requred")
+			print("Ofono not required")
 			return
 		elif sim_keys != 'ofono':
 			os.environ['IWD_SIM_KEYS'] = sim_keys
@@ -701,7 +701,7 @@ def start_test(ctx, subtests, rqueue):
 		# test results are queued and printed at the very end so its
 		# difficult to know *where* a test failed (python gives a stack
 		# trace but printing the exception/failure immediately shows
-		# where in the debug logs something failed). Moreso if there are
+		# where in the debug logs something failed). More so if there are
 		# several test functions inside a single python file they run
 		# as a single test and it is difficult (again) to know where
 		# something failed.
@@ -731,7 +731,7 @@ def start_test(ctx, subtests, rqueue):
 				func, file = str(t).split(' ')
 				#
 				# TODO: There may be a better way of doing this
-				# but strigifying the test class gives us a string:
+				# but stringifying the test class gives us a string:
 				# <function> (<file>.<class>)
 				#
 				file = file.strip('()').split('.')[0] + '.py'
@@ -981,7 +981,7 @@ def run_auto_tests(ctx, args):
 			p = multiprocessing.Process(target=start_test, args=(ctx, subtests, rqueue))
 			p.start()
 			# Rather than time each subtest we just time the total but
-			# mutiply the default time by the number of tests being run.
+			# multiply the default time by the number of tests being run.
 			p.join(int(args.timeout) * len(subtests))
 
 			if p.is_alive():
diff --git a/tools/utils.py b/tools/utils.py
index d5445ea7..3a88e119 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -133,7 +133,7 @@ class Process(subprocess.Popen):
 					f.write(stamp + ': ')
 
 			# Write out a separator so multiple process calls per
-			# test are easer to read.
+			# test are easier to read.
 			if instance.hup:
 				f.write("Terminated: {}\n\n".format(instance.args))
 
diff --git a/unit/test-cmac-aes.c b/unit/test-cmac-aes.c
index 365265f6..8ac79900 100644
--- a/unit/test-cmac-aes.c
+++ b/unit/test-cmac-aes.c
@@ -51,7 +51,7 @@ static void cmac_test(const void *data)
 	for (i = 0; i < test->tag_len; i++)
 		sprintf(tag_str + (i * 2), "%02x", test->tag[i]);
 
-	printf("Tag    = %s (%zu octects)\n", tag_str, test->tag_len);
+	printf("Tag    = %s (%zu octets)\n", tag_str, test->tag_len);
 
 	result = cmac_aes(test->key, test->key_len,
 				test->msg, test->msg_len, tag, test->tag_len);
diff --git a/unit/test-hmac-md5.c b/unit/test-hmac-md5.c
index 3faff8c5..8058327d 100644
--- a/unit/test-hmac-md5.c
+++ b/unit/test-hmac-md5.c
@@ -50,7 +50,7 @@ static void hmac_test(const void *data)
 
 	hmac_len = strlen(test->hmac) / 2;
 
-	printf("HMAC   = %s (%d octects)\n", test->hmac, hmac_len);
+	printf("HMAC   = %s (%d octets)\n", test->hmac, hmac_len);
 
 	result = hmac_md5(test->key, test->key_len,
 				test->data, test->data_len, output, hmac_len);
diff --git a/unit/test-hmac-sha1.c b/unit/test-hmac-sha1.c
index 56f4fb4b..d71f50e9 100644
--- a/unit/test-hmac-sha1.c
+++ b/unit/test-hmac-sha1.c
@@ -50,7 +50,7 @@ static void hmac_test(const void *data)
 
 	hmac_len = strlen(test->hmac) / 2;
 
-	printf("HMAC   = %s (%d octects)\n", test->hmac, hmac_len);
+	printf("HMAC   = %s (%d octets)\n", test->hmac, hmac_len);
 
 	result = hmac_sha1(test->key, test->key_len,
 				test->data, test->data_len, output, hmac_len);
diff --git a/unit/test-hmac-sha256.c b/unit/test-hmac-sha256.c
index 2515394c..eb244996 100644
--- a/unit/test-hmac-sha256.c
+++ b/unit/test-hmac-sha256.c
@@ -50,7 +50,7 @@ static void hmac_test(const void *data)
 
 	hmac_len = strlen(test->hmac) / 2;
 
-	printf("HMAC   = %s (%d octects)\n", test->hmac, hmac_len);
+	printf("HMAC   = %s (%d octets)\n", test->hmac, hmac_len);
 
 	result = hmac_sha256(test->key, test->key_len,
 				test->data, test->data_len, output, hmac_len);
diff --git a/unit/test-kdf-sha256.c b/unit/test-kdf-sha256.c
index 56459eaa..6b3ef826 100644
--- a/unit/test-kdf-sha256.c
+++ b/unit/test-kdf-sha256.c
@@ -52,7 +52,7 @@ static void kdf_test(const void *data)
 
 	kdf_len = strlen(test->kdf) / 2;
 
-	printf("PRF    = %s (%d octects)\n", test->kdf, kdf_len);
+	printf("PRF    = %s (%d octets)\n", test->kdf, kdf_len);
 
 	result = kdf_sha256(test->key, test->key_len, test->prefix,
 				test->prefix_len, test->data, test->data_len,
diff --git a/unit/test-prf-sha1.c b/unit/test-prf-sha1.c
index a58d009d..2a35708f 100644
--- a/unit/test-prf-sha1.c
+++ b/unit/test-prf-sha1.c
@@ -52,7 +52,7 @@ static void prf_test(const void *data)
 
 	prf_len = strlen(test->prf) / 2;
 
-	printf("PRF    = %s (%d octects)\n", test->prf, prf_len);
+	printf("PRF    = %s (%d octets)\n", test->prf, prf_len);
 
 	result = prf_sha1(test->key, test->key_len, test->prefix,
 				test->prefix_len, test->data, test->data_len,
-- 
2.34.1

