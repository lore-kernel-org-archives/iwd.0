Content-Type: multipart/mixed; boundary="===============3598530018303041745=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/13] auto-t: update start_ap() to remove psk argument
Date: Tue, 20 Oct 2020 11:02:52 -0700
Message-ID: <20201020180256.1630120-9-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3598530018303041745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9bfc8c1a..c1349bbd 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -467,7 +467,7 @@ class Device(IWDDBusAbstract):
                                         error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

-    def start_ap(self, ssid, psk):
+    def start_ap(self, ssid):
         try:
             self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'ap')
         except Exception as e:
@@ -476,7 +476,7 @@ class Device(IWDDBusAbstract):
         self._ap_iface =3D dbus.Interface(self._bus.get_object(IWD_SERVICE,
                                             self.device_path),
                                             IWD_AP_INTERFACE)
-        self._ap_iface.Start(ssid, psk, reply_handler=3Dself._success,
+        self._ap_iface.Start(ssid, reply_handler=3Dself._success,
                                      error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

-- =

2.26.2

--===============3598530018303041745==--

