Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9102C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:46 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso131929pjc.5
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8tLpd8iyFxeYQRa17NWWdw7BzwcHOdwMi5qT4vPnSk=;
        b=Nrv7OqrRo2nboyQ4aEHtgQyv60i4RhOgmOcuFXV4tBw0Kq5auBrGEMQv8iD+5ClQTg
         gLrRZQEtwV4p3YWFR+mGKqehAFyp2W2XIruC48d/y2XP6KQQX4hgxKD2pjKpAdkbCTpp
         MxemJ/pnVh/GYuXQkhx5yH1OWwqALsfEnbXOZKQ1CqohrRtggtXCE9RY4HKEewPam0h7
         Ja8R+LqTRPdVjCgd6uQVYprzENO8zAnMpcTjYFH0BMiPLAgjvRRj4p0EqvVmu7vj+yJ5
         9phYEnujWdQGVKrzWEi6HT/QId1rPQhtvvUnVOrlEWi1eIwGj6Vb5X/80I3sFLJo+fJd
         j1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8tLpd8iyFxeYQRa17NWWdw7BzwcHOdwMi5qT4vPnSk=;
        b=5VzaMZYz8UdFv9xy7z6UkBp2xClmsKITNGlSnr10xk5KfmPN7MK3fAXh9R2/exgeDs
         6zfGx/S2NeUjORASe6/hqYXp/96Ooe+GzAf4K7WfNyYmsyPt1GAgJWlGwpwLfAT+R9ot
         hfD5XHqem5hQHd5LxoqjEviUsMkroFl8lbaByAobW07cMH1EHSZFVobH+X/swI9WLEzu
         uIPsKZEzwF2VRBYsyWaKghCkxPTKG9gZlURJxG5OlCkIuPA1y6rVbqW/3rIAaxJLWeaw
         LaJUwttNYvHcqQtl4H1BiprbJ233Zj8C1fe7nhZ5SyPSTx3fFLfL7kAS9c3L7PxAJzeK
         h1RQ==
X-Gm-Message-State: ACrzQf12MipXkQ0at3ahyW2IdqDWYpTXRs70z9ctYtr17YSlZ6D0Olyo
	jJ6WE2b0slbCP/N9jJldevEWrsm+FqA=
X-Google-Smtp-Source: AMsMyM4kP0RUiKJQcqUv78uPlxfbSJyqo7LhgiN0Fvc4HLKyOCY5lHhSZe6U3b+zLlpLiLpcynS2bA==
X-Received: by 2002:a17:90a:b00d:b0:212:f91d:88c7 with SMTP id x13-20020a17090ab00d00b00212f91d88c7mr28129051pjq.112.1667429504982;
        Wed, 02 Nov 2022 15:51:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/11] auto-t: add proper AccessPoint object class
Date: Wed,  2 Nov 2022 15:51:14 -0700
Message-Id: <20221102225116.297129-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AP mode device APIs were hacked together and only able to start
stop an AP. Now that the AP interface has more functionality its
best to use the DBus class template to access the full AP interface
capabilities.
---
 autotests/util/iwd.py | 101 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 8 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9e96382a..98b9ea1c 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -299,6 +299,69 @@ class DeviceProvisioning(IWDDBusAbstract):
     def role(self):
         return self._properties['Role']
 
+class AccessPointDevice(IWDDBusAbstract):
+    '''
+        Class represents net.connman.iwd.AccessPoint
+    '''
+    _iface_name = IWD_AP_INTERFACE
+
+    def start(self, ssid, psk):
+        self._iface.Start(ssid, psk, reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+        IWD._wait_for_object_condition(self, 'obj.started == True')
+
+    def start_profile(self, ssid):
+        self._iface.StartProfile(ssid, reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+        IWD._wait_for_object_condition(self, 'obj.started == True')
+
+    def stop(self):
+        self._iface.Stop(reply_handler=self._success,
+                            error_handler=self._failure)
+        self._wait_for_async_op()
+
+        IWD._wait_for_object_condition(self, 'obj.started == False')
+
+    def scan(self):
+        self._iface.Scan(reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+        IWD._wait_for_object_condition(self, 'obj.scanning == True')
+        IWD._wait_for_object_condition(self, 'obj.scanning == False')
+
+    def get_ordered_networks(self):
+        return self._iface.GetOrderedNetworks()
+
+    @property
+    def started(self):
+        return self._properties['Started']
+
+    @property
+    def name(self):
+        return self._properties['Name']
+
+    @property
+    def scanning(self):
+        return self._properties['Scanning']
+
+    @property
+    def frequency(self):
+        return self._properties['Frequency']
+
+    @property
+    def pairwise_ciphers(self):
+        return self._properties['PairwiseCiphers']
+
+    @property
+    def group_cipher(self):
+        return self._properties['GroupCipher']
+
+
 class Device(IWDDBusAbstract):
     '''
         Class represents a network device object: net.connman.iwd.Device
@@ -312,6 +375,7 @@ class Device(IWDDBusAbstract):
         self._station_props = None
         self._station_debug_obj = None
         self._dpp_obj = None
+        self._ap_obj = None
 
         IWDDBusAbstract.__init__(self, *args, **kwargs)
 
@@ -354,6 +418,17 @@ class Device(IWDDBusAbstract):
 
         return self._station_debug_obj
 
+    @property
+    def _ap(self):
+        if self._properties['Mode'] != 'ap':
+            self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'ap')
+
+        if self._ap_obj is None:
+            self._ap_obj = AccessPointDevice(object_path=self._object_path,
+                                                namespace=self._namespace)
+
+        return self._ap_obj
+
     def _station_properties(self):
         if self._station_props is not None:
             return self._station_props
@@ -605,20 +680,30 @@ class Device(IWDDBusAbstract):
         except Exception as e:
             raise _convert_dbus_ex(e)
 
-        self._ap_iface = dbus.Interface(self._bus.get_object(IWD_SERVICE,
-                                            self.device_path),
-                                            IWD_AP_INTERFACE)
         if psk:
-            self._ap_iface.Start(ssid, psk, reply_handler=self._success,
-                                    error_handler=self._failure)
+            self._ap.start(ssid, psk)
         else:
-            self._ap_iface.StartProfile(ssid, reply_handler=self._success,
-                                    error_handler=self._failure)
-        self._wait_for_async_op()
+            self._ap.start_profile(ssid)
 
     def stop_ap(self):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 
+        IWD._wait_for_object_condition(self, "obj._properties['Mode'] == 'station'")
+
+    @property
+    def group_cipher(self):
+        if self._properties['Mode'] != 'ap':
+            raise Exception('group_cipher only supported in AP mode')
+
+        return self._ap.group_cipher
+
+    @property
+    def pairwise_ciphers(self):
+        if self._properties['Mode'] != 'ap':
+            raise Exception('pairwise_cipher only supported in AP mode')
+
+        return self._ap.pairwise_ciphers
+
     def connect_hidden_network(self, name):
         '''Connect to a hidden network
            Possible exception: BusyEx
-- 
2.34.3

