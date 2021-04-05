Content-Type: multipart/mixed; boundary="===============4967561004473701665=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: add python wrapper for hwsim rule prefix
Date: Mon, 05 Apr 2021 15:40:25 -0700
Message-ID: <20210405224027.1052197-3-prestwoj@gmail.com>
In-Reply-To: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4967561004473701665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index ad4bec1f..320e9dfa 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -132,6 +132,16 @@ class Rule(HwsimDBusAbstract):
                             reply_handler=3Dself._success, error_handler=
=3Dself._failure)
         self._wait_for_async_op()
 =

+    @property
+    def prefix(self):
+        return self._properties['Prefix']
+
+    @prefix.setter
+    def prefix(self, value):
+        self._prop_proxy.Set(self._iface_name, 'Prefix', dbus.ByteArray.fr=
omhex(value),
+                            reply_handler=3Dself._success, error_handler=
=3Dself._failure)
+        self._wait_for_async_op()
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
@@ -150,7 +160,8 @@ class Rule(HwsimDBusAbstract):
                prefix + '\tPriority:\t' + str(self.priority) + '\n' +\
                prefix + '\tFrequency:\t' + str(self.frequency) + '\n' + \
                prefix + '\tApply rssi:\t' + str(self.signal) + '\n' + \
-               prefix + '\tApply drop:\t' + str(self.drop) + '\n'
+               prefix + '\tApply drop:\t' + str(self.drop) + '\n' + \
+               prefix + '\tPrefix:\t' + str([hex(b) for b in self.prefix])=
 + '\n'
 =

 class RuleSet(collections.Mapping):
     def __init__(self, hwsim, objects):
-- =

2.26.2

--===============4967561004473701665==--

