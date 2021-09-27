Content-Type: multipart/mixed; boundary="===============7448389821480673328=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 8/9] auto-t: set ocv on PSK FT test
Date: Mon, 27 Sep 2021 10:04:03 -0700
Message-ID: <20210927170404.1292107-8-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============7448389821480673328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testPSK-roam/connection_test.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index b4ead946..d9d86840 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -100,11 +100,13 @@ class Test(unittest.TestCase):
 =

         self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].set_value('ocv', '1')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 =

         self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].set_value('ocv', '1')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 =

@@ -115,11 +117,13 @@ class Test(unittest.TestCase):
 =

         self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[0].set_value('ft_over_ds', '1')
+        self.bss_hostapd[0].set_value('ocv', '0')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 =

         self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[1].set_value('ft_over_ds', '1')
+        self.bss_hostapd[0].set_value('ocv', '0')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 =

-- =

2.31.1

--===============7448389821480673328==--

