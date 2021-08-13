Content-Type: multipart/mixed; boundary="===============9093809374509093325=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] auto-t: use prefix on hotspot anqp test
Date: Fri, 13 Aug 2021 13:26:08 -0700
Message-ID: <20210813202612.809470-2-prestwoj@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9093809374509093325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hotspot ANQP delay test was setting a global delay on all
packets which had some unintended consequences. At the time this
was the only way of simulating the test scenario but now hwsim
supports prefix matching so only the ANQP request/response will
be delayed.
---
 autotests/testHotspot/anqp_delay_test.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index 67c12025..323e1fd3 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -65,14 +65,15 @@ class Test(unittest.TestCase):
 =

         # Force the case where ANQP does not finish before Connect() comes=
 in
         rule0.delay =3D 100
+        rule0.prefix =3D '0d'
 =

-        ordered_network.network_object.connect()
-
-        rule0.delay =3D 1
+        ordered_network.network_object.connect(wait=3DFalse)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

+        hapd.wait_for_event('AP-STA-CONNECTED')
+
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

-- =

2.31.1

--===============9093809374509093325==--

