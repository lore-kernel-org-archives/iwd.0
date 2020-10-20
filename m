Content-Type: multipart/mixed; boundary="===============5525614571594092344=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/13] storage: allow NULL type on
 storage_network_ssid_from_path
Date: Tue, 20 Oct 2020 11:02:47 -0700
Message-ID: <20201020180256.1630120-4-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5525614571594092344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to allow this API to be used simply to get the file name
without extension. AP will be storing provisioning files similarly
to the network format but the extension will not map to existing
security types. For this case it makes sense to allow a NULL type
which will prevent the security type from being set/parsed.
---
 src/storage.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/storage.c b/src/storage.c
index 00d93933..9ef84e32 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -287,6 +287,11 @@ char *storage_get_network_file_path(enum security type=
, const char *ssid)
 	return path;
 }
 =

+/*
+ * Get filename (without extension) which IWD treats as an SSID. Optionally
+ * parse the extension to get the security type (*.psk, *.open, *.8021x) by
+ * providing a 'type' pointer.
+ */
 const char *storage_network_ssid_from_path(const char *path,
 							enum security *type)
 {
@@ -302,7 +307,10 @@ const char *storage_network_ssid_from_path(const char =
*path,
 =

 	end =3D strchr(filename, '.');
 =

-	if (!end || !security_from_str(end + 1, type))
+	if (!end)
+		return NULL;
+
+	if (type && !security_from_str(end + 1, type))
 		return NULL;
 =

 	if (filename[0] !=3D '=3D') {
-- =

2.26.2

--===============5525614571594092344==--

