Content-Type: multipart/mixed; boundary="===============7340292872204111589=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/10] autotests: Update APRanges usage in testAP
Date: Fri, 05 Mar 2021 16:09:35 +0100
Message-ID: <20210305150936.868546-9-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7340292872204111589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[General].APRange is now [IPv4].APAddressPool and the netmask is changed
from 23 to 27 bits to make the test correctly assert that only two
default-sized subnets are allowed by IWD simultaneously (default has
changed from 24 to 28 bits)
---
 autotests/testAP/dhcp/main.conf |  4 +++-
 autotests/testAP/dhcp_test.py   | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/autotests/testAP/dhcp/main.conf b/autotests/testAP/dhcp/main.c=
onf
index 667de23c..62ae782d 100644
--- a/autotests/testAP/dhcp/main.conf
+++ b/autotests/testAP/dhcp/main.conf
@@ -3,4 +3,6 @@ DisableMacAddressRandomization=3Dtrue
 =

 [General]
 EnableNetworkConfiguration=3Dtrue
-APRanges=3D192.168.80.0/23
+
+[IPv4]
+APAddressPool=3D192.168.80.0/27
diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
index bf52fb28..e69c4465 100644
--- a/autotests/testAP/dhcp_test.py
+++ b/autotests/testAP/dhcp_test.py
@@ -58,8 +58,14 @@ class Test(unittest.TestCase):
             testutil.test_iface_operstate(dev2.name)
             testutil.test_ifaces_connected(dev1.name, dev2.name, group=3DF=
alse)
 =

-            testutil.test_ip_address_match(dev1.name, "192.168.80.1")
-            testutil.test_ip_address_match(dev2.name, "192.168.80.2")
+            try:
+                testutil.test_ip_address_match(dev1.name, "192.168.80.1")
+                testutil.test_ip_address_match(dev2.name, "192.168.80.2")
+                ip =3D "192.168.80.1"
+            except:
+                testutil.test_ip_address_match(dev1.name, "192.168.80.17")
+                testutil.test_ip_address_match(dev2.name, "192.168.80.18")
+                ip =3D "192.168.80.17"
 =

             wd.unregister_psk_agent(psk_agent)
 =

@@ -76,7 +82,7 @@ class Test(unittest.TestCase):
             # got initially.
             dev4.start_ap('TestAP4', 'Password4')
 =

-            testutil.test_ip_address_match(dev4.name, "192.168.80.1")
+            testutil.test_ip_address_match(dev4.name, ip)
 =

         finally:
             dev1.stop_ap()
-- =

2.27.0

--===============7340292872204111589==--

