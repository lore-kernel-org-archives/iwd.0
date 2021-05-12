Content-Type: multipart/mixed; boundary="===============1467513543310464281=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] auto-t: update FT-over-DS test for new behavior
Date: Wed, 12 May 2021 12:21:44 -0700
Message-ID: <20210512192144.348398-7-prestwoj@gmail.com>
In-Reply-To: <20210512192144.348398-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1467513543310464281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The FT-over-DS procedure now authenticates with multiple BSS's
upon connecting. This causes list_sta() to return our address for
any authenticated APs. It has now been changed to work with this
new behavior, as well as a check that the station fully connected
to the expected AP initially.
---
 autotests/testFT-PSK-over-DS/connection_test.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index 4c751841..47104b69 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -62,8 +62,13 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.=
address)
+
+        # list_sta actually reports any authenticated stations. Due to the
+        # nature of FT-over-DS IWD should authenticate to all stations with
+        # the same mobility domain. This means both APs should show our st=
ation.
         self.assertTrue(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
+        self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         wd.unregister_psk_agent(psk_agent)
 =

-- =

2.31.1

--===============1467513543310464281==--

