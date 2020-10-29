Content-Type: multipart/mixed; boundary="===============5299973978258980029=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix hotspot autoconnect test
Date: Thu, 29 Oct 2020 09:19:02 -0700
Message-ID: <20201029161902.2371076-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5299973978258980029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test was removing files in /var/lib/iwd which is no longer
mounted read/write (nor are config files put there anymore).
---
 autotests/testHotspot/autoconnect_test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index 252a4b92..b8caa7fb 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -47,7 +47,7 @@ class Test(unittest.TestCase):
         #
         # Remove provisioning file, this should cause a disconnect.
         #
-        os.remove("/var/lib/iwd/ssidWPA2-1.psk")
+        os.remove("/tmp/iwd/ssidWPA2-1.psk")
 =

         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
@@ -74,7 +74,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd_hotspot.ifname)
 =

-        os.remove('/var/lib/iwd/hotspot/autoconnect.conf')
+        os.remove('/tmp/iwd/hotspot/autoconnect.conf')
 =

         #
         # make sure removal of hotspot conf file resulted in disconnect
-- =

2.26.2

--===============5299973978258980029==--

