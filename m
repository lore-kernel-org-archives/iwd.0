Content-Type: multipart/mixed; boundary="===============2646915519996953440=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/4] client: Fail on requests with invalid arguments
Date: Thu, 24 Oct 2019 12:53:56 -0700
Message-ID: <20191024195356.28206-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191024195356.28206-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2646915519996953440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/agent.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 52cb85cf..0bda42ea 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -118,7 +118,9 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_error_reply(message, "Invalid argument");
+
 	if (!path)
 		return agent_error_reply(message, "Invalid argument");
 =

@@ -156,7 +158,9 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_error_reply(message, "Invalid argument");
+
 	if (!path)
 		return agent_error_reply(message, "Invalid argument");
 =

@@ -217,7 +221,9 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return agent_error_reply(message, "Invalid argument");
+
 	if (!path)
 		return agent_error_reply(message, "Invalid argument");
 =

@@ -273,7 +279,9 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 					"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "os", &path, &username);
+	if (!l_dbus_message_get_arguments(message, "os", &path, &username))
+		return agent_error_reply(message, "Invalid arguments");
+
 	if (!path || !username)
 		return agent_error_reply(message, "Invalid argument");
 =

-- =

2.13.6

--===============2646915519996953440==--

