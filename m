Content-Type: multipart/mixed; boundary="===============3759903395624357569=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 7/8] client: Check family name before comparison
Date: Wed, 23 Oct 2019 13:24:02 -0700
Message-ID: <20191023202403.9690-7-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3759903395624357569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/display.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/client/display.c b/client/display.c
index 0faa0840..b22b6e90 100644
--- a/client/display.c
+++ b/client/display.c
@@ -180,7 +180,8 @@ void display_refresh_set_cmd(const char *family, const =
char *entity,
 		return;
 	}
 =

-	if (display_refresh.family && !strcmp(display_refresh.family, family)) {
+	if (display_refresh.family && family &&
+				!strcmp(display_refresh.family, family)) {
 		struct l_string *buf =3D l_string_new(128);
 		L_AUTO_FREE_VAR(char *, args);
 		char *prompt;
@@ -205,10 +206,10 @@ void display_refresh_set_cmd(const char *family, cons=
t char *entity,
 =

 		args =3D l_string_unwrap(buf);
 =

-		prompt =3D l_strdup_printf(IWD_PROMPT"%s%s%s %s %s\n",
-					family ? : "",
-					entity ? " " : "", entity ? : "",
-					cmd->cmd ? : "", args ? : "");
+		prompt =3D l_strdup_printf(IWD_PROMPT"%s%s%s %s %s\n", family,
+						entity ? " " : "",
+						entity ? : "",
+						cmd->cmd ? : "", args ? : "");
 =

 		l_queue_push_tail(display_refresh.redo_entries, prompt);
 		display_refresh.undo_lines++;
-- =

2.13.6

--===============3759903395624357569==--

