Content-Type: multipart/mixed; boundary="===============7876117983057692014=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: check linkmode/operstate in adhoc test (open)
Date: Thu, 09 Apr 2020 09:19:30 -0700
Message-ID: <20200409161930.2930-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7876117983057692014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A previous patch fixed the linkmode/operstate for open AdHoc networks.
---
 autotests/testAdHoc/open_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testAdHoc/open_test.py b/autotests/testAdHoc/open_te=
st.py
index 815533bb..a3882a50 100644
--- a/autotests/testAdHoc/open_test.py
+++ b/autotests/testAdHoc/open_test.py
@@ -25,9 +25,9 @@ class Test(unittest.TestCase):
         dev1.adhoc_wait_for_connected(dev2.address)
         dev2.adhoc_wait_for_connected(dev1.address)
 =

-        #testutil.test_iface_operstate(dev1.name)
-        #testutil.test_iface_operstate(dev2.name)
-        #testutil.test_ifaces_connected(dev1.name, dev2.name)
+        testutil.test_iface_operstate(dev1.name)
+        testutil.test_iface_operstate(dev2.name)
+        testutil.test_ifaces_connected(dev1.name, dev2.name)
 =

     def test_connection_success(self):
         wd =3D IWD(True)
-- =

2.21.1

--===============7876117983057692014==--

