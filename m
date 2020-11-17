Content-Type: multipart/mixed; boundary="===============5662688715748493807=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: add namespaces to testAP
Date: Tue, 17 Nov 2020 12:53:04 -0800
Message-ID: <20201117205304.3542997-4-prestwoj@gmail.com>
In-Reply-To: <20201117205304.3542997-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5662688715748493807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAP/dhcp_config_test.py | 19 +++++++++++++++----
 autotests/testAP/hw.conf             |  6 +++++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/autotests/testAP/dhcp_config_test.py b/autotests/testAP/dhcp_c=
onfig_test.py
index a278c3b7..975cab4d 100644
--- a/autotests/testAP/dhcp_config_test.py
+++ b/autotests/testAP/dhcp_config_test.py
@@ -16,7 +16,15 @@ class Test(unittest.TestCase):
         # this range.
         wd =3D IWD(True, '/tmp/dhcp')
 =

-        dev1, dev2 =3D wd.list_devices(2)
+        ns0 =3D ctx.get_namespace('ns0')
+
+        wd_ns0 =3D IWD(True, '/tmp/dhcp', namespace=3Dns0)
+
+        dev1 =3D wd_ns0.list_devices(1)[0]
+        dev2, dev3, dev4, dev5 =3D wd.list_devices(4)
+        dev3.disconnect()
+        dev4.disconnect()
+        dev5.disconnect()
 =

         dev1.start_ap('APConfig')
 =

@@ -51,11 +59,14 @@ class Test(unittest.TestCase):
             wd.wait_for_object_condition(dev2, condition)
 =

             testutil.test_iface_operstate(dev2.name)
-            testutil.test_ifaces_connected(dev1.name, dev2.name, group=3DF=
alse)
-
-            testutil.test_ip_address_match(dev1.name, "192.168.1.1")
+            #
+            # TODO: cannot yet check the AP interface IP since its in a
+            #       different namespace.
+            #
             testutil.test_ip_address_match(dev2.name, "192.168.1.3")
 =

+            testutil.test_ip_connected(('192.168.1.3', ctx), ('192.168.1.1=
', ns0))
+
             wd.unregister_psk_agent(psk_agent)
 =

             dev2.disconnect()
diff --git a/autotests/testAP/hw.conf b/autotests/testAP/hw.conf
index bac128b2..c9c0c7ca 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,6 +1,10 @@
 [SETUP]
-num_radios=3D5
+num_radios=3D6
 start_iwd=3D0
+hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3Dpsk-ccmp.conf
+
+[NameSpaces]
+ns0=3Drad5
-- =

2.26.2

--===============5662688715748493807==--

