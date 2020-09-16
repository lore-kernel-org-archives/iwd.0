Content-Type: multipart/mixed; boundary="===============8332790806357440338=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] auto-t: update EAP-PEAP-SIM test to use ofono
Date: Wed, 16 Sep 2020 12:39:45 -0700
Message-ID: <20200916193945.683476-6-prestwoj@gmail.com>
In-Reply-To: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8332790806357440338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/misc/secrets/eap-user-peap-sim.text | 2 +-
 autotests/testEAP-PEAP-SIM/connection_test.py | 6 ++++++
 autotests/testEAP-PEAP-SIM/hw.conf            | 4 +---
 autotests/testEAP-PEAP-SIM/sim.db             | 2 +-
 autotests/testEAP-PEAP-SIM/sim.eap_user       | 2 +-
 autotests/testEAP-PEAP-SIM/sim_keys.conf      | 4 ----
 6 files changed, 10 insertions(+), 10 deletions(-)
 delete mode 100644 autotests/testEAP-PEAP-SIM/sim_keys.conf

diff --git a/autotests/misc/secrets/eap-user-peap-sim.text b/autotests/misc=
/secrets/eap-user-peap-sim.text
index b3875a5c..76820116 100644
--- a/autotests/misc/secrets/eap-user-peap-sim.text
+++ b/autotests/misc/secrets/eap-user-peap-sim.text
@@ -1,4 +1,4 @@
 # Phase 1 users
 *	PEAP
 # Phase 2
-"132010000000000(a)example.com"	SIM	[2]
+"112345678(a)phonesim.org"	SIM	[2]
diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
index e4f03dc2..37398c15 100644
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ b/autotests/testEAP-PEAP-SIM/connection_test.py
@@ -9,6 +9,7 @@ import iwd
 from iwd import IWD
 from iwd import NetworkType
 from hlrauc import AuthCenter
+from ofono import Ofono
 =

 class Test(unittest.TestCase):
     def validate_connection(self, wd):
@@ -44,6 +45,11 @@ class Test(unittest.TestCase):
 =

     def test_connection_success(self):
         auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
+
+        ofono =3D Ofono()
+        ofono.enable_modem('/phonesim')
+        ofono.wait_for_sim_auth()
+
         wd =3D IWD(True)
 =

         try:
diff --git a/autotests/testEAP-PEAP-SIM/hw.conf b/autotests/testEAP-PEAP-SI=
M/hw.conf
index f98429f4..659ba0e0 100644
--- a/autotests/testEAP-PEAP-SIM/hw.conf
+++ b/autotests/testEAP-PEAP-SIM/hw.conf
@@ -1,9 +1,7 @@
 [SETUP]
 num_radios=3D2
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:sim_keys.conf:../misc/certs:../mis=
c/secrets
-sim_keys=3D/tmp/sim_keys.conf
+sim_keys=3Dofono
 =

 [HOSTAPD]
 rad0=3DssidEAP-PEAP-SIM.conf
diff --git a/autotests/testEAP-PEAP-SIM/sim.db b/autotests/testEAP-PEAP-SIM=
/sim.db
index b7f51e66..fbf79786 100644
--- a/autotests/testEAP-PEAP-SIM/sim.db
+++ b/autotests/testEAP-PEAP-SIM/sim.db
@@ -1 +1 @@
-32010000000000:D0D1D2D3D4D5D6D7:E1E2E3E4:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
+12345678:673fb8cd35f98800:1fb1e3b5:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
diff --git a/autotests/testEAP-PEAP-SIM/sim.eap_user b/autotests/testEAP-PE=
AP-SIM/sim.eap_user
index 17f7e1ae..dabb81a8 100644
--- a/autotests/testEAP-PEAP-SIM/sim.eap_user
+++ b/autotests/testEAP-PEAP-SIM/sim.eap_user
@@ -1 +1 @@
-"132010000000000(a)example.com"	SIM
+"112345678(a)phonesim.org"	SIM
diff --git a/autotests/testEAP-PEAP-SIM/sim_keys.conf b/autotests/testEAP-P=
EAP-SIM/sim_keys.conf
deleted file mode 100644
index 000760ad..00000000
--- a/autotests/testEAP-PEAP-SIM/sim_keys.conf
+++ /dev/null
@@ -1,4 +0,0 @@
-[SIM]
-Identity=3D32010000000000(a)example.com
-Kc=3Dd0d1d2d3d4d5d6d7d0d1d2d3d4d5d6d7d0d1d2d3d4d5d6d7
-SRES=3De1e2e3e4e1e2e3e4e1e2e3e4
-- =

2.26.2

--===============8332790806357440338==--

