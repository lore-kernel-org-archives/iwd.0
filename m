Content-Type: multipart/mixed; boundary="===============8348914356520711378=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/7] test-runner: don't kill dmesg after individual tests
Date: Wed, 30 Mar 2022 15:20:57 -0700
Message-ID: <20220330222057.2160244-7-prestwoj@gmail.com>
In-Reply-To: 20220330222057.2160244-1-prestwoj@gmail.com

--===============8348914356520711378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents any kernel logging from being available after the first
test is finished.
---
 tools/run-tests | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/run-tests b/tools/run-tests
index d7213aa7..edb46094 100755
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

--===============8348914356520711378==--

