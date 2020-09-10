Content-Type: multipart/mixed; boundary="===============0450674138445493527=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 15/26] auto-t: hwsim: wait for method return
Date: Thu, 10 Sep 2020 11:58:44 -0700
Message-ID: <20200910185855.27833-15-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0450674138445493527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is not safe to assume that the python dbus implementation will
wait for a method to return. The documentation says this with
respect to reply_handler/error_handler:

"If both are None, the implementation may request that no reply is sent"

To stay on the safe side we should always include the error/reply
handlers and wait for the operation to complete.
---
 autotests/util/hwsim.py | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 6d2b3e8f..a0ddedcd 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -58,7 +58,9 @@ class Rule(HwsimDBusAbstract):
 =

     @source.setter
     def source(self, value):
-        self._prop_proxy.Set(self._iface_name, 'Source', value)
+        self._prop_proxy.Set(self._iface_name, 'Source', value, reply_hand=
ler=3Dself._success,
+                                error_handler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def destination(self):
@@ -66,7 +68,9 @@ class Rule(HwsimDBusAbstract):
 =

     @destination.setter
     def destination(self, value):
-        self._prop_proxy.Set(self._iface_name, 'Destination', value)
+        self._prop_proxy.Set(self._iface_name, 'Destination', value, reply=
_handler=3Dself._success,
+                                error_handler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def bidirectional(self):
@@ -75,7 +79,8 @@ class Rule(HwsimDBusAbstract):
     @bidirectional.setter
     def bidirectional(self, value):
         self._prop_proxy.Set(self._iface_name, 'Bidirectional',
-                dbus.Boolean(value))
+                dbus.Boolean(value), reply_handler=3Dself._success, error_=
handler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def frequency(self):
@@ -84,7 +89,8 @@ class Rule(HwsimDBusAbstract):
     @frequency.setter
     def frequency(self, value):
         self._prop_proxy.Set(self._iface_name, 'Frequency',
-                dbus.UInt32(value))
+                dbus.UInt32(value), reply_handler=3Dself._success, error_h=
andler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def priority(self):
@@ -93,7 +99,8 @@ class Rule(HwsimDBusAbstract):
     @priority.setter
     def priority(self, value):
         self._prop_proxy.Set(self._iface_name, 'Priority',
-                dbus.Int16(value))
+                dbus.Int16(value), reply_handler=3Dself._success, error_ha=
ndler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def signal(self):
@@ -102,7 +109,8 @@ class Rule(HwsimDBusAbstract):
     @signal.setter
     def signal(self, value):
         self._prop_proxy.Set(self._iface_name, 'SignalStrength',
-                dbus.Int16(value))
+                dbus.Int16(value), reply_handler=3Dself._success, error_ha=
ndler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def drop(self):
@@ -110,7 +118,9 @@ class Rule(HwsimDBusAbstract):
 =

     @drop.setter
     def drop(self, value):
-        self._prop_proxy.Set(self._iface_name, 'Drop', dbus.Boolean(value))
+        self._prop_proxy.Set(self._iface_name, 'Drop', dbus.Boolean(value),
+                                    reply_handler=3Dself._success, error_h=
andler=3Dself._failure)
+        self._wait_for_async_op()
 =

     @property
     def delay(self):
@@ -118,7 +128,9 @@ class Rule(HwsimDBusAbstract):
 =

     @delay.setter
     def delay(self, value):
-        self._prop_proxy.Set(self._iface_name, 'Delay', dbus.UInt32(value))
+        self._prop_proxy.Set(self._iface_name, 'Delay', dbus.UInt32(value),
+                            reply_handler=3Dself._success, error_handler=
=3Dself._failure)
+        self._wait_for_async_op()
 =

     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
@@ -126,6 +138,9 @@ class Rule(HwsimDBusAbstract):
 =

         self._wait_for_async_op()
 =

+    def __del__(self):
+        self.remove()
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Rule: ' + self.path + '\n' + \
                prefix + '\tSource:\t\t' + self.source + '\n' + \
-- =

2.21.3

--===============0450674138445493527==--

