Content-Type: multipart/mixed; boundary="===============4743593367367664273=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/11] hwsim: change radio Create() to take a dictionary
Date: Thu, 17 Dec 2020 11:36:04 -0800
Message-ID: <20201217193611.1177006-4-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4743593367367664273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Create() API was limited to only taking a Name and boolean
(for p2p enabling). The actual hwsim nl80211 API can take more
attributes than this (which are actually utilized when creating
from the command line). To get the DBus API up to the same
functionality the two arguments in Create were replaced with
a single dictionary. This allows for extending later if more
arguments are needed.
---
 tools/hwsim.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index c17792bf..6a1eb348 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1599,20 +1599,38 @@ static struct l_dbus_message *radio_manager_create(=
struct l_dbus *dbus,
 					void *user_data)
 {
 	struct l_genl_msg *new_msg;
-	const char *name;
-	bool p2p;
+	struct l_dbus_message_iter dict;
+	struct l_dbus_message_iter variant;
+	const char *key;
+	const char *name =3D NULL;
+	bool p2p =3D false;
 =

 	if (pending_create_msg)
 		return dbus_error_busy(message);
 =

-	if (!l_dbus_message_get_arguments(message, "sb", &name, &p2p))
-		return dbus_error_invalid_args(message);
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &dict))
+		goto invalid;
+
+	while (l_dbus_message_iter_next_entry(&dict, &key, &variant)) {
+		bool ret =3D false;
 =

-	new_msg =3D l_genl_msg_new_sized(HWSIM_CMD_NEW_RADIO, 16 + strlen(name));
+		if (!strcmp(key, "Name"))
+			ret =3D l_dbus_message_iter_get_variant(&variant,
+								"s", &name);
+		else if (!strcmp(key, "P2P"))
+			ret =3D l_dbus_message_iter_get_variant(&variant,
+								"b", &p2p);
+
+		if (!ret)
+			goto invalid;
+	}
+
+	new_msg =3D l_genl_msg_new_sized(HWSIM_CMD_NEW_RADIO,
+					16 + name ? strlen(name) : 0);
 	l_genl_msg_append_attr(new_msg, HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE,
 				0, NULL);
 =

-	if (name[0])
+	if (name)
 		l_genl_msg_append_attr(new_msg, HWSIM_ATTR_RADIO_NAME,
 					strlen(name) + 1, name);
 =

@@ -1627,12 +1645,15 @@ static struct l_dbus_message *radio_manager_create(=
struct l_dbus *dbus,
 	pending_create_radio_id =3D 0;
 =

 	return NULL;
+
+invalid:
+	return dbus_error_invalid_args(message);
 }
 =

 static void setup_radio_manager_interface(struct l_dbus_interface *interfa=
ce)
 {
 	l_dbus_interface_method(interface, "CreateRadio", 0,
-				radio_manager_create, "o", "sb",
+				radio_manager_create, "o", "a{sv}",
 				"path", "name", "p2p_device");
 }
 =

-- =

2.26.2

--===============4743593367367664273==--

