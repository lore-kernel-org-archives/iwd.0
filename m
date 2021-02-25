Content-Type: multipart/mixed; boundary="===============7837224176892448913=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 17/17] test-runner: stop/warn on processes running after test
Date: Thu, 25 Feb 2021 14:01:06 -0800
Message-ID: <20210225220106.1728411-17-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7837224176892448913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gives the dev some inidication their test did not clean up
correctly and running processes remain.
---
 tools/test-runner | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 7c1498d0..eab0f0ab 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -56,6 +56,10 @@ def exit_vm():
 	if config:
 		for p in config.ctx.processes:
 			print("Process %s still running!" % p.name)
+			p.kill()
+			p =3D None
+
+		config.ctx.processes =3D []
 =

 	if config.ctx and config.ctx.results:
 		print_results(config.ctx.results)
-- =

2.26.2

--===============7837224176892448913==--

