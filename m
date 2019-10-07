Content-Type: multipart/mixed; boundary="===============8822770293518469188=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] tools: ios_convert: embed certs rather than using paths
Date: Mon, 07 Oct 2019 13:13:00 -0700
Message-ID: <20191007201300.2955-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8822770293518469188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/ios_convert.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/ios_convert.py b/tools/ios_convert.py
index 8aa10113..d3b6cc8d 100755
--- a/tools/ios_convert.py
+++ b/tools/ios_convert.py
@@ -114,7 +114,7 @@ def write_network(network, root_ca_path):
                 output +=3D "EAP-Identity=3Danonymous\n"
 =

         if root_ca_path:
-                output +=3D "EAP-%s-CACert=3D%s\n" % (eap, root_ca_path)
+                output +=3D "EAP-%s-CACert=3Dembed:root_ca\n" % eap
 =

         output +=3D "EAP-%s-Phase2-Method=3DTunneled-%s\n" % \
                                                         (eap, network.inne=
r_eap)
@@ -158,6 +158,12 @@ def write_network(network, root_ca_path):
 =

         output +=3D "\n"
 =

+        if root_ca_path:
+                output +=3D "[@pem(a)root_ca]\n"
+                with open(root_ca_path) as f:
+                        output +=3D f.read()
+                output +=3D '\n'
+
         print("Provisioning network %s\n" % conf_file)
 =

         if args.verbose:
-- =

2.17.1

--===============8822770293518469188==--

