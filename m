Content-Type: multipart/mixed; boundary="===============0478131524724538787=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: use .frequency property in SAQuery-spoofing test
Date: Thu, 12 Aug 2021 16:12:32 -0700
Message-ID: <20210812231233.747743-5-prestwoj@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0478131524724538787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAQuery-spoofing/connection_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index c4c4e923..f64a93f7 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -49,7 +49,7 @@ class Test(unittest.TestCase):
             wd.wait_for_object_condition(device, condition)
 =

         # Spoof a disassociate frame. This will kick off SA Query procedur=
e.
-        hwsim.spoof_disassociate(radio, hostapd.get_freq(), device.address)
+        hwsim.spoof_disassociate(radio, hostapd.frequency, device.address)
 =

         # sleep to ensure hostapd responds and SA Query does not timeout
         sleep(4)
-- =

2.31.1

--===============0478131524724538787==--

