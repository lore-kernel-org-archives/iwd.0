Content-Type: multipart/mixed; boundary="===============5102205810570446754=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/5] auto-t: Remove bogus logic
Date: Thu, 07 May 2020 12:20:23 -0700
Message-ID: <20200507192023.11498-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200507192023.11498-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5102205810570446754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Device object has no property named 'connected'.
client_connect has no member dev2
---
 autotests/testAP/failure_test.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index 9944abaa..d30bccb4 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -22,13 +22,6 @@ class Test(unittest.TestCase):
         psk_agent =3D PSKAgent('Password1')
         wd.register_psk_agent(psk_agent)
 =

-        try:
-            dev2.disconnect()
-            condition =3D 'not obj.connected'
-            wd.wait_for_object_condition(dev2, condition)
-        except:
-            pass
-
         ordered_network.network_object.connect()
 =

         condition =3D 'obj.connected'
-- =

2.13.6

--===============5102205810570446754==--

