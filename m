Content-Type: multipart/mixed; boundary="===============7078594836907205198=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] auto-t: speed up testRoamRetry
Date: Fri, 13 Aug 2021 12:47:10 -0700
Message-ID: <20210813194710.807550-3-prestwoj@gmail.com>
In-Reply-To: <20210813194710.807550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7078594836907205198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test took quite a while to execute (~2 minutes on my machine)
because there was simply no other way to test this scenario but
waiting. Now the no-roam-candidates condition can be waited for
rather than just sleeping for 20 seconds. Additionally the default
RoamRetryInterval was being used which is 60 seconds. Instead
main.conf can set this to 5 seconds and really cut down on the time
to wait.

Part of a comment was also removed due to being incorrect. Even
with neighbor reports IWD still must scan, its just that the
scan is more limited and, in theory, faster.
---
 autotests/testRoamRetry/fast_retry_test.py | 7 +++----
 autotests/testRoamRetry/main.conf          | 2 ++
 autotests/testRoamRetry/stop_retry_test.py | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)
 create mode 100644 autotests/testRoamRetry/main.conf

diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
index d6324c31..e8b5455d 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -82,7 +82,7 @@ class Test(unittest.TestCase):
         # schedule another attempt for 60 seconds later
         rule0.signal =3D -8000
 =

-        wd.wait(20)
+        device.wait_for_event('no-roam-candidates')
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[0].list_sta())
@@ -99,13 +99,12 @@ class Test(unittest.TestCase):
         wd.wait(1)
 =

         # Assert low signal for BSS 0, check that iwd starts transition to=
 BSS 1
-        # in less than 10 seconds. Because of the neighbor report a scan s=
hould
-        # not be necessary.
+        # in less than 10 seconds.
         rule0.signal =3D -8000
         rule1.signal =3D -2000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, max_wait=3D10)
+        wd.wait_for_object_condition(device, condition, max_wait=3D15)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
diff --git a/autotests/testRoamRetry/main.conf b/autotests/testRoamRetry/ma=
in.conf
new file mode 100644
index 00000000..f0d1c0f4
--- /dev/null
+++ b/autotests/testRoamRetry/main.conf
@@ -0,0 +1,2 @@
+[General]
+RoamRetryInterval=3D5
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
index be9776a5..3bf166d8 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -99,7 +99,7 @@ class Test(unittest.TestCase):
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         self.assertRaises(TimeoutError, wd.wait_for_object_condition, devi=
ce,
-                          condition, max_wait=3D70)
+                          condition, max_wait=3D10)
 =

         device.disconnect()
 =

-- =

2.31.1

--===============7078594836907205198==--

