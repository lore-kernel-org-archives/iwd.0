Content-Type: multipart/mixed; boundary="===============1403644679215485714=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] client: remove warning on mkdir return
Date: Tue, 09 Feb 2021 12:37:13 -0800
Message-ID: <20210209203713.756142-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1403644679215485714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes up a previous commit which breaks iwctl. The
check was added to satisfy static analysis but it ended
up preventing iwctl from starting. In this case mkdir
can fail (e.g. if the directory already exists) and only
if it fails should the history be read. Otherwise a
successful mkdir return indicates the history folder is
new and there is no reason to try reading it.
---
 client/display.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/client/display.c b/client/display.c
index 4b9ee8f0..07cb7bda 100644
--- a/client/display.c
+++ b/client/display.c
@@ -681,7 +681,6 @@ void display_init(void)
 {
 	const char *data_home;
 	char *data_path;
-	int ret;
 =

 	display_refresh.redo_entries =3D l_queue_new();
 =

@@ -702,16 +701,15 @@ void display_init(void)
 	}
 =

 	if (data_path) {
-		ret =3D mkdir(data_path, 0700);
-		/* Not much can be done since display isn't even initialized */
-		if (L_WARN_ON(ret < 0)) {
-			l_free(data_path);
-			return;
+		/*
+		 * If mkdir succeeds that means its a new directory, no need
+		 * to read the history since it doesn't exist
+		 */
+		if (mkdir(data_path, 0700) !=3D 0) {
+			history_path =3D l_strdup_printf("%s/history", data_path);
+			read_history(history_path);
 		}
 =

-		history_path =3D l_strdup_printf("%s/history", data_path);
-		read_history(history_path);
-
 		l_free(data_path);
 	} else {
 		history_path =3D NULL;
-- =

2.26.2

--===============1403644679215485714==--

