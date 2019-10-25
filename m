Content-Type: multipart/mixed; boundary="===============6857126271612445076=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/5] client: Consolidate cancelation replies
Date: Fri, 25 Oct 2019 13:32:04 -0700
Message-ID: <20191025203208.30628-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6857126271612445076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/agent.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 8af714a2..b80e5727 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -50,6 +50,15 @@ static struct pending_op {
 	struct l_queue *saved_input;
 } pending_op;
 =

+static struct l_dbus_message *agent_reply_canceled(
+						struct l_dbus_message *message,
+						const char *text)
+{
+	return l_dbus_message_new_error(message,
+					IWD_AGENT_INTERFACE ".Error.Canceled",
+					"Error: %s", text);
+}
+
 static struct l_dbus_message *agent_error(const char *text)
 {
 	display_error(text);
@@ -342,9 +351,8 @@ static void process_input_username_password(const char =
*prompt)
 	if (l_queue_isempty(pending_op.saved_input)) {
 		/* received username */
 		if (!strlen(prompt)) {
-			reply =3D l_dbus_message_new_error(pending_message,
-					IWD_AGENT_INTERFACE ".Error.Canceled",
-					"Canceled by user");
+			reply =3D agent_reply_canceled(pending_message,
+							"Canceled by user");
 			goto send_reply;
 		}
 =

@@ -372,9 +380,8 @@ static void process_input_passphrase(const char *prompt)
 	struct l_dbus_message *reply;
 =

 	if (!strlen(prompt)) {
-		reply =3D l_dbus_message_new_error(pending_message,
-					IWD_AGENT_INTERFACE ".Error.Canceled",
-					"Canceled by user");
+		reply =3D agent_reply_canceled(pending_message,
+							"Canceled by user");
 		goto send_reply;
 	}
 =

-- =

2.13.6

--===============6857126271612445076==--

