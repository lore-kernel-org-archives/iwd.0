Content-Type: multipart/mixed; boundary="===============8474352045019577324=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/6] auto-t: hwsim.py: add match/match_offset properties
Date: Thu, 09 Sep 2021 15:08:44 -0700
Message-ID: <20210909220848.19376-2-prestwoj@gmail.com>
In-Reply-To: <20210909220848.19376-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8474352045019577324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index e5d336e3..34859910 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -169,6 +169,22 @@ class Rule(HwsimDBusAbstract):
     def drop_ack(self, value):
         self._prop_proxy.Set(self._iface_name, 'DropAck', value)
 =

+    @property
+    def match(self):
+        return self._properties['MatchBytes']
+
+    @match.setter
+    def match(self, value):
+        self._prop_proxy.Set(self._iface_name, 'MatchBytes', dbus.ByteArra=
y.fromhex(value))
+
+    @property
+    def match_offset(self):
+        return self._properties(['MatchBytesOffset'])
+
+    @match_offset.setter
+    def match_offset(self, value):
+        self._prop_proxy.Set(self._iface_name, 'MatchBytesOffset', dbus.UI=
nt16(value))
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.31.1

--===============8474352045019577324==--

