Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB797176ADE
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179516; cv=none; b=T7l1tP3P5ll2jME14XoAITTnFjjM8PbNYHhPtMCbRvTlU7v2GoKJgM/od7fCHkVtG6xzkbt8VMG2FXzcMURAoKZZm532Q/uI5mPX9U+vcg+zQyBK5f3qwxF75OobLtzB8pm7RE/C+7fTSgsnnsAyE6GfvNcnWsr12Rn1CiiGmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179516; c=relaxed/simple;
	bh=0TblQlnV1b1AGbXTScJbBhKYf2a0AHZUNpdwuzpyaOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTL3XYob2FnVH1UUdwvgVNw73Z6dTG+H+oKA3sH8e8m6qACFlb6yHmgx263X6L7JvftQ4FHFPgGs1K4PMv5Kot9C4vQdx8i0Ga3jTAv1zCmI4Q6uoFg32rRBSVGU9tE73z4QyhMzGeOyKI977pR2XItwivxv0/Dlz3gmRptlAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ3AcDpn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ3AcDpn"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c54b1f52f7so35611596d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179513; x=1727784313; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLLtYNQR+C3oSPVjkUh2qQFzpK0wvefIlOfPrWG7IRg=;
        b=jZ3AcDpnmQBLTn6QPEQOBEOLX3dLHyjxTdrfuTiNH/oHprFOgNfjC1+r4kyKg29rGM
         R9TESZP6FkbDYY6r2MEXOm3ou9wm7XwUMqzMYCdfzuwvidqjm+tPK/XcNTw3GhXBcTVj
         S0qJAzxEQlgrMBx/x3Vl6a/z7mT+h52DbJnMrNsFNuITwKUljwMyaIWNl6Q/NUVzPD19
         g4pXMectv9U2d514pomzJwUFVnREt+g2rQqAp9YeC8xAi8RZIKk2XCHvApMvyC+ZV09U
         3Rpxyl8ekBhOD2Z9+F0bV8zOKQn4WxtrocbBAYzT1wEuDCUWsVJMOa1zad+rjKmDG3Vk
         0omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179513; x=1727784313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLLtYNQR+C3oSPVjkUh2qQFzpK0wvefIlOfPrWG7IRg=;
        b=jT7kDYdZRtTcgxf5AYtuvsQf9BmMoyS7jkN/X7VRVs32aQcvaCfyyzhI9xd9gRse8x
         rzLbiwvUPqromQGc8nztkkR6xBqXcBCjnl0YB+ujo0iQ8s7XMpWQfTRYtmppVFW+YIjN
         F1EGBlHA+dZvpsfsVmhPw23TnAufTE+refH+h/cODOV3ZFqcDs+5k4tpky9xNSjGwMj2
         eBWtTSxtvgydFrC3kE5hapT4I5dBkHvrVyrHgAkRqtixPbH5P44Qxh/mv6GOKIf3LH6S
         BlM/fc7asHHJjROmyKcAAdRsA2FD3TQG5QPSlEmyDeepxcqLmliVP4vLg7Zh0FScmssY
         iUVQ==
X-Gm-Message-State: AOJu0YzlrmZupF4dtXDT8UViRL/SXfCpAl5wEPUBxj2gDMULJW/3wRGl
	pBq9gmh8lzOcdzxYJUHuiYOsbYPQCazQhqyBOO3dZV789vKFPzudcFezYw==
X-Google-Smtp-Source: AGHT+IHyaiesgBvSauoqJopA+KfuKdvWgQczDiZFK3dkKKP4aABxeZWo5AsQbSLXy4NMxVGng2gPzw==
X-Received: by 2002:a05:6214:398c:b0:6c5:50bb:d59d with SMTP id 6a1803df08f44-6c7bc7ec5a4mr222240406d6.37.1727179513400;
        Tue, 24 Sep 2024 05:05:13 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/16] auto-t: update utils to use DeviceProvisioningAgent
