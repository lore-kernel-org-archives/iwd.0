Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26D28F2
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 20:03:42 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id d12so9628144lfq.12
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 13:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkRCqMqOAI4MxU+FKUC5JmYcC5eB+RU9kqBfTbQ6TIE=;
        b=gzfTBWruMX7IhaKx2ez/G29bH/WRn6UUCa2o2xpwLcznnal2j2y9zMWDolEWSz1hrC
         /zdn9Bn2JLNylK+cMkn1bhsU2Tcp9MRWOvOUfSDL9BA0qC01S/T0RmC7wWg5Wi71j4hF
         IB59JUqUt1YHrj517QrrQY22VtAizA2ZVf/wrrDth8lHZZ9TkbNA6MEM4Dm8PE9EN9bP
         97HidHEFh8vw9OcAoGKSbFirJ0iXOpTKXbD+W8Nb3h52wz9T821elFfdksWjARAVlN63
         l7gK9PACsh0Xs0WwLR+wZW0CQl/j3FuwiYyUQke6NTJqSJnILHLLyBzBJpmkOUJRFInc
         JXAw==
X-Gm-Message-State: AJIora/EXr164QET75gvTLYU6/DSOb0z16aQuUBgVI6WQ3GEcjw1ndtn
	mwrVX51jtpco7tjViTJP5UJVIVnt3MOcxser
X-Google-Smtp-Source: AGRyM1sfo+W/aILpidqIxLqvZ3UV/cMXQcISqtcDp6Sogi1YAxaDEtZwkhRFckjXU66UQcD98A9c2w==
X-Received: by 2002:a05:6512:1324:b0:47f:bda5:408 with SMTP id x36-20020a056512132400b0047fbda50408mr31243510lfu.649.1657224220171;
        Thu, 07 Jul 2022 13:03:40 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004791e47c5b8sm6525269lfq.175.2022.07.07.13.03.38
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:03:39 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v2 3/4] autotests: Also validate correct hostname sent over DHCPv4
Date: Thu,  7 Jul 2022 22:03:08 +0200
Message-Id: <20220707200309.3276163-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
References: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
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

