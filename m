Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A546B7
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:58 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id h192so3703882pgc.4
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkoFoVF8waPjoXpAaLeb6i2HYuOWVxZiXzl1f1mb8mE=;
        b=ZBn1RW+IfkhFWzREuCDVZf5BfNlImuAyN094r0MAokpr36CVUgAZdGVpV1HcRFtdS+
         9JVNBVfLzGCpV9BnLazJbOlNcNIpubsrmU7B1mF8MLAskn2FXpHBIJH8wSgpKfNIL/F7
         KqAuviRh/yg3rhzBHBb/zImEdNK8wZGdMNPm8tgag4YxOt6iHKmnTbNecKdgI5Cv+hg7
         h5iJ17bzgRKgtr4V3p2nf0HkjwMaSDqC/0BA1vf4TtUKxHGVTmBjvV8bcgN3SH9D2csZ
         Fe+121QMB/QFjSiQ90J7LUK+/nugUzK+n7uSn0Rtry3ETobV+b+O4Pl6hSkVokwfj7h+
         h1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkoFoVF8waPjoXpAaLeb6i2HYuOWVxZiXzl1f1mb8mE=;
        b=nXAuknavx/DuOw7pFk5ftpbO+c9JWVXwKOWNaa/4PjHPMyGDLN84j150Ba1YO/krR7
         s4FYvjO9j7feAyQH59LtfVRWFyRU3s/M9wQZ/FOCSZ6oAAaA3DAeYRPNfZrdjCm0S2tD
         vvvZ614oPOCIeFJQydreL2ly7M4s0DUaqerGwqfEY05ycfhZdS32gImdU2H5SOkTcTIT
         Yszpt3UdxAkYuYcJdOwHJy9RpqcYtpF7JytnLwty/IxGz3Sg8hwM45B1QJEI4u50VGW4
         cZrjpjTS4hbSephr7j77fhAsuco8HKCBKTKr7f8JEEVg4QA7yW77IpcHqYU/aWbHmecC
         Tf4Q==
X-Gm-Message-State: AJIora/4kPwnzK8IjiiXODiZox/KV1uRmws1eOERxjTmj4T3wMySqPRj
	y5+6HsdnUjhOUxMdCWJhcSNVxgSyyew=
X-Google-Smtp-Source: AGRyM1s3IZKzBWyLRKpW73lqsbSS/xGcwsJug+BgBjyBRTWxCp45oVntqJdQZOehfI2sHPow63cQrA==
X-Received: by 2002:a63:2160:0:b0:3fc:b8ac:1976 with SMTP id s32-20020a632160000000b003fcb8ac1976mr1037669pgm.453.1656112197297;
        Fri, 24 Jun 2022 16:09:57 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] auto-t: fix rekey/reauth logic in a few ways
Date: Fri, 24 Jun 2022 16:07:38 -0700
Message-Id: <20220624230741.1957863-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rekey/reauth logic was broken in a few different ways.

For rekeys the event list was not being reset so any past 4-way
handshake would allow the call to pass. This actually removes
the need for the sleep in the extended key ID test because the
actual handshake event is waited for correctly.

For both rekeys and reauths, just waiting for the EAP/handshake
events was not enough. Without checking if the client got
disconnected we essentially allow a full disconnect and reconnect,
meaning the rekey/reauth failed.

Now a 'disallow' array can be passed to wait_for_event which will
throw an exception if any events in that array are encountered
while waiting for the target event.
---
 autotests/testWPA2-ext-key-id/connection_test.py |  2 --
 autotests/util/hostapd.py                        | 16 ++++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/autotests/testWPA2-ext-key-id/connection_test.py b/autotests/testWPA2-ext-key-id/connection_test.py
index d77a216b..afd48149 100644
--- a/autotests/testWPA2-ext-key-id/connection_test.py
+++ b/autotests/testWPA2-ext-key-id/connection_test.py
@@ -50,8 +50,6 @@ class Test(unittest.TestCase):
             testutil.test_iface_operstate()
             testutil.test_ifaces_connected()
 
-            wd.wait(0.5)
-
         device.disconnect()
 
         condition = 'not obj.connected'
diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index ff5a97c1..758427fe 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -102,23 +102,26 @@ class HostapdCLI(object):
 
         return True
 
-    def _poll_event(self, event):
+    def _poll_event(self, event, disallow):
         # Look through the list (most recent is first) until the even is found.
         # Once found consume this event and any older ones as to not
         # accidentally trigger a false positive later on.
         for idx, e in enumerate(self.events):
+            for d in disallow:
+                if d in e:
+                    raise Exception('Event %s found while waiting for %s' % (d, event))
             if event in e:
                 self.events = self.events[:idx]
                 return e
 
         return False
 
-    def wait_for_event(self, event, timeout=10):
+    def wait_for_event(self, event, timeout=10, disallow=[]):
         if event == 'AP-ENABLED':
             if self.enabled:
                 return 'AP-ENABLED'
 
-        return ctx.non_block_wait(self._poll_event, timeout, event,
+        return ctx.non_block_wait(self._poll_event, timeout, event, disallow,
                                     exception=TimeoutError("waiting for event"))
 
     def _data_available(self):
@@ -166,8 +169,8 @@ class HostapdCLI(object):
         self.events = []
         cmd = 'EAPOL_REAUTH ' + client_address
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
-        self.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        self.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
+        self.wait_for_event('CTRL-EVENT-EAP-STARTED', disallow=['AP-STA-DISCONNECTED'])
+        self.wait_for_event('CTRL-EVENT-EAP-SUCCESS', disallow=['AP-STA-DISCONNECTED'])
 
     def reload(self):
         # Seemingly all three commands needed for the instance to notice
@@ -234,7 +237,8 @@ class HostapdCLI(object):
         if address:
             cmd = 'REKEY_PTK %s' % address
             self.ctrl_sock.sendall(cmd.encode('utf-8'))
-            self.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+            self.events = []
+            self.wait_for_event('EAPOL-4WAY-HS-COMPLETED', disallow=['AP-STA-DISCONNECTED'])
             return
 
         cmd = 'REKEY_GTK'
-- 
2.34.1

