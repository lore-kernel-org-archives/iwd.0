Content-Type: multipart/mixed; boundary="===============8757693768482563102=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 2/3] auto-t: Add async API call for connect_hidden_network
Date: Tue, 09 Jun 2020 18:22:20 -0700
Message-ID: <20200610012221.19263-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200610012221.19263-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8757693768482563102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index b9eeb0ff..ef1ea80e 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -482,6 +482,21 @@ class Device(IWDDBusAbstract):
                                error_handler=3Dself._failure)
         self._wait_for_async_op()
 =

+    def connect_hidden_network_async(self, name, reply_handler, error_hand=
ler):
+        '''Connect to a hidden network
+           Possible exception: BusyEx
+                               FailedEx
+                               InvalidArgumentsEx
+                               NotConfiguredEx
+                               NotConnectedEx
+                               NotFoundEx
+                               ServiceSetOverlapEx
+        '''
+        self._iface.ConnectHiddenNetwork(name,
+                               dbus_interface=3DIWD_STATION_INTERFACE,
+                               reply_handler=3Dreply_handler,
+                               error_handler=3Derror_handler)
+
     def start_adhoc(self, ssid, psk=3DNone):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'ad-hoc')
         self._adhoc_iface =3D dbus.Interface(self._bus.get_object(IWD_SERV=
ICE,
-- =

2.13.6

--===============8757693768482563102==--

