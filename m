Content-Type: multipart/mixed; boundary="===============1794530866551121486=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] test-runner: don't reset dbus object on reset()
Date: Thu, 29 Jul 2021 15:21:51 -0700
Message-ID: <20210729222154.159542-6-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1794530866551121486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Doing this is redundant since the dbus object is initialized
anyways when a new test starts.
---
 tools/test-runner | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index ff7d9586..cb97657e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -593,9 +593,6 @@ class Namespace:
 =

 		self.radios =3D []
 =

-		if self.name =3D=3D "root":
-			self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_addres=
s)
-
 		for p in list(self.processes):
 			print("Killing process %s" % p.name)
 			p.kill()
-- =

2.31.1

--===============1794530866551121486==--

