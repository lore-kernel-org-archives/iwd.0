Content-Type: multipart/mixed; boundary="===============3732577976557962910=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/6] auto-t: rekey in FT/FILS tests
Date: Tue, 28 Sep 2021 15:36:09 -0700
Message-ID: <20210928223609.1163537-6-prestwoj@gmail.com>
In-Reply-To: 20210928223609.1163537-1-prestwoj@gmail.com

--===============3732577976557962910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testFILS/fils_256_test.py       | 3 +++
 autotests/testFILS/fils_384_test.py       | 3 +++
 autotests/testFT-FILS/connection_test.py  | 3 +++
 autotests/testPSK-roam/connection_test.py | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index 62de581b..02fad28e 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -55,6 +55,9 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

+        hapd.rekey(device.address)
+        hapd.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+
         device.disconnect()
 =

     @classmethod
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index 8df5554c..8ecd2fec 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -55,6 +55,9 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

+        hapd.rekey(device.address)
+        hapd.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+
         device.disconnect()
 =

     @classmethod
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FI=
LS/connection_test.py
index b136cb7b..d1389cea 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -95,6 +95,9 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

+        self.bss_hostapd[1].rekey(device.address)
+        self.bss_hostapd[1].wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+
     def test_fils_ft_roam_sha256(self):
         wd =3D IWD(True)
 =

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index f9306a57..d1beb010 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -80,6 +80,9 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

+        self.bss_hostapd[1].rekey(device.address)
+        self.bss_hostapd[1].wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+
         device.roam(self.bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-- =

2.31.1

--===============3732577976557962910==--

