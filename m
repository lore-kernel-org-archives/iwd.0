Content-Type: multipart/mixed; boundary="===============1580720255725755438=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/5] auto-t: Rename test case to reflect its purpose
Date: Thu, 07 May 2020 12:20:20 -0700
Message-ID: <20200507192023.11498-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200507192023.11498-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1580720255725755438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAP/failure_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index d419c05b..2c1e14b3 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -54,7 +54,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-    def test_connection_success(self):
+    def test_connection_failure(self):
         wd =3D IWD()
 =

         dev1, dev2 =3D wd.list_devices(2)
-- =

2.13.6

--===============1580720255725755438==--

