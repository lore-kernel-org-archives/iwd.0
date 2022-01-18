Content-Type: multipart/mixed; boundary="===============6104224583002543869=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 08/12] auto-t: iwd.py: allow passing uri to start_configurator
Date: Tue, 18 Jan 2022 13:25:08 -0800
Message-ID: <20220118212512.2017977-8-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============6104224583002543869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a URI is passed this will envoke ConfigureEnrollee()
---
 autotests/util/iwd.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 54b4819e..3f21d5d6 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -280,8 +280,11 @@ class DeviceProvisioning(IWDDBusAbstract):
     def start_enrollee(self):
         return self._iface.StartEnrollee()
 =

-    def start_configurator(self):
-        return self._iface.StartConfigurator()
+    def start_configurator(self, uri=3DNone):
+        if uri:
+            return self._iface.ConfigureEnrollee(uri)
+        else:
+            return self._iface.StartConfigurator()
 =

     def stop(self):
         self._iface.Stop()
@@ -667,8 +670,8 @@ class Device(IWDDBusAbstract):
     def dpp_start_enrollee(self):
         return self._device_provisioning.start_enrollee()
 =

-    def dpp_start_configurator(self):
-        return self._device_provisioning.start_configurator()
+    def dpp_start_configurator(self, uri=3DNone):
+        return self._device_provisioning.start_configurator(uri)
 =

     def dpp_stop(self):
         return self._device_provisioning.stop()
-- =

2.31.1

--===============6104224583002543869==--

