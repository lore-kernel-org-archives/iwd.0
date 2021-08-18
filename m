Content-Type: multipart/mixed; boundary="===============5395030768957051105=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] auto-t: hwsim.py: add Enabled property
Date: Wed, 18 Aug 2021 15:09:30 -0700
Message-ID: <20210818220934.295721-4-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5395030768957051105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 4e3b8ec2..3a83bcd8 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -142,6 +142,16 @@ class Rule(HwsimDBusAbstract):
                             reply_handler=3Dself._success, error_handler=
=3Dself._failure)
         self._wait_for_async_op()
 =

+    @property
+    def enabled(self):
+        return self._properties['Enabled']
+
+    @enabled.setter
+    def enabled(self, value):
+        self._prop_proxy.Set(self._iface_name, 'Enabled', value,
+                            reply_handler=3Dself._success, error_handler=
=3Dself._failure)
+        self._wait_for_async_op()
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.31.1

--===============5395030768957051105==--

