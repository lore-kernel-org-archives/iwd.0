Content-Type: multipart/mixed; boundary="===============6557682698114823724=="
MIME-Version: 1.0
From: Matt Oberle <matt.r.oberle@gmail.com>
Subject: [PATCH 1/3] storage: provide storage_is_file
Date: Mon, 09 Aug 2021 01:27:24 -0400
Message-ID: <20210809052726.177038-1-matt.r.oberle@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6557682698114823724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a function 'storage_is_file' which will use stat to verify a
file's existence given a path relative to the storage directory.

Not all filesystems provide a file type via readdir's d_type.
XFS is a notable system with optional d_type support.
When d_type is not supported stat must be used as a fallback.
If a stat fallback is not provided iwd will fail to load state files.

---
 src/storage.c | 18 ++++++++++++++++++
 src/storage.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index 00d93933..4b89c615 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -29,11 +29,13 @@
 #include <errno.h>
 #include <ctype.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include <string.h>
 #include <stdarg.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <time.h>
+#include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -445,3 +447,19 @@ void storage_known_frequencies_sync(struct l_settings =
*known_freqs)
 =

 	l_free(known_freq_file_path);
 }
+
+bool storage_is_file(const char *filename)
+{
+	char *path;
+	struct stat st;
+	int err;
+
+	path =3D storage_get_path("%s", filename);
+	err =3D stat(path, &st);
+	l_free(path);
+
+	if (!err && S_ISREG(st.st_mode) !=3D 0)
+		return true;
+
+	return false;
+}
diff --git a/src/storage.h b/src/storage.h
index 80b63c53..e1ec2cd4 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -32,6 +32,7 @@ ssize_t write_file(const void *buffer, size_t len, bool p=
reserve_times,
 			const char *path_fmt, ...)
 	__attribute__((format(printf, 4, 5)));
 =

+bool storage_is_file(const char *filename);
 bool storage_create_dirs(void);
 void storage_cleanup_dirs(void);
 char *storage_get_path(const char *format, ...);
-- =

2.32.0

--===============6557682698114823724==--

