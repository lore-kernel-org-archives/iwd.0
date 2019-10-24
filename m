Content-Type: multipart/mixed; boundary="===============5520296724185703204=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/4] client: Respond to invalid agent requests
Date: Thu, 24 Oct 2019 12:53:54 -0700
Message-ID: <20191024195356.28206-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191024195356.28206-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5520296724185703204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to send an error back to iwd, instead of returning NULL
and waiting for iwd to timeout on agent request.
---
 client/agent.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index c8da72dc..4d23e05e 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -123,11 +123,11 @@ static struct l_dbus_message *request_passphrase_meth=
od_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_error_reply(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_error_reply(message, "Invalid network object");
 =

 	display("Type the network passphrase for %s.\n",
 				proxy_interface_get_identity_str(proxy));
@@ -164,11 +164,11 @@ static struct l_dbus_message *request_private_key_pas=
sphrase_method_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_error_reply(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_error_reply(message, "Invalid network object");
 =

 	display("Type the passphrase for the network encrypted private key for "
 			"%s.\n", proxy_interface_get_identity_str(proxy));
@@ -228,11 +228,11 @@ static struct l_dbus_message *request_username_and_pa=
ssword_method_call(
 =

 	l_dbus_message_get_arguments(message, "o", &path);
 	if (!path)
-		return NULL;
+		return agent_error_reply(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_error_reply(message, "Invalid network object");
 =

 	display("Type the network credentials for %s.\n",
 				proxy_interface_get_identity_str(proxy));
@@ -287,11 +287,11 @@ static struct l_dbus_message *request_user_password_m=
ethod_call(
 =

 	l_dbus_message_get_arguments(message, "os", &path, &username);
 	if (!path || !username)
-		return NULL;
+		return agent_error_reply(message, "Invalid argument");
 =

 	proxy =3D proxy_interface_find(IWD_NETWORK_INTERFACE, path);
 	if (!proxy)
-		return NULL;
+		return agent_error_reply(message, "Invalid network object");
 =

 	display("Type the network password for %s.\n",
 				proxy_interface_get_identity_str(proxy));
-- =

2.13.6

--===============5520296724185703204==--

