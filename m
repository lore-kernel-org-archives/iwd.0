Content-Type: multipart/mixed; boundary="===============4268121284848690042=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] auto-t: remove unneeded hidden networks
Date: Thu, 29 Jul 2021 15:21:52 -0700
Message-ID: <20210729222154.159542-7-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4268121284848690042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

testScan was creating 10 separate hidden networks which
sometimes bogged down hostapd to the point that it would
not start up in time before test-runner's timeouts fired.
This appeared to be due to hostapd needing to create 10
separate interfaces which would sometimes fail with -ENFILE.

The test itself only needed two separate networks, so instead
the additional 8 can be completely removed.
---
 autotests/testScan/hw.conf                | 11 +++---
 autotests/testScan/periodic_scan_test.py  | 12 ++-----
 autotests/testScan/requested_scan_test.py |  8 -----
 autotests/testScan/ssid_hidden.conf       | 41 -----------------------
 autotests/testScan/ssid_hidden_0.conf     |  4 +++
 autotests/testScan/ssid_hidden_1.conf     |  4 +++
 autotests/testScan/ssid_hidden_2.open     |  3 --
 autotests/testScan/ssid_hidden_3.open     |  3 --
 autotests/testScan/ssid_hidden_4.open     |  3 --
 autotests/testScan/ssid_hidden_5.open     |  3 --
 autotests/testScan/ssid_hidden_6.open     |  3 --
 autotests/testScan/ssid_hidden_7.open     |  3 --
 autotests/testScan/ssid_hidden_8.open     |  3 --
 autotests/testScan/ssid_hidden_9.open     |  3 --
 14 files changed, 16 insertions(+), 88 deletions(-)
 delete mode 100644 autotests/testScan/ssid_hidden.conf
 create mode 100644 autotests/testScan/ssid_hidden_0.conf
 create mode 100644 autotests/testScan/ssid_hidden_1.conf
 delete mode 100644 autotests/testScan/ssid_hidden_2.open
 delete mode 100644 autotests/testScan/ssid_hidden_3.open
 delete mode 100644 autotests/testScan/ssid_hidden_4.open
 delete mode 100644 autotests/testScan/ssid_hidden_5.open
 delete mode 100644 autotests/testScan/ssid_hidden_6.open
 delete mode 100644 autotests/testScan/ssid_hidden_7.open
 delete mode 100644 autotests/testScan/ssid_hidden_8.open
 delete mode 100644 autotests/testScan/ssid_hidden_9.open

diff --git a/autotests/testScan/hw.conf b/autotests/testScan/hw.conf
index b2464baf..660c874e 100644
--- a/autotests/testScan/hw.conf
+++ b/autotests/testScan/hw.conf
@@ -1,9 +1,10 @@
 [SETUP]
-num_radios=3D5
+num_radios=3D6
 start_iwd=3D0
 =

 [HOSTAPD]
-rad0=3Dssid_hidden.conf
-rad1=3Dssid_open.conf
-rad2=3Dssid_8021x.conf
-rad3=3Dssid_psk.conf
+rad0=3Dssid_hidden_0.conf
+rad1=3Dssid_hidden_1.conf
+rad2=3Dssid_open.conf
+rad3=3Dssid_8021x.conf
+rad4=3Dssid_psk.conf
diff --git a/autotests/testScan/periodic_scan_test.py b/autotests/testScan/=
periodic_scan_test.py
index 3252f79f..439b844d 100644
--- a/autotests/testScan/periodic_scan_test.py
+++ b/autotests/testScan/periodic_scan_test.py
@@ -12,11 +12,7 @@ class Test(unittest.TestCase):
         'ssid_open': False,
         'ssid_psk': False,
         'ssid_8021x': False,
-        'ssid_hidden_5': False,
-        'ssid_hidden_6': False,
-        'ssid_hidden_7': False,
-        'ssid_hidden_8': False,
-        'ssid_hidden_9': False,
+        'ssid_hidden_1': False,
     }
 =

     def set_network(self, ssid):
