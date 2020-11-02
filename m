Content-Type: multipart/mixed; boundary="===============1394770393026190119=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] auto-t: add support for AP StartWithConfig API
Date: Mon, 02 Nov 2020 10:28:51 -0800
Message-ID: <20201102182851.2580877-3-prestwoj@gmail.com>
In-Reply-To: <20201102182851.2580877-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1394770393026190119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a psk is not provided to start_ap, it is assumed that the
AP is being started with a config file.
---
 autotests/util/iwd.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index f6ec164f..6f66e8a8 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -467,7 +467,7 @@ class Device(IWDDBusAbstract):
                                         error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

-    def start_ap(self, ssid, psk):
+    def start_ap(self, ssid, psk=3DNone):
         try:
             self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'ap')
         except Exception as e:
@@ -476,8 +476,12 @@ class Device(IWDDBusAbstract):
         self._ap_iface =3D dbus.Interface(self._bus.get_object(IWD_SERVICE,
                                             self.device_path),
                                             IWD_AP_INTERFACE)
-        self._ap_iface.Start(ssid, psk, reply_handler=3Dself._success,
-                                     error_handler=3Dself._failure)
+        if psk:
+            self._ap_iface.Start(ssid, psk, reply_handler=3Dself._success,
+                                    error_handler=3Dself._failure)
+        else:
+            self._ap_iface.StartProfile(ssid, reply_handler=3Dself._succes=
s,
+                                    error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

     def stop_ap(self):
-- =

2.26.2

--===============1394770393026190119==--

