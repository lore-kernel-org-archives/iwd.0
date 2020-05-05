Content-Type: multipart/mixed; boundary="===============3986963530254227497=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix failing adhoc test
Date: Tue, 05 May 2020 10:31:48 -0700
Message-ID: <20200505173148.30258-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3986963530254227497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There appears to be a race condition in the kernel where if two stations
(using the same kernel) do a join IBSS at the same time the New Station
event never comes in (as if no other station has joined the IBSS).

Until this is sorted out, a sleep between starting the IBSS fixes the
issue for the test.
---
 autotests/testAdHoc/adhoc_test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/autotests/testAdHoc/adhoc_test.py b/autotests/testAdHoc/adhoc_=
test.py
index 119c6c7e..27c87a82 100644
--- a/autotests/testAdHoc/adhoc_test.py
+++ b/autotests/testAdHoc/adhoc_test.py
@@ -8,6 +8,7 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 import testutil
+from time import sleep
 =

 class Test(unittest.TestCase):
 =

@@ -18,6 +19,7 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(dev2)
 =

         dev1.start_adhoc("AdHocNetwork", "secret123")
+        sleep(1)
         dev2.start_adhoc("AdHocNetwork", "secret123")
 =

         dev1.adhoc_wait_for_connected(dev2.address)
-- =

2.21.1

--===============3986963530254227497==--

