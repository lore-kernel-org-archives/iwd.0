Content-Type: multipart/mixed; boundary="===============7596045622860521438=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/7] auto-t: testSAE-roam: wait for ip link down
Date: Wed, 30 Mar 2022 13:23:13 -0700
Message-ID: <20220330202315.1881335-5-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============7596045622860521438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before setting the address, wait for the interface to go down. This
fixes somewhat rare cases where setting the address returns -EBUSY
and ultimately breaks the neighbor reports.
---
 autotests/testSAE-roam/connection_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-=
roam/connection_test.py
index a276232e..2c8cd799 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -120,13 +120,13 @@ class Test(unittest.TestCase):
                             HostapdCLI(config=3D'ft-sae-2.conf'),
                             HostapdCLI(config=3D'ft-psk-3.conf') ]
 =

-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].=
ifname, 'down']).wait()
         ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].=
ifname, \
                            'addr', '12:00:00:00:00:01', 'up']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].=
ifname, 'down']).wait()
         ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].=
ifname, \
                            'addr', '12:00:00:00:00:02', 'up']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].=
ifname, 'down']).wait()
         ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].=
ifname, \
                            'addr', '12:00:00:00:00:03', 'up']).wait()
 =

-- =

2.34.1

--===============7596045622860521438==--

