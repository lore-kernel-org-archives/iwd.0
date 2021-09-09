Content-Type: multipart/mixed; boundary="===============3579683981594837726=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/6] auto-t: change testSAE timeout_test to use match/offset
Date: Thu, 09 Sep 2021 15:08:45 -0700
Message-ID: <20210909220848.19376-3-prestwoj@gmail.com>
In-Reply-To: <20210909220848.19376-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3579683981594837726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes things more clear on what frames are being blocked
since it passes over header information to get to the actual
SAE payload.
---
 autotests/testSAE/timeout_test.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index 1792f1c0..6f757edb 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -42,6 +42,8 @@ class Test(unittest.TestCase):
         #
         hostapd =3D HostapdCLI(config=3D'ssidSAE.conf')
         hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000=
')
+        hostapd.set_value('sae_groups', '19')
+        hostapd.reload()
 =

         hwsim =3D Hwsim()
         bss_radio =3D hwsim.get_radio('rad0')
@@ -50,6 +52,8 @@ class Test(unittest.TestCase):
         rule0.source =3D bss_radio.addresses[0]
         rule0.drop =3D True
         rule0.prefix =3D 'b0'
+        rule0.match =3D '01 00 00 00 13 00'
+        rule0.match_offset =3D 26
         rule0.match_times =3D 1
         rule0.drop_ack =3D True
         rule0.enabled =3D True
@@ -57,6 +61,8 @@ class Test(unittest.TestCase):
         wd =3D IWD(True)
         self.validate_connection(wd)
 =

+        rule0.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
-- =

2.31.1

--===============3579683981594837726==--

