Content-Type: multipart/mixed; boundary="===============4382425292638691402=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] doc: Update the test-runner documentation
Date: Thu, 07 Apr 2022 09:39:31 -0700
Message-ID: <20220407163931.1137665-1-prestwoj@gmail.com>

--===============4382425292638691402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Includes instructions for UML, which is now the preferred way to use
test-runner.
---
 doc/test-runner.txt | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 081a056f..f286785e 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -8,7 +8,6 @@ test-runner is an automated test execution tool for IWD. It=
 is capable of
 creating the emulated environments representing a variety of network topol=
ogies
 and run the automated tests of IWD functionality.
 =

-
 Software Prerequisites
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

@@ -30,6 +29,7 @@ OS:
 	12. phonesim (optional)
 	13. wpa_supplicant	2.9
 	14. radvd		2.18
+	15. dhcpd
 =

 Note: The version for hostapd is listed as 'recent'. Older hostapd versions
 will work but we are continually adopting new features from hostapd and us=
ing
@@ -54,34 +54,48 @@ In addition, the following Python packages are required:
 Building Kernel
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

+test-runner can work both in a fully virtualized environment (QEMU) or ins=
ide
+a UML (User Mode Linux) instance. Its recommended using UML as its both fa=
ster
+and more reliable than QEMU for timing specific scenarios. When building t=
he
+kernel for UML its important to always specify ARCH=3Dum for any build com=
mand.
+The default architectures seem to muck with the kernel config that UML nee=
ds
+and will likely result in a UML binary that won't run under test-runner.
+
 The test-runner tool requires a kernel that is at least build with these
 minimal options for a successful boot and execution:
 =

 	<arch>_defconfig 			Default kernel configuration
 =

 	kvm_guest.config			Default configuration for
-						kvm guests
+						kvm guests (QEMU only)
 =

 	<iwd>/tools/test_runner_kernel_config	The test-runner specific
 						configuration
 =

 These configurations should be installed as .config in the kernel source
-directory. To make a x86_64 guest kernel the sequence of commands may look
+directory. To build a x86_64 UML kernel the sequence of commands may look
 as follows:
 =

 	$ cd linux-X.X.X
 =

-	$ make x86_64_defconfig
-
-	$ make kvm_guest.config
+	$ make ARCH=3Dum x86_64_defconfig
 =

-	$ sh <iwd>/tools/test_runner_kernel_config
+	$ ARCH=3Dum sh <iwd>/tools/test_runner_kernel_config
 =

-	$ make olddefconfig
+	$ make ARCH=3Dum olddefconfig
 =

 After that a default kernel with the required options can be built:
 =

-	$ make -j$(nproc)
+	$ make ARCH=3Dum -j$(nproc)
+
+If you do need to build a QEMU kernel you can remove ARCH=3Dum and make the
+kvm_guest.config target as well.
+
+After building (for UML) there should be a 'linux' executable at the root =
of the
+repository, this is the UML binary that should be supplied to test-runner =
with
+the --kernel,-k option.
+
+For QEMU it is instead a kernel image located at arch/boot/<arch>/bzImage.
 =

 Note: If your host distribution does not contain a regulatory.db you may g=
et an
 error similar to this when building the kernel:
@@ -136,7 +150,7 @@ tests shipped with IWD:
 =

 	$ cd <iwd>/tools
 =

-	$ sudo ./test-runner
+	$ sudo ./test-runner -k <kernel binary>
 =

 One can specify a particular set of test configurations to be executed by =
using
 '-A <dir1,dir2>' parameter. An absolute path is necessary for the test
-- =

2.34.1

--===============4382425292638691402==--

