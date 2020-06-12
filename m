Content-Type: multipart/mixed; boundary="===============5201219204031909130=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] auto-t: add 'Delay' property to hwsim python module
Date: Fri, 12 Jun 2020 12:14:13 -0700
Message-ID: <20200612191414.13413-3-prestwoj@gmail.com>
In-Reply-To: <20200612191414.13413-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5201219204031909130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 4d3748b1..6d2b3e8f 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -112,6 +112,14 @@ class Rule(HwsimDBusAbstract):
     def drop(self, value):
         self._prop_proxy.Set(self._iface_name, 'Drop', dbus.Boolean(value))
 =

+    @property
+    def delay(self):
+        return int(self._properties['Delay'])
+
+    @delay.setter
+    def delay(self, value):
+        self._prop_proxy.Set(self._iface_name, 'Delay', dbus.UInt32(value))
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.21.1

--===============5201219204031909130==--

