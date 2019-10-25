Content-Type: multipart/mixed; boundary="===============3020438110353413192=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/5] client: Fail on requests with invalid arguments
Date: Fri, 25 Oct 2019 13:32:07 -0700
Message-ID: <20191025203208.30628-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191025203208.30628-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3020438110353413192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/agent.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 40e123d8..78499419 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -127,7 +127,9 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_reply_failed(message, "Invalid argument");
+
 	if (!path)
 		return agent_reply_failed(message, "Invalid argument");
 =

@@ -165,7 +167,9 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_reply_failed(message, "Invalid argument");
+
 	if (!path)
 		return agent_reply_failed(message, "Invalid argument");
 =

@@ -226,7 +230,9 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_reply_failed(message, "Invalid argument");
+
 	if (!path)
 		return agent_reply_failed(message, "Invalid argument");
 =

@@ -282,7 +288,9 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 					"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "os", &path, &username);
+	if (!l_dbus_message_get_arguments(message, "os", &path, &username))
+		return agent_reply_failed(message, "Invalid arguments");
+
 	if (!path || !username)
 		return agent_reply_failed(message, "Invalid argument");
 =

-- =

2.13.6

--===============3020438110353413192==--

