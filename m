Content-Type: multipart/mixed; boundary="===============1264323869385107906=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] test-runner: fix --help and unknown options
Date: Tue, 05 Apr 2022 11:30:11 -0700
Message-ID: <20220405183011.856403-5-prestwoj@gmail.com>
In-Reply-To: 20220405183011.856403-1-prestwoj@gmail.com

--===============1264323869385107906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If --help or unknown options were supplied to test-runner python
would thrown a maximum recusion depth exception. This was due to
the way ArgumentParser was subclassed.

To fix this call ArgumentParser.__init__() rather than using the
super() method. And do this also for the RunnerCoreArgParse
subclass as well. In addition the namespace argument was removed
from parse_args since its not used, and instead supplied directly
to the parents parse_args method.
---
 tools/runner.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index fc1cab44..0068c74f 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -92,7 +92,7 @@ class RunnerNamespace(Namespace):
 #
 class RunnerCoreArgParse(ArgumentParser):
 	def __init__(self, *args, **kwargs):
-		super().__init__(self, *args, **kwargs)
+		ArgumentParser.__init__(self, *args, **kwargs)
 =

 		self.add_argument('--start', '-s',
 				help=3D'Custom init process in virtual environment',
@@ -154,23 +154,23 @@ class RunnerCoreArgParse(ArgumentParser):
 				dest=3D'valgrind')
 =

 	# Overwrite to use a custom namespace class and parse from env
-	def parse_args(self, *args, namespace=3DRunnerNamespace()):
+	def parse_args(self, *args):
 		if len(sys.argv) > 1:
-			return super().parse_args(*args, namespace=3Dnamespace)
+			return super().parse_args(*args, namespace=3DRunnerNamespace())
 =

 		options =3D []
 		for k, v in os.environ.items():
 			options.append('--' + k)
 			options.append(v)
 =

-		return self.parse_known_args(args=3Doptions, namespace=3Dnamespace)[0]
+		return self.parse_known_args(args=3Doptions, namespace=3DRunnerNamespace=
())[0]
 =

 #
 # Arguments only needed outside the test environment
 #
 class RunnerArgParse(RunnerCoreArgParse):
 	def __init__(self, *args, **kwargs):
-		super().__init__(*args, **kwargs)
+		RunnerCoreArgParse.__init__(self, *args, **kwargs)
 =

 		self.add_argument('--runner', '-r',
 				metavar=3D'<runner type>',
-- =

2.34.1

--===============1264323869385107906==--

