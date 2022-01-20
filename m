Content-Type: multipart/mixed; boundary="===============5679291934477181718=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 09/10] auto-t: add test for IWD as configurator + initiator
Date: Thu, 20 Jan 2022 15:44:14 -0800
Message-ID: <20220120234415.2469451-9-prestwoj@gmail.com>
In-Reply-To: 20220120234415.2469451-1-prestwoj@gmail.com

--===============5679291934477181718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testDPP/connection_test.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index 38d44b25..160e533e 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -82,6 +82,22 @@ class Test(unittest.TestCase):
 =

         self.hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
 =

+    def test_iwd_as_configurator_initiator(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect =3D True
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        uri =3D self.wpas.dpp_enrollee_start(oper_and_channel=3D'81/2')
+
+        self.device.dpp_start_configurator(uri)
+
+        self.hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
+
     def setUp(self):
         self.wd =3D IWD(True)
         self.device =3D self.wd.list_devices(1)[0]
-- =

2.31.1

--===============5679291934477181718==--

