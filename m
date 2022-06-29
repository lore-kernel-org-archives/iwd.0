Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFB3D98
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 17:33:26 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 68so15952680pgb.10
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y3wzxHVM00PeMDfep0ZRJsDuIkf4a5IKJMGHp2VAYo=;
        b=DquZ74TQxBr5O2i4J6HfsGfrD2T/ch8ph4iIMC5Knb4yGsUJ4UxSTtAgVcHNEwpxkE
         Q8kYmznMgJCwB52ocRz7liJZxRwJxrOzqcTxeAFqHhQvwHa3lxNpfKAkKCVVWkk9CRf/
         O+HYSS3I680RIcZD3AY0DEJSQqX4f5fdyNZEz/nlosWanSRamxNcM3TrcrLFivs0IJCH
         jlLTZUW0ajW+4kcBeHTD6vlwL6Nl13t/armQkp0B33KDxBcWneJD403Pa7vF1gTD6moA
         bPxbK+jOs1pTetdnRoANwMHclkqgDwwwJHRlsenSsPQWenrdmA274xxbh+tUVxPDd4hh
         Gj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y3wzxHVM00PeMDfep0ZRJsDuIkf4a5IKJMGHp2VAYo=;
        b=KGGV8AsOBvm0zNtXTLz7fkXZhm6uGPWlC7Mdjd0zqwVAJdTwKk2k81M0wWmEMysMMh
         2Vaz+kxuQajLYCLO4DhY5k3XRZuIoBK33kxmx9uGHKGEri3x7FxJ8CjR/wAqQehuMYmm
         wHi0c7fdWW4b4W7f7FfUaayx4FvCjVJuWiGZ4ChFt6O9Y26pQwiiFjb/FKky8G6lPcbt
         4NO2wNFTo01WDwLJFwp1/rE8zDfRbdDgujFd1UcZd2QqK7G+jRTwYu+cwqHYJ7fPjEvV
         vJcdPPb5rFNCnQq+KuNDkvy6HT6SMLXhiVA0uqhC8oWaGKUXOEPGZEEIuEEQtqGC+ggf
         NoYQ==
X-Gm-Message-State: AJIora9XRl0IDW1dn2D+OOjDRCXc5g0MyfdGmn1aA8KM9rEWa1rGSPXD
	jvOxLeMVNt7wy1k/GoiKyzkIlL22aGM=
X-Google-Smtp-Source: AGRyM1vnk8xZ78VeOKPCDxBUhSz2QfDnOQ0UxQdrMj8GvL2uG3JgPjvsHb5uoc7hRRdH/MipAkWaIg==
X-Received: by 2002:a63:8641:0:b0:40d:d04d:1b22 with SMTP id x62-20020a638641000000b0040dd04d1b22mr3921333pgd.418.1656524005475;
        Wed, 29 Jun 2022 10:33:25 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id o9-20020a63e349000000b0040cf934a1a0sm11533637pgj.28.2022.06.29.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:33:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: fix unpredictability/pointless test from testAgent
Date: Wed, 29 Jun 2022 10:31:13 -0700
Message-Id: <20220629173113.2442455-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629173113.2442455-1-prestwoj@gmail.com>
References: <20220629173113.2442455-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

testAgent had a few tests which weren't reliable, and one was not actually
testing anything, or at least not what the name implied it should be testing.

The first issue was using iwctl in the first place. There is not a reliable
way to know when iwctl has registered its agent so relying on that with a sleep,
or waiting for the service to become available isn't 100% fool proof. To fix
this use the updated PSKAgent which allows multiple to be registered. This ensures
the agent is ready for requests. This test was also renamed to be consistent with
what its actually testing: that IWD uses the first agent registered.

This removes test_connection_with_other_agent as well because this test case is
covered by the client test itself. There is no need to re-test iwctl's agent
functionality here.
---
 autotests/testAgent/agent_test.py | 40 ++++---------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_test.py
index c1dc8c7c..fc988f21 100644
--- a/autotests/testAgent/agent_test.py
+++ b/autotests/testAgent/agent_test.py
@@ -56,51 +56,19 @@ class Test(unittest.TestCase):
 
         IWD.clear_storage()
 
-    def test_connection_with_other_agent(self):
-        def wait_for_service_pid(pid):
-            dbus_object = ctx._bus.get_object('org.freedesktop.DBus',
-                                 '/org/freedesktop/DBus')
-            dbus_iface = dbus.Interface(dbus_object, 'org.freedesktop.DBus')
-
-            services = dbus_iface.ListNames()
-
-            for service in services:
-                bus_iface = dbus.Interface(dbus_object, "org.freedesktop.DBus")
-                if pid == int(bus_iface.GetConnectionUnixProcessID(service)):
-                    return True
-
-            return False
-
+    def test_connection_use_first_from_multiple_registered(self):
         wd = IWD()
 
-        iwctl = ctx.start_process(['iwctl', '-P', 'secret_ssid2'])
-
-        # Let iwctl to start and register its agent.
-        ctx.non_block_wait(wait_for_service_pid, 10, iwctl.pid)
-
-        self.check_connection(wd, 'ssid2')
-
-        iwctl.kill()
-
-        IWD.clear_storage()
-
-    def test_connection_use_own_agent_from_multiple_registered(self):
-
-        wd = IWD()
-
-        iwctl = ctx.start_process(['iwctl', '-P', 'secret_ssid2'])
-        # Let iwctl to start and register its agent.
-        wd.wait(2)
-
         psk_agent = PSKAgent("secret_ssid1")
         wd.register_psk_agent(psk_agent)
 
+        psk_agent = PSKAgent("secret_ssid2")
+        wd.register_psk_agent(psk_agent)
+
         self.check_connection(wd, 'ssid1')
 
         wd.unregister_psk_agent(psk_agent)
 
-        iwctl.kill()
-
         IWD.clear_storage()
 
     @classmethod
-- 
2.34.1

