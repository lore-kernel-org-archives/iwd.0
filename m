Content-Type: multipart/mixed; boundary="===============2634725895553273808=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] test-runner: only remove GLib timeout if it exists
Date: Fri, 13 Aug 2021 15:45:54 -0700
Message-ID: <20210813224554.816379-4-prestwoj@gmail.com>
In-Reply-To: <20210813224554.816379-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2634725895553273808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There was a race condition here where the GLib timeout could have
fired but the test function returned successfully prior to the
end of the while loop. This would end up causing source_remove to
print a warning that the source did not exist.

Instead check if the timeout fired prior to removing it.
---
 tools/test-runner | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 5a8006a5..dcb1ba5e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -751,10 +751,12 @@ class Namespace:
 			try:
 				ret =3D func(*args)
 				if ret:
-					GLib.source_remove(timeout)
+					if not done.value:
+						GLib.source_remove(timeout)
 					return ret
 			except Exception as e:
-				GLib.source_remove(timeout)
+				if not done.value:
+					GLib.source_remove(timeout)
 				raise e
 =

 			sleep(0.1)
-- =

2.31.1

--===============2634725895553273808==--

