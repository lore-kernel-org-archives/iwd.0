Content-Type: multipart/mixed; boundary="===============6409338723933171816=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] test-runner: fix check for phonesim
Date: Wed, 06 Apr 2022 15:08:55 -0700
Message-ID: <20220406220856.996243-1-prestwoj@gmail.com>

--===============6409338723933171816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This got changed to use which, but not updated to remove the
list argument.
---
 tools/run-tests | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/run-tests b/tools/run-tests
index 78665de1..7e61b6b1 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -461,7 +461,7 @@ class TestContext(Namespace):
 			os.environ['IWD_SIM_KEYS'] =3D sim_keys
 			return
 =

-		if not shutil.which('ofonod') or not shutil.which(['phonesim']):
+		if not shutil.which('ofonod') or not shutil.which('phonesim'):
 			print("Ofono or Phonesim not found, skipping test")
 			return
 =

-- =

2.34.1

--===============6409338723933171816==--

