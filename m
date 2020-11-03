Content-Type: multipart/mixed; boundary="===============0414391142652092694=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: fix testNetconfig hardcoded interface
Date: Tue, 03 Nov 2020 11:06:39 -0800
Message-ID: <20201103190641.2736204-2-prestwoj@gmail.com>
In-Reply-To: <20201103190641.2736204-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0414391142652092694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If running multiple tests testNetconfig would fail due to the
hardcoded wln0 in the dhcpd.conf file. dhcpd can actually start
by passing in the interface to the run command rather than
inside the config file.
---
 autotests/testNetconfig/connection_test.py | 3 ++-
 autotests/testNetconfig/dhcpd.conf         | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 6818ceff..5fc7a88e 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -62,7 +62,8 @@ class Test(unittest.TestCase):
         ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
                                 wait=3DTrue)
         ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
-        ctx.start_process(['dhcpd', '-cf', '/tmp/dhcpd.conf', '-lf', '/tmp=
/dhcpd.leases'])
+        ctx.start_process(['dhcpd', '-cf', '/tmp/dhcpd.conf', '-lf', '/tmp=
/dhcpd.leases',
+                            hapd.ifname])
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testNetconfig/dhcpd.conf b/autotests/testNetconfig/d=
hcpd.conf
index 77b4da1c..0c4fe9b9 100644
--- a/autotests/testNetconfig/dhcpd.conf
+++ b/autotests/testNetconfig/dhcpd.conf
@@ -10,7 +10,6 @@ subnet 192.168.1.0 netmask 255.255.255.0
   option routers 192.168.1.1;
   option subnet-mask 255.255.255.0;
   option domain-name-servers 192.168.1.1;
-  interface wln0;
   range 192.168.1.10 192.168.1.20;
   range 192.168.1.100 192.168.1.200;
  }
-- =

2.26.2

--===============0414391142652092694==--

