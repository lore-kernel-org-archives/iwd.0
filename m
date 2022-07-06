Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9B5390
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 16:57:20 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id f2so17544848wrr.6
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 09:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkRCqMqOAI4MxU+FKUC5JmYcC5eB+RU9kqBfTbQ6TIE=;
        b=ah7aG1j/lfqhqVR7mid0EsKU6Ce65VhqDEY9RTXygQFDtbxRb3728aJdyz1kwOAEmx
         3tFeeWWPliJdNEGCyqHYQaI4q3X20yIq1o+3f5ChB4DgyDN3CEHnz1Qx7Q9Ah6P0KYHD
         ed66w67Llw4rXWdjdi68S76zk2zE4NW0W1m9cu8X0Da5/zSTAkHlW+BGdLdMezbcQ77/
         1KchT3XcDDvLBweJ9dMw8kgC+/S2r9y+eGGBUUxd7/tJ+7h/fZgE2H97qOABEASnNqs4
         mplmugm2gq2hTN8YyyMXx9KeegOI5KKrfkX/yuXOMcKKdT7r934fwvcPvmT+xhoFHcuv
         OJDg==
X-Gm-Message-State: AJIora+EKpQ8rnn9cj46GoNsvjtZ+8UnNMhHJNvsIEQM1hL7DrD/85xZ
	ffWOIcJ5x/Uz6jLqFbH4aPQnoqlzhxMyWrGu
X-Google-Smtp-Source: AGRyM1s+k7HHnJsx69syTrOjhE8kTKsPpUG6q0q0gacAJOVzLoEugfbHw6JSCittUx4rz2sm3MpFpQ==
X-Received: by 2002:a5d:6487:0:b0:21b:983c:5508 with SMTP id o7-20020a5d6487000000b0021b983c5508mr37869787wri.185.1657126638375;
        Wed, 06 Jul 2022 09:57:18 -0700 (PDT)
Received: from localhost.localdomain ([46.222.51.165])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm29147856wmq.20.2022.07.06.09.57.16
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:57:18 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/5] autotests: Also validate correct hostname sent over DHCPv4
Date: Wed,  6 Jul 2022 18:57:00 +0200
Message-Id: <20220706165702.3241756-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testNetconfig/auto.psk           | 5 +++++
 autotests/testNetconfig/connection_test.py | 5 +++++
 2 files changed, 10 insertions(+)
 create mode 100644 autotests/testNetconfig/auto.psk

diff --git a/autotests/testNetconfig/auto.psk b/autotests/testNetconfig/auto.psk
new file mode 100644
index 00000000..4077d65f
--- /dev/null
+++ b/autotests/testNetconfig/auto.psk
@@ -0,0 +1,5 @@
+[IPv4]
+SendHostname=true
+
+[Settings]
+AutoConnect=false
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index aebb0a2e..cf90993a 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -36,6 +36,8 @@ class Test(unittest.TestCase):
                     return socket.inet_pton(socket.AF_INET6, l.split(None, 1)[1].split('/', 1)[0])
             return None
 
+        os.system("hostname test-sta")
+        IWD.copy_to_storage('auto.psk', name='ap-ns1.psk')
         wd = IWD(True)
 
         psk_agent = PSKAgent("secret123")
@@ -109,6 +111,7 @@ class Test(unittest.TestCase):
         leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
         lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
         self.assertEqual(lease['state'], 'active')
+        self.assertEqual(lease['client-hostname'], 'test-sta')
         self.assertTrue(lease['starts'] < connect_time)
         self.assertTrue(lease['ends'] > connect_time)
         # The T1 is 15 seconds per dhcpd.conf.  This is the approximate interval between lease
@@ -123,6 +126,7 @@ class Test(unittest.TestCase):
         leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
         new_lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
         self.assertEqual(new_lease['state'], 'active')
+        self.assertEqual(new_lease['client-hostname'], 'test-sta')
         self.assertTrue(new_lease['starts'] > lease['starts'] + 10)
         self.assertTrue(new_lease['starts'] < lease['starts'] + 25)
         self.assertTrue(new_lease['ends'] > lease['ends'] + 10)
@@ -162,6 +166,7 @@ class Test(unittest.TestCase):
         leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
         new_lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
         self.assertEqual(new_lease['state'], 'active')
+        self.assertEqual(lease['client-hostname'], 'test-sta')
         self.assertTrue(new_lease['starts'] > lease['starts'] + 70)
         self.assertTrue(new_lease['starts'] < lease['starts'] + 85)
         self.assertTrue(new_lease['ends'] > lease['ends'] + 70)
-- 
2.34.1

