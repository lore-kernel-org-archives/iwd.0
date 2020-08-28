Content-Type: multipart/mixed; boundary="===============8693054451110706976=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/15] auto-t: testutil.py: update to work with test-runner
 rewrite
Date: Fri, 28 Aug 2020 09:40:39 -0700
Message-ID: <20200828164050.1456-5-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8693054451110706976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to the others, testutil.py was converted to use the global
test context to lookup radios/interfaces rather than the wiphy_map
---
 autotests/util/testutil.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index aaa4e7e1..0a94e23a 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -5,8 +5,8 @@ import fcntl
 import struct
 import select
 =

-import wiphy
 import iwd
+from config import ctx
 =

 HWSIM_ETHERTYPE =3D 0x0800
 HWSIM_PACKETLEN =3D 250
@@ -54,8 +54,9 @@ def tx(fromsock, tosock, src, dst):
 def test_connected(if0=3DNone, if1=3DNone, group=3DTrue):
     if if0 is None or if1 is None:
         iwd_list =3D [dev.name for dev in iwd.IWD.get_instance().list_devi=
ces()]
-        non_iwd_list =3D [ifname for w in wiphy.wiphy_map.values()
-                for ifname in w.interface_map]
+
+        non_iwd_list =3D [rad.interface.name for rad in ctx.radios if rad.=
interface is not None]
+
         for intf in iwd_list + non_iwd_list:
             if if0 is None:
                 if0 =3D intf
-- =

2.21.1

--===============8693054451110706976==--

