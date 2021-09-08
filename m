Content-Type: multipart/mixed; boundary="===============2770293650549467430=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] auto-t: hwsim.py: add prefix_offset property
Date: Wed, 08 Sep 2021 15:47:41 -0700
Message-ID: <20210908224744.102156-2-prestwoj@gmail.com>
In-Reply-To: <20210908224744.102156-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2770293650549467430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index e5d336e3..732a1fcf 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -169,6 +169,14 @@ class Rule(HwsimDBusAbstract):
     def drop_ack(self, value):
         self._prop_proxy.Set(self._iface_name, 'DropAck', value)
 =

+    @property
+    def prefix_offset(self):
+        return self._properties(['PrefixOffset'])
+
+    @prefix_offset.setter
+    def prefix_offset(self, value):
+        self._prop_proxy.Set(self._iface_name, 'PrefixOffset', dbus.UInt16=
(value))
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.31.1

--===============2770293650549467430==--

