Content-Type: multipart/mixed; boundary="===============0726834670245468592=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: turn off scan address randomization in testHotspot
Date: Fri, 13 Aug 2021 15:45:53 -0700
Message-ID: <20210813224554.816379-3-prestwoj@gmail.com>
In-Reply-To: <20210813224554.816379-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0726834670245468592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This (hopefully) will make this test pass better on slower machines.
In addition the mechanism of copying over separate main.conf files
was changed (rather than echo'ing the option into /tmp/main.conf)
---
 autotests/testHotspot/anqp_delay_test.py  | 5 ++---
 autotests/testHotspot/anqp_disabled.conf  | 5 +++++
 autotests/testHotspot/anqp_enabled.conf   | 5 +++++
 autotests/testHotspot/autoconnect_test.py | 5 ++---
 autotests/testHotspot/hessid_test.py      | 5 ++---
 autotests/testHotspot/hotspot_test.py     | 5 ++---
 autotests/testHotspot/roaming_test.py     | 5 ++---
 7 files changed, 20 insertions(+), 15 deletions(-)
 create mode 100644 autotests/testHotspot/anqp_disabled.conf
 create mode 100644 autotests/testHotspot/anqp_enabled.conf

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index 323e1fd3..04e5a1d7 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -5,8 +5,8 @@ import sys
 import os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
@@ -87,8 +87,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('example.conf')
-        conf =3D '[General]\nDisableANQP=3D0\n'
-        os.system('echo "%s" > /tmp/main.conf' % conf)
+        IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testHotspot/anqp_disabled.conf b/autotests/testHotsp=
ot/anqp_disabled.conf
new file mode 100644
index 00000000..b18f66d7
--- /dev/null
+++ b/autotests/testHotspot/anqp_disabled.conf
@@ -0,0 +1,5 @@
+[General]
+DisableANQP=3D1
+
+[Scan]
+DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testHotspot/anqp_enabled.conf b/autotests/testHotspo=
t/anqp_enabled.conf
new file mode 100644
index 00000000..c66a63e0
--- /dev/null
+++ b/autotests/testHotspot/anqp_enabled.conf
@@ -0,0 +1,5 @@
+[General]
+DisableANQP=3D0
+
+[Scan]
+DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index 354bf61b..777a0670 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -5,8 +5,8 @@ import sys
 import os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import IWD_CONFIG_DIR
 from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
@@ -109,8 +109,7 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         IWD.copy_to_hotspot('autoconnect.conf')
         IWD.copy_to_storage('ssidWPA2-1.psk')
-        conf =3D '[General]\nDisableANQP=3D0\n'
-        os.system('echo "%s" > /tmp/main.conf' % conf)
+        IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/h=
essid_test.py
index 5d3954b9..88e750de 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_test.py
@@ -5,8 +5,8 @@ import sys
 import os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
@@ -50,8 +50,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('hessid.conf')
-        conf =3D '[General]\nDisableANQP=3D1\n'
-        os.system('echo "%s" > /tmp/main.conf' % conf)
+        IWD.copy_to_storage('anqp_disabled.conf', storage_dir=3DIWD_CONFIG=
_DIR, name=3D'main.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_test.py
index 460ff89f..f49477dc 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -5,8 +5,8 @@ import sys
 import os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
@@ -50,8 +50,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('example.conf')
-        conf =3D '[General]\nDisableANQP=3D0\n'
-        os.system('echo "%s" > /tmp/main.conf' % conf)
+        IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/=
roaming_test.py
index d18864e0..6cdd6922 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_test.py
@@ -5,8 +5,8 @@ import sys
 import os
 =

 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
@@ -50,8 +50,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('roaming.conf')
-        conf =3D '[General]\nDisableANQP=3D1\n'
-        os.system('echo "%s" > /tmp/main.conf' % conf)
+        IWD.copy_to_storage('anqp_disabled.conf', storage_dir=3DIWD_CONFIG=
_DIR, name=3D'main.conf')
 =

     @classmethod
     def tearDownClass(cls):
-- =

2.31.1

--===============0726834670245468592==--

