Content-Type: multipart/mixed; boundary="===============3937083986212367122=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/5] client: Respond to invalid agent requests
Date: Fri, 25 Oct 2019 13:32:06 -0700
Message-ID: <20191025203208.30628-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191025203208.30628-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3937083986212367122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to send an error back to iwd, instead of returning NULL
and waiting for iwd to timeout on agent request.
---
 client/agent.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 503418a0..40e123d8 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -59,6 +59,14 @@ static struct l_dbus_message *agent_reply_canceled(
 					"Error: %s", text);
 }
 =

+static struct l_dbus_message *agent_reply_failed(struct l_dbus_message *me=
ssage,
+							const char *text)
+{
+	return l_dbus_message_new_error(message,
+					IWD_AGENT_INTERFACE ".Error.Failed",
+					"Error: %s", text);
+}
+
 static struct l_dbus_message *agent_error(struct l_dbus_message *message,
 							const char *text)
 {
@@ -121,11 +129,11 @@ static struct l_dbus_message *request_passphrase_meth=
od_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_reply_failed(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_reply_failed(message, "Invalid network object");
 =

 	display("Type the network passphrase for %s.\n",
 				proxy_interface_get_identity_str(proxy));
@@ -159,11 +167,11 @@ static struct l_dbus_message *request_private_key_pas=
sphrase_method_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_reply_failed(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_reply_failed(message, "Invalid network object");
 =

 	display("Type the passphrase for the network encrypted private key for "
 			"%s.\n", proxy_interface_get_identity_str(proxy));
@@ -220,11 +228,11 @@ static struct l_dbus_message *request_username_and_pa=
ssword_method_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_reply_failed(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_reply_failed(message, "Invalid network object");
 =

 	display("Type the network credentials for %s.\n",
 				proxy_interface_get_identity_str(proxy));
@@ -276,11 +284,11 @@ static struct l_dbus_message *request_user_password_m=
ethod_call(
 =

 	l_dbus_message_get_arguments(message, "os", &path, &username);
 	if (!path || !username)
-		return NULL;
+		return agent_reply_failed(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_reply_failed(message, "Invalid network object");
 =

 	display("Type the network password for %s.\n",
 				proxy_interface_get_identity_str(proxy));
-- =

2.13.6

--===============3937083986212367122==--

