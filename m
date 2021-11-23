Content-Type: multipart/mixed; boundary="===============3625028061992230520=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: testPSK-roam deauthenticate IWD after roam
Date: Tue, 23 Nov 2021 09:37:39 -0800
Message-ID: <20211123173739.3600218-2-prestwoj@gmail.com>
In-Reply-To: 20211123173739.3600218-1-prestwoj@gmail.com

--===============3625028061992230520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After roaming deauth IWD and check the connection state.
---
 autotests/testPSK-roam/connection_test.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index 437e52fc..8d9b22ad 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -100,6 +100,10 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[1].ifname, device.name, True, =
True))
 =

+        self.bss_hostapd[0].deauthenticate(device.address)
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
     def test_ft_psk(self):
         wd =3D IWD(True)
 =

-- =

2.31.1

--===============3625028061992230520==--

