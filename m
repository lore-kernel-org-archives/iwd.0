Content-Type: multipart/mixed; boundary="===============5294143139605913337=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/5] test-runner: set DBUS_SYSTEM_BUS_ADDRESS for --shell
Date: Thu, 23 Sep 2021 15:57:25 -0700
Message-ID: <20210923225728.556306-2-prestwoj@gmail.com>
In-Reply-To: 20210923225728.556306-1-prestwoj@gmail.com

--===============5294143139605913337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After namespaces were added, the dbus address was customized to
be /tmp/dbus{0..N}. This prevented any dbus applications started
in the shell from working properly.

Set DBUS_SYSTEM_BUS_ADDRESS to the environment prior to entering
the shell.
---
 tools/test-runner | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test-runner b/tools/test-runner
index b0d6554d..a1967173 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1416,6 +1416,7 @@ def run_auto_tests(ctx, args):
 				# a set of tests was passed in just start out in the first.
 				#
 				os.chdir(tests[0])
+				os.environ['DBUS_SYSTEM_BUS_ADDRESS'] =3D ctx.dbus_address
 				os.system('/bin/bash')
 				exit()
 =

-- =

2.31.1

--===============5294143139605913337==--

