Content-Type: multipart/mixed; boundary="===============8365051634366268267=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 08/14] test-runner: add time-travel to kernel config
Date: Thu, 31 Mar 2022 16:16:35 -0700
Message-ID: <20220331231641.484200-8-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============8365051634366268267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This lets UML work with time-travel[=3Dinf-cpu] options.
---
 tools/test_runner_kernel_config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test_runner_kernel_config b/tools/test_runner_kernel_con=
fig
index f29c1781..7806fdb2 100755
--- a/tools/test_runner_kernel_config
+++ b/tools/test_runner_kernel_config
@@ -50,3 +50,4 @@ scripts/config --enable CONFIG_SECURITYFS
 # Options needed for UML
 scripts/config --enable CONFIG_BINFMT_ELF
 scripts/config --enable CONFIG_HOSTFS
+scripts/config --enable CONFIG_UML_TIME_TRAVEL_SUPPORT
-- =

2.34.1

--===============8365051634366268267==--

