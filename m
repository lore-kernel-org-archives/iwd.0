Content-Type: multipart/mixed; boundary="===============5613829520066916316=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 24/26] auto-t: fix testWPA2 to wait for device object
Date: Thu, 10 Sep 2020 11:58:53 -0700
Message-ID: <20200910185855.27833-24-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5613829520066916316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testWPA2/connection_test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testWPA2/connection_test.py b/autotests/testWPA2/con=
nection_test.py
index dcb4722e..3ff9b50f 100644
--- a/autotests/testWPA2/connection_test.py
+++ b/autotests/testWPA2/connection_test.py
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
-- =

2.21.3

--===============5613829520066916316==--

