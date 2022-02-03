Content-Type: multipart/mixed; boundary="===============5168924501699699688=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: only wait for wpa_s to get the DPP configuration
Date: Thu, 03 Feb 2022 11:43:20 -0800
Message-ID: <20220203194320.96759-1-prestwoj@gmail.com>

--===============5168924501699699688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As far as wpa_supplicant goes we don't need to test if it can actually
connect to the network, just that it receives the DPP configuration.
---
 autotests/testDPP/connection_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index 38d44b25..a451d584 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -80,7 +80,7 @@ class Test(unittest.TestCase):
 =

         self.wpas.dpp_enrollee_start(uri)
 =

-        self.hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
+        self.wpas.wait_for_event('DPP-CONF-RECEIVED')
 =

     def setUp(self):
         self.wd =3D IWD(True)
-- =

2.31.1

--===============5168924501699699688==--

