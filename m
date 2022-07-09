Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38477B
	for <iwd@lists.linux.dev>; Sat,  9 Jul 2022 00:23:50 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id a9so228837lfk.11
        for <iwd@lists.linux.dev>; Fri, 08 Jul 2022 17:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkRCqMqOAI4MxU+FKUC5JmYcC5eB+RU9kqBfTbQ6TIE=;
        b=uFfz+7aTa3uOZF3VUlqnM52EHLdpyl+jy0wEs73Q3jV0uVHxYvEEgE1ZKRl3whrh0t
         x6VKR3eGCW32lYeAG7Ug6ag8/sJsnQs6mcBe+zmlevkjkSGzFCtuLkYeO4ZeZX/HqoiP
         gRQjSD6Adjfr8hxyvwhU6LEJQFdpy8ndQKKpmJmCvPx6rgYFaiWGmORV9IbNlWjzYFtk
         e8OOYFjhWy1dJBDJr1JOt1+K44ENuqsVYamZGiPfWIGnKK1a0J1EKCqwIfHgyBok9X7M
         tGwLoosvXDBhhsAaFxuanR41LhtGVVIVE46SZT/14dbeia8gYmhu9zOeev5dgAAJTqqY
         yvIA==
X-Gm-Message-State: AJIora/rBW3LdNwk5Z2OKJFxOURRmw7s7ZDFPD7m6RPKz9oM9JCtiCms
	u2/y2tJyOOJ2MTxkN/rsw1qqPuovdV+JTU98
X-Google-Smtp-Source: AGRyM1u/Pk9p+E4lAEHKdjtGfJPkAW8syq62ViU+iaJFHsejzh44zTu7DKqKnEcCihzNFcflat4sNQ==
X-Received: by 2002:a05:6512:3d11:b0:47f:8fe3:8e98 with SMTP id d17-20020a0565123d1100b0047f8fe38e98mr3971709lfv.53.1657326228681;
        Fri, 08 Jul 2022 17:23:48 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm75603lfh.286.2022.07.08.17.23.47
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:23:47 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v3 3/4] autotests: Also validate correct hostname sent over DHCPv4
Date: Sat,  9 Jul 2022 02:23:33 +0200
Message-Id: <20220709002334.3329502-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
References: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
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

