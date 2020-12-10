Content-Type: multipart/mixed; boundary="===============6947319019029406234=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] auto-t: support IP match with no IP set
Date: Thu, 10 Dec 2020 09:45:22 -0800
Message-ID: <20201210174525.874021-6-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6947319019029406234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows an interface with no IP set to be checked for
by passing None in as the address. This will generate an
exception by ioctl which we catch.
---
 autotests/util/testutil.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index 94f8ef32..f50223b1 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -146,9 +146,15 @@ def test_iface_operstate(intf=3DNone):
         sock.close()
 =

 def test_ip_address_match(intf, ip):
-    s =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
-    addr =3D fcntl.ioctl(s.fileno(), SIOCGIFADDR, struct.pack('256s', intf=
.encode('utf-8')))
-    addr =3D socket.inet_ntoa(addr[20:24])
+    try:
+        s =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        addr =3D fcntl.ioctl(s.fileno(), SIOCGIFADDR, struct.pack('256s', =
intf.encode('utf-8')))
+        addr =3D socket.inet_ntoa(addr[20:24])
+    except OSError as e:
+        if e.errno !=3D 99 or ip !=3D None:
+            raise Exception('SIOCGIFADDR failed with %d' % e.errno)
+
+        return
 =

     if ip !=3D addr:
         raise Exception('IP for %s did not match %s (was %s)' % (intf, ip,=
 addr))
-- =

2.26.2

--===============6947319019029406234==--

