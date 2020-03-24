Content-Type: multipart/mixed; boundary="===============4072955189339233486=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: fix testAddressRandomization
Date: Tue, 24 Mar 2020 13:24:02 -0700
Message-ID: <20200324202403.26860-2-prestwoj@gmail.com>
In-Reply-To: <20200324202403.26860-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4072955189339233486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was dependent on having a local main.conf in /etc/iwd
---
 autotests/testAddressRandomization/connection_test.py | 2 +-
 autotests/testAddressRandomization/hw.conf            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
index fab8fea9..74c9601d 100644
--- a/autotests/testAddressRandomization/connection_test.py
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -38,7 +38,7 @@ class Test(unittest.TestCase):
         return device.address
 =

     def test_connection_success(self):
-        wd =3D IWD(True)
+        wd =3D IWD()
 =

         devices =3D wd.list_devices(1)
         device =3D devices[0]
diff --git a/autotests/testAddressRandomization/hw.conf b/autotests/testAdd=
ressRandomization/hw.conf
index fa46c8b8..35af520e 100644
--- a/autotests/testAddressRandomization/hw.conf
+++ b/autotests/testAddressRandomization/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-start_iwd=3D0
 tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
-- =

2.21.1

--===============4072955189339233486==--

