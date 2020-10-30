Content-Type: multipart/mixed; boundary="===============4209064739015528661=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] storage: add storage_network_filename_from_path
Date: Fri, 30 Oct 2020 09:34:09 -0700
Message-ID: <20201030163413.2446645-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4209064739015528661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to allow this API to be used simply to get the file name
without extension. AP will be storing provisioning files similarly
to the network format but the extension will not map to existing
security types. Some of the parsing code from
storage_network_ssid_from_path was reused for parsing the file name
and verification.
---
 src/storage.c | 40 ++++++++++++++++++++++++++++++++++------
 src/storage.h |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 00d93933..60fb1bc3 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -287,13 +287,12 @@ char *storage_get_network_file_path(enum security typ=
e, const char *ssid)
 	return path;
 }
 =

-const char *storage_network_ssid_from_path(const char *path,
-							enum security *type)
+static bool parse_file_path(const char *path, char *buf,
+				const char **ext_offset)
 {
 	const char *filename =3D strrchr(path, '/');
 	const char *c, *end;
 	char *decoded;
-	static char buf[67];
 =

 	if (filename)
 		filename++;	/* Skip the / */
@@ -302,8 +301,8 @@ const char *storage_network_ssid_from_path(const char *=
path,
 =

 	end =3D strchr(filename, '.');
 =

-	if (!end || !security_from_str(end + 1, type))
-		return NULL;
+	if (!end)
+		return false;
 =

 	if (filename[0] !=3D '=3D') {
 		if (end =3D=3D filename || end - filename > 32)
@@ -319,7 +318,7 @@ const char *storage_network_ssid_from_path(const char *=
path,
 		memcpy(buf, filename, end - filename);
 		buf[end - filename] =3D '\0';
 =

-		return buf;
+		goto done;
 	}
 =

 	if (end - filename <=3D 1 || end - filename > 65)
@@ -342,6 +341,35 @@ const char *storage_network_ssid_from_path(const char =
*path,
 	strcpy(buf, decoded);
 	l_free(decoded);
 =

+done:
+	if (ext_offset)
+		*ext_offset =3D end;
+
+	return true;
+}
+
+const char *storage_network_filename_from_path(const char *path)
+{
+	static char buf[67];
+
+	if (!parse_file_path(path, buf, NULL))
+		return NULL;
+
+	return buf;
+}
+
+const char *storage_network_ssid_from_path(const char *path,
+							enum security *type)
+{
+	const char *end;
+	static char buf[67];
+
+	if (!parse_file_path(path, buf, &end))
+		return NULL;
+
+	if (!security_from_str(end + 1, type))
+		return NULL;
+
 	return buf;
 }
 =

diff --git a/src/storage.h b/src/storage.h
index 80b63c53..d9b17c7f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -37,6 +37,7 @@ void storage_cleanup_dirs(void);
 char *storage_get_path(const char *format, ...);
 char *storage_get_hotspot_path(const char *format, ...);
 =

+const char *storage_network_filename_from_path(const char *path);
 const char *storage_network_ssid_from_path(const char *path,
 							enum security *type);
 char *storage_get_network_file_path(enum security type, const char *ssid);
-- =

2.26.2

--===============4209064739015528661==--

