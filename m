Content-Type: multipart/mixed; boundary="===============6504580323033428579=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/8] client: Ignore invalid agent requests
Date: Wed, 23 Oct 2019 13:23:58 -0700
Message-ID: <20191023202403.9690-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6504580323033428579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/agent.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 5ed6538f..a64d71c5 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -112,7 +112,9 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return NULL;
+
 	if (!path)
 		return NULL;
 =

@@ -153,7 +155,9 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 					"'--"COMMAND_OPTION_PASSPHRASE"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return NULL;
+
 	if (!path)
 		return NULL;
 =

@@ -216,7 +220,9 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 						"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "o", &path);
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return NULL;
+
 	if (!path)
 		return NULL;
 =

@@ -275,7 +281,9 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 					"'--"COMMAND_OPTION_PASSWORD"' "
 					"command-line option.\n");
 =

-	l_dbus_message_get_arguments(message, "os", &path, &username);
+	if (!l_dbus_message_get_arguments(message, "os", &path, &username))
+		return NULL;
+
 	if (!path || !username)
 		return NULL;
 =

-- =

2.13.6

--===============6504580323033428579==--

