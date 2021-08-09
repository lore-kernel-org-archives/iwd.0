Content-Type: multipart/mixed; boundary="===============5340608065818834330=="
MIME-Version: 1.0
From: Matt Oberle <matt.r.oberle@gmail.com>
Subject: [PATCH 3/3] hotspot: stat fallback for unknown d_type
Date: Mon, 09 Aug 2021 01:27:26 -0400
Message-ID: <20210809052726.177038-3-matt.r.oberle@gmail.com>
In-Reply-To: <20210809052726.177038-1-matt.r.oberle@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5340608065818834330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Utilize 'storage_is_file' when readdir returns DT_UNKNOWN to ensure
features like autoconnect work on filesystems that don't return a d_type
(eg. XFS).
---
 src/hotspot.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index e99b2a38..17e8577e 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -495,12 +495,16 @@ static int hotspot_init(void)
 		char *filename;
 		struct network_config config;
 =

-		if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK)
-			continue;
-
 		filename =3D l_strdup_printf("%s/%s", hs20_dir, dirent->d_name);
 		s =3D l_settings_new();
 =

+		if (dirent->d_type =3D=3D DT_UNKNOWN) {
+			if (!storage_is_file(filename))
+				goto next;
+		} else if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK) {
+			goto next;
+		}
+
 		if (!l_settings_load_from_file(s, filename))
 			goto next;
 =

-- =

2.32.0

--===============5340608065818834330==--

