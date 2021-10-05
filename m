Content-Type: multipart/mixed; boundary="===============5411708955329024295=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 11/11] auto-t: update rekey() use to not wait for event
Date: Tue, 05 Oct 2021 15:00:51 -0700
Message-ID: <20211005220051.4018694-11-prestwoj@gmail.com>
In-Reply-To: 20211005220051.4018694-1-prestwoj@gmail.com

--===============5411708955329024295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hostapd event wait was moved into rekey() itself.
---
 autotests/testFILS/fils_256_test.py       | 1 -
 autotests/testFILS/fils_384_test.py       | 1 -
 autotests/testFT-FILS/connection_test.py  | 1 -
 autotests/testPSK-roam/connection_test.py | 1 -
 4 files changed, 4 deletions(-)

diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index 02fad28e..a4e58715 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -56,7 +56,6 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

         hapd.rekey(device.address)
-        hapd.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
 =

         device.disconnect()
 =

diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index 8ecd2fec..e6550a17 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -56,7 +56,6 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

         hapd.rekey(device.address)
-        hapd.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
 =

         device.disconnect()
 =

diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FI=
LS/connection_test.py
index d1389cea..14025a3b 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -96,7 +96,6 @@ class Test(unittest.TestCase):
                           (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

         self.bss_hostapd[1].rekey(device.address)
-        self.bss_hostapd[1].wait_for_event('EAPOL-4WAY-HS-COMPLETED')
 =

     def test_fils_ft_roam_sha256(self):
         wd =3D IWD(True)
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index d1beb010..ee50e4a7 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -81,7 +81,6 @@ class Test(unittest.TestCase):
                           (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

         self.bss_hostapd[1].rekey(device.address)
-        self.bss_hostapd[1].wait_for_event('EAPOL-4WAY-HS-COMPLETED')
 =

         device.roam(self.bss_hostapd[0].bssid)
 =

-- =

2.31.1

--===============5411708955329024295==--

