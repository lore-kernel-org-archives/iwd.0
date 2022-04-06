Content-Type: multipart/mixed; boundary="===============8490193155515626148=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 10/10] test-runner: allow decode failure when writing IO
Date: Wed, 06 Apr 2022 12:14:53 -0700
Message-ID: <20220406191453.978426-10-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============8490193155515626148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If this fails, e.g. an invalid utf-8 character it should not cause
the test to fail.
---
 tools/utils.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index be4c8638..55db4227 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -168,7 +168,10 @@ class Process(subprocess.Popen):
 		if not data:
 			return True
 =

-		data =3D data.decode('utf-8')
+		try:
+			data =3D data.decode('utf-8')
+		except:
+			return True
 =

 		# Save data away in case the caller needs it (e.g. list_sta)
 		self.out +=3D data
-- =

2.34.1

--===============8490193155515626148==--

