Content-Type: multipart/mixed; boundary="===============3288323352297974206=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/4] client: Don't check for errors on agent requests
Date: Thu, 24 Oct 2019 12:53:55 -0700
Message-ID: <20191024195356.28206-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191024195356.28206-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3288323352297974206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This assumes that iwd will never send the errors as agent requests,
therefore, eliminate the unnecessary checks.
---
 client/agent.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 4d23e05e..52cb85cf 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -109,9 +109,6 @@ static struct l_dbus_message *request_passphrase_method=
_call(
 	struct l_dbus_message *reply;
 	const char *path;
 =

-	if (dbus_message_has_error(message))
-		return NULL;
-
 	reply =3D request_passphrase_command_option(message);
 	if (reply)
 		return reply;
@@ -150,9 +147,6 @@ static struct l_dbus_message *request_private_key_passp=
hrase_method_call(
 	struct l_dbus_message *reply;
 	const char *path;
 =

-	if (dbus_message_has_error(message))
-		return NULL;
-
 	reply =3D request_passphrase_command_option(message);
 	if (reply)
 		return reply;
@@ -212,9 +206,6 @@ static struct l_dbus_message *request_username_and_pass=
word_method_call(
 	struct l_dbus_message *reply;
 	const char *path;
 =

-	if (dbus_message_has_error(message))
-		return NULL;
-
 	reply =3D request_username_and_password_command_option(message);
 	if (reply)
 		return reply;
@@ -273,9 +264,6 @@ static struct l_dbus_message *request_user_password_met=
hod_call(
 	const char *username;
 	char *username_prompt;
 =

-	if (dbus_message_has_error(message))
-		return NULL;
-
 	reply =3D request_user_password_command_option(message);
 	if (reply)
 		return reply;
-- =

2.13.6

--===============3288323352297974206==--

