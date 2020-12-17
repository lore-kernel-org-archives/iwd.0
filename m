Content-Type: multipart/mixed; boundary="===============6344400413495002122=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/11] test-runner: Use DBus for hwsim radios
Date: Thu, 17 Dec 2020 11:36:10 -0800
Message-ID: <20201217193611.1177006-10-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6344400413495002122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the hwsim DBus API rather than command line. This both is
faster and more dynamic than doing so with the command line.
This also avoids tracking the radio ID since we can just hang
on to the radio Dbus object directly.
---
 tools/test-runner | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 16628399..7bd15a28 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -41,7 +41,6 @@ TIOCSTTY =3D 0x540E
 =

 config =3D None
 intf_id =3D 0
-rad_id =3D 0
 =

 TEST_MAX_TIMEOUT =3D 120
 =

@@ -314,35 +313,26 @@ class VirtualRadio(Radio):
 		than the command line.
 	'''
 	def __init__(self, name, config=3DNone):
-		global rad_id
-
-		super().__init__(name)
-
 		self.disable_cipher =3D None
 		self.disable_iftype =3D None
 =

-		args =3D ['hwsim', '--create', '--name', self.name, '--nointerface', '--=
p2p']
+		hwsim =3D importlib.import_module('hwsim').Hwsim()
 =

 		if config:
-			self.disable_iftype =3D config.get('iftype_disable', False)
-			if self.disable_iftype:
-				args.append('--iftype-disable')
-				args.append(self.disable_iftype)
-
-			self.disable_cipher =3D config.get('cipher_disable', False)
-			if self.disable_cipher:
-				args.append('--cipher-disable')
-				args.append(self.disable_cipher)
+			self.disable_iftype =3D config.get('iftype_disable', None)
+			self.disable_cipher =3D config.get('cipher_disable', None)
 =

-		Process(args, wait=3DTrue)
+		self._radio =3D hwsim.radios.create(name, p2p_device=3DTrue,
+					iftype_disable=3Dself.disable_iftype,
+					cipher_disable=3Dself.disable_cipher)
 =

-		self.id =3D rad_id
-		rad_id +=3D 1
+		super().__init__(self._radio.name)
 =

 	def __del__(self):
 		super().__del__()
 =

-		Process(['hwsim', '--destroy=3D%s' % self.id])
+		self._radio.remove()
+		self._radio =3D None
 =

 	def __str__(self):
 		ret =3D super().__str__()
-- =

2.26.2

--===============6344400413495002122==--

