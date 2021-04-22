Content-Type: multipart/mixed; boundary="===============4956180635733881898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] test-runner: add timeout for waiting for process to finish
Date: Thu, 22 Apr 2021 10:37:41 -0700
Message-ID: <20210422173746.2324850-2-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4956180635733881898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a process hangs on exit test-runner would sit indefinitely
waiting.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index bbb25925..c3a5ff89 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -242,7 +242,7 @@ class Process:
 		if not wait and not check:
 			return
 =

-		self.pid.wait()
+		self.pid.wait(timeout=3D5)
 		self.killed =3D True
 =

 		self.stdout.seek(self.io_position)
-- =

2.26.2

--===============4956180635733881898==--

