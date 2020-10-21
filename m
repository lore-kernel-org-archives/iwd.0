Content-Type: multipart/mixed; boundary="===============9181432240655962296=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] test-runner: add switch for genl debugging
Date: Wed, 21 Oct 2020 14:36:52 -0700
Message-ID: <20201021213652.1791048-2-prestwoj@gmail.com>
In-Reply-To: <20201021213652.1791048-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9181432240655962296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Providing 'iwd-genl' in the list of verbose options will enable
IWD_GENL_DEBUG.
---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 10db4c78..3ae4558c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -578,6 +578,9 @@ class TestContext:
 		if self.is_verbose('iwd-tls'):
 			env['IWD_TLS_DEBUG'] =3D '1'
 =

+		if self.is_verbose('iwd-genl'):
+			env['IWD_GENL_DEBUG'] =3D '1'
+
 		pid =3D self.start_process(args, env=3Denv)
 		return pid
 =

-- =

2.26.2

--===============9181432240655962296==--

