Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1031A7F
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+dHa/dF"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-671357f0209so46445126d6.0
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464129; x=1700068929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBeroSzBX6viLWO4InxSFlNOHYAqDC1wQME5BKDhn48=;
        b=e+dHa/dFVWO1FRboHDVlNXyOYmwyLDlGI0CwG2StkVF5lZcT+TFmmWGKsYCGPbR8qB
         Pg6rjdLwx1hLL9myHArk3FcXDBuuwroRmGFKtKs3sSXZyc/0k7H6Nt6M891YXH3PZEvV
         OC8othfH9dAggQC4z9EK37giqw2FTVxr1s8Qd/22qgabLExH9RYJ2vEmuJGFActHgwP2
         4frzApd3hYwIFV93Kojgd7cbsMRBUH94UKIe6EvFjiENmW2IIs4izqc57T487jaVOC4q
         5e3fjda/ElBO0E2J9WqK0Pi8nu5bs+rwjxMGBBqS31CKHOizFcFNgskHW8cPx5VolS1h
         qDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464129; x=1700068929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBeroSzBX6viLWO4InxSFlNOHYAqDC1wQME5BKDhn48=;
        b=lZ4exI0FC1jZy1wf4c5pHnKgZ6R5xcpq5x3ZnuoewKOnk3qmCVw6sNbvTS+xap4EWa
         WTHex9IHPUCVGKZSzfwTIgiSHDoDbpjD6ekpgwa3d2fEaq7/yq+iBUrIZ54VY8YuWKYp
         YP//4/y8tPeQOp+C9fgfKVfIU4SFDuC/ZJ/ONZry3AQz5coXH8x9wChI3vSMD9zPFi7J
         MM7Bwxzv/4MgB3pnxFaw+cYqGXu85p6pbtsHRfM4F5mB3ejmwYsm2BI8bonY8ZWCWEJj
         7vuLdzZNzP+1QC8Fvm/SE36mH3SfmJ2mfJQw9kP/Bqhsyqmt0wO7wFPRgIKeLYykH3CN
         2H0Q==
X-Gm-Message-State: AOJu0YxN7GaU46ggeEc+Bv+sLIW/ayHFMY0rKuahbRUmcfKF/QNtGiaH
	iywPrNJ0Laa/0Lv+tUHi5WIccyZP2eo=
X-Google-Smtp-Source: AGHT+IFFLDduH9jYCMjP+Tt6RnzlP+/rCpzSaRG1QQh2IFv4xny1XFYrkBaXSYfJthQgMxpT5kyCbA==
X-Received: by 2002:a05:6214:1bc6:b0:66d:5c10:cab7 with SMTP id m6-20020a0562141bc600b0066d5c10cab7mr3052282qvc.46.1699464129126;
        Wed, 08 Nov 2023 09:22:09 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 09/10] auto-t: add APIs for PKEX
Date: Wed,  8 Nov 2023 09:21:54 -0800
Message-Id: <20231108172155.2129509-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
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
 autotests/util/iwd.py | 153 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5fa12444..c0ce0817 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -42,6 +42,8 @@ IWD_P2P_SERVICE_MANAGER_INTERFACE = 'net.connman.iwd.p2p.ServiceManager'
 IWD_P2P_WFD_INTERFACE =         'net.connman.iwd.p2p.Display'
 IWD_STATION_DEBUG_INTERFACE =   'net.connman.iwd.StationDebug'
 IWD_DPP_INTERFACE =             'net.connman.iwd.DeviceProvisioning'
+IWD_DPP_PKEX_INTERFACE =        'net.connman.iwd.SharedCodeDeviceProvisioning'
+IWD_SHARED_CODE_AGENT_INTERFACE = 'net.connman.iwd.SharedCodeAgent'
 
 IWD_AGENT_MANAGER_PATH =        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =            '/'
@@ -212,6 +214,33 @@ class SignalAgent(dbus.service.Object):
     def handle_new_level(self, path, level):
         pass
 
+class SharedCodeAgent(dbus.service.Object):
+    def __init__(self, codes = {}):
+        self._path = '/test/agent/' + str(int(round(time.time() * 1000)))
+        self._codes = codes
+
+        dbus.service.Object.__init__(self, ctx.get_bus(), self._path)
+
+    @property
+    def path(self):
+        return self._path
+
+    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+                         in_signature='', out_signature='')
+    def Release(self):
+        print("SharedCodeAgent released")
+
+    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+                         in_signature='s', out_signature='s')
+    def RequestSharedCode(self, identifier):
+        print("SharedCodeAgent request for %s" % identifier)
+
+        code = self._codes.get(identifier, None)
+        if not code:
+            return NotFoundEx("No code found for %s" % identifier)
+
+        return code
+
 class AdHocDevice(IWDDBusAbstract):
     '''
         Class represents an AdHoc device object: net.connman.iwd.AdHoc
@@ -299,6 +328,49 @@ class DeviceProvisioning(IWDDBusAbstract):
     def role(self):
         return self._properties['Role']
 
+class SharedCodeDeviceProvisioning(IWDDBusAbstract):
+    _iface_name = IWD_DPP_PKEX_INTERFACE
+
+    def start_enrollee(self, code, identifier=None):
+        args = {
+            "Code": code
+        }
+
+        if identifier:
+            args["Identifier"] = identifier
+
+        self._iface.StartEnrollee(args)
+
+    def start_configurator(self, path):
+        self._iface.StartConfigurator(dbus.ObjectPath(path))
+
+    def configure_enrollee(self, code, identifier=None):
+        args = {
+            "Code": code
+        }
+
+        if identifier:
+            args["Identifier"] = identifier
+
+        self._iface.ConfigureEnrollee(args)
+
+    def stop(self):
+        self._iface.Stop()
+
+    def register_agent(self, path):
+        self._iface.RegisterSharedCodeAgent(path)
+
+    def unregister_agent(self):
+        self._iface.UnregisterSharedCodeAgent()
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
@@ -375,6 +447,7 @@ class Device(IWDDBusAbstract):
         self._station_props = None
         self._station_debug_obj = None
         self._dpp_obj = None
+        self._sc_dpp_obj = None
         self._ap_obj = None
 
         IWDDBusAbstract.__init__(self, *args, **kwargs)
@@ -407,6 +480,17 @@ class Device(IWDDBusAbstract):
 
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
@@ -774,13 +858,76 @@ class Device(IWDDBusAbstract):
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
+    def dpp_pkex_start_configurator(self, *args, **kwargs):
+        ret = self._sc_device_provisioning.start_configurator(*args, **kwargs)
+
+        condition = 'obj.started == True'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+        condition = 'obj.role == "configurator"'
+        IWD._wait_for_object_condition(self._sc_device_provisioning, condition)
+
+        return ret
+
+    def dpp_pkex_configure_enrollee(self, *args, **kwargs):
+        ret = self._sc_device_provisioning.configure_enrollee(*args, **kwargs)
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
+
+    def dpp_pkex_register_agent(self, path):
+        self._sc_device_provisioning.register_agent(path)
+
+    def dpp_pkex_unregister_agent(self):
+        self._sc_device_provisioning.unregister_agent()
 
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

