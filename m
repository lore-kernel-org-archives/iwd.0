Content-Type: multipart/mixed; boundary="===============9057989233642015689=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: remove warning on mkdir return
Date: Tue, 09 Feb 2021 12:29:41 -0800
Message-ID: <20210209202941.755413-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9057989233642015689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts a previous commit which breaks iwctl. The
check was added to satisfy static analysis but it ended
up preventing iwctl from starting. In this case mkdir
can fail (e.g. if the directory already exists).
---
 client/display.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/client/display.c b/client/display.c
index 4b9ee8f0..961ad419 100644
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

@@ -702,12 +701,7 @@ void display_init(void)
 	}
 =

 	if (data_path) {
-		ret =3D mkdir(data_path, 0700);
-		/* Not much can be done since display isn't even initialized */
-		if (L_WARN_ON(ret < 0)) {
-			l_free(data_path);
-			return;
-		}
+		mkdir(data_path, 0700);
 =

 		history_path =3D l_strdup_printf("%s/history", data_path);
 		read_history(history_path);
-- =

2.26.2

--===============9057989233642015689==--

