Content-Type: multipart/mixed; boundary="===============7847241278537320166=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 8/8] auto-t: don't wait for wpa_supplicant to connect
Date: Tue, 22 Mar 2022 15:51:13 -0700
Message-ID: <20220322225113.1023688-8-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============7847241278537320166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When configuring wpa_supplicant all we care about is that it
received the configuration object. wpa_supplicant takes quite a bit
of time to connect in some cases so waiting for that is unneeded.

This also increases the DPP timeout which may be required on slower
systems or if the timing is particularly unlucky when receiving
frames.
---
 autotests/testDPP/connection_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index b58620b8..ab3cbf95 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -80,7 +80,7 @@ class Test(unittest.TestCase):
 =

         self.wpas.dpp_enrollee_start(uri)
 =

-        self.wpas.wait_for_event('DPP-CONF-RECEIVED')
+        self.wpas.wait_for_event('DPP-CONF-RECEIVED', timeout=3D30)
 =

     def test_iwd_as_configurator_initiator(self):
         self.hapd.reload()
@@ -96,7 +96,7 @@ class Test(unittest.TestCase):
 =

         self.device.dpp_start_configurator(uri)
 =

-        self.hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
+        self.wpas.wait_for_event('DPP-CONF-RECEIVED', timeout=3D30)
 =

     def setUp(self):
         self.wd =3D IWD(True)
@@ -118,6 +118,7 @@ class Test(unittest.TestCase):
         self.device.disconnect()
         self.device.dpp_stop()
         self.wpas.dpp_configurator_remove()
+        self.wpas.clean_up()
 =

         self.wd =3D None
         self.device =3D None
-- =

2.34.1

--===============7847241278537320166==--

