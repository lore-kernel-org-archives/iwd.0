Content-Type: multipart/mixed; boundary="===============5609989834207365443=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/4] client: Modify error handler to return error msg
Date: Thu, 24 Oct 2019 12:53:53 -0700
Message-ID: <20191024195356.28206-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5609989834207365443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to send error back to iwd, instead of returning NULL
and waiting for iwd to timeout on agent request.
---
 client/agent.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 5ed6538f..c8da72dc 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -50,7 +50,16 @@ static struct pending_op {
 	struct l_queue *saved_input;
 } pending_op;
 =

-static struct l_dbus_message *agent_error(const char *text)
+static struct l_dbus_message *agent_error_reply(struct l_dbus_message *mes=
sage,
+							const char *text)
+{
+	return l_dbus_message_new_error(message,
+					IWD_AGENT_INTERFACE ".Error.Failed",
+					"Error: %s", text);
+}
+
+static struct l_dbus_message *agent_error(struct l_dbus_message *message,
+							const char *text)
 {
 	display_error(text);
 =

@@ -60,7 +69,7 @@ static struct l_dbus_message *agent_error(const char *tex=
t)
 		l_main_quit();
 	}
 =

-	return NULL;
+	return agent_error_reply(message, text);
 }
 =

 static struct l_dbus_message *release_method_call(struct l_dbus *dbus,
@@ -108,7 +117,7 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No passphrase is provided as "
+		return agent_error(message, "No passphrase is provided as "
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

@@ -149,7 +158,7 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No passphrase is provided as "
+		return agent_error(message, "No passphrase is provided as "
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

@@ -211,7 +220,8 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No username or password is provided as "
+		return agent_error(message, "No username or password is "
+					"provided as "
 					"'--"COMMAND_OPTION_USERNAME"' or "
 					"'--"COMMAND_OPTION_PASSWORD"' "
 						"command-line option.\n");
@@ -271,7 +281,7 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No password is provided as "
+		return agent_error(message, "No password is provided as "
 					"'--"COMMAND_OPTION_PASSWORD"' "
 					"command-line option.\n");
 =

-- =

2.13.6

--===============5609989834207365443==--

