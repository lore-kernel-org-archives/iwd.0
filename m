Content-Type: multipart/mixed; boundary="===============0347511731330735068=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: add missing ocv option and wait to testChannelSwitch
Date: Tue, 19 Oct 2021 12:02:32 -0700
Message-ID: <20211019190232.560446-1-prestwoj@gmail.com>

--===============0347511731330735068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This should have been added to the original test
---
 autotests/testChannelSwitch/connection_test.py | 4 ++++
 autotests/testChannelSwitch/ssidCCMP.conf      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/autotests/testChannelSwitch/connection_test.py b/autotests/tes=
tChannelSwitch/connection_test.py
index e5421c69..03d24a77 100644
--- a/autotests/testChannelSwitch/connection_test.py
+++ b/autotests/testChannelSwitch/connection_test.py
@@ -39,6 +39,10 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected()
 =

         hapd.chan_switch(2)
+        # Make sure the SA Query is verified and IWD doesn't disconnect
+        with self.assertRaises(TimeoutError):
+            condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+            wd.wait_for_object_condition(device, condition, 4)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testChannelSwitch/ssidCCMP.conf b/autotests/testChan=
nelSwitch/ssidCCMP.conf
index 074e8228..438b9955 100644
--- a/autotests/testChannelSwitch/ssidCCMP.conf
+++ b/autotests/testChannelSwitch/ssidCCMP.conf
@@ -5,3 +5,4 @@ ssid=3DssidCCMP
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+ocv=3D1
-- =

2.31.1

--===============0347511731330735068==--

