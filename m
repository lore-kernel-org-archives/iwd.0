Content-Type: multipart/mixed; boundary="===============0637229923009971099=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] auto-t: update tests to enable hwsim rules
Date: Wed, 18 Aug 2021 15:09:33 -0700
Message-ID: <20210818220934.295721-7-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0637229923009971099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testHT-VHT/connection_test.py    | 3 +++
 autotests/testOWE/timeout_test.py          | 2 ++
 autotests/testRSSIAgent/connection_test.py | 1 +
 autotests/testRoamRetry/fast_retry_test.py | 2 ++
 autotests/testRoamRetry/stop_retry_test.py | 2 ++
 autotests/testSAE/timeout_test.py          | 1 +
 6 files changed, 11 insertions(+)

diff --git a/autotests/testHT-VHT/connection_test.py b/autotests/testHT-VHT=
/connection_test.py
index 3d190509..051822c2 100644
--- a/autotests/testHT-VHT/connection_test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -66,16 +66,19 @@ class Test(unittest.TestCase):
         rule0.source =3D vht_radio.addresses[0]
         rule0.bidirectional =3D True
         rule0.signal =3D -5100
+        rule0.enabled =3D True
 =

         rule1 =3D hwsim.rules.create()
         rule1.source =3D ht_radio.addresses[0]
         rule1.bidirectional =3D True
         rule1.signal =3D -5200
+        rule1.enabled =3D True
 =

         rule2 =3D hwsim.rules.create()
         rule2.source =3D non_ht_radio.addresses[0]
         rule2.bidirectional =3D True
         rule2.signal =3D -5300
+        rule2.enabled =3D True
 =

         wd =3D IWD()
 =

diff --git a/autotests/testOWE/timeout_test.py b/autotests/testOWE/timeout_=
test.py
index fbf79f4c..96d367b3 100644
--- a/autotests/testOWE/timeout_test.py
+++ b/autotests/testOWE/timeout_test.py
@@ -39,12 +39,14 @@ class Test(unittest.TestCase):
         rule0.bidirectional =3D True
         rule0.drop =3D True
         rule0.prefix =3D 'b0'
+        rule0.enabled =3D True
 =

         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio1.addresses[0]
         rule1.bidirectional =3D True
         rule1.drop =3D True
         rule1.prefix =3D 'b0'
+        rule1.enabled =3D True
 =

         # Test Authenticate (b0) and Association (00) timeouts
 =

diff --git a/autotests/testRSSIAgent/connection_test.py b/autotests/testRSS=
IAgent/connection_test.py
index f485b388..ded09f6c 100644
--- a/autotests/testRSSIAgent/connection_test.py
+++ b/autotests/testRSSIAgent/connection_test.py
@@ -20,6 +20,7 @@ class Test(unittest.TestCase):
     def test_rssi_agent(self):
         rule =3D Hwsim().rules.create()
         rule.signal =3D -4000
+        rule.enabled =3D True
 =

         wd =3D IWD()
 =

diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
index e8b5455d..c7de5055 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -29,10 +29,12 @@ class Test(unittest.TestCase):
         rule0 =3D hwsim.rules.create()
         rule0.source =3D bss_radio[0].addresses[0]
         rule0.bidirectional =3D True
+        rule0.enabled =3D True
 =

         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
+        rule1.enabled =3D True
 =

         # Fill in the neighbor AP tables in both BSSes.  By default each
         # instance knows only about current BSS, even inside one hostapd
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
index 3bf166d8..f2f95990 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -28,10 +28,12 @@ class Test(unittest.TestCase):
         rule0 =3D hwsim.rules.create()
         rule0.source =3D bss_radio[0].addresses[0]
         rule0.bidirectional =3D True
+        rule0.enabled =3D True
 =

         rule1 =3D hwsim.rules.create()
         rule1.source =3D bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
+        rule1.enabled =3D True
 =

         # Fill in the neighbor AP tables in both BSSes.  By default each
         # instance knows only about current BSS, even inside one hostapd
diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index 28ff288c..abef109b 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -35,6 +35,7 @@ class Test(unittest.TestCase):
         rule0.bidirectional =3D True
         rule0.drop =3D True
         rule0.prefix =3D 'b0'
+        rule0.enabled =3D True
 =

         wd.wait(1)
         print(rule0)
-- =

2.31.1

--===============0637229923009971099==--

