Content-Type: multipart/mixed; boundary="===============7590001013153847090=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: fix blacklist test ranking
Date: Tue, 27 Jul 2021 15:11:28 -0700
Message-ID: <20210727221128.33131-2-prestwoj@gmail.com>
In-Reply-To: <20210727221128.33131-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7590001013153847090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The scan ranking logic was previously changed to be based off a
theoretical calculated data rate rather than signal strength.
For HT/VHT networks there are many data points that can be used
for this calculation, but non HT/VHT networks are estimated based
on a simple table mapping signal strengths to data rates.

This table starts at a signal strength of -65 dBm and decreases from
there, meaning any signal strengths greater than -65 dBm will end up
getting the same ranking. This poses a problem for 3/4 blacklisting
tests as they set signal strengths ranging from -20 to -40 dBm.
IWD will then autoconnect to whatever network popped up first, which
may not be the expected network.

To fix this the signal strengths were changed to much lower values
which ensures IWD picks the expected network.
---
 autotests/testBSSBlacklist/bad_pass_test.py       | 4 ++--
 autotests/testBSSBlacklist/connection_test.py     | 4 ++--
 autotests/testBSSBlacklist/temp_blacklist_test.py | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index b0a81991..1d41f390 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -32,12 +32,12 @@ class Test(unittest.TestCase):
         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
-        rule1.signal =3D -3000
+        rule1.signal =3D -7000
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
-        rule2.signal =3D -4000
+        rule2.signal =3D -8000
 =

         wd =3D IWD(True)
 =

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 111ae582..58931d3e 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -34,12 +34,12 @@ class Test(unittest.TestCase):
         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
-        rule1.signal =3D -3000
+        rule1.signal =3D -7000
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
-        rule2.signal =3D -4000
+        rule2.signal =3D -8000
 =

         wd =3D IWD(True)
 =

diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
index efb848e9..02438f89 100644
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ b/autotests/testBSSBlacklist/temp_blacklist_test.py
@@ -32,7 +32,7 @@ class Test(unittest.TestCase):
         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
-        rule1.signal =3D -2500
+        rule1.signal =3D -7000
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
-- =

2.31.1

--===============7590001013153847090==--

