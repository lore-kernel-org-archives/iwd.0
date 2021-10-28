Content-Type: multipart/mixed; boundary="===============4330349087415711161=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] test-runner: fix qemu warning for newer versions
Date: Thu, 28 Oct 2021 10:34:10 -0700
Message-ID: <20211028173410.86074-3-prestwoj@gmail.com>
In-Reply-To: 20211028173410.86074-1-prestwoj@gmail.com

--===============4330349087415711161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

warning: short-form boolean option 'readonly' deprecated
Please use readonly=3Don instead
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index a1f86c00..d62f8b51 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1806,7 +1806,7 @@ class Main:
 			'-display', 'none', '-m', '%dM' % ram, '-nographic', '-vga',
 			'none', '-no-acpi', '-no-hpet',
 			'-no-reboot', '-fsdev',
-			'local,id=3Dfsdev-root,path=3D/,readonly,security_model=3Dnone,multidev=
s=3Dremap',
+			'local,id=3Dfsdev-root,path=3D/,readonly=3Don,security_model=3Dnone,mul=
tidevs=3Dremap',
 			'-device',
 			'virtio-9p-pci,fsdev=3Dfsdev-root,mount_tag=3D/dev/root',
 			'-chardev', 'stdio,id=3Dchardev-serial0,signal=3Doff',
-- =

2.31.1

--===============4330349087415711161==--

