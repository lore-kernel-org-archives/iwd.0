Content-Type: multipart/mixed; boundary="===============7453972183926326688=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/7] test-runner: move context iteration until after value
 checks
Date: Wed, 30 Mar 2022 15:20:56 -0700
Message-ID: <20220330222057.2160244-6-prestwoj@gmail.com>
In-Reply-To: 20220330222057.2160244-1-prestwoj@gmail.com

--===============7453972183926326688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows the callers condition to be checked immediately without
the mainloop running.
---
 tools/run-tests | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 94b71ea4..d7213aa7 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -722,8 +722,6 @@ class Namespace:
 		context =3D mainloop.get_context()
 =

 		while True:
-			context.iteration(may_block=3DFalse)
-
 			try:
 				ret =3D func(*args)
 				if ret:
@@ -735,8 +733,6 @@ class Namespace:
 					GLib.source_remove(timeout)
 				raise e
 =

-			sleep(0.1)
-
 			if done.value =3D=3D True:
 				if isinstance(exception, Exception):
 					raise exception
@@ -745,6 +741,8 @@ class Namespace:
 				else:
 					return
 =

+			context.iteration(may_block=3DFalse)
+
 	def __str__(self):
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
-- =

2.34.1

--===============7453972183926326688==--

