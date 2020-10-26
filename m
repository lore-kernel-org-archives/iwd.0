Content-Type: multipart/mixed; boundary="===============0954940538733023306=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 5/6] auto-t: testutil: add test_ip_address_match
Date: Mon, 26 Oct 2020 11:05:43 -0700
Message-ID: <20201026180544.2130802-5-prestwoj@gmail.com>
In-Reply-To: <20201026180544.2130802-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0954940538733023306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Checks that the the IP address for a given interface matches
---
 autotests/util/testutil.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index f9cfbf29..faa81f65 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -125,6 +125,7 @@ def test_ifaces_connected(if0=3DNone, if1=3DNone, group=
=3DTrue):
             raise e
 =

 SIOCGIFFLAGS =3D 0x8913
+SIOCGIFADDR =3D 0x8915
 IFF_UP =3D 1 << 0
 IFF_RUNNING =3D 1 << 6
 =

@@ -143,3 +144,11 @@ def test_iface_operstate(intf=3DNone):
             raise Exception(intf + ' operstate wrong')
     finally:
         sock.close()
+
+def test_ip_address_match(intf, ip):
+    s =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+    addr =3D fcntl.ioctl(s.fileno(), SIOCGIFADDR, struct.pack('256s', intf=
.encode('utf-8')))
+    addr =3D socket.inet_ntoa(addr[20:24])
+
+    if ip !=3D addr:
+        raise Exception('IP for %s did not match %s (was %s)' % (intf, ip,=
 addr))
-- =

2.26.2

--===============0954940538733023306==--

