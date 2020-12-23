Content-Type: multipart/mixed; boundary="===============7505611431851687212=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] crypto: Update l_pkcs5_pbkdf2 call after rename
Date: Thu, 24 Dec 2020 00:22:15 +0100
Message-ID: <20201223232215.1078347-2-andrew.zaborowski@intel.com>
In-Reply-To: <20201223232215.1078347-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7505611431851687212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
This fixes up crypto_psk_from_passphrase after the rename in ell and
should only be applied if/after the commit
"pkcs5: Rename to cert-crypto" is pushed to ell.
---
 src/crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index f5f8e24d..563f17ce 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -552,8 +552,9 @@ int crypto_psk_from_passphrase(const char *passphrase,
 	if (ssid_len =3D=3D 0 || ssid_len > 32)
 		return -ERANGE;
 =

-	result =3D l_pkcs5_pbkdf2(L_CHECKSUM_SHA1, passphrase, ssid, ssid_len,
-				4096, psk, sizeof(psk));
+	result =3D l_cert_pkcs5_pbkdf2(L_CHECKSUM_SHA1, passphrase,
+					ssid, ssid_len, 4096,
+					psk, sizeof(psk));
 	if (!result)
 		return -ENOKEY;
 =

-- =

2.27.0

--===============7505611431851687212==--

