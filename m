Content-Type: multipart/mixed; boundary="===============6160264293446070861=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] client: apply format attribute to two functions
Date: Tue, 07 Apr 2020 20:32:43 -0700
Message-ID: <20200408033243.587218-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6160264293446070861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clang was able to find these extra ones.
---
 client/agent.c   | 2 +-
 client/display.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index b804b50d..157b61c0 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -303,7 +303,7 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 =

 	username_prompt =3D l_strdup_printf(COLOR_BLUE PROMPT_USERNAME " "
 						COLOR_OFF "%s\n", username);
-	display(username_prompt);
+	display("%s", username_prompt);
 	l_free(username_prompt);
 =

 	display_agent_prompt(PROMPT_PASSWORD, true);
diff --git a/client/display.h b/client/display.h
index 2b0d8d7c..fbae0c67 100644
--- a/client/display.h
+++ b/client/display.h
@@ -32,8 +32,10 @@ struct command_family;
 #define CLEAR_SCREEN	"\033[2J"
 #define MARGIN		"  "
 =

-void display(const char *format, ...);
-void display_table_header(const char *caption, const char *fmt, ...);
+void display(const char *format, ...)
+		__attribute__((format(printf, 1, 2)));
+void display_table_header(const char *caption, const char *fmt, ...)
+		__attribute__((format(printf, 2, 3)));
 void display_table_footer(void);
 void display_error(const char *error);
 void display_command_line(const char *command_family,
-- =

2.25.1

--===============6160264293446070861==--

