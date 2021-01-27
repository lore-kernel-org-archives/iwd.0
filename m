Content-Type: multipart/mixed; boundary="===============6535265461631361311=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 3/5] doc: update kernel configuration instructions for KVM
 guests
Date: Wed, 27 Jan 2021 10:05:03 +0000
Message-ID: <20210127100457.341757-3-alsi@bang-olufsen.dk>
In-Reply-To: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6535265461631361311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kvmguest shorthand was removed after the release of Linux 5.10. It
was just shorthand for kvm_guest.config anyway, so update the
test-runner documentation accordingly.
---
 doc/test-runner.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 17d7bbb2..3426d1dc 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -48,7 +48,7 @@ minimal options for a successful boot and execution:
 =

 	<arch>_defconfig 			Default kernel configuration
 =

-	kvmconfig				Default configuration for
+	kvm_guest.config			Default configuration for
 						kvm guests
 =

 	<iwd>/tools/test_runner_kernel_config	The test-runner specific
@@ -62,7 +62,7 @@ as follows:
 =

 	$ make x86_64_defconfig
 =

-	$ make kvmconfig
+	$ make kvm_guest.config
 =

 	$ sh <iwd>/tools/test_runner_kernel_config
 =

-- =

2.29.2
--===============6535265461631361311==--

