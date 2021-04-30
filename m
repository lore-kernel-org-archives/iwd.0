Content-Type: multipart/mixed; boundary="===============6598634432629266554=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: add FT-back to original AP on FT-PSK-roam
Date: Fri, 30 Apr 2021 11:20:36 -0700
Message-ID: <20210430182036.273912-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6598634432629266554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testFT-PSK-roam/connection_test.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 37c6da18..7399e5e1 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -98,6 +98,25 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
 =

+        rule0.signal =3D -2000
+        rule1.signal =3D -8000
+
+        condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition)
+
+        # Check that iwd is on BSS 0 once out of roaming state and doesn't
+        # go through 'disconnected', 'autoconnect', 'connecting' in between
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
+
+        self.assertTrue(self.bss_hostapd[0].list_sta())
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.=
name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[1].ifname, device.name))
+
     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-- =

2.26.2

--===============6598634432629266554==--

