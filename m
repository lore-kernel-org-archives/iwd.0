Content-Type: multipart/mixed; boundary="===============2538927048687507586=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] test-runner: catch exception on test file removal
Date: Wed, 22 Dec 2021 17:12:21 -0800
Message-ID: <20211223011222.20509-1-prestwoj@gmail.com>

--===============2538927048687507586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without catching this can result in a fatal error, ending the
test run.
---
 tools/test-runner | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 7fa8b840..b5c4f777 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1380,7 +1380,10 @@ def post_test(ctx, to_copy):
 	allowed =3D ['phonesim.conf', 'certs', 'secrets', 'iwd']
 	for f in [f for f in os.listdir('/tmp') if f not in allowed]:
 		dbg("File %s was not cleaned up!" % f)
-		os.remove('/tmp/' + f)
+		try:
+			os.remove('/tmp/' + f)
+		except:
+			pass
 =

 def print_results(results):
 	table =3D PrettyTable(['Test', colored('Passed', 'green'), colored('Faile=
d', 'red'), \
-- =

2.31.1

--===============2538927048687507586==--

