Content-Type: multipart/mixed; boundary="===============6309645168162007987=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] client: Automate display refresh enablement
Date: Thu, 09 Apr 2020 15:51:46 -0700
Message-ID: <20200409225146.19811-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200409225146.19811-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6309645168162007987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The display refresh is automatically enabled or disabled depending on
the width of the window. This allows to avoid the incorrect display on
refresh for the small windows.
---
 client/display.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 client/display.h |  1 +
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/client/display.c b/client/display.c
index c285d1bc..b19759ea 100644
--- a/client/display.c
+++ b/client/display.c
@@ -28,6 +28,8 @@
 #include <stdio.h>
 #include <signal.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
 =

 #include <readline/history.h>
 #include <readline/readline.h>
@@ -48,6 +50,7 @@ static struct l_timeout *refresh_timeout;
 static struct saved_input *agent_saved_input;
 =

 static struct display_refresh {
+	bool enabled;
 	char *family;
 	char *entity;
 	const struct command *cmd;
@@ -56,7 +59,7 @@ static struct display_refresh {
 	size_t undo_lines;
 	struct l_queue *redo_entries;
 	bool recording;
-} display_refresh;
+} display_refresh =3D { .enabled =3D true };
 =

 struct saved_input {
 	char *line;
@@ -221,12 +224,45 @@ void display_refresh_set_cmd(const char *family, cons=
t char *entity,
 	}
 }
 =

+static void display_refresh_check_feasibility(void)
+{
+	const struct winsize ws;
+
+	ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws);
+
+	if (ws.ws_col < LINE_LEN - 1) {
+		if (display_refresh.enabled) {
+			display_refresh.recording =3D false;
+			display(COLOR_YELLOW "Auto-refresh is disabled. "
+				"Enlarge window width to@least %u to enable."
+				"\n" COLOR_OFF, LINE_LEN - 1);
+			display_refresh.recording =3D true;
+		}
+
+		display_refresh.enabled =3D false;
+	} else {
+		display_refresh.enabled =3D true;
+	}
+}
+
+static void display_refresh_check_applicability(void)
+{
+	if (display_refresh.enabled && display_refresh.cmd)
+		display_refresh_redo_lines();
+	else if (display_refresh.cmd)
+		display_refresh_timeout_set();
+}
+
 static void timeout_callback(struct l_timeout *timeout, void *user_data)
 {
 	struct saved_input *input;
 =

-	if (!display_refresh.cmd)
+	if (!display_refresh.enabled || !display_refresh.cmd) {
+		if (display_refresh.cmd)
+			display_refresh_timeout_set();
+
 		return;
+	}
 =

 	input =3D save_input();
 	display_refresh_undo_lines();
@@ -336,8 +372,7 @@ void display_table_footer(void)
 {
 	display_text("\n");
 =

-	if (display_refresh.cmd)
-		display_refresh_redo_lines();
+	display_refresh_check_applicability();
 }
 =

 void display_command_line(const char *command_family,
@@ -636,8 +671,7 @@ void display_quit(void)
 =

 static void window_change_signal_handler(void *user_data)
 {
-	if (display_refresh.cmd)
-		display_refresh_reset();
+	display_refresh_check_feasibility();
 }
 =

 static char *history_path;
@@ -691,6 +725,8 @@ void display_init(void)
 							readline_callback);
 =

 	rl_redisplay();
+
+	display_refresh_check_feasibility();
 }
 =

 void display_exit(void)
diff --git a/client/display.h b/client/display.h
index fbae0c67..b5df944a 100644
--- a/client/display.h
+++ b/client/display.h
@@ -28,6 +28,7 @@ struct command_family;
 #define COLOR_GREEN	"\x1b[32m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_BLUE	"\x1B[94m"
+#define COLOR_YELLOW	"\x1b[33m"
 #define COLOR_OFF	"\x1B[0m"
 #define CLEAR_SCREEN	"\033[2J"
 #define MARGIN		"  "
-- =

2.13.6

--===============6309645168162007987==--

