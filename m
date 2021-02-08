Content-Type: multipart/mixed; boundary="===============3168146277947595336=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] client: check mkdir return in display_init
Date: Mon, 08 Feb 2021 12:19:55 -0800
Message-ID: <20210208201958.607049-2-prestwoj@gmail.com>
In-Reply-To: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3168146277947595336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Printing a warning is about all that we can do at this
point during initialization.
---
 client/display.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 961ad419..4b9ee8f0 100644
--- a/client/display.c
+++ b/client/display.c
@@ -681,6 +681,7 @@ void display_init(void)
 {
 	const char *data_home;
 	char *data_path;
+	int ret;
 =

 	display_refresh.redo_entries =3D l_queue_new();
 =

@@ -701,7 +702,12 @@ void display_init(void)
 	}
 =

 	if (data_path) {
-		mkdir(data_path, 0700);
+		ret =3D mkdir(data_path, 0700);
+		/* Not much can be done since display isn't even initialized */
+		if (L_WARN_ON(ret < 0)) {
+			l_free(data_path);
+			return;
+		}
 =

 		history_path =3D l_strdup_printf("%s/history", data_path);
 		read_history(history_path);
-- =

2.26.2

--===============3168146277947595336==--

