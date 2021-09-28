Content-Type: multipart/mixed; boundary="===============3909311823543934229=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 7/9] auto-t: set ocv on PSK FT test
Date: Tue, 28 Sep 2021 08:46:56 -0700
Message-ID: <20210928154658.2382597-7-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============3909311823543934229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testPSK-roam/connection_test.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index b4ead946..918cceb0 100644
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
+        self.bss_hostapd[0].set_value('ocv', '1')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 =

         self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[1].set_value('ft_over_ds', '1')
+        self.bss_hostapd[1].set_value('ocv', '1')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 =

-- =

2.31.1

--===============3909311823543934229==--

