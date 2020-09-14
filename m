Content-Type: multipart/mixed; boundary="===============0671597171110523037=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: replace waiting for network with device
Date: Mon, 14 Sep 2020 14:02:33 -0700
Message-ID: <20200914210233.428835-4-prestwoj@gmail.com>
In-Reply-To: <20200914210233.428835-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0671597171110523037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many tests waited on the network object 'connected' property after
issuing a Connect command. This is not correct as 'connected' is
set quite early in the connection process. The correct way of doing
this is waiting for the device state to change to connected.

This common code was replaced, hopefully putting to rest any random
failures that happen occasionally.
---
 autotests/testAP/failure_test.py                     |  4 ++--
 .../testAddressRandomization/connection_test.py      |  4 ++--
 autotests/testBSSBlacklist/bad_pass_test.py          |  4 ++--
 autotests/testBSSBlacklist/connection_test.py        |  4 ++--
 .../testClientNonInteractive/connect_command_test.py |  4 ++--
 autotests/testConnectAutoconnect/validation.py       |  4 ++--
 autotests/testDisconnectOnConnect/connection_test.py |  8 ++++----
 autotests/testEAP-AKA-ofono/connection_test.py       |  4 ++--
 autotests/testEAP-AKA-prime-ofono/connection_test.py |  4 ++--
 autotests/testEAP-AKA-prime/connection_test.py       |  4 ++--
 autotests/testEAP-AKA/connection_test.py             |  8 ++++----
 autotests/testEAP-MSCHAPV2/connection_test.py        |  4 ++--
 autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py |  4 ++--
 autotests/testEAP-PEAP-GTC/peap_gtc_test.py          |  4 ++--
 autotests/testEAP-PEAP-MSCHAPv2/connection_test.py   |  4 ++--
 autotests/testEAP-PEAP-SIM/connection_test.py        |  4 ++--
 autotests/testEAP-PEAP/peap_frag_test.py             |  4 ++--
 autotests/testEAP-PEAP/peap_v0_test.py               |  4 ++--
 autotests/testEAP-PEAP/peap_v1_test.py               |  4 ++--
 autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py   |  4 ++--
 autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py |  8 ++++----
 autotests/testEAP-PWD/connection_test.py             |  8 ++++----
 autotests/testEAP-PWD/frag_test.py                   |  4 ++--
 autotests/testEAP-SIM-ofono/connection_test.py       |  4 ++--
 autotests/testEAP-SIM/connection_test.py             |  8 ++++----
 autotests/testEAP-TLS-Frag/connection_test.py        |  4 ++--
 .../testEAP-TLS-embedded-pems/connection_test.py     |  4 ++--
 autotests/testEAP-TLS/connection_test.py             |  4 ++--
 autotests/testEAP-TLSwithMFPC/connection_test.py     |  4 ++--
 autotests/testEAP-TLSwithMFPR/connection_test.py     |  4 ++--
 autotests/testEAP-TTLS-CHAP/connection_test.py       |  8 ++++----
 .../testEAP-TTLS-EAP-MSCHAPV2/connection_test.py     |  4 ++--
 autotests/testEAP-TTLS-Frag/connection_test.py       |  4 ++--
 autotests/testEAP-TTLS-MSCHAP/connection_test.py     |  8 ++++----
 autotests/testEAP-TTLS-MSCHAPv2/connection_test.py   |  8 ++++----
 autotests/testEAP-TTLS-PAP/connection_test.py        |  8 ++++----
 autotests/testEAP-TTLS/connection_test.py            |  4 ++--
 autotests/testFILS/fils_256_test.py                  |  8 ++++----
 autotests/testFILS/fils_384_test.py                  |  8 ++++----
 autotests/testFT-8021x-roam/connection_test.py       | 12 +++++++-----
 autotests/testFT-FILS-SHA256/connection_test.py      | 12 +++++++-----
 autotests/testFT-FILS-SHA384/connection_test.py      |  8 ++++----
 autotests/testFT-PSK-over-DS/connection_test.py      |  4 ++--
 autotests/testFT-PSK-roam/connection_test.py         |  4 ++--
 autotests/testFT-SAE-roam/connection_test.py         |  4 ++--
 autotests/testHT-VHT/connection_test.py              |  7 ++-----
 autotests/testKnownNetworks/frequency_test.py        |  4 ++--
 autotests/testKnownNetworks/known_network_test.py    |  4 ++--
 autotests/testMFP-Options/connection_test.py         |  4 ++--
 autotests/testOWE/connection_test.py                 |  4 ++--
 autotests/testOWE/renegotiate_test.py                |  4 ++--
 autotests/testOpen/connection_test.py                |  4 ++--
 autotests/testRRM/connection_test.py                 |  4 ++--
 autotests/testRSSIAgent/connection_test.py           |  4 ++--
 autotests/testSAE/clogging_test.py                   |  6 +++---
 autotests/testSAE/connection_test.py                 |  4 ++--
 autotests/testSAE/group_20_connection_test.py        |  4 ++--
 autotests/testSAQuery-spoofing/connection_test.py    |  8 ++++----
 autotests/testSAQuery/connection_test.py             |  4 ++--
 autotests/testWPA/connection_test.py                 |  4 ++--
 autotests/testWPA2-SHA256/connection_test.py         |  4 ++--
 autotests/testWPA2withMFP/connection_test.py         |  4 ++--
 62 files changed, 161 insertions(+), 160 deletions(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index a2622f45..4959802f 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -25,8 +25,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev, condition)
 =

         wd.unregister_psk_agent(psk_agent)
 =

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
index 74c9601d..10d1b35b 100644
--- a/autotests/testAddressRandomization/connection_test.py
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -24,8 +24,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index b2ceb998..0aff053a 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -77,8 +77,8 @@ class Test(unittest.TestCase):
         # successfully to bss_hostapd[0]
         self.assertIn(device.address, bss_hostapd[0].list_sta())
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         wd.unregister_psk_agent(psk_agent)
 =

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 8083fc92..8d7d92e1 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -134,8 +134,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertIn(device.address, bss_hostapd[0].list_sta())
 =

