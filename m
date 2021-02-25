Content-Type: multipart/mixed; boundary="===============7942471648089060028=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/17] test-runner: fix Namespace class ref problems
Date: Thu, 25 Feb 2021 14:01:03 -0800
Message-ID: <20210225220106.1728411-14-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7942471648089060028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Namespace class was never being removed when tests finished.
This is fixed by unreffing the hwsim internal _radio object which
both cleans up the radio and allows the Namespace to be removed.
---
 tools/test-runner | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index ae02578e..19272774 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -565,11 +565,9 @@ class Hostapd:
 dbus_count =3D 0
 =

 class Namespace:
-	dbus_address =3D None
-	processes =3D []
-	radios =3D []
-
 	def __init__(self, args, name, radios):
+		self.dbus_address =3D None
+		self.processes =3D []
 		self.name =3D name
 		self.radios =3D radios
 		self.args =3D args
@@ -581,9 +579,13 @@ class Namespace:
 		self.start_dbus()
 =

 	def reset(self):
-		self.radios =3D []
 		self._bus =3D None
 =

+		for r in self.radios:
+			r._radio =3D None
+
+		self.radios =3D []
+
 		if self.name =3D=3D "root":
 			self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_addres=
s)
 =

@@ -595,7 +597,6 @@ class Namespace:
 =

 	def __del__(self):
 		print("Removing namespace %s" % self.name)
-		self.reset()
 =

 		Process(['ip', 'netns', 'del', self.name], wait=3DTrue)
 =

-- =

2.26.2

--===============7942471648089060028==--

