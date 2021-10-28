Content-Type: multipart/mixed; boundary="===============0762353559939166347=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] test-runner: handle pyroute2 IW() between versions
Date: Thu, 28 Oct 2021 10:34:09 -0700
Message-ID: <20211028173410.86074-2-prestwoj@gmail.com>
In-Reply-To: 20211028173410.86074-1-prestwoj@gmail.com

--===============0762353559939166347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It appears different versions of pyroute2 may or may not have
iwutil, and instead use pyroute2.IW() directly. Try the iwutil
way first, then pyroute2.IW()
---
 tools/test-runner | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 6c7a7e45..a1f86c00 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -853,7 +853,11 @@ class TestContext(Namespace):
 =

 	def discover_radios(self):
 		phys =3D []
-		iw =3D pyroute2.iwutil.IW()
+
+		try:
+			iw =3D pyroute2.iwutil.IW()
+		except:
+			iw =3D pyroute2.IW()
 =

 		attrs =3D [phy['attrs'] for phy in iw.list_wiphy()]
 =

-- =

2.31.1

--===============0762353559939166347==--

