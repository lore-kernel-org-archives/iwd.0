Content-Type: multipart/mixed; boundary="===============1769397800079558891=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/7] tools: add some required options to kernel config
Date: Wed, 30 Mar 2022 13:23:09 -0700
Message-ID: <20220330202315.1881335-1-prestwoj@gmail.com>

--===============1769397800079558891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks like some architectures defconfig were adding these in
automatically, but not others. Explicitly add these to make sure
the kernel is built correctly.
---
 tools/test_runner_kernel_config | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/test_runner_kernel_config b/tools/test_runner_kernel_con=
fig
index 64674683..c3e65d34 100755
--- a/tools/test_runner_kernel_config
+++ b/tools/test_runner_kernel_config
@@ -1,8 +1,12 @@
 #! /bin/sh
 =

+scripts/config --enable CONFIG_CFG80211
+scripts/config --enable CONFIG_MAC80211
 scripts/config --enable CONFIG_MAC80211_HWSIM
 scripts/config --enable CONFIG_NLMON
 scripts/config --enable CONFIG_VLAN_8021Q
+scripts/config --enable CONFIG_RFKILL
+scripts/config --enable CONFIG_IPV6
 =

 scripts/config --enable CONFIG_EXPERT
 scripts/config --enable CONFIG_CFG80211_CERTIFICATION_ONUS
@@ -16,14 +20,21 @@ scripts/config --enable CONFIG_CRYPTO_RSA
 scripts/config --enable CONFIG_CRYPTO_AES_X86_64
 scripts/config --enable CONFIG_CRYPTO_AES_NI_INTEL
 scripts/config --enable CONFIG_CRYPTO_MD4
+scripts/config --enable CONFIG_CRYPTO_MD5
+scripts/config --enable CONFIG_CRYPTO_SHA1
+scripts/config --enable CONFIG_CRYPTO_SHA256
+scripts/config --enable CONFIG_CRYPTO_SHA512
 scripts/config --enable CONFIG_CRYPTO_SHA1_SSSE3
 scripts/config --enable CONFIG_CRYPTO_SHA256_SSSE3
 scripts/config --enable CONFIG_CRYPTO_SHA512_SSSE3
 scripts/config --enable CONFIG_CRYPTO_ECB
+scripts/config --enable CONFIG_CRYPTO_CBC
 scripts/config --enable CONFIG_CRYPTO_CMAC
 scripts/config --enable CONFIG_CRYPTO_DES
 scripts/config --enable CONFIG_CRYPTO_DES3_EDE_X86_64
 scripts/config --enable CONFIG_CRYPTO_ARC4
+scripts/config --enable CONFIG_CRYPTO_HMAC
+scripts/config --enable CONFIG_KEYS
 scripts/config --enable CONFIG_KEY_DH_OPERATIONS
 scripts/config --enable CONFIG_ASYMMETRIC_KEY_TYPE
 scripts/config --enable CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-- =

2.34.1

--===============1769397800079558891==--

