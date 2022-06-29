Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F37B
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 17:33:25 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id h192so15993236pgc.4
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRJrLiWTGa7J9VTvJo2F8GwpuB7icliIQLhPjvji9xY=;
        b=bb7mcTGBarDHfDqGsp/03ka9e/l8OyQbs02T7MNtEqyolXSsdveQ9Uh+lKpPJ3a4eC
         bJeA71WB/MwxXaVJsvn6a3HGPofJj/P//zeXrgvVYDLgxeDCCQDtwv04rWAANcWhpHY9
         SaTFe03Z8jbRHj2c2BdT8IuCk2YdJt8xTtNfhtSpLXai4OudqWhSM/Zeo2btv1xjIR/Z
         3xpCeChWASZFNO6azbhTeTZps/9wMXTWMtq+VcCM0yUQ8Th6gPmfT6PNP/GJYjAZt9wy
         z03HshwkPlGqNG0vPe/2jx4y4ulF06gYX2CoL25x1R22WM+0j1RwilYu0bFWHsSHIWmt
         odhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRJrLiWTGa7J9VTvJo2F8GwpuB7icliIQLhPjvji9xY=;
        b=l6ENuvnGYnD/+YjD0SXXXzVPdIOJzWPISmcYfbM3F7mSA6gHZYhe3+CmTS59HqEN+y
         H6cs0lGg02cDgpT1hwk9KArrWS3zVuSer9ffXQthnFBr/f9hU6llj/oYXwfSd6V1b5Xb
         tKb6NWU85ycvfS7DEYQ1Kq8OriKHe6nYIOdKFmvCs0PcIwuzxpvTRNIfFm0rIQVRpWA0
         WQSP+jPHHRdH8EXspRqJrusjzPHKWuCKP6qPXhgLelckEvdV9pL8gZHXZZHTTNP00gQO
         cwMuyXr8BRovDGK07tA2zlYpOwMPIYz9y59dH5x7vlcbYGA/wpV64ht0o/zskEsJiV4S
         uzxA==
X-Gm-Message-State: AJIora9QQ2O0eLdGkEwUtn8d7B+HQ7dXZ7RTcRJG7a5qqsIB+NWVkQW2
	950CsTFGq5uDrFsb54YPV1e/ZcJGKd0=
X-Google-Smtp-Source: AGRyM1vVFfI985RFTF+J9GVOscAd2mj72y6z/hXuetYaudYkmKlFvCQLkFntUTBpzUWhzpd107i+6g==
X-Received: by 2002:a63:555d:0:b0:3fd:5d54:2708 with SMTP id f29-20020a63555d000000b003fd5d542708mr3958103pgm.92.1656524004650;
        Wed, 29 Jun 2022 10:33:24 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id o9-20020a63e349000000b0040cf934a1a0sm11533637pgj.28.2022.06.29.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:33:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: allow multiple PSKAgent's to be registered
Date: Wed, 29 Jun 2022 10:31:12 -0700
Message-Id: <20220629173113.2442455-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By creating a new bus connection for each agent we can register multiple
with IWD. This did mean the agent interface needs to be unique for each
agent (removing _agent_manager_if) as well as tracking multiple agents
in a list.
---
 autotests/util/iwd.py | 51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index b74ba440..5591d7e1 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -865,10 +865,11 @@ class PSKAgent(dbus.service.Object):
             users = [users]
         self.users = users
         self._path = '/test/agent/%s' % agent_count
+        self._bus = dbus.bus.BusConnection(address_or_type=namespace.dbus_address)
 
         agent_count += 1
 
-        dbus.service.Object.__init__(self, namespace.get_bus(), self._path)
+        dbus.service.Object.__init__(self, self._bus, self._path)
 
     @property
     def path(self):
@@ -1086,11 +1087,10 @@ class IWD(AsyncOpAbstract):
         start_iwd_daemon=True)
     '''
     _object_manager_if = None
-    _agent_manager_if = None
     _iwd_proc = None
     _devices = None
     _default_instance = None
-    psk_agent = None
+    psk_agents = []
 
     def __init__(self, start_iwd_daemon = False, iwd_config_dir = '/tmp',
                             iwd_storage_dir = IWD_STORAGE_DIR, namespace=ctx):
@@ -1114,11 +1114,12 @@ class IWD(AsyncOpAbstract):
             IWD._default_instance = weakref.ref(self)
 
     def __del__(self):
-        if self.psk_agent:
-            self.unregister_psk_agent(self.psk_agent)
+        for agent in self.psk_agents:
+            self.unregister_psk_agent(agent)
+
+        self.psk_agents = []
 
         self._object_manager_if = None
-        self._agent_manager_if = None
         self._known_networks = None
         self._devices = None
 
@@ -1137,15 +1138,6 @@ class IWD(AsyncOpAbstract):
                                       DBUS_OBJECT_MANAGER)
         return self._object_manager_if
 
-    @property
-    def _agent_manager(self):
-        if self._agent_manager_if is None:
-            self._agent_manager_if =\
-                dbus.Interface(self._bus.get_object(IWD_SERVICE,
-                                                    IWD_AGENT_MANAGER_PATH),
-                               IWD_AGENT_MANAGER_INTERFACE)
-        return self._agent_manager_if
-
     @staticmethod
     def _wait_for_object_condition(obj, condition_str, max_wait = 50):
         def _eval_wrap(obj, condition_str):
@@ -1271,22 +1263,27 @@ class IWD(AsyncOpAbstract):
         return known_network_list
 
     def register_psk_agent(self, psk_agent):
-        self._agent_manager.RegisterAgent(
-                                     psk_agent.path,
-                                     dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
-                                     reply_handler=self._success,
-                                     error_handler=self._failure)
+        iface = dbus.Interface(psk_agent._bus.get_object(IWD_SERVICE,
+                                                IWD_AGENT_MANAGER_PATH),
+                                                IWD_AGENT_MANAGER_INTERFACE)
+        iface.RegisterAgent(psk_agent.path,
+                            dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
+                            reply_handler=self._success,
+                            error_handler=self._failure)
+
         self._wait_for_async_op()
-        self.psk_agent = psk_agent
+        self.psk_agents.append(psk_agent)
 
     def unregister_psk_agent(self, psk_agent):
-        self._agent_manager.UnregisterAgent(
-                                     psk_agent.path,
-                                     dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
-                                     reply_handler=self._success,
-                                     error_handler=self._failure)
+        iface = dbus.Interface(psk_agent._bus.get_object(IWD_SERVICE,
+                                                IWD_AGENT_MANAGER_PATH),
+                                                IWD_AGENT_MANAGER_INTERFACE)
+        iface.UnregisterAgent(psk_agent.path,
+                                dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
+                                reply_handler=self._success,
+                                error_handler=self._failure)
         self._wait_for_async_op()
-        self.psk_agent = None
+        self.psk_agents.remove(psk_agent)
 
     @staticmethod
     def get_instance():
-- 
2.34.1

