Content-Type: multipart/mixed; boundary="===============1749173984546654283=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] auto-t: hwsim.py: add drop_ack property
Date: Tue, 07 Sep 2021 14:14:45 -0700
Message-ID: <20210907211450.27270-4-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1749173984546654283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 496c06a0..8ba9550a 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -161,6 +161,14 @@ class Rule(HwsimDBusAbstract):
     def match_times(self, value):
         self._prop_proxy.Set(self._iface_name, 'MatchTimes', dbus.UInt16(v=
alue))
 =

+    @property
+    def drop_ack(self):
+        return self._properties(['DropAck'])
+
+    @drop_ack.setter
+    def drop_ack(self, value):
+        self._prop_proxy.Set(self._iface_name, 'DropAck', value)
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.31.1

--===============1749173984546654283==--

