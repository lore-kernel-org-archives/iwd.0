Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2A7E9
	for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 16:36:39 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id n7so17676722wrv.4
        for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 09:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=QFPu+PJPzNyzfj0lQfHe/faTr5j/5QqoTMN0OsN0iCs=;
        b=2nJzeSbubQgCY3AfMOE/PG4gvi2Z2BPjR0x/hhU16keBo9R6e3WQY9qMQ4gWvMHEfb
         SshNM8or60YYLHtFf5qsPJg41weEsWLstP7Y6PTWz4sQOYrJui6SS6yPqmcO5kHdUckU
         PW4kbL3rBtsvLYAhGjHsAQRX76hGSGU+NtTfiNKbZTrDIp5hdlCs9NJnhAzGW+hrLljT
         nty9pKUfV0NoqC7PQx8IeAAFL6PJ1mHrTSc3a3KnHhd1QbgHe+q6OVhAsHwFre5+jdL0
         Va6FyGD/vkIPBfqbtjilwCWZe5NUd7qqu7GD0AlCkn9fuiiiHud7ICmJiCoWy70PSXZL
         kzLg==
X-Gm-Message-State: ACgBeo0dKnq24tKrdcryjJJOTyLmfU4MMv+w8aKBNeu0oB1hYYJMfpaN
	Q+EdYqUEODo4E8LumO96jsLL5OsF8T0=
X-Google-Smtp-Source: AA6agR6PmkNtLu6Y8MUd3gpEPnKL5gK8I8adsNJDLqveZ2zisVQicbfJYDxjDHGMRQFVLDma1uYHpQ==
X-Received: by 2002:a5d:634f:0:b0:225:2ab4:d539 with SMTP id b15-20020a5d634f000000b002252ab4d539mr13435338wrw.149.1661272597292;
        Tue, 23 Aug 2022 09:36:37 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id g1-20020adff3c1000000b0021e5f32ade7sm14716319wrp.68.2022.08.23.09.36.36
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:36:36 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] autotests: Fix testNetconfig ACD test
Date: Tue, 23 Aug 2022 18:36:14 +0200
Message-Id: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of static_test.py starts a second IWD instance and tries to make
it connect to the AP with the same IP address as the first IWD instance
which is already connected, to produce an IP conflict.  For this, the
second instance uses DHCP and the test expects the DHCP server to offer
the address 192.168.1.10 to it.  However in the current setup the DHCP
server manages to detect that 192.168.1.10 is in use and offers .11
instead.  Break the DHCP server's conflict detection by disabling ICMP
ping replies in order to fix the test.

Previously this has worked because the AP's and the DHCP server's
network interface is in the same network namespace as the first IWD
instance's network interface meaning that pings between the two
interfaces shouldn't work (a known Linux kernel routing quirk...).
I am not sure why those pings currently do work but take no chances and
disable ICMP pings.
---
 autotests/testNetconfig/static_test.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 01d694ca..4ce279f2 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -85,11 +85,16 @@ class Test(unittest.TestCase):
         condition = 'not obj.connected'
         wd_ns0.wait_for_object_condition(ordered_network.network_object, condition)
 
-        # Connect to the same network from a dynamically configured client.  The
-        # DHCP server doesn't know (even though dev1 announced itself) that
-        # 192.168.1.10 is already in use and if it assigns dev2 the lowest
-        # available address, that's going to be 192.168.1.10.  dev1's ACD
-        # implementation should then stop using this address.
+        # Connect to the same network from a dynamically configured client.  We
+        # block ICMP pings so that the DHCP server can't confirm that
+        # 192.168.1.10 is in use by dev1 and if it assigns dev2 the lowest
+        # available address, that's going to be 192.168.1.10.  We also keep the
+        # second client's netdev in a separate namespace so that the kernel
+        # lets us assign the same IP.  dev1's ACD implementation should then
+        # stop using this address.  Yes, a quite unrealistic scenario but this
+        # lets us test our reaction to a conflict appearing after successful
+        # initial setup.
+        os.system("echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all")
         ordered_network.network_object.connect()
 
         condition = 'obj.state == DeviceState.connected'
-- 
2.34.1

