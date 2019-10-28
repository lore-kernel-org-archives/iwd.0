Content-Type: multipart/mixed; boundary="===============0956883745943737352=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Cancel agent prompt with CTRL+D
Date: Mon, 28 Oct 2019 10:29:33 -0700
Message-ID: <20191028172933.13643-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0956883745943737352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, CTRL+D used to cause termination of the client. Now, the
command will cancel the agent=E2=80=99s prompts in agent mod. In regular mo=
de
the behavior is unchanged.
---
 client/agent.c   | 28 +++++++++++++++++++---------
 client/display.c |  8 ++++----
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 78499419..16bc3c4f 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -366,14 +366,17 @@ static void process_input_username_password(const cha=
r *prompt)
 	struct l_dbus_message *reply;
 	char *username;
 =

-	if (l_queue_isempty(pending_op.saved_input)) {
-		/* received username */
-		if (!strlen(prompt)) {
-			reply =3D agent_reply_canceled(pending_message,
+	if (!prompt || !strlen(prompt)) {
+		reply =3D agent_reply_canceled(pending_message,
 							"Canceled by user");
-			goto send_reply;
-		}
 =

+		l_queue_clear(pending_op.saved_input, l_free);
+
+		goto send_reply;
+	}
+
+	if (l_queue_isempty(pending_op.saved_input)) {
+		/* received username */
 		l_queue_push_tail(pending_op.saved_input, l_strdup(prompt));
 =

 		display_agent_prompt(PROMPT_PASSWORD, true);
@@ -397,7 +400,7 @@ static void process_input_passphrase(const char *prompt)
 {
 	struct l_dbus_message *reply;
 =

-	if (!strlen(prompt)) {
+	if (!prompt || !strlen(prompt)) {
 		reply =3D agent_reply_canceled(pending_message,
 							"Canceled by user");
 		goto send_reply;
@@ -412,11 +415,18 @@ send_reply:
 =

 static void process_input_password(const char *prompt)
 {
-	struct l_dbus_message *reply =3D
-			l_dbus_message_new_method_return(pending_message);
+	struct l_dbus_message *reply;
+
+	if (!prompt || !strlen(prompt)) {
+		reply =3D agent_reply_canceled(pending_message,
+							"Canceled by user");
+		goto send_reply;
+	}
 =

+	reply =3D l_dbus_message_new_method_return(pending_message);
 	l_dbus_message_set_arguments(reply, "s", prompt);
 =

+send_reply:
 	agent_send_reply(reply);
 }
 =

diff --git a/client/display.c b/client/display.c
index c08183da..cd17ad84 100644
--- a/client/display.c
+++ b/client/display.c
@@ -465,6 +465,10 @@ static void readline_callback(char *prompt)
 =

 	HIST_ENTRY *previous_prompt;
 =

+	if (agent_prompt(masked_input.use_mask ?
+					masked_input.passphrase : prompt))
+		goto done;
+
 	if (!prompt) {
 		display_quit();
 =

@@ -473,10 +477,6 @@ static void readline_callback(char *prompt)
 		return;
 	}
 =

-	if (agent_prompt(masked_input.use_mask ?
-					masked_input.passphrase : prompt))
-		goto done;
-
 	if (!strlen(prompt))
 		goto done;
 =

-- =

2.13.6

--===============0956883745943737352==--

