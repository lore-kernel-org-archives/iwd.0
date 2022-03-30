Content-Type: multipart/mixed; boundary="===============7195974693424564987=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/7] tools: add UML specific options to the kernel config
Date: Wed, 30 Mar 2022 13:23:10 -0700
Message-ID: <20220330202315.1881335-2-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============7195974693424564987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test_runner_kernel_config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/test_runner_kernel_config b/tools/test_runner_kernel_con=
fig
index c3e65d34..f29c1781 100755
--- a/tools/test_runner_kernel_config
+++ b/tools/test_runner_kernel_config
@@ -46,3 +46,7 @@ scripts/config --enable CONFIG_HW_RANDOM_VIRTIO
 scripts/config --enable CONFIG_HW_RANDOM_INTEL
 #scripts/config --enable CONFIG_HW_RANDOM_AMD
 scripts/config --enable CONFIG_SECURITYFS
+
+# Options needed for UML
+scripts/config --enable CONFIG_BINFMT_ELF
+scripts/config --enable CONFIG_HOSTFS
-- =

2.34.1

--===============7195974693424564987==--

