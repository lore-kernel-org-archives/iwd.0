Content-Type: multipart/mixed; boundary="===============2761712300062439389=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: remove hwsim rules on __del__
Date: Fri, 11 Sep 2020 11:11:29 -0700
Message-ID: <20200911181130.73148-2-prestwoj@gmail.com>
In-Reply-To: <20200911181130.73148-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2761712300062439389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents previous tests rules from carrying over into
future tests.
---
 autotests/util/hwsim.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index a0ddedcd..cf1ab536 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -240,6 +240,9 @@ class RadioList(collections.Mapping):
     def __delitem__(self, key):
         self._dict.pop(key).remove()
 =

+    def values(self):
+        return self._dict.values()
+
     def _interfaces_added_handler(self, path, interfaces):
         self._dict[path] =3D Radio(interfaces[HWSIM_RADIO_INTERFACE])
 =

@@ -271,6 +274,10 @@ class Hwsim(iwd.AsyncOpAbstract):
         self._rules =3D RuleSet(self, objects)
         self._radios =3D RadioList(self, objects)
 =

+    def __del__(self):
+        for rule in self._rules.values():
+            rule.remove()
+
     @property
     def rules(self):
         return self._rules
-- =

2.26.2

--===============2761712300062439389==--

