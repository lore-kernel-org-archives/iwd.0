Content-Type: multipart/mixed; boundary="===============1220918590026758471=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/6] auto-t: block auth frames for FT-over-DS test
Date: Tue, 28 Sep 2021 15:36:06 -0700
Message-ID: <20210928223609.1163537-3-prestwoj@gmail.com>
In-Reply-To: 20210928223609.1163537-1-prestwoj@gmail.com

--===============1220918590026758471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The FT-over-DS test was allowed to fail as it stood. If FT-over-DS
failed it would just do a normal over-Air transition which satisfied
all the checks. To prevent this Authenticate frames are blocked after
the initial connection so if FT-over-DS fails there is no other way
to roam.
---
 autotests/testPSK-roam/connection_test.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index 918cceb0..f9306a57 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -59,6 +59,9 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

+        if over_ds:
+            self.rule0.enabled =3D True
+
         device.roam(self.bss_hostapd[1].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
@@ -150,12 +153,24 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

+        self.rule0.enabled =3D False
+
     @classmethod
     def setUpClass(cls):
+        hwsim =3D Hwsim()
+
         IWD.copy_to_storage('TestFT.psk')
 =

         cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-psk-ccmp-1.conf'),
                             HostapdCLI(config=3D'ft-psk-ccmp-2.conf') ]
+        rad2 =3D hwsim.get_radio('rad2')
+
+        cls.rule0 =3D hwsim.rules.create()
+        cls.rule0.source =3D rad2.addresses[0]
+        cls.rule0.bidirectional =3D True
+        cls.rule0.signal =3D -2000
+        cls.rule0.prefix =3D 'b0'
+        cls.rule0.drop =3D True
 =

         # Set interface addresses to those expected by hostapd config files
         os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-- =

2.31.1

--===============1220918590026758471==--

