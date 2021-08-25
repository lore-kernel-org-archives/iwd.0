Content-Type: multipart/mixed; boundary="===============4826272815926695058=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: testutil.py: update Process changes
Date: Wed, 25 Aug 2021 15:17:25 -0700
Message-ID: <20210825221726.784086-3-prestwoj@gmail.com>
In-Reply-To: <20210825221726.784086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4826272815926695058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/testutil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index ea705bad..1fced6c4 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -169,7 +169,7 @@ def test_ip_connected(tup0, tup1):
     ip1, ns1 =3D tup1
 =

     try:
-        ns0.start_process(['ping', '-c', '5', '-i', '0.2', ip1], wait=3DTr=
ue, check=3DTrue)
-        ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], wait=3DTr=
ue, check=3DTrue)
+        ns0.start_process(['ping', '-c', '5', '-i', '0.2', ip1], check=3DT=
rue)
+        ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], check=3DT=
rue)
     except:
         raise Exception('Could not ping between %s and %s' % (ip0, ip1))
-- =

2.31.1

--===============4826272815926695058==--

