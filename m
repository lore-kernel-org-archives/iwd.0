Content-Type: multipart/mixed; boundary="===============2112157498510198807=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Rephrase the wait messages
Date: Wed, 08 Apr 2020 18:51:01 -0700
Message-ID: <20200409015101.11398-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2112157498510198807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/display.c b/client/display.c
index cf74326d..4a9f7be0 100644
--- a/client/display.c
+++ b/client/display.c
@@ -548,7 +548,7 @@ void display_disable_cmd_prompt(void)
 {
 	display_refresh_reset();
 =

-	rl_set_prompt("Waiting to connect to IWD");
+	rl_set_prompt("Waiting for IWD to start...");
 	printf("\r");
 	rl_on_new_line();
 	rl_redisplay();
@@ -685,7 +685,7 @@ void display_init(void)
 =

 	rl_completer_quote_characters =3D "\"";
 	rl_erase_empty_line =3D 1;
-	rl_callback_handler_install("Waiting for IWD to appear...",
+	rl_callback_handler_install("Waiting for IWD to start...",
 							readline_callback);
 =

 	rl_redisplay();
-- =

2.13.6

--===============2112157498510198807==--

