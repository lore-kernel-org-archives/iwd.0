Content-Type: multipart/mixed; boundary="===============1518369684345446978=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/5] client: Modify error handler to return cancelation msg
Date: Fri, 25 Oct 2019 13:32:05 -0700
Message-ID: <20191025203208.30628-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191025203208.30628-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1518369684345446978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to send cancelation error back to iwd, instead of
returning NULL and waiting for iwd to timeout on agent request.
---
 client/agent.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index b80e5727..503418a0 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -59,7 +59,8 @@ static struct l_dbus_message *agent_reply_canceled(
 					"Error: %s", text);
 }
 =

-static struct l_dbus_message *agent_error(const char *text)
+static struct l_dbus_message *agent_error(struct l_dbus_message *message,
+							const char *text)
 {
 	display_error(text);
 =

@@ -69,7 +70,7 @@ static struct l_dbus_message *agent_error(const char *tex=
t)
 		l_main_quit();
 	}
 =

-	return NULL;
+	return agent_reply_canceled(message, text);
 }
 =

 static struct l_dbus_message *release_method_call(struct l_dbus *dbus,
@@ -114,7 +115,7 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No passphrase is provided as "
+		return agent_error(message, "No passphrase is provided as "
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

@@ -152,7 +153,7 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 		return reply;
 =

 	if (command_option_get(COMMAND_OPTION_DONTASK, NULL))
-		return agent_error("No passphrase is provided as "
+		return agent_error(message, "No passphrase is provided as "
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

@@ -211,7 +212,8 @@ static struct l_dbus_message *request_username_and_pass=
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
@@ -268,7 +270,7 @@ static struct l_dbus_message *request_user_password_met=
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

--===============1518369684345446978==--

