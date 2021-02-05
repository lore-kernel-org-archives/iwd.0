Content-Type: multipart/mixed; boundary="===============6430611328400578093=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: fix SAQuery-spoofing test
Date: Fri, 05 Feb 2021 10:09:11 -0800
Message-ID: <20210205180911.320809-3-prestwoj@gmail.com>
In-Reply-To: <20210205180911.320809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6430611328400578093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test occationally failed due to a badly timed DBus scan
triggering right when hwsim tried sending out the spoofed frame.
This caused mac80211_hwsim to reject CMD_FRAME when the timing
was just right.

Rather than always starting a DBus scan we can rely on periodic
scans and only DBus scan if there are no networks in IWD's list.
A scanning check was also added prior to sending out the frame
and if true we wait for not scanning. This is more paranoia than
anything.
---
 .../testSAQuery-spoofing/connection_test.py      | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index 7ad96d4f..a1e84de6 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -32,12 +32,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidCCMP')
+        ordered_network =3D device.get_ordered_network('ssidCCMP', scan_if=
_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -49,9 +44,12 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        # TODO: for some reason hostapd does not respond to SA query if do=
ne
-        #       too soon after connection.
-        sleep(1)
+        # Ensure IWD is not scanning. This causes problems with mac80211_h=
wsim
+        # where CMD_FRAME will fail during a scan. This is due to the fram=
e not
+        # having the same frequency as the radio (since hwsim is off-chann=
el)
+        if device.scanning:
+            condition =3D 'not obj.scanning'
+            wd.wait_for_object_condition(device, condition)
 =

         # Spoof a disassociate frame. This will kick off SA Query procedur=
e.
         hwsim.spoof_disassociate(radio, hostapd.get_freq(), device.address)
-- =

2.26.2

--===============6430611328400578093==--

