Content-Type: multipart/mixed; boundary="===============5058313458665504186=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix Radio/Interface circular reference
Date: Tue, 03 Nov 2020 09:03:06 -0800
Message-ID: <20201103170306.2653870-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5058313458665504186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Code was added with commit 04487f575b6 which passes a radio object
to the Interface class constructor and stores it in the Interface
object. The radio class also stores each Interface object which
creates a circular reference and causes the Radio to stick around
long after the tests finishes.

I cannot see why the Interface needs to keep track of the Radio
object. None of the wpa_supplicant utilities use this so it has
been removed.
---
 tools/test-runner | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 3ae4558c..b4840fa4 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -246,11 +246,10 @@ class Process:
 				raise Exception("Timed out waiting for socket")
 =

 class Interface:
-	def __init__(self, name, config, radio):
+	def __init__(self, name, config):
 		self.name =3D name
 		self.ctrl_interface =3D '/var/run/hostapd/' + name
 		self.config =3D config
-		self.radio =3D radio
 =

 	def __del__(self):
 		Process(['iw', 'dev', self.name, 'del'], True)
@@ -276,7 +275,7 @@ class Radio:
 =

 		intf_id +=3D 1
 =

-		self.interface =3D Interface(ifname, config, self)
+		self.interface =3D Interface(ifname, config)
 		self.use =3D use
 =

 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
-- =

2.26.2

--===============5058313458665504186==--

