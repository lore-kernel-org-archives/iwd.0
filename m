Content-Type: multipart/mixed; boundary="===============3097891871286863813=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 8/9] auto-t: add test for IWD as configurator + initiator
Date: Tue, 22 Feb 2022 14:28:46 -0800
Message-ID: <20220222222847.2480099-8-prestwoj@gmail.com>
In-Reply-To: 20220222222847.2480099-1-prestwoj@gmail.com

--===============3097891871286863813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testDPP/connection_test.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index a451d584..b58620b8 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -82,6 +82,22 @@ class Test(unittest.TestCase):
 =

         self.wpas.wait_for_event('DPP-CONF-RECEIVED')
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

2.34.1

--===============3097891871286863813==--

