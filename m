Content-Type: multipart/mixed; boundary="===============0801306189922396802=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] autotests: Extend a testP2P timeout
Date: Fri, 03 Sep 2021 21:06:42 +0200
Message-ID: <20210903190643.252321-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0801306189922396802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With various versions of wpa_supplicant tested, after an IWD GO tears
the group down, the wpa_supplicant P2P client will not immediately
signal that the group has disappeared but will at least wait for the
lost beacon signal, wait some more and try reconnecting and all that
takes it 10s or a little longer.  Possibly sending Deauthenticate frames
to clients first would improve this.
---
 autotests/testP2P/connection_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 46440053..76613fa6 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -130,7 +130,7 @@ class Test(unittest.TestCase):
         if not go:
             wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=
=3D 0', max_wait=3D3)
         else:
-            wd.wait_for_object_condition(wpas, 'obj.p2p_group is None', ma=
x_wait=3D3)
+            wd.wait_for_object_condition(wpas, 'obj.p2p_group is None', ma=
x_wait=3D15)
         self.assertEqual(peer.connected, False)
 =

     def setUp(self):
-- =

2.30.2

--===============0801306189922396802==--

