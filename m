Content-Type: multipart/mixed; boundary="===============2098142766252233218=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 09/10] auto-t: cleanup the few uses of is_verbose
Date: Wed, 06 Apr 2022 12:14:52 -0700
Message-ID: <20220406191453.978426-9-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============2098142766252233218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These were used outside of run-tests in a couple places. Replace
these with Process.is_verbose()
---
 autotests/testP2P/connection_test.py | 4 +++-
 autotests/util/wpas.py               | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index d1681164..f22f0682 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -11,6 +11,8 @@ import testutil
 from config import ctx
 from wpas import Wpas
 =

+from utils import Process
+
 class Test(unittest.TestCase):
     leases_path =3D '/tmp/dhcp.lease'
 =

@@ -110,7 +112,7 @@ class Test(unittest.TestCase):
             self.assertEqual(wpas.p2p_group['go_ip_addr'], '192.168.1.1')
 =

             extra_params =3D []
-            if ctx.is_verbose('dhclient'):
+            if Process.is_verbose('dhclient'):
                 extra_params.append('-v')
 =

             dhcp =3D ctx.start_process(['dhclient', '-d', '--no-pid', '-cf=
', '/dev/null', '-lf', self.leases_path,
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 995bdad1..67b32d5f 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -3,8 +3,11 @@ import os
 import socket
 from gi.repository import GLib
 from config import ctx
+
 import binascii
 =

+from utils import Process
+
 ctrl_count =3D 0
 =

 class Wpas:
@@ -31,7 +34,7 @@ class Wpas:
         self.io_watch =3D None
 =

         cmd =3D ['wpa_supplicant', '-i', self.interface.name, '-c', self.c=
onfig_path]
-        if ctx.is_verbose('wpa_supplicant-dbg'):
+        if Process.is_verbose('wpa_supplicant-dbg'):
             cmd +=3D ['-d']
 =

         self.wpa_supplicant =3D ctx.start_process(cmd)
-- =

2.34.1

--===============2098142766252233218==--