@@ -61,11 +57,7 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        IWD.copy_to_storage('ssid_hidden_5.open')
-        IWD.copy_to_storage('ssid_hidden_6.open')
-        IWD.copy_to_storage('ssid_hidden_7.open')
-        IWD.copy_to_storage('ssid_hidden_8.open')
-        IWD.copy_to_storage('ssid_hidden_9.open')
+        IWD.copy_to_storage('ssid_hidden_1.open')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testScan/requested_scan_test.py b/autotests/testScan=
/requested_scan_test.py
index 3858b4f5..69297f27 100644
--- a/autotests/testScan/requested_scan_test.py
+++ b/autotests/testScan/requested_scan_test.py
@@ -15,10 +15,6 @@ class Test(unittest.TestCase):
         'ssid_psk': False,
         'ssid_8021x': False,
         'ssid_hidden_0': False,
-        'ssid_hidden_1': False,
-        'ssid_hidden_2': False,
-        'ssid_hidden_3': False,
-        'ssid_hidden_4': False,
     }
 =

     def set_network(self, ssid):
@@ -63,10 +59,6 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssid_hidden_0.open')
-        IWD.copy_to_storage('ssid_hidden_1.open')
-        IWD.copy_to_storage('ssid_hidden_2.open')
-        IWD.copy_to_storage('ssid_hidden_3.open')
-        IWD.copy_to_storage('ssid_hidden_4.open')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testScan/ssid_hidden.conf b/autotests/testScan/ssid_=
hidden.conf
deleted file mode 100644
index 2dfed56f..00000000
--- a/autotests/testScan/ssid_hidden.conf
+++ /dev/null
@@ -1,41 +0,0 @@
-ssid=3Dssid_hidden_0
-interface=3Dwln0
-hw_mode=3Dg
-channel=3D1
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_1
-ssid=3Dssid_hidden_1
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_2
-ssid=3Dssid_hidden_2
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_3
-ssid=3Dssid_hidden_3
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_4
-ssid=3Dssid_hidden_4
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_5
-ssid=3Dssid_hidden_5
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_6
-ssid=3Dssid_hidden_6
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_7
-ssid=3Dssid_hidden_7
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_8
-ssid=3Dssid_hidden_8
-ignore_broadcast_ssid=3D1
-
-bss=3Dwln0_9
-ssid=3Dssid_hidden_9
-ignore_broadcast_ssid=3D1
diff --git a/autotests/testScan/ssid_hidden_0.conf b/autotests/testScan/ssi=
d_hidden_0.conf
new file mode 100644
index 00000000..5d15e360
--- /dev/null
+++ b/autotests/testScan/ssid_hidden_0.conf
@@ -0,0 +1,4 @@
+ssid=3Dssid_hidden_0
+hw_mode=3Dg
+channel=3D1
+ignore_broadcast_ssid=3D1
diff --git a/autotests/testScan/ssid_hidden_1.conf b/autotests/testScan/ssi=
d_hidden_1.conf
new file mode 100644
index 00000000..cc11803f
--- /dev/null
+++ b/autotests/testScan/ssid_hidden_1.conf
@@ -0,0 +1,4 @@
+ssid=3Dssid_hidden_1
+hw_mode=3Dg
+channel=3D1
+ignore_broadcast_ssid=3D1
diff --git a/autotests/testScan/ssid_hidden_2.open b/autotests/testScan/ssi=
d_hidden_2.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_2.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_3.open b/autotests/testScan/ssi=
d_hidden_3.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_3.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_4.open b/autotests/testScan/ssi=
d_hidden_4.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_4.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_5.open b/autotests/testScan/ssi=
d_hidden_5.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_5.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_6.open b/autotests/testScan/ssi=
d_hidden_6.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_6.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_7.open b/autotests/testScan/ssi=
d_hidden_7.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_7.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_8.open b/autotests/testScan/ssi=
d_hidden_8.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_8.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
diff --git a/autotests/testScan/ssid_hidden_9.open b/autotests/testScan/ssi=
d_hidden_9.open
deleted file mode 100644
index 28622594..00000000
--- a/autotests/testScan/ssid_hidden_9.open
+++ /dev/null
@@ -1,3 +0,0 @@
-[Settings]
-AutoConnect=3Dfalse
-Hidden=3Dtrue
-- =

2.31.1

--===============4268121284848690042==--

