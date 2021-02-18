Content-Type: multipart/mixed; boundary="===============6136371929198157175=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] test-runner: require root user to run with --monitor
Date: Thu, 18 Feb 2021 12:19:29 -0800
Message-ID: <20210218201933.1406654-3-prestwoj@gmail.com>
In-Reply-To: <20210218201933.1406654-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6136371929198157175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the monitor file requires touching the host file
system, root access is required.
---
 tools/test-runner | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index a390014b..8bf8d363 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1434,6 +1434,10 @@ class Main:
 			options +=3D ' --log-uid %u' % uid
 =

 		if self.args.monitor:
+			if os.environ.get('SUDO_GID', None) is None:
+				print("--monitor can only be used as root user")
+				quit()
+
 			self.args.monitor =3D os.path.abspath(self.args.monitor)
 			mon_parent_dir =3D os.path.abspath(os.path.join(self.args.monitor, os.p=
ardir))
 =

-- =

2.26.2

--===============6136371929198157175==--

