Content-Type: multipart/mixed; boundary="===============2326610953162594521=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] main: Fix freeing invalid pointer
Date: Fri, 10 Apr 2020 11:09:42 -0700
Message-ID: <20200410180942.14109-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2326610953162594521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index f8f3043d..8bcbb6a7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -374,6 +374,7 @@ int main(int argc, char *argv[])
 	struct l_dbus *dbus;
 	const char *config_dir;
 	char **config_dirs;
+	int i;
 =

 	for (;;) {
 		int opt;
@@ -456,9 +457,9 @@ int main(int argc, char *argv[])
 =

 	config_dirs =3D l_strsplit(config_dir, ':');
 =

-	for (; *config_dirs; config_dirs++) {
+	for (i =3D 0; config_dirs[i]; i++) {
 		L_AUTO_FREE_VAR(char *, path) =3D
-			l_strdup_printf("%s/%s", *config_dirs, "main.conf");
+			l_strdup_printf("%s/%s", config_dirs[i], "main.conf");
 =

 		if (!l_settings_load_from_file(iwd_config, path))
 			continue;
-- =

2.13.6

--===============2326610953162594521==--

