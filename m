Content-Type: multipart/mixed; boundary="===============0062876703063858132=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 02/10] test-runner: remove path_exists/find_binary
Date: Wed, 06 Apr 2022 12:14:45 -0700
Message-ID: <20220406191453.978426-2-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============0062876703063858132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are already implemented in the shutil module
---
 tools/run-tests | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 4291250a..a95a7494 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -57,28 +57,6 @@ def exit_vm():
 =

 	runner.stop()
 =

-def path_exists(path):
-	'''
-		Searches PATH as well as absolute paths.
-	'''
-	if shutil.which(path):
-		return True
-	try:
-		os.stat(path)
-	except:
-		return False
-	return True
-
-def find_binary(list):
-	'''
-		Returns a binary from 'list' if its found in PATH or on a
-		valid absolute path.
-	'''
-	for path in list:
-		if path_exists(path):
-			return path
-	return None
-
 class Interface:
 	def __init__(self, name, config):
 		self.name =3D name
@@ -529,7 +507,7 @@ class TestContext(Namespace):
 			os.environ['IWD_SIM_KEYS'] =3D sim_keys
 			return
 =

-		if not find_binary(['ofonod']) or not find_binary(['phonesim']):
+		if not shutil.which('ofonod') or not shutil.which(['phonesim']):
 			print("Ofono or Phonesim not found, skipping test")
 			return
 =

-- =

2.34.1

--===============0062876703063858132==--

