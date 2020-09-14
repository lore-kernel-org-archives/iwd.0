Content-Type: multipart/mixed; boundary="===============1121577508818251931=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: fix testFT-PSK-roam
Date: Mon, 14 Sep 2020 14:02:32 -0700
Message-ID: <20200914210233.428835-3-prestwoj@gmail.com>
In-Reply-To: <20200914210233.428835-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1121577508818251931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some cleanup code got removed by mistake which cleared out any
hwsim rules before the next subtest. Without this the second test
would end up getting erroneous signal strength numbers in the scan
results causing a failure.
---
 autotests/testFT-PSK-roam/connection_test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index ccbaccb8..6ad7af4e 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -187,6 +187,11 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

+        hwsim =3D Hwsim()
+
+        for rule in list(hwsim.rules.keys()):
+            del hwsim.rules[rule]
+
     @classmethod
     def setUpClass(cls):
         hwsim =3D Hwsim()
-- =

2.26.2

--===============1121577508818251931==--

