Content-Type: multipart/mixed; boundary="===============2607939230744020278=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] unit: add checksum/random check for test-dpp
Date: Mon, 10 Jan 2022 14:05:35 -0800
Message-ID: <20220110220535.1002289-1-prestwoj@gmail.com>

--===============2607939230744020278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-dpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 1d4846c7..c40fd8b5 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -143,7 +143,9 @@ int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
 =

-	l_test_add("DPP test key derivation", test_key_derivation, NULL);
+	if (l_checksum_is_supported(L_CHECKSUM_SHA256, true) &&
+						l_getrandom_is_supported())
+		l_test_add("DPP test key derivation", test_key_derivation, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============2607939230744020278==--

