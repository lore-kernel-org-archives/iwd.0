Content-Type: multipart/mixed; boundary="===============6054830886411607716=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 10/14] auto-t: wait for roam events in proper order
Date: Thu, 31 Mar 2022 16:16:37 -0700
Message-ID: <20220331231641.484200-10-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============6054830886411607716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These were out of order and would sometimes fail the check.
---
 autotests/testPSK-roam/roam_ap_disconnect_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/=
testPSK-roam/roam_ap_disconnect_test.py
index 9cef3090..760c25fa 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -32,8 +32,8 @@ class Test(unittest.TestCase):
 =

         # Since both BSS's have low signal, the roam should fail and trigg=
er
         # another roam scan.
-        device.wait_for_event('no-roam-candidates', timeout=3D30)
         device.wait_for_event('roam-scan-triggered', timeout=3D30)
+        device.wait_for_event('no-roam-candidates', timeout=3D30)
 =

         # Hostapd sends disconnect
         self.bss_hostapd[0].disable()
-- =

2.34.1

--===============6054830886411607716==--

