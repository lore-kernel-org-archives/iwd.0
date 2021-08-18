Content-Type: multipart/mixed; boundary="===============7961031425857325232=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] hwsim: add Rule.remove_all()
Date: Wed, 18 Aug 2021 10:26:01 -0700
Message-ID: <20210818172603.266294-2-prestwoj@gmail.com>
In-Reply-To: <20210818172603.266294-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7961031425857325232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are really no cases where a test wants to remove a single
rule. Most loop through and remove rules individually so this
is being added as a convenience.
---
 autotests/util/hwsim.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 320e9dfa..4e3b8ec2 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -202,6 +202,10 @@ class RuleSet(collections.Mapping):
         self._dict[path] =3D obj
         return obj
 =

+    def remove_all(self):
+        for rule in self._dict.values():
+            rule.remove()
+
 class Radio(HwsimDBusAbstract):
     _iface_name =3D HWSIM_RADIO_INTERFACE
 =

-- =

2.31.1

--===============7961031425857325232==--

