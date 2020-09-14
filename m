Content-Type: multipart/mixed; boundary="===============6543955607942123619=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: don't clear out rules from hwsim object
Date: Mon, 14 Sep 2020 14:02:31 -0700
Message-ID: <20200914210233.428835-2-prestwoj@gmail.com>
In-Reply-To: <20200914210233.428835-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6543955607942123619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This got added in the re-write but a __del__ method was also
added to the Rule class as well. This caused problems if hwsim
cleaned up since it removed the rules, which caused each rule
to call __del__. Since the rule had already been removed there
was no longer a DBus interface which raised an exception.
---
 autotests/util/hwsim.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index cf1ab536..4f41952f 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -274,10 +274,6 @@ class Hwsim(iwd.AsyncOpAbstract):
         self._rules =3D RuleSet(self, objects)
         self._radios =3D RadioList(self, objects)
 =

-    def __del__(self):
-        for rule in self._rules.values():
-            rule.remove()
-
     @property
     def rules(self):
         return self._rules
-- =

2.26.2

--===============6543955607942123619==--

