Content-Type: multipart/mixed; boundary="===============9126768430032286929=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: make AdHoc APIs behave like others
Date: Mon, 14 Sep 2020 14:04:05 -0700
Message-ID: <20200914210407.428918-5-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9126768430032286929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AdHoc functionality in iwd.py was not consistent at all with
how all the other classes worked (my bad). Instead we can create
a very simple AdHocDevice class which inherits all the DBus magic
in the IWDDBusAbstract class.
---
 autotests/util/iwd.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index e74a6faf..2713d774 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -206,6 +206,20 @@ class SignalAgent(dbus.service.Object):
     def handle_new_level(self, path, level):
         pass
 =

+class AdHocDevice(IWDDBusAbstract):
+    '''
+        Class represents an AdHoc device object: net.connman.iwd.AdHoc
+    '''
+    _iface_name =3D IWD_ADHOC_INTERFACE
+
+    @property
+    def started(self):
+        return self._properties['Started']
+
+    @property
+    def connected_peers(self):
+        return self._properties['ConnectedPeers']
+
 =

 class Device(IWDDBusAbstract):
     '''
@@ -506,6 +520,8 @@ class Device(IWDDBusAbstract):
                                         error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

+        return AdHocDevice(self.device_path)
+
     def stop_adhoc(self):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 =

-- =

2.26.2

--===============9126768430032286929==--

