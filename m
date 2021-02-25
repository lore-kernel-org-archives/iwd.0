Content-Type: multipart/mixed; boundary="===============7471802659733337269=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/17] auto-t: testutil.py: pass wait into ping
Date: Thu, 25 Feb 2021 14:00:52 -0800
Message-ID: <20210225220106.1728411-3-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7471802659733337269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will wait for the process and cleanup ping-out file
---
 autotests/util/testutil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index f50223b1..c649b387 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -164,7 +164,7 @@ def test_ip_connected(tup0, tup1):
     ip1, ns1 =3D tup1
 =

     try:
-        ns0.start_process(['ping', '-c', '5', '-i', '0.2', ip1], check=3DT=
rue)
-        ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], check=3DT=
rue)
+        ns0.start_process(['ping', '-c', '5', '-i', '0.2', ip1], wait=3DTr=
ue, check=3DTrue)
+        ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], wait=3DTr=
ue, check=3DTrue)
     except:
         raise Exception('Could not ping between %s and %s' % (ip0, ip1))
-- =

2.26.2

--===============7471802659733337269==--

