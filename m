Content-Type: multipart/mixed; boundary="===============5735348315625873687=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] test-runner: enable scripts to be executed as init
Date: Tue, 05 Apr 2022 11:30:10 -0700
Message-ID: <20220405183011.856403-4-prestwoj@gmail.com>
In-Reply-To: 20220405183011.856403-1-prestwoj@gmail.com

--===============5735348315625873687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This enables CONFIG_BINFMT_SCRIPT which allows the init process to
interpret #! and execute the script rather than requiring a binary
for init.
---
 tools/test_runner_kernel_config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/test_runner_kernel_config b/tools/test_runner_kernel_con=
fig
index 7806fdb2..c7049edd 100755
--- a/tools/test_runner_kernel_config
+++ b/tools/test_runner_kernel_config
@@ -51,3 +51,4 @@ scripts/config --enable CONFIG_SECURITYFS
 scripts/config --enable CONFIG_BINFMT_ELF
 scripts/config --enable CONFIG_HOSTFS
 scripts/config --enable CONFIG_UML_TIME_TRAVEL_SUPPORT
+scripts/config --enable CONFIG_BINFMT_SCRIPT
-- =

2.34.1

--===============5735348315625873687==--

