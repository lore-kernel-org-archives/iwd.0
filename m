Content-Type: multipart/mixed; boundary="===============6886918648564664468=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] test-runner: fix verbose arguments as single string
Date: Tue, 26 Jan 2021 09:46:54 -0800
Message-ID: <20210126174657.867692-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6886918648564664468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The verbose arguments come in from the QEMU command line as a
single string. This should have been split into an array immediately
but was not. This led to issues like hostapd debug being enabled
when "-v hostapd_cli" was passed in.
---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 3ba49953..fba589e3 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1212,6 +1212,9 @@ def run_tests():
 	if not args.debug:
 		sys.stdout =3D open(os.devnull, 'w')
 =

+	if args.verbose !=3D []:
+		args.verbose =3D args.verbose.split(',')
+
 	os.environ['PATH'] =3D '%s/src' % args.testhome
 	os.environ['PATH'] +=3D ':%s/tools' % args.testhome
 	os.environ['PATH'] +=3D ':%s/client' % args.testhome
-- =

2.26.2

--===============6886918648564664468==--

