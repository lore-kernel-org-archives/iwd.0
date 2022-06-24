Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0B4C6F
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:58 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 184so3660448pga.12
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbhjQ2zPW6+dU9vr/yPe+IemjoLojRnPkfy9L4ZkOfY=;
        b=ayH2rVLV7PGwnAJpAELZ3S2UarKtaYHRT5L6ggpRNBjRZ2JxvqLyH7K9VUQUTt0+eb
         +M9iXsB3jYdCD8BHVRKvgM9IessAifOmcD2P/sdnlmoNcG8sTk7kFxMkBomNZvE+4KU+
         O9aA2UjA4lwKLJD8LAHNdICqFJPOIwHDPQb91PMe9ztjUWkx2qxBWklu88ypHMRRKHN1
         A5Zcxyi1uFikvnWN1fYr3tTSpNcYtk7Bc1dpbUiQIMbvfiY9qhPTM8jQGC6lTDUvQk5w
         ct78Lm690t+T+mTuNACNH0HahyMSgdqAbQA8kAXjYnVRktSTQd9/1uF1XckLsWCqrgd4
         UImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbhjQ2zPW6+dU9vr/yPe+IemjoLojRnPkfy9L4ZkOfY=;
        b=EKHSstQJH8hDR7sZtVQqK9SOuEsIB2JCU08IiEMsj49c0LYdjc81avTo43kPDCEimq
         kpStTAH5KITaVSzvKpQkfG8hGUHJjrxx1fNlacAKlHDMGNISNW0r/JDEamMT8knPF0z2
         ZbW2MaXuCBBShfLTn+9Dca0DbP/buj4ncjc+KCMREuqh4/SJFjZ1PWLPQA+3mGNGyqtI
         dzf4WMaE4MhsfLLK+/f1gg3gdBK9aZ8OePJiR1Myn9HUt6b1plGAcnU42BhzQjJKa0yw
         5Be/wr0nwsOhB8CpDmDRgLtHBas0zC9IGN4lz7G7gXBjeh5wqFP92M+QEg+ZyjIDpTQT
         Qg1A==
X-Gm-Message-State: AJIora+9sGNyfSm4EpAG9nRaEaULnU7rc6ktIfs9v/wp0dUiax9z1Sgb
	BFYRoJQu4whvmHL4ZCc5D5mBTW78bOA=
X-Google-Smtp-Source: AGRyM1sx2gAk/eFQ+S5fSWT5ga0JsPprn3TCNGyon1mZVciCapuzngVaoHC62/11mpRokHuE/binTg==
X-Received: by 2002:a05:6a00:1821:b0:525:6ed7:cdcc with SMTP id y33-20020a056a00182100b005256ed7cdccmr1378907pfa.70.1656112198139;
        Fri, 24 Jun 2022 16:09:58 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] auto-t: remove sleep in testAgent
Date: Fri, 24 Jun 2022 16:07:39 -0700
Message-Id: <20220624230741.1957863-6-prestwoj@gmail.com>
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

The test here is verifying that a DBus Connect() call will still
work with 'other' agents registered. In this case it uses iwctl to
set a password, then call Connect() manually.

The problem here is that we have no way of knowing when iwctl fully
starts and registers its agent. There was a sleep in there but that
is unreliable and we occationally were still getting past that without
iwctl having started fully.

To fix this properly we need to wait for iwctl's agent service to appear
on the bus. Since the bus name is unknown we must first find all names,
then cross reference their PID's against the iwctl PID. This is done
using ListNames, and GetConnectionUnixProcessID APIs.
---
 autotests/testAgent/agent_test.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_test.py
index e2d6e49e..c1dc8c7c 100644
--- a/autotests/testAgent/agent_test.py
+++ b/autotests/testAgent/agent_test.py
@@ -2,6 +2,7 @@
 
 import unittest
 import sys
+import dbus
 
 sys.path.append('../util')
 import iwd
@@ -56,11 +57,26 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
 
     def test_connection_with_other_agent(self):
+        def wait_for_service_pid(pid):
+            dbus_object = ctx._bus.get_object('org.freedesktop.DBus',
+                                 '/org/freedesktop/DBus')
+            dbus_iface = dbus.Interface(dbus_object, 'org.freedesktop.DBus')
+
+            services = dbus_iface.ListNames()
+
+            for service in services:
+                bus_iface = dbus.Interface(dbus_object, "org.freedesktop.DBus")
+                if pid == int(bus_iface.GetConnectionUnixProcessID(service)):
+                    return True
+
+            return False
+
         wd = IWD()
 
         iwctl = ctx.start_process(['iwctl', '-P', 'secret_ssid2'])
+
         # Let iwctl to start and register its agent.
-        wd.wait(2)
+        ctx.non_block_wait(wait_for_service_pid, 10, iwctl.pid)
 
         self.check_connection(wd, 'ssid2')
 
-- 
2.34.1

