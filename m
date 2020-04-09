Content-Type: multipart/mixed; boundary="===============1372325023034379514=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/3] main: Simplify config file search logic
Date: Wed, 08 Apr 2020 18:44:17 -0700
Message-ID: <20200409014417.10029-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200409014417.10029-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1372325023034379514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/src/main.c b/src/main.c
index b5ccc63b..a0384179 100644
--- a/src/main.c
+++ b/src/main.c
@@ -374,7 +374,6 @@ int main(int argc, char *argv[])
 	struct l_dbus *dbus;
 	const char *config_dir;
 	char **config_dirs;
-	int i;
 =

 	for (;;) {
 		int opt;
@@ -456,18 +455,18 @@ int main(int argc, char *argv[])
 	iwd_config =3D l_settings_new();
 =

 	config_dirs =3D l_strsplit(config_dir, ':');
-	for (i =3D 0; config_dirs[i]; i++) {
-		char *path =3D l_strdup_printf("%s/%s", config_dirs[i],
-								"main.conf");
-		bool result =3D l_settings_load_from_file(iwd_config, path);
-		l_free(path);
-
-		if (result) {
-			l_info("Loaded configuration from %s/main.conf",
-							config_dirs[i]);
-			break;
-		}
+
+	for (; *config_dirs; config_dirs++) {
+		L_AUTO_FREE_VAR(char *, path) =3D
+			l_strdup_printf("%s/%s", *config_dirs, "main.conf");
+
+		if (!l_settings_load_from_file(iwd_config, path))
+			continue;
+
+		l_info("Loaded configuration from %s", path);
+		break;
 	}
+
 	l_strv_free(config_dirs);
 =

 	__eapol_set_config(iwd_config);
-- =

2.13.6

--===============1372325023034379514==--

