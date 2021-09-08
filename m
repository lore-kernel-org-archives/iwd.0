Content-Type: multipart/mixed; boundary="===============3614311506030545983=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: add SAE test for a non-ACKed confirm
Date: Wed, 08 Sep 2021 15:47:43 -0700
Message-ID: <20210908224744.102156-4-prestwoj@gmail.com>
In-Reply-To: <20210908224744.102156-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3614311506030545983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAE/timeout_test.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index 263f4e28..8de21176 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -60,6 +60,27 @@ class Test(unittest.TestCase):
 =

         rule0.remove()
 =

+    def test_sta_confirm_not_acked(self):
+        hostapd =3D HostapdCLI(config=3D'ssidSAE.conf')
+        hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000=
')
+
+        hwsim =3D Hwsim()
+        bss_radio =3D hwsim.get_radio('rad0')
+
+        rule0 =3D hwsim.rules.create()
+        rule0.source =3D bss_radio.addresses[0]
+        rule0.drop =3D True
+        rule0.prefix =3D '02 00 00 00'
+        rule0.prefix_offset =3D 26
+        rule0.match_times =3D 1
+        rule0.drop_ack =3D True
+        rule0.enabled =3D True
+
+        wd =3D IWD(True)
+        self.validate_connection(wd)
+
+        rule0.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
-- =

2.31.1

--===============3614311506030545983==--

