Content-Type: multipart/mixed; boundary="===============1225539161653227214=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] client: fix double password prompt
Date: Thu, 08 Apr 2021 11:02:42 -0700
Message-ID: <20210408180242.1200268-2-prestwoj@gmail.com>
In-Reply-To: <20210408180242.1200268-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1225539161653227214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For username/password prompts the password portion was appearing
on screen twice:

Username: myuser(a)example.com
Password: Password:

This appears to be caused by the call to rl_redisplay() in cases
where there was a previous prompt ("Username" in this case). This
patch adds a flag to disply_agent_prompt which avoids this call
if that flag is set.
---
 client/agent.c   | 10 +++++-----
 client/display.c |  6 ++++--
 client/display.h |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 037ae785..398c42a1 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -139,7 +139,7 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 =

 	display("Type the network passphrase for %s.\n",
 				proxy_interface_get_identity_str(proxy));
-	display_agent_prompt(PROMPT_PASSPHRASE, true);
+	display_agent_prompt(PROMPT_PASSPHRASE, true, true);
 =

 	pending_op.type =3D AGENT_OP_TYPE_PASSPHRASE;
 	pending_op.last_label =3D PROMPT_PASSPHRASE;
@@ -179,7 +179,7 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 =

 	display("Type the passphrase for the network encrypted private key for "
 			"%s.\n", proxy_interface_get_identity_str(proxy));
-	display_agent_prompt(PROMPT_PASSPHRASE, true);
+	display_agent_prompt(PROMPT_PASSPHRASE, true, true);
 =

 	pending_op.type =3D AGENT_OP_TYPE_PASSPHRASE;
 	pending_op.last_label =3D PROMPT_PASSPHRASE;
@@ -242,7 +242,7 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 =

 	display("Type the network credentials for %s.\n",
 				proxy_interface_get_identity_str(proxy));
-	display_agent_prompt(PROMPT_USERNAME, false);
+	display_agent_prompt(PROMPT_USERNAME, false, true);
 =

 	pending_op.type =3D AGENT_OP_TYPE_UNAME_PASSWORD;
 	pending_op.last_label =3D PROMPT_USERNAME;
@@ -306,7 +306,7 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 	display("%s", username_prompt);
 	l_free(username_prompt);
 =

-	display_agent_prompt(PROMPT_PASSWORD, true);
+	display_agent_prompt(PROMPT_PASSWORD, true, true);
 =

 	pending_op.type =3D AGENT_OP_TYPE_PASSWORD;
 	pending_op.last_label =3D PROMPT_PASSWORD;
@@ -379,7 +379,7 @@ static void process_input_username_password(const char =
*prompt)
 		/* received username */
 		l_queue_push_tail(pending_op.saved_input, l_strdup(prompt));
 =

-		display_agent_prompt(PROMPT_PASSWORD, true);
+		display_agent_prompt(PROMPT_PASSWORD, true, false);
 		pending_op.last_label =3D PROMPT_PASSWORD;
 =

 		return;
diff --git a/client/display.c b/client/display.c
index 07cb7bda..e13e3b4a 100644
--- a/client/display.c
+++ b/client/display.c
@@ -590,7 +590,7 @@ void display_disable_cmd_prompt(void)
 	rl_redisplay();
 }
 =

-void display_agent_prompt(const char *label, bool mask_input)
+void display_agent_prompt(const char *label, bool mask_input, bool redispl=
ay)
 {
 	char *prompt;
 =

@@ -613,7 +613,9 @@ void display_agent_prompt(const char *label, bool mask_=
input)
 		agent_saved_input->line =3D rl_copy_text(0, rl_end);
 		rl_set_prompt("");
 		rl_replace_line("", 0);
-		rl_redisplay();
+
+		if (redisplay)
+			rl_redisplay();
 =

 		rl_erase_empty_line =3D 0;
 		rl_set_prompt(prompt);
diff --git a/client/display.h b/client/display.h
index b5df944a..f662a470 100644
--- a/client/display.h
+++ b/client/display.h
@@ -51,7 +51,7 @@ void display_refresh_set_cmd(const char *family, const ch=
ar *entity,
 void display_enable_cmd_prompt(void);
 void display_disable_cmd_prompt(void);
 =

-void display_agent_prompt(const char *label, bool mask_input);
+void display_agent_prompt(const char *label, bool mask_input, bool redispl=
ay);
 void display_agent_prompt_release(const char *label);
 bool display_agent_is_active(void);
 =

-- =

2.26.2

--===============1225539161653227214==--

