Content-Type: multipart/mixed; boundary="===============4114485391216491537=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] test-runner: Add flags for DHCP and TLS verbose output
Date: Tue, 29 Sep 2020 18:37:12 +0200
Message-ID: <20200929163717.754459-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4114485391216491537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add "iwd-tls" and "iwd-dhcp" flags for -v.  These should automatically
enable "-v iwd" output because of the substring matching.
---
 tools/test-runner | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 00a0978a..dc6b1f7a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -565,6 +565,12 @@ class TestContext:
 		env['CONFIGURATION_DIRECTORY'] =3D config_dir
 		env['STATE_DIRECTORY'] =3D '/var/lib/iwd'
 =

+		if self.is_verbose('iwd-dhcp'):
+			env['IWD_DHCP_DEBUG'] =3D '1'
+
+		if self.is_verbose('iwd-tls'):
+			env['IWD_TLS_DEBUG'] =3D '1'
+
 		pid =3D self.start_process(args, env=3Denv)
 		return pid
 =

-- =

2.25.1

--===============4114485391216491537==--

