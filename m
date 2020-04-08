Content-Type: multipart/mixed; boundary="===============6216297043297665620=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Rewrite workaround for readline
Date: Wed, 08 Apr 2020 16:14:07 -0700
Message-ID: <20200408231407.11321-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6216297043297665620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of calling display(""), explicitly use the sequence of
commands to force readline to properly update its internal state
and re-display the prompt.
---
 client/display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 4bcf51a2..cf74326d 100644
--- a/client/display.c
+++ b/client/display.c
@@ -534,7 +534,14 @@ void display_enable_cmd_prompt(void)
 =

 	rl_set_prompt(IWD_PROMPT);
 =

-	display("");
+	/*
+	 * The following sequence of rl_* commands forces readline to properly
+	 * update its internal state and re-display the new prompt.
+	 */
+	rl_save_prompt();
+	rl_redisplay();
+	rl_restore_prompt();
+	rl_forced_update_display();
 }
 =

 void display_disable_cmd_prompt(void)
-- =

2.13.6

--===============6216297043297665620==--

