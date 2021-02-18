Content-Type: multipart/mixed; boundary="===============6841566662399292953=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] test-runner: add __str__ method to Process
Date: Thu, 18 Feb 2021 12:19:32 -0800
Message-ID: <20210218201933.1406654-6-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6841566662399292953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Printing out processes was done manually but instead we can
make Process printing extendable by adding its own __str__
method. This now will print if the process is a multi-test
process as well.
---
 tools/test-runner | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index f898ae1e..c9f624d4 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -310,6 +310,11 @@ class Process:
 			if waited > wait:
 				raise Exception("Timed out waiting for socket")
 =

+	def __str__(self):
+		ret =3D str(self.args) + ' multi_test=3D%s' % str(self.multi_test)
+		ret +=3D '\n'
+		return ret
+
 class Interface:
 	def __init__(self, name, config):
 		self.name =3D name
@@ -678,7 +683,7 @@ class Namespace:
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
 		for p in self.processes:
-			ret +=3D '\t%s\n' % str(p.args)
+			ret +=3D '\t%s' % str(p)
 =

 		ret +=3D 'Radios:\n'
 		if len(self.radios) > 0:
-- =

2.26.2

--===============6841566662399292953==--

