Content-Type: multipart/mixed; boundary="===============3129739252849791153=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] test-runner: pass **kwargs in dbg()
Date: Thu, 12 Aug 2021 16:07:15 -0700
Message-ID: <20210812230716.747378-2-prestwoj@gmail.com>
In-Reply-To: <20210812230716.747378-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3129739252849791153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index f18ae538..1ee2d6a6 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -46,11 +46,11 @@ TEST_MAX_TIMEOUT =3D 120
 =

 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

-def dbg(*s):
+def dbg(*s, **kwargs):
 	'''
 		Allows prints if stdout has been re-directed
 	'''
-	print(*s, file=3Dsys.__stdout__)
+	print(*s, **kwargs, file=3Dsys.__stdout__)
 =

 def exit_vm():
 	if config:
-- =

2.31.1

--===============3129739252849791153==--

