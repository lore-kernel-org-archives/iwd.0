Content-Type: multipart/mixed; boundary="===============6993371034882259208=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 1/8] storage: convert storage to a module
Date: Thu, 10 Feb 2022 14:58:35 -0800
Message-ID: <20220210225842.895962-1-prestwoj@gmail.com>

--===============6993371034882259208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c    |   6 ---
 src/storage.c | 102 ++++++++++++++++++++++++++------------------------
 src/storage.h |   2 -
 3 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/src/main.c b/src/main.c
index d0dbedc8..2102665a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -498,9 +498,6 @@ int main(int argc, char *argv[])
 =

 	exit_status =3D EXIT_FAILURE;
 =

-	if (!storage_create_dirs())
-		goto failed_dirs;
-
 	genl =3D l_genl_new();
 	if (!genl) {
 		l_error("Failed to open generic netlink socket");
@@ -542,9 +539,6 @@ failed_rtnl:
 	l_genl_unref(genl);
 =

 failed_genl:
-	storage_cleanup_dirs();
-
-failed_dirs:
 	l_settings_free(iwd_config);
 	l_timeout_remove(timeout);
 	l_main_exit();
diff --git a/src/storage.c b/src/storage.c
index 4b89c615..6bf0616d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -44,6 +44,7 @@
 =

 #include "src/common.h"
 #include "src/storage.h"
+#include "src/module.h"
 =

 #define STORAGE_DIR_MODE (S_IRUSR | S_IWUSR | S_IXUSR)
 #define STORAGE_FILE_MODE (S_IRUSR | S_IWUSR)
@@ -184,54 +185,6 @@ error_create_dirs:
 	return r;
 }
 =

-bool storage_create_dirs(void)
-{
-	const char *state_dir;
-	char **state_dirs;
-
-	state_dir =3D getenv("STATE_DIRECTORY");
-	if (!state_dir)
-		state_dir =3D DAEMON_STORAGEDIR;
-
-	l_debug("Using state directory %s", state_dir);
-
-	state_dirs =3D l_strsplit(state_dir, ':');
-	if (!state_dirs[0]) {
-		l_strv_free(state_dirs);
-		return false;
-	}
-
-	storage_path =3D l_strdup(state_dirs[0]);
-	l_strv_free(state_dirs);
-
-	if (create_dirs(storage_path)) {
-		l_error("Failed to create %s", storage_path);
-
-		l_free(storage_path);
-
-		return false;
-	}
-
-	storage_hotspot_path =3D l_strdup_printf("%s/hotspot/", storage_path);
-
-	if (create_dirs(storage_hotspot_path)) {
-		l_error("Failed to create %s", storage_hotspot_path);
-
-		l_free(storage_path);
-		l_free(storage_hotspot_path);
-
-		return false;
-	}
-
-	return true;
-}
-
-void storage_cleanup_dirs(void)
-{
-	l_free(storage_path);
-	l_free(storage_hotspot_path);
-}
-
 char *storage_get_path(const char *format, ...)
 {
 	va_list args;
@@ -463,3 +416,56 @@ bool storage_is_file(const char *filename)
 =

 	return false;
 }
+
+static int storage_init(void)
+{
+	const char *state_dir;
+	char **state_dirs;
+	int ret;
+
+	state_dir =3D getenv("STATE_DIRECTORY");
+	if (!state_dir)
+		state_dir =3D DAEMON_STORAGEDIR;
+
+	l_debug("Using state directory %s", state_dir);
+
+	state_dirs =3D l_strsplit(state_dir, ':');
+	if (!state_dirs[0]) {
+		l_strv_free(state_dirs);
+		return -EINVAL;
+	}
+
+	storage_path =3D l_strdup(state_dirs[0]);
+	l_strv_free(state_dirs);
+
+	ret =3D create_dirs(storage_path);
+	if (ret < 0) {
+		l_error("Failed to create %s", storage_path);
+
+		l_free(storage_path);
+
+		return ret;
+	}
+
+	storage_hotspot_path =3D l_strdup_printf("%s/hotspot/", storage_path);
+
+	ret =3D create_dirs(storage_hotspot_path);
+	if (ret < 0) {
+		l_error("Failed to create %s", storage_hotspot_path);
+
+		l_free(storage_path);
+		l_free(storage_hotspot_path);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static void storage_exit(void)
+{
+	l_free(storage_path);
+	l_free(storage_hotspot_path);
+}
+
+IWD_MODULE(storage, storage_init, storage_exit);
diff --git a/src/storage.h b/src/storage.h
index e1ec2cd4..f75185f6 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -33,8 +33,6 @@ ssize_t write_file(const void *buffer, size_t len, bool p=
reserve_times,
 	__attribute__((format(printf, 4, 5)));
 =

 bool storage_is_file(const char *filename);
-bool storage_create_dirs(void);
-void storage_cleanup_dirs(void);
 char *storage_get_path(const char *format, ...);
 char *storage_get_hotspot_path(const char *format, ...);
 =

-- =

2.34.1

--===============6993371034882259208==--

