Content-Type: multipart/mixed; boundary="===============0485622897248254118=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/5] hwsim: add NoVirtualInterface option to DBus API
Date: Tue, 05 Apr 2022 11:30:07 -0700
Message-ID: <20220405183011.856403-1-prestwoj@gmail.com>

--===============0485622897248254118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was available with --no-interface but no such option existed
for the DBus API.
---
 tools/hwsim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index de808074..8dcb75c4 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1707,6 +1707,7 @@ static struct l_dbus_message *radio_manager_create(st=
ruct l_dbus *dbus,
 	bool p2p =3D false;
 	const char *disabled_iftypes =3D NULL;
 	const char *disabled_ciphers =3D NULL;
+	bool no_vif =3D false;
 	struct radio_info_rec *radio;
 =

 	if (!l_dbus_message_get_arguments(message, "a{sv}", &dict))
@@ -1727,6 +1728,10 @@ static struct l_dbus_message *radio_manager_create(s=
truct l_dbus *dbus,
 		else if (!strcmp(key, "CipherTypeDisable"))
 			ret =3D l_dbus_message_iter_get_variant(&variant, "s",
 							&disabled_ciphers);
+		else if (!strcmp(key, "NoVirtualInterface"))
+			ret =3D l_dbus_message_iter_get_variant(&variant, "b",
+							&no_vif);
+
 		if (!ret)
 			goto invalid;
 	}
@@ -1765,6 +1770,9 @@ static struct l_dbus_message *radio_manager_create(st=
ruct l_dbus *dbus,
 =

 	}
 =

+	if (no_vif)
+		l_genl_msg_append_attr(new_msg, HWSIM_ATTR_NO_VIF, 0, NULL);
+
 	radio =3D l_new(struct radio_info_rec, 1);
 	radio->pending =3D l_dbus_message_ref(message);
 	radio->name =3D l_strdup(name);
-- =

2.34.1

--===============0485622897248254118==--

