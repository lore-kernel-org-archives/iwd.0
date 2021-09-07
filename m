Content-Type: multipart/mixed; boundary="===============7398226540517514375=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] auto-t: hwsim.py: add match_times property
Date: Tue, 07 Sep 2021 14:14:43 -0700
Message-ID: <20210907211450.27270-2-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7398226540517514375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hwsim.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index cc62495c..496c06a0 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -153,6 +153,14 @@ class Rule(HwsimDBusAbstract):
                             reply_handler=3Dself._success, error_handler=
=3Dself._failure)
         self._wait_for_async_op()
 =

+    @property
+    def match_times(self):
+        return self._properties['MatchTimes']
+
+    @match_times.setter
+    def match_times(self, value):
+        self._prop_proxy.Set(self._iface_name, 'MatchTimes', dbus.UInt16(v=
alue))
+
     def remove(self):
         self._iface.Remove(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
-- =

2.31.1

--===============7398226540517514375==--

