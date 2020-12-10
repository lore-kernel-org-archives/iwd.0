Content-Type: multipart/mixed; boundary="===============4225669757119308491=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] test-runner: add iwd-acd to verbose options
Date: Thu, 10 Dec 2020 09:45:24 -0800
Message-ID: <20201210174525.874021-8-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4225669757119308491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will turn on IWD_ACD_DEBUG
---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index c2ff7eff..3628e45e 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -586,6 +586,9 @@ class Namespace:
 		if self.is_verbose('iwd-genl'):
 			env['IWD_GENL_DEBUG'] =3D '1'
 =

+		if self.is_verbose('iwd-acd'):
+			env['IWD_ACD_DEBUG'] =3D '1'
+
 		pid =3D self.start_process(args, env=3Denv)
 		return pid
 =

-- =

2.26.2

--===============4225669757119308491==--

