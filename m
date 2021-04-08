Content-Type: multipart/mixed; boundary="===============5804037065187219268=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] agent: call back even if agent disconnects
Date: Thu, 08 Apr 2021 09:51:30 -0700
Message-ID: <20210408165130.1191226-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5804037065187219268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was found that if the user cancels/disconnects the agent prior to
entering credentials, IWD would get stuck and could no longer accept
any connect calls with the error "Operation already in progress".
For example exiting iwctl in the Password prompt would cause this:

iwctl
$ station wlan0 connect myssid
$ Password: <Ctrl-C>

This was due to the agent never calling the network callback in the
case of an agent disconnect. Network would wait indefinitely for the
credentials, and disallow any future connect attempts.

To fix this agent_request_free was modified to call the user callback
in order to signal the disconnect to network. Network can then fail
the connection and allow other connection requests.
---
 src/agent.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 101eaffd..3725ea95 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -132,12 +132,36 @@ static void send_cancel_request(void *user_data, int =
reason)
 static void agent_request_free(void *user_data)
 {
 	struct agent_request *request =3D user_data;
+	agent_request_passphrase_func_t passphrase_cb;
+	agent_request_user_name_passwd_func_t user_pass_cb;
 =

 	l_dbus_message_unref(request->message);
 =

 	if (request->trigger)
-		dbus_pending_reply(&request->trigger,
-					dbus_error_aborted(request->trigger));
+		l_dbus_message_unref(request->trigger);
+
+	/*
+	 * If we have not yet called back the agent was disconnected prior to
+	 * the user fully entering credentials.
+	 */
+	if (request->user_callback) {
+		switch (request->type) {
+		case AGENT_REQUEST_TYPE_PASSPHRASE:
+			passphrase_cb =3D request->user_callback;
+
+			passphrase_cb(AGENT_RESULT_FAILED, NULL,
+						request->trigger,
+						request->user_data);
+			break;
+		case AGENT_REQUEST_TYPE_USER_NAME_PASSWD:
+			user_pass_cb =3D request->user_callback;
+
+			user_pass_cb(AGENT_RESULT_FAILED, NULL, NULL,
+						request->trigger,
+						request->user_data);
+			break;
+		}
+	}
 =

 	if (request->destroy)
 		request->destroy(request->user_data);
@@ -153,6 +177,8 @@ static void passphrase_reply(struct l_dbus_message *rep=
ly,
 	enum agent_result result =3D AGENT_RESULT_FAILED;
 	agent_request_passphrase_func_t user_callback =3D request->user_callback;
 =

+	request->user_callback =3D NULL;
+
 	if (l_dbus_message_get_error(reply, &error, &text))
 		goto done;
 =

@@ -175,6 +201,8 @@ static void user_name_passwd_reply(struct l_dbus_messag=
e *reply,
 	agent_request_user_name_passwd_func_t user_callback =3D
 		request->user_callback;
 =

+	request->user_callback =3D NULL;
+
 	if (l_dbus_message_get_error(reply, &error, &text))
 		goto done;
 =

@@ -492,8 +520,10 @@ bool agent_request_cancel(unsigned int req_id, int rea=
son)
 =

 		request =3D l_queue_remove_if(agent->requests, find_request,
 							L_UINT_TO_PTR(req_id));
-		if (request)
+		if (request) {
+			request->user_callback =3D NULL;
 			break;
+		}
 	}
 =

 	if (!request)
-- =

2.26.2

--===============5804037065187219268==--

