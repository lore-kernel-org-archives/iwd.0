Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6127702
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3007048pjk.1
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8tLpd8iyFxeYQRa17NWWdw7BzwcHOdwMi5qT4vPnSk=;
        b=jg8dxJcmVGqL3HxyawXbghOIqYuNQpvOjDlbUaLdqJPNqukZvaW0LTw6CLnLXAUZ3m
         8rhKuuBSKMu/OnmAnW5BnOxqIl1XL73Va+1pjapzNxEsLdCk1yP9JYRoszGIg6fn08zH
         ZXr1Mw6/my8P46Bxt4Il/myONGqK9z00aiilKFtQOk0zc2NfhOsXiGnkcq3qjGFoasrZ
         TZ/vTF3WblBT2rN8svwn31W3sqdz65op7QtX60SNnSPZQFk38Zv1OPj7GziodtXpCF51
         VS5ojL8jOS3XTQjg99+dOIuYB/3W+KRK9jimKw7jy/Xz0pB3AVIiYKlMuyd/hpP4P32h
         rL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8tLpd8iyFxeYQRa17NWWdw7BzwcHOdwMi5qT4vPnSk=;
        b=BetgLEf8enfb9CSyVZmdJuvRUiZXt5xRN3s9Gb/Zr2x66sJtuoGX5m228zZZoL7J3I
         d2flMMao0Z0EDIn/s8S0yTlwGhNPLSMvB0Rr2wg4DAkhm4qSN61j500WhxJiHqBtbkCc
         nKiZtKTvE1NBQG33+kmT9ZGrJVu/A8m6PsZf1ymGvUZQiYaWdJyA6xq0NHF2jXv4JH35
         S+zrjMcr0YAF+GAc5WRG0jAQ/boiYjZ8niUmVzk7Z0N3bIuXqupmlO65fPr10uW7Z7tF
         8NjrH/HrUyp/WevzK19mdg3fjgO9K4izkcaSCZwuSgeFsp90JK9tFJ+4H7q5W6qJ9KLq
         bXag==
X-Gm-Message-State: ACrzQf3U5irWSqzC4vNgpTINF6JlCSi5lIeY9vltOMGE4Qgd+Owzs6W6
	89Bk4nCuqcwUUC22i0JdOqMFNghK/xM=
X-Google-Smtp-Source: AMsMyM7DOIi9YCTSTUTVhB69wfd4nIIPcF5AlxPxbjBu2v5lEmDnMEJJkEY6HwXGhA0rDGPgwgSjcw==
X-Received: by 2002:a17:90b:1b05:b0:213:dc73:3084 with SMTP id nu5-20020a17090b1b0500b00213dc733084mr18555490pjb.13.1667422422260;
        Wed, 02 Nov 2022 13:53:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/10] auto-t: add proper AccessPoint object class
Date: Wed,  2 Nov 2022 13:53:25 -0700
Message-Id: <20221102205327.268693-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
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

