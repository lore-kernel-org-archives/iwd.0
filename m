Content-Type: multipart/mixed; boundary="===============7430540504052175740=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] client: Rename window change signal for clarity
Date: Thu, 09 Apr 2020 15:51:45 -0700
Message-ID: <20200409225146.19811-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7430540504052175740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/display.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/client/display.c b/client/display.c
index 4a9f7be0..c285d1bc 100644
--- a/client/display.c
+++ b/client/display.c
@@ -40,7 +40,7 @@
 #define IWD_PROMPT COLOR_GREEN "[iwd]" COLOR_OFF "# "
 #define LINE_LEN 81
 =

-static struct l_signal *resize_signal;
+static struct l_signal *window_change_signal;
 static struct l_io *io;
 static char dashed_line[LINE_LEN] =3D { [0 ... LINE_LEN - 2] =3D '-' };
 static char empty_line[LINE_LEN] =3D { [0 ... LINE_LEN - 2] =3D ' ' };
@@ -634,7 +634,7 @@ void display_quit(void)
 	rl_crlf();
 }
 =

-static void signal_handler(void *user_data)
+static void window_change_signal_handler(void *user_data)
 {
 	if (display_refresh.cmd)
 		display_refresh_reset();
@@ -678,7 +678,9 @@ void display_init(void)
 =

 	setlinebuf(stdout);
 =

-	resize_signal =3D l_signal_create(SIGWINCH, signal_handler, NULL, NULL);
+	window_change_signal =3D
+		l_signal_create(SIGWINCH, window_change_signal_handler, NULL,
+									NULL);
 =

 	rl_attempted_completion_function =3D command_completion;
 	rl_completion_display_matches_hook =3D display_completion_matches;
@@ -708,7 +710,7 @@ void display_exit(void)
 =

 	l_io_destroy(io);
 =

-	l_signal_remove(resize_signal);
+	l_signal_remove(window_change_signal);
 =

 	if (history_path)
 		write_history(history_path);
-- =

2.13.6

--===============7430540504052175740==--