diff --git a/autotests/testClientNonInteractive/connect_command_test.py b/a=
utotests/testClientNonInteractive/connect_command_test.py
index a503bd24..247b40c7 100644
--- a/autotests/testClientNonInteractive/connect_command_test.py
+++ b/autotests/testClientNonInteractive/connect_command_test.py
@@ -20,8 +20,8 @@ class Test(unittest.TestCase):
 =

         ordered_network =3D device.get_ordered_network(ssid)
 =

-        condition =3D 'obj.connected'
-        self.wd.wait_for_object_condition(ordered_network.network_object, =
condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        self.wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests/tes=
tConnectAutoconnect/validation.py
index 6db479a9..b240d25d 100644
--- a/autotests/testConnectAutoconnect/validation.py
+++ b/autotests/testConnectAutoconnect/validation.py
@@ -24,8 +24,8 @@ class TestConnectAutoConnect(unittest.TestCase):
         else:
             ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

     def check_autoconnect(self, wd, device, ssid, throws):
         if throws is None:
diff --git a/autotests/testDisconnectOnConnect/connection_test.py b/autotes=
ts/testDisconnectOnConnect/connection_test.py
index d5dc81dc..7e36d4aa 100644
--- a/autotests/testDisconnectOnConnect/connection_test.py
+++ b/autotests/testDisconnectOnConnect/connection_test.py
@@ -36,16 +36,16 @@ class Test(unittest.TestCase):
 =

         wpa_net.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(wpa_net.network_object, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         open_net =3D device.get_ordered_network('ssidOpen')
         self.assertEqual(open_net.type, NetworkType.open)
 =

         open_net.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(open_net.network_object, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
index 27f736f6..ff987709 100644
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-ofono/connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
index 967ba352..01dd8249 100644
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-prime-ofono/connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-AKA-prime/connection_test.py b/autotests/tes=
tEAP-AKA-prime/connection_test.py
index 3c5714ee..8367022c 100644
--- a/autotests/testEAP-AKA-prime/connection_test.py
+++ b/autotests/testEAP-AKA-prime/connection_test.py
@@ -40,8 +40,8 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-AKA/connection_test.py b/autotests/testEAP-A=
KA/connection_test.py
index c4b7c2f9..122fd6b7 100644
--- a/autotests/testEAP-AKA/connection_test.py
+++ b/autotests/testEAP-AKA/connection_test.py
@@ -46,16 +46,16 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-MSCHAPV2/connection_test.py b/autotests/test=
EAP-MSCHAPV2/connection_test.py
index 35926375..33ce856f 100644
--- a/autotests/testEAP-MSCHAPV2/connection_test.py
+++ b/autotests/testEAP-MSCHAPV2/connection_test.py
@@ -38,8 +38,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         wd.unregister_psk_agent(psk_agent)
 =

diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py b/autotes=
ts/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
index c372ab64..16203c68 100644
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
+++ b/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
@@ -35,8 +35,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py b/autotests/testEA=
P-PEAP-GTC/peap_gtc_test.py
index c81367d7..f3bea378 100644
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py
+++ b/autotests/testEAP-PEAP-GTC/peap_gtc_test.py
@@ -34,8 +34,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py b/autotests=
/testEAP-PEAP-MSCHAPv2/connection_test.py
index 7c6eb61b..7998fa07 100644
--- a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
@@ -34,8 +34,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
index 26643d78..e4f03dc2 100644
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ b/autotests/testEAP-PEAP-SIM/connection_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP/peap_frag_test.py b/autotests/testEAP-P=
EAP/peap_frag_test.py
index 2299816d..8bae8bd9 100644
--- a/autotests/testEAP-PEAP/peap_frag_test.py
+++ b/autotests/testEAP-PEAP/peap_frag_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP/peap_v0_test.py b/autotests/testEAP-PEA=
P/peap_v0_test.py
index 1022d00a..4ad73c20 100644
--- a/autotests/testEAP-PEAP/peap_v0_test.py
+++ b/autotests/testEAP-PEAP/peap_v0_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAP/peap_v1_test.py b/autotests/testEAP-PEA=
P/peap_v1_test.py
index 32c27b75..efd55337 100644
--- a/autotests/testEAP-PEAP/peap_v1_test.py
+++ b/autotests/testEAP-PEAP/peap_v1_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py b/autotests=
/testEAP-PEAPv0-CryptoBinding/ISK_test.py
index a25f99ef..5febc8db 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
@@ -36,8 +36,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index 33ff0285..638ad4b3 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -40,16 +40,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-PWD/connection_test.py b/autotests/testEAP-P=
WD/connection_test.py
index 2edc45b8..de3c6122 100644
--- a/autotests/testEAP-PWD/connection_test.py
+++ b/autotests/testEAP-PWD/connection_test.py
@@ -43,16 +43,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-PWD/frag_test.py b/autotests/testEAP-PWD/fra=
g_test.py
index 763ecc17..bb6103bd 100644
--- a/autotests/testEAP-PWD/frag_test.py
+++ b/autotests/testEAP-PWD/frag_test.py
@@ -32,8 +32,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
index de7c4b48..dcb2dcbc 100644
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ b/autotests/testEAP-SIM-ofono/connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-SIM/connection_test.py b/autotests/testEAP-S=
IM/connection_test.py
index 617d833b..a7615b52 100644
--- a/autotests/testEAP-SIM/connection_test.py
+++ b/autotests/testEAP-SIM/connection_test.py
@@ -44,16 +44,16 @@ class Test(unittest.TestCase):
                 auth.stop()
                 raise
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TLS-Frag/connection_test.py b/autotests/test=
EAP-TLS-Frag/connection_test.py
index 069250cf..3e155eea 100644
--- a/autotests/testEAP-TLS-Frag/connection_test.py
+++ b/autotests/testEAP-TLS-Frag/connection_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TLS-embedded-pems/connection_test.py b/autot=
ests/testEAP-TLS-embedded-pems/connection_test.py
index 5d46868d..5d3c0c40 100644
--- a/autotests/testEAP-TLS-embedded-pems/connection_test.py
+++ b/autotests/testEAP-TLS-embedded-pems/connection_test.py
@@ -43,8 +43,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(hostapd.ifname, device.name)
diff --git a/autotests/testEAP-TLS/connection_test.py b/autotests/testEAP-T=
LS/connection_test.py
index 9b696aa4..1e390e69 100644
--- a/autotests/testEAP-TLS/connection_test.py
+++ b/autotests/testEAP-TLS/connection_test.py
@@ -43,8 +43,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(hapd.ifname, device.name)
diff --git a/autotests/testEAP-TLSwithMFPC/connection_test.py b/autotests/t=
estEAP-TLSwithMFPC/connection_test.py
index 069250cf..3e155eea 100644
--- a/autotests/testEAP-TLSwithMFPC/connection_test.py
+++ b/autotests/testEAP-TLSwithMFPC/connection_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TLSwithMFPR/connection_test.py b/autotests/t=
estEAP-TLSwithMFPR/connection_test.py
index 069250cf..3e155eea 100644
--- a/autotests/testEAP-TLSwithMFPR/connection_test.py
+++ b/autotests/testEAP-TLSwithMFPR/connection_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TTLS-CHAP/connection_test.py b/autotests/tes=
tEAP-TTLS-CHAP/connection_test.py
index 331e799f..0d7d87ab 100644
--- a/autotests/testEAP-TTLS-CHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-CHAP/connection_test.py
@@ -43,16 +43,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py b/autot=
ests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
index 23c839b1..a9832674 100644
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
+++ b/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
@@ -40,8 +40,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-TTLS-Frag/connection_test.py b/autotests/tes=
tEAP-TTLS-Frag/connection_test.py
index 832a0b93..ef29425d 100644
--- a/autotests/testEAP-TTLS-Frag/connection_test.py
+++ b/autotests/testEAP-TTLS-Frag/connection_test.py
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TTLS-MSCHAP/connection_test.py b/autotests/t=
estEAP-TTLS-MSCHAP/connection_test.py
index 973370a8..1e60fd3e 100644
--- a/autotests/testEAP-TTLS-MSCHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAP/connection_test.py
@@ -43,16 +43,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py b/autotests=
/testEAP-TTLS-MSCHAPv2/connection_test.py
index 918e8d1f..78a11087 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
@@ -43,16 +43,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-TTLS-PAP/connection_test.py b/autotests/test=
EAP-TTLS-PAP/connection_test.py
index a8f6fde7..3e4a238a 100644
--- a/autotests/testEAP-TTLS-PAP/connection_test.py
+++ b/autotests/testEAP-TTLS-PAP/connection_test.py
@@ -43,16 +43,16 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         hostapd.eapol_reauth(device.address)
 =

         hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
         hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testEAP-TTLS/connection_test.py b/autotests/testEAP-=
TTLS/connection_test.py
index fa7d1e55..81bcdc3f 100644
--- a/autotests/testEAP-TTLS/connection_test.py
+++ b/autotests/testEAP-TTLS/connection_test.py
@@ -34,8 +34,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index af033d4a..1bf4dca3 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -42,8 +42,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
@@ -62,8 +62,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index 70e3bc87..9a5cddfd 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -42,8 +42,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
@@ -62,8 +62,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index 084bac64..2dfe9ce5 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -55,8 +55,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
@@ -82,7 +82,9 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
@@ -132,8 +134,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS-SHA256/connection_test.py
index d87afce0..267639cd 100644
--- a/autotests/testFT-FILS-SHA256/connection_test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -60,8 +60,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
@@ -85,8 +85,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
@@ -112,7 +112,9 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
index d87afce0..12a85e3f 100644
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -60,8 +60,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
@@ -85,8 +85,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index 188eca63..28a045ef 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -59,8 +59,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 6ad7af4e..2d65c925 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -145,8 +145,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index 99f58456..a8d1da6c 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -65,8 +65,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testHT-VHT/connection_test.py b/autotests/testHT-VHT=
/connection_test.py
index e4781ea0..c31dd5fb 100644
--- a/autotests/testHT-VHT/connection_test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -10,7 +10,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
 import testutil
-from time import sleep
 from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
@@ -35,10 +34,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        sleep(1)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hostapd.ifname)
diff --git a/autotests/testKnownNetworks/frequency_test.py b/autotests/test=
KnownNetworks/frequency_test.py
index de040d3e..f07074f2 100644
--- a/autotests/testKnownNetworks/frequency_test.py
+++ b/autotests/testKnownNetworks/frequency_test.py
@@ -21,8 +21,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testKnownNetworks/known_network_test.py b/autotests/=
testKnownNetworks/known_network_test.py
index a94a2151..6ac19bc6 100644
--- a/autotests/testKnownNetworks/known_network_test.py
+++ b/autotests/testKnownNetworks/known_network_test.py
@@ -29,8 +29,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testMFP-Options/connection_test.py b/autotests/testM=
FP-Options/connection_test.py
index ccdc3452..0f1ef830 100644
--- a/autotests/testMFP-Options/connection_test.py
+++ b/autotests/testMFP-Options/connection_test.py
@@ -43,8 +43,8 @@ class TestMFP(unittest.TestCase):
         else:
             ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/conne=
ction_test.py
index 539b06d0..ee1036c8 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -37,8 +37,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testOWE/renegotiate_test.py b/autotests/testOWE/rene=
gotiate_test.py
index 7c736acd..e3fd911b 100644
--- a/autotests/testOWE/renegotiate_test.py
+++ b/autotests/testOWE/renegotiate_test.py
@@ -37,8 +37,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testOpen/connection_test.py b/autotests/testOpen/con=
nection_test.py
index 5b0a7fe1..48417ef3 100644
--- a/autotests/testOpen/connection_test.py
+++ b/autotests/testOpen/connection_test.py
@@ -34,8 +34,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/conne=
ction_test.py
index 74733e19..e1c077c9 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -53,8 +53,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testRSSIAgent/connection_test.py b/autotests/testRSS=
IAgent/connection_test.py
index ab0bc3a5..f485b388 100644
--- a/autotests/testRSSIAgent/connection_test.py
+++ b/autotests/testRSSIAgent/connection_test.py
@@ -51,8 +51,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         # Test with 5 signal strength levels first, then with 3
 =

diff --git a/autotests/testSAE/clogging_test.py b/autotests/testSAE/cloggin=
g_test.py
index c46c5821..35b9e65e 100644
--- a/autotests/testSAE/clogging_test.py
+++ b/autotests/testSAE/clogging_test.py
@@ -43,9 +43,9 @@ class Test(unittest.TestCase):
         for n in networks:
             n.network_object.connect(wait=3DFalse)
 =

-        for n in networks:
-            condition =3D 'obj.connected'
-            wd.wait_for_object_condition(n.network_object, condition)
+        for d in devices:
+            condition =3D 'obj.state =3D=3D DeviceState.connected'
+            wd.wait_for_object_condition(d, condition)
 =

         for d in devices:
             condition =3D 'obj.state =3D=3D DeviceState.connected'
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index 56bb1f6d..520db0b1 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
 =

         network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(network.network_object, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         wd.wait(2)
 =

diff --git a/autotests/testSAE/group_20_connection_test.py b/autotests/test=
SAE/group_20_connection_test.py
index 5631878a..8ddab8eb 100644
--- a/autotests/testSAE/group_20_connection_test.py
+++ b/autotests/testSAE/group_20_connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
 =

         network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(network.network_object, condition)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         wd.wait(2)
 =

diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index 4887b172..7ad96d4f 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -46,8 +46,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         # TODO: for some reason hostapd does not respond to SA query if do=
ne
         #       too soon after connection.
@@ -60,8 +60,8 @@ class Test(unittest.TestCase):
         sleep(4)
 =

         # Since disassociate was spoofed we should still be connected
-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQue=
ry/connection_test.py
index 9ea95e2b..571e6e9f 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -40,8 +40,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         # Make AP go down ungracefully, when hostapd comes back up it shou=
ld
         # send an unprotected disassociate frame so the client will re-aut=
h.
diff --git a/autotests/testWPA/connection_test.py b/autotests/testWPA/conne=
ction_test.py
index d2edde48..3962c807 100644
--- a/autotests/testWPA/connection_test.py
+++ b/autotests/testWPA/connection_test.py
@@ -38,8 +38,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
diff --git a/autotests/testWPA2-SHA256/connection_test.py b/autotests/testW=
PA2-SHA256/connection_test.py
index 9486c716..70c708da 100644
--- a/autotests/testWPA2-SHA256/connection_test.py
+++ b/autotests/testWPA2-SHA256/connection_test.py
@@ -37,8 +37,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

diff --git a/autotests/testWPA2withMFP/connection_test.py b/autotests/testW=
PA2withMFP/connection_test.py
index 9486c716..70c708da 100644
--- a/autotests/testWPA2withMFP/connection_test.py
+++ b/autotests/testWPA2withMFP/connection_test.py
@@ -37,8 +37,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         device.disconnect()
 =

-- =

2.26.2

--===============0671597171110523037==--

