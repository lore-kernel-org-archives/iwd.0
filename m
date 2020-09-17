Content-Type: multipart/mixed; boundary="===============0489166656296509006=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix testNetconfig
Date: Thu, 17 Sep 2020 14:32:28 -0700
Message-ID: <20200917213228.788093-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0489166656296509006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interface was hard coded to wln0 which works when running single
tests but not when running multiple. Instead use the actual ifname
that hostapd is using.
---
 autotests/testNetconfig/connection_test.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 3a590aeb..6818ceff 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -8,6 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
 import testutil
 from config import ctx
 =

@@ -54,10 +55,11 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        hapd =3D HostapdCLI()
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ifconfig', 'wln0', '192.168.1.1', 'netmask', '=
255.255.255.0'],
+        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
                                 wait=3DTrue)
         ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
         ctx.start_process(['dhcpd', '-cf', '/tmp/dhcpd.conf', '-lf', '/tmp=
/dhcpd.leases'])
-- =

2.26.2

--===============0489166656296509006==--

