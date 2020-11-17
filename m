Content-Type: multipart/mixed; boundary="===============6335073544881418525=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: add test_ip_connected to testutil
Date: Tue, 17 Nov 2020 12:53:03 -0800
Message-ID: <20201117205304.3542997-3-prestwoj@gmail.com>
In-Reply-To: <20201117205304.3542997-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6335073544881418525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Used to check IP connectivity between namespaces. The input
should be two tuples containing the IP and namespace to ping
from/to.
---
 autotests/util/testutil.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index faa81f65..94f8ef32 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -152,3 +152,13 @@ def test_ip_address_match(intf, ip):
 =

     if ip !=3D addr:
         raise Exception('IP for %s did not match %s (was %s)' % (intf, ip,=
 addr))
+
+def test_ip_connected(tup0, tup1):
+    ip0, ns0 =3D tup0
+    ip1, ns1 =3D tup1
+
+    try:
+        ns0.start_process(['ping', '-c', '5', '-i', '0.2', ip1], check=3DT=
rue)
+        ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], check=3DT=
rue)
+    except:
+        raise Exception('Could not ping between %s and %s' % (ip0, ip1))
-- =

2.26.2

--===============6335073544881418525==--

