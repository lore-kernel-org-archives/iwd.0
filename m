Content-Type: multipart/mixed; boundary="===============6039378988665098466=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: change blacklist test RSSI values
Date: Tue, 05 May 2020 09:03:18 -0700
Message-ID: <20200505160318.26419-2-prestwoj@gmail.com>
In-Reply-To: <20200505160318.26419-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6039378988665098466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These values were meant only to force IWD's BSS preference but
since the RSSI's were so low in some cases this caused a roam
immediately after connecting. This patch changes the RSSI values
to prevent a roam from happening.
---
 autotests/testBSSBlacklist/bad_pass_test.py   | 4 ++--
 autotests/testBSSBlacklist/connection_test.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index 3de47719..3516f3be 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -36,12 +36,12 @@ class Test(unittest.TestCase):
         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
-        rule1.signal =3D -8000
+        rule1.signal =3D -3000
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
-        rule2.signal =3D -10000
+        rule2.signal =3D -4000
 =

         wd =3D IWD(True, '/tmp')
 =

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index ee169826..917f3192 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -36,12 +36,12 @@ class Test(unittest.TestCase):
         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
-        rule1.signal =3D -8000
+        rule1.signal =3D -3000
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
-        rule2.signal =3D -10000
+        rule2.signal =3D -4000
 =

         wd =3D IWD(True, '/tmp')
 =

-- =

2.21.1

--===============6039378988665098466==--

