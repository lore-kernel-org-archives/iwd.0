Content-Type: multipart/mixed; boundary="===============2411414611567340225=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/18] test-runner: don't run duplicate tests
Date: Thu, 12 Aug 2021 13:21:53 -0700
Message-ID: <20210812202207.737053-4-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2411414611567340225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the user provides duplicate tests in the list only append one
of them to the list. This can happen accidentally when using
glob matches.
---
 tools/test-runner | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 939efa51..28c7d900 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1013,15 +1013,17 @@ def build_test_list(args):
 				tests =3D [test_root + '/' + x for x in full_list[i:] \
 							if x.startswith('test')]
 			elif os.path.exists(t):
-				tests.append(t)
+				if t not in tests:
+					tests.append(t)
 			elif os.path.exists(path):
-				tests.append(path)
+				if path not in tests:
+					tests.append(path)
 			else:
 				matches =3D glob(path)
 				if matches =3D=3D []:
 					raise Exception("Could not find test %s" % t)
 =

-				tests.extend(matches)
+				tests.extend(list(set(matches) - set(tests)))
 =

 	return sorted(tests)
 =

-- =

2.31.1

--===============2411414611567340225==--

