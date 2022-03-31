Content-Type: multipart/mixed; boundary="===============7697083731526177474=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 07/14] test-runner: don't kill dmesg after individual tests
Date: Thu, 31 Mar 2022 16:16:34 -0700
Message-ID: <20220331231641.484200-7-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============7697083731526177474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents any kernel logging from being available after the first
test is finished.
---
 tools/run-tests | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/run-tests b/tools/run-tests
index e2993b1b..c4d133a6 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -186,6 +186,9 @@ class Process(subprocess.Popen):
 	@classmethod
 	def kill_all(cls):
 		for p in cls.processes.values():
+			if p.args[0] =3D=3D 'dmesg':
+				continue
+
 			p.kill()
 =

 	@staticmethod
-- =

2.34.1

--===============7697083731526177474==--

