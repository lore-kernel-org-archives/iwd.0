Content-Type: multipart/mixed; boundary="===============8659677949574712388=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] storage: add storage_get_ap_path
Date: Fri, 30 Oct 2020 09:34:10 -0700
Message-ID: <20201030163413.2446645-2-prestwoj@gmail.com>
In-Reply-To: <20201030163413.2446645-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8659677949574712388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/storage.c | 30 ++++++++++++++++++++++++++++++
 src/storage.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index 60fb1bc3..e7ac3938 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -50,6 +50,7 @@
 =

 static char *storage_path =3D NULL;
 static char *storage_hotspot_path =3D NULL;
+static char *storage_ap_path =3D NULL;
 =

 static int create_dirs(const char *filename)
 {
@@ -221,6 +222,16 @@ bool storage_create_dirs(void)
 		return false;
 	}
 =

+	storage_ap_path =3D l_strdup_printf("%s/ap/", storage_path);
+
+	if (create_dirs(storage_ap_path)) {
+		l_error("Failed to create %s", storage_ap_path);
+
+		l_free(storage_path);
+		l_free(storage_hotspot_path);
+		l_free(storage_ap_path);
+	}
+
 	return true;
 }
 =

@@ -228,6 +239,7 @@ void storage_cleanup_dirs(void)
 {
 	l_free(storage_path);
 	l_free(storage_hotspot_path);
+	l_free(storage_ap_path);
 }
 =

 char *storage_get_path(const char *format, ...)
@@ -266,6 +278,24 @@ char *storage_get_hotspot_path(const char *format, ...)
 	return str;
 }
 =

+char *storage_get_ap_path(const char *format, ...)
+{
+	va_list args;
+	char *fmt, *str;
+
+	if (!format)
+		return l_strdup(storage_ap_path);
+
+	fmt =3D l_strdup_printf("%s/%s", storage_ap_path, format);
+
+	va_start(args, format);
+	str =3D l_strdup_vprintf(fmt, args);
+	va_end(args);
+
+	l_free(fmt);
+	return str;
+}
+
 char *storage_get_network_file_path(enum security type, const char *ssid)
 {
 	char *path;
diff --git a/src/storage.h b/src/storage.h
index d9b17c7f..a6076d63 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -36,6 +36,7 @@ bool storage_create_dirs(void);
 void storage_cleanup_dirs(void);
 char *storage_get_path(const char *format, ...);
 char *storage_get_hotspot_path(const char *format, ...);
+char *storage_get_ap_path(const char *format, ...);
 =

 const char *storage_network_filename_from_path(const char *path);
 const char *storage_network_ssid_from_path(const char *path,
-- =

2.26.2

--===============8659677949574712388==--