Date: Tue, 24 Sep 2024 05:04:45 -0700
Message-Id: <20240924120447.251761-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 48 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 83f2d9ef..262afe52 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -43,7 +43,7 @@ IWD_P2P_WFD_INTERFACE =         'net.connman.iwd.p2p.Display'
 IWD_STATION_DEBUG_INTERFACE =   'net.connman.iwd.StationDebug'
 IWD_DPP_INTERFACE =             'net.connman.iwd.DeviceProvisioning'
 IWD_DPP_PKEX_INTERFACE =        'net.connman.iwd.SharedCodeDeviceProvisioning'
-IWD_SHARED_CODE_AGENT_INTERFACE = 'net.connman.iwd.SharedCodeAgent'
+IWD_DPP_AGENT_INTERFACE =       'net.connman.iwd.DeviceProvisioningAgent'
 
 IWD_AGENT_MANAGER_PATH =        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =            '/'
@@ -214,31 +214,32 @@ class SignalAgent(dbus.service.Object):
     def handle_new_level(self, path, level):
         pass
 
-class SharedCodeAgent(dbus.service.Object):
+class DeviceProvisioningAgent(dbus.service.Object):
     def __init__(self, codes = {}):
         self._path = '/test/agent/' + str(int(round(time.time() * 1000)))
         self._codes = codes
+        self._bus = dbus.bus.BusConnection(address_or_type=ctx.dbus_address)
 
-        dbus.service.Object.__init__(self, ctx.get_bus(), self._path)
+        dbus.service.Object.__init__(self, self._bus, self._path)
 
     @property
     def path(self):
         return self._path
 
-    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+    @dbus.service.method(IWD_DPP_AGENT_INTERFACE,
                          in_signature='', out_signature='')
     def Release(self):
-        print("SharedCodeAgent released")
+        print("DeviceProvisioningAgent released")
 
-    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+    @dbus.service.method(IWD_DPP_AGENT_INTERFACE,
                          in_signature='s', out_signature='')
-    def Cancel(self, reason):
-        print("SharedCodeAgent canceled (%s)" % reason)
+    def CancelSharedCode(self, reason):
+        print("DeviceProvisioningAgent canceled (%s)" % reason)
 
-    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+    @dbus.service.method(IWD_DPP_AGENT_INTERFACE,
                          in_signature='s', out_signature='s')
     def RequestSharedCode(self, identifier):
-        print("SharedCodeAgent request for %s" % identifier)
+        print("DeviceProvisioningAgent request for %s" % identifier)
 
         code = self._codes.get(identifier, None)
         if not code:
@@ -352,8 +353,8 @@ class SharedCodeDeviceProvisioning(IWDDBusAbstract):
 
         self._iface.StartEnrollee(args)
 
-    def start_configurator(self, path):
-        self._iface.StartConfigurator(dbus.ObjectPath(path))
+    def start_configurator(self):
+        self._iface.StartConfigurator()
 
     def configure_enrollee(self, code, identifier=None):
         args = {
@@ -1572,6 +1573,29 @@ class IWD(AsyncOpAbstract):
         self._wait_for_async_op()
         self.psk_agents.remove(psk_agent)
 
+    def register_dpp_agent(self, dpp_agent):
+        iface = dbus.Interface(dpp_agent._bus.get_object(IWD_SERVICE,
+                                                IWD_AGENT_MANAGER_PATH),
+                                                IWD_AGENT_MANAGER_INTERFACE)
+        iface.RegisterDeviceProvisioningAgent(dpp_agent.path,
+                            dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
+                            reply_handler=self._success,
+                            error_handler=self._failure)
+
+        self._wait_for_async_op()
+        self.dpp_agent = dpp_agent
+
+    def unregister_dpp_agent(self, dpp_agent):
+        iface = dbus.Interface(dpp_agent._bus.get_object(IWD_SERVICE,
+                                                IWD_AGENT_MANAGER_PATH),
+                                                IWD_AGENT_MANAGER_INTERFACE)
+        iface.UnregisterDeviceProvisioningAgent(dpp_agent.path,
+                                dbus_interface=IWD_AGENT_MANAGER_INTERFACE,
+                                reply_handler=self._success,
+                                error_handler=self._failure)
+        self._wait_for_async_op()
+        self.dpp_agent = None
+
     @staticmethod
     def get_instance():
         return IWD._default_instance()
-- 
2.34.1

