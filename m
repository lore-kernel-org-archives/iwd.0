Content-Type: multipart/mixed; boundary="===============8383438698885148404=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] tools: change print to %zd for ssize_t
Date: Thu, 24 Feb 2022 09:12:07 -0800
Message-ID: <20220224171207.2780029-1-prestwoj@gmail.com>

--===============8383438698885148404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

iwd-decrypt-profile was using %ld which isn't portable.
---
 tools/iwd-decrypt-profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iwd-decrypt-profile.c b/tools/iwd-decrypt-profile.c
index e660c346..e71b56b4 100644
--- a/tools/iwd-decrypt-profile.c
+++ b/tools/iwd-decrypt-profile.c
@@ -196,7 +196,7 @@ int main(int argc, char *argv[])
 		close(fd);
 =

 		if (len < 0) {
-			printf("Unable to write to %s (%ld)\n", outfile, len);
+			printf("Unable to write to %s (%zd)\n", outfile, len);
 			goto failed;
 		}
 	}
-- =

2.34.1

--===============8383438698885148404==--

