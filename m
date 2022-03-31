Content-Type: multipart/mixed; boundary="===============2849096078042335463=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 06/14] test-runner: use may_block=True for context
 iteration (and move location)
Date: Thu, 31 Mar 2022 16:16:33 -0700
Message-ID: <20220331231641.484200-6-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============2849096078042335463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows the callers condition to be checked immediately without
the mainloop running. In addition may_block=3DTrue allows the mainloop
to poll/sleep rather than immediately return back to the caller. This
handles async IO much better than may_block=3DFalse, at least for our
use-case.
---
 tools/run-tests | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 94b71ea4..e2993b1b 100755
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

+			context.iteration(may_block=3DTrue)
+
 	def __str__(self):
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
-- =

2.34.1

--===============2849096078042335463==--

