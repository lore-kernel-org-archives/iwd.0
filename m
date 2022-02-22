Content-Type: multipart/mixed; boundary="===============4129145284885242710=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 5/9] auto-t: iwd.py: allow passing uri to start_configurator
Date: Tue, 22 Feb 2022 14:28:43 -0800
Message-ID: <20220222222847.2480099-5-prestwoj@gmail.com>
In-Reply-To: 20220222222847.2480099-1-prestwoj@gmail.com

--===============4129145284885242710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a URI is passed this will envoke ConfigureEnrollee()
---
 autotests/util/iwd.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 170dd96b..d6620da5 100755
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
@@ -668,8 +671,8 @@ class Device(IWDDBusAbstract):
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

2.34.1

--===============4129145284885242710==--

