Content-Type: multipart/mixed; boundary="===============1304214491218274221=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] test-runner: fix process cleanup loop
Date: Thu, 22 Apr 2021 10:37:40 -0700
Message-ID: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1304214491218274221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The processes in the list ultimately get removed for each
kill() call. This causes strange behavior since the list is
being iterated and each iteration is removing items. Instead
iterate over a new temporary list so the actual process list
can be cleaned up.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index fce3eed4..bbb25925 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -599,7 +599,7 @@ class Namespace:
 		if self.name =3D=3D "root":
 			self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_addres=
s)
 =

-		for p in self.processes:
+		for p in list(self.processes):
 			print("Killing process %s" % p.name)
 			p.kill()
 =

-- =

2.26.2

--===============1304214491218274221==--

