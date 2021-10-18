Content-Type: multipart/mixed; boundary="===============0657177468348464839=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] auto-t: SAQuery-spoofing replace sleep with condition wait
Date: Mon, 18 Oct 2021 15:33:58 -0700
Message-ID: <20211018223359.497849-3-prestwoj@gmail.com>
In-Reply-To: 20211018223359.497849-1-prestwoj@gmail.com

--===============0657177468348464839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By sleeping for 4 seconds IWD had plenty of time to fully disconnect
and reconnect in time to pass the final "connected" check. Instead
use wait_for_object_condition to wait for disconnected and expect
this to fail. This will let the test fail if IWD disconnects.
---
 autotests/testSAQuery-spoofing/connection_test.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index f64a93f7..0ff0615f 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -51,8 +51,10 @@ class Test(unittest.TestCase):
         # Spoof a disassociate frame. This will kick off SA Query procedur=
e.
         hwsim.spoof_disassociate(radio, hostapd.frequency, device.address)
 =

-        # sleep to ensure hostapd responds and SA Query does not timeout
-        sleep(4)
+        # ensure hostapd responds and SA Query does not timeout
+        with self.assertRaises(TimeoutError):
+            condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+            wd.wait_for_object_condition(device, condition, 4)
 =

         # Since disassociate was spoofed we should still be connected
         condition =3D 'obj.state =3D=3D DeviceState.connected'
-- =

2.31.1

--===============0657177468348464839==--

