Content-Type: multipart/mixed; boundary="===============4926953159970414096=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] test-runner: add monitor to path
Date: Fri, 05 Feb 2021 15:53:07 -0800
Message-ID: <20210205235308.345635-2-prestwoj@gmail.com>
In-Reply-To: <20210205235308.345635-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4926953159970414096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test-runner b/tools/test-runner
index 6fd4dd1f..8b6a57a6 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1230,6 +1230,7 @@ def run_tests():
 	os.environ['PATH'] =3D '%s/src' % args.testhome
 	os.environ['PATH'] +=3D ':%s/tools' % args.testhome
 	os.environ['PATH'] +=3D ':%s/client' % args.testhome
+	os.environ['PATH'] +=3D ':%s/monitor' % args.testhome
 	os.environ['PATH'] +=3D ':%s/wired' % args.testhome
 	os.environ['PATH'] +=3D ':' + args.path
 =

-- =

2.26.2

--===============4926953159970414096==--

