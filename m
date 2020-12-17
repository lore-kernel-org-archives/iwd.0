Content-Type: multipart/mixed; boundary="===============5755367930063060272=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/11] hwsim: add iftype/cipher disabling through DBus
Date: Thu, 17 Dec 2020 11:36:08 -0800
Message-ID: <20201217193611.1177006-8-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5755367930063060272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the Dbus API to allow disabling iftypes and ciphers
just as you can with the command line.
---
 tools/hwsim.c | 141 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 57 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 6a1eb348..62a7d66d 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -195,6 +195,62 @@ static void do_debug(const char *str, void *user_data)
 	l_info("%s%s", prefix, str);
 }
 =

+static void hwsim_disable_support(const char *disable,
+		const struct hwsim_support *map, uint32_t *mask)
+{
+	char **list =3D l_strsplit(disable, ',');
+	char **iter =3D list;
+	int i;
+
+	while (*iter) {
+		for (i =3D 0; map[i].name; i++) {
+			if (!strcmp(map[i].name, *iter))
+				*mask &=3D ~(map[i].value);
+		}
+
+		iter++;
+	}
+
+	l_strfreev(list);
+}
+
+static bool is_cipher_disabled(const char *args, enum crypto_cipher cipher)
+{
+	char **list =3D l_strsplit(args, ',');
+	char **iter =3D list;
+	int i;
+
+	while (*iter) {
+		for (i =3D 0; cipher_map[i].name; i++) {
+			if (!strcmp(*iter, cipher_map[i].name) &&
+					cipher =3D=3D cipher_map[i].value) {
+				printf("disable cipher: %s\n", cipher_map[i].name);
+				l_strfreev(list);
+				return true;
+			}
+		}
+
+		iter++;
+	}
+
+	l_strfreev(list);
+
+	return false;
+}
+
+static void hwsim_disable_ciphers(const char *disable)
+{
+	uint8_t i;
+
+	for (i =3D 0; i < L_ARRAY_SIZE(hwsim_supported_ciphers); i++) {
+		if (is_cipher_disabled(disable, hwsim_supported_ciphers[i]))
+			continue;
+
+		hwsim_ciphers[hwsim_num_ciphers] =3D hwsim_supported_ciphers[i];
+		hwsim_num_ciphers++;
+	}
+}
+
 static void create_callback(struct l_genl_msg *msg, void *user_data)
 {
 	struct l_genl_attr attr;
@@ -1604,6 +1660,8 @@ static struct l_dbus_message *radio_manager_create(st=
ruct l_dbus *dbus,
 	const char *key;
 	const char *name =3D NULL;
 	bool p2p =3D false;
+	const char *disabled_iftypes =3D NULL;
+	const char *disabled_ciphers =3D NULL;
 =

 	if (pending_create_msg)
 		return dbus_error_busy(message);
@@ -1620,7 +1678,12 @@ static struct l_dbus_message *radio_manager_create(s=
truct l_dbus *dbus,
 		else if (!strcmp(key, "P2P"))
 			ret =3D l_dbus_message_iter_get_variant(&variant,
 								"b", &p2p);
-
+		else if (!strcmp(key, "InterfaceTypeDisable"))
+			ret =3D l_dbus_message_iter_get_variant(&variant, "s",
+							&disabled_iftypes);
+		else if (!strcmp(key, "CipherTypeDisable"))
+			ret =3D l_dbus_message_iter_get_variant(&variant, "s",
+							&disabled_ciphers);
 		if (!ret)
 			goto invalid;
 	}
@@ -1638,6 +1701,26 @@ static struct l_dbus_message *radio_manager_create(s=
truct l_dbus *dbus,
 		l_genl_msg_append_attr(new_msg, HWSIM_ATTR_SUPPORT_P2P_DEVICE,
 					0, NULL);
 =

+	if (disabled_iftypes) {
+		hwsim_disable_support(disabled_iftypes, iftype_map,
+						&hwsim_iftypes);
+
+		if (hwsim_iftypes !=3D HWSIM_DEFAULT_IFTYPES)
+			l_genl_msg_append_attr(new_msg,
+						HWSIM_ATTR_IFTYPE_SUPPORT,
+						4, &hwsim_iftypes);
+	}
+
+	if (disabled_ciphers) {
+		hwsim_disable_ciphers(disabled_ciphers);
+
+		if (hwsim_num_ciphers)
+			l_genl_msg_append_attr(new_msg, HWSIM_ATTR_CIPHER_SUPPORT,
+					sizeof(uint32_t) * hwsim_num_ciphers,
+					hwsim_ciphers);
+
+	}
+
 	l_genl_family_send(hwsim, new_msg, radio_manager_create_callback,
 				pending_create_msg, NULL);
 =

@@ -2525,62 +2608,6 @@ error:
 	l_main_quit();
 }
 =

-static void hwsim_disable_support(char *disable,
-		const struct hwsim_support *map, uint32_t *mask)
-{
-	char **list =3D l_strsplit(disable, ',');
-	char **iter =3D list;
-	int i;
-
-	while (*iter) {
-		for (i =3D 0; map[i].name; i++) {
-			if (!strcmp(map[i].name, *iter))
-				*mask &=3D ~(map[i].value);
-		}
-
-		iter++;
-	}
-
-	l_strfreev(list);
-}
-
-static bool is_cipher_disabled(char *args, enum crypto_cipher cipher)
-{
-	char **list =3D l_strsplit(args, ',');
-	char **iter =3D list;
-	int i;
-
-	while (*iter) {
-		for (i =3D 0; cipher_map[i].name; i++) {
-			if (!strcmp(*iter, cipher_map[i].name) &&
-					cipher =3D=3D cipher_map[i].value) {
-				printf("disable cipher: %s\n", cipher_map[i].name);
-				l_strfreev(list);
-				return true;
-			}
-		}
-
-		iter++;
-	}
-
-	l_strfreev(list);
-
-	return false;
-}
-
-static void hwsim_disable_ciphers(char *disable)
-{
-	uint8_t i;
-
-	for (i =3D 0; i < L_ARRAY_SIZE(hwsim_supported_ciphers); i++) {
-		if (is_cipher_disabled(disable, hwsim_supported_ciphers[i]))
-			continue;
-
-		hwsim_ciphers[hwsim_num_ciphers] =3D hwsim_supported_ciphers[i];
-		hwsim_num_ciphers++;
-	}
-}
-
 static void family_discovered(const struct l_genl_family_info *info,
 							void *user_data)
 {
-- =

2.26.2

--===============5755367930063060272==--

