Content-Type: multipart/mixed; boundary="===============8689736916733799768=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] test-runner: set processor count for VM
Date: Thu, 10 Dec 2020 09:45:25 -0800
Message-ID: <20201210174525.874021-9-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8689736916733799768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For better reliability the processor count is now set to qemu.
In cases of low CPU count (< 2) hosts the processor count is
limited to 1. Otherwise half of the host cores will be used for
the VM.
---
 tools/test-runner | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 3628e45e..bc580a41 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1405,6 +1405,19 @@ class Main:
 			'kernel'
 		]
 =

+		nproc =3D multiprocessing.cpu_count()
+
+		#
+		# Specially handle CPU systems with minimal cores, otherwise
+		# use half the host cores.
+		#
+		if nproc < 2:
+			smp =3D 1
+		else:
+			smp =3D int(nproc / 2)
+
+		print("Using %d cores for VM" % smp)
+
 		#
 		# This passes through most of the command line options to
 		# the kernel command line. Some are not relevant (e.g. qemu)
@@ -1443,7 +1456,7 @@ class Main:
 				rootflags=3Dtrans=3Dvirtio,version=3D9p2000.u \
 				acpi=3Doff pci=3Dnoacpi %s ro \
 				mac80211_hwsim.radios=3D0 %s' % (kern_log, options),
-			'-cpu', 'host'
+			'-cpu', 'host', '-smp', str(smp)
 		]
 =

 		# Add two ethernet devices for testing EAD
-- =

2.26.2

--===============8689736916733799768==--

