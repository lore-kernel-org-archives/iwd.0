Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A553B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJcnP39Q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c77449a6daso11802355ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140933; x=1697745733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PAYVwyyHw0vjdAKxptwWDRnv6J4jNgoZT/HKqZKxIA=;
        b=IJcnP39Qc0jNytitYD+XYCG79S8hzDmefEbfNr2WX074AUWQ+V60lOUrdP/++ZYiI4
         jAbmGEwfVV8zxSY9Ra7ZnFLTJYqR3JUHISmEAmZFRuMra+norNy5R0FAe51oqubTXiLR
         yPEkCSBdKrH5QPAX0jmgyLDleguuQtMvgM7AKijz4ZJe4W0EDyiBlD83FX++DyEtdUZo
         z8/zdmuHc5/ySIQ4/t5Uf5duHmTLfcNbrAGPEhiNWzTShZH/1q4oYuvwQR7luIJtbQf+
         IkaYVK2vVliZ4rhqOu90KwbFUcAPAboxLqfdZ2dKdVBmtuheBAL809K0Yvz5s15dQUfw
         3xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140933; x=1697745733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PAYVwyyHw0vjdAKxptwWDRnv6J4jNgoZT/HKqZKxIA=;
        b=dmT7ooBUTpCmc0l0AUbM0WGb0feIBkx2gQQEzmjUb7/ywv66sX01801LvtGltpWH0s
         4jBg0ca5tJXwPbtqGI4csSrOUHZFJceO43MpWIqIjTL3W/ydDB0B5M0tcdr/d3jvMBnn
         ui0Ii2lAXPLpHKGA/EMWn5ld5iUYYhjw5z5YuObYXd2CmKrrkglLn0b6JFFf3AZap7ed
         aOl+20Fn69jXlNG3vYO47kUyY3+hiG6JSz2UaW82EFKg5DSMtp0ctIT0RJBOugTPtqBa
         /gqw/IJnZ0A9u4MqaZxrsN4J9zwECO2khu9gyTtagytZmyPbyC9a9oI/Ps34uudhZ5qY
         /aZQ==
X-Gm-Message-State: AOJu0YyX5pdaU3jIVXtf6iS563kVKgEpvSUrBSoHcqQWYbP1ytl8UbI4
	6snV+1pco4jhMlSzBsvMM5JlPH8hjWE=
X-Google-Smtp-Source: AGHT+IHkTdQFfsatNOD7IRJAT6hVVQSZvk/RcBA6YxGjamKNjZd1scg8Z4m9FFiORFaUu2c2CHxAug==
X-Received: by 2002:a17:902:ea09:b0:1c5:d747:a124 with SMTP id s9-20020a170902ea0900b001c5d747a124mr32966528plg.9.1697140932981;
        Thu, 12 Oct 2023 13:02:12 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 20/21] auto-t: add APIs for PKEX
Date: Thu, 12 Oct 2023 13:01:49 -0700
Message-Id: <20231012200150.338401-21-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also added some sanity checks to the existing DPP APIs to make
sure started/role gets set correctly.
---
 autotests/util/iwd.py | 93 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5fa12444..79490904 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -42,6 +42,7 @@ IWD_P2P_SERVICE_MANAGER_INTERFACE = 'net.connman.iwd.p2p.ServiceManager'
 IWD_P2P_WFD_INTERFACE =         'net.connman.iwd.p2p.Display'
 IWD_STATION_DEBUG_INTERFACE =   'net.connman.iwd.StationDebug'
 IWD_DPP_INTERFACE =             'net.connman.iwd.DeviceProvisioning'
+IWD_DPP_PKEX_INTERFACE =        'net.connman.iwd.SharedCodeDeviceProvisioning'
 
 IWD_AGENT_MANAGER_PATH =        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =            '/'
@@ -299,6 +300,33 @@ class DeviceProvisioning(IWDDBusAbstract):
     def role(self):
         return self._properties['Role']
 
+class SharedCodeDeviceProvisioning(IWDDBusAbstract):
+    _iface_name = IWD_DPP_PKEX_INTERFACE
+
+    def start_enrollee(self, key, identifier=None):
+        args = {
+            "Key": key
+        }
+
+        if identifier:
+            args["Identifier"] = identifier
+
+        return self._iface.StartEnrollee(args)
+
+    def start_configurator(self):
+        return self._iface.StartConfigurator()
+
+    def stop(self):
+        self._iface.Stop()
+
+    @property
+    def started(self):
+        return self._properties['Started']
+
+    @property
+    def role(self):
+        return self._properties['Role']
+
 class AccessPointDevice(IWDDBusAbstract):
     '''
         Class represents net.connman.iwd.AccessPoint
@@ -375,6 +403,7 @@ class Device(IWDDBusAbstract):
         self._station_props = None
         self._station_debug_obj = None
         self._dpp_obj = None
+        self._sc_dpp_obj = None
         self._ap_obj = None
 
         IWDDBusAbstract.__init__(self, *args, **kwargs)
@@ -407,6 +436,17 @@ class Device(IWDDBusAbstract):
 
         return self._dpp_obj
 
+    @property
+    def _sc_device_provisioning(self):
+        if self._properties['Mode'] != 'station':
+            self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
+
+        if self._sc_dpp_obj is None:
+            self._sc_dpp_obj = SharedCodeDeviceProvisioning(
+                                            object_path=self._object_path,
+                                            namespace=self._namespace)
+        return self._sc_dpp_obj
+
     @property
     def _station_debug(self):
         if self._properties['Mode'] != 'station':
@@ -774,13 +814,60 @@ class Device(IWDDBusAbstract):
         self._station_debug.wait_for_event(event, timeout)
 
     def dpp_start_enrollee(self):
-        return self._device_provisioning.start_enrollee()
+        ret = self._device_provisioning.start_enrollee()
+
+        condition = 'obj.started == True'
+        IWD._wait_for_object_condition(self._device_provisioning, condition)
+        condition = 'obj.role == "enrollee"'
+        IWD._wait_for_object_condition(self._device_provisioning, condition)
+
+        return ret
 
     def dpp_start_configurator(self, uri=None):
-        return self._device_provisioning.start_configurator(uri)
+        ret = self._device_provisioning.start_configurator(uri)
+
+        condition = 'obj.started == True'
+        IWD._wait_for_object_condition(self._device_provisioning, condition)
+        condition = 'obj.role == "configurator"'
+        IWD._wait_for_object_condition(self._device_provisioning, condition)
+
+        return ret
+
+    def dpp_pkex_enroll(self, *args, **kwargs):
+        ret = self._sc_device_provisioning.start_enrollee(*args, **kwargs)
+
+        condition = 'obj.started == True'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+        condition = 'obj.role == "enrollee"'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+
+        return ret
+
+    def dpp_pkex_configure(self):
+        ret = self._sc_device_provisioning.start_configurator()
+
+        condition = 'obj.started == True'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+        condition = 'obj.role == "configurator"'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+
+        return ret
+
+    def dpp_pkex_stop(self):
+        ret = self._sc_device_provisioning.stop()
+
+        condition = 'obj.started == False'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+
+        return ret
 
     def dpp_stop(self):
-        return self._device_provisioning.stop()
+        ret = self._device_provisioning.stop()
+
+        condition = 'obj.started == False'
+        IWD._wait_for_object_condition(self._device_provisioning, condition)
+
+        return ret
 
     def __str__(self, prefix = ''):
         s = prefix + 'Device: ' + self.device_path + '\n'\
-- 
2.25.1

