Content-Type: multipart/mixed; boundary="===============4972399521575768092=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/2] hwsim: allow concurrent radio creations
Date: Wed, 16 Feb 2022 11:39:42 -0800
Message-ID: <20220216193943.1411659-1-prestwoj@gmail.com>

--===============4972399521575768092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently CreateRadio only allows a single outstanding DBus message
until the radio is fully created. 99% of the time this is just fine
but in order to test dual phy cards there needs to be support for
phy's appearing at the same time.

This required storing the pending DBus message inside the radio object
rather than a single static variable.

The code was refactored to handle the internal radio info objects better
for the various cases:
 - Creation from CreateRadio()
 - Radio already existed before hwsim started, or created externally
 - Existing radio changed name, address, etc.

First, Name is now a required option to CreateRadio(). This allows
the radio info to be pushed to the queue immediately (also allowing the
pending DBus message to be tracked). Then, when the NEW_RADIO event
fires the pending radio can be looked up (by name) and filled with the
remaining info.

If the radio was not found by name but a matching ID was found this is
the 'changed' case and the radio is re-initialized with the changed
values.

If neither name or ID matches the radio was created externally, or
prior to hwsim starting. A radio info object is created at this time
and initialized.

The ID was changed to a signed integer in order to initialize it to an
invalid number -1. Doing this was required since a pending uninitalized
radio ID (0) could match an existing radio ID. This required some
bounds checks in case the kernels counter reaches an extremely high value.
This isn't likely to ever happen in practice.
---
 tools/hwsim.c | 187 +++++++++++++++++++++++++++-----------------------
 1 file changed, 101 insertions(+), 86 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index f74dd82e..3ff3faab 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -35,6 +35,7 @@
 #include <net/if_arp.h>
 =

 #include <ell/ell.h>
+#include "ell/useful.h"
 =

 #include "linux/nl80211.h"
 =

@@ -405,7 +406,7 @@ static void list_callback(struct l_genl_msg *msg, void =
*user_data)
 }
 =

 struct radio_info_rec {
-	uint32_t id;
+	int32_t id;
 	uint32_t wiphy_id;
 	char alpha2[2];
 	bool p2p;
@@ -415,6 +416,8 @@ struct radio_info_rec {
 	uint8_t addrs[2][ETH_ALEN];
 	char *name;
 	bool ap_only;
+	struct l_dbus_message *pending;
+	uint32_t cmd_id;
 };
 =

 struct interface_info_rec {
@@ -428,13 +431,16 @@ struct interface_info_rec {
 static struct l_queue *radio_info;
 static struct l_queue *interface_info;
 =

-static struct l_dbus_message *pending_create_msg;
-static uint32_t pending_create_radio_id;
-
 static void radio_free(void *user_data)
 {
 	struct radio_info_rec *rec =3D user_data;
 =

+	if (rec->cmd_id)
+		l_genl_family_cancel(nl80211, rec->cmd_id);
+
+	if (rec->pending)
+		l_dbus_message_unref(rec->pending);
+
 	l_free(rec->name);
 	l_free(rec);
 }
@@ -458,7 +464,7 @@ static void hwsim_radio_cache_cleanup(void)
 static bool radio_info_match_id(const void *a, const void *b)
 {
 	const struct radio_info_rec *rec =3D a;
-	uint32_t id =3D L_PTR_TO_UINT(b);
+	int32_t id =3D L_PTR_TO_INT(b);
 =

 	return rec->id =3D=3D id;
 }
@@ -512,12 +518,6 @@ static const char *interface_get_path(const struct int=
erface_info_rec *rec)
 	return path;
 }
 =

-static struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
-{
-	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".InProgress",
-					"Operation already in progress");
-}
-
 static struct l_dbus_message *dbus_error_failed(struct l_dbus_message *msg)
 {
 	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".Failed",
@@ -603,17 +603,19 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
 	struct l_genl_attr attr;
 	uint16_t type, len;
 	const void *data;
-	const char *name =3D NULL;
-	const uint32_t *id =3D NULL;
-	size_t name_len =3D 0;
-	struct radio_info_rec *rec;
+	_auto_(l_free) char *name =3D NULL;
+	const int32_t *id =3D NULL;
+	struct radio_info_rec *rec =3D NULL;
 	uint8_t file_buffer[128];
 	int bytes, consumed;
 	unsigned int uintval;
-	bool old;
+	bool changed =3D false;
+	bool new =3D false;
 	struct radio_info_rec prev_rec;
 	bool name_change =3D false;
 	const char *path;
+	struct l_dbus_message *reply;
+	const struct l_queue_entry *entry;
 =

 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -625,11 +627,19 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
 				break;
 =

 			id =3D data;
+
+			/*
+			 * ID of -1 denotes a pending creation, so if somehow
+			 * the kernel ID counter reaches an extremely high
+			 * number of radios we just bail.
+			 */
+			if (L_WARN_ON(*id < 0))
+				return;
+
 			break;
 =

 		case HWSIM_ATTR_RADIO_NAME:
-			name =3D data;
-			name_len =3D len;
+			name =3D l_strndup(data, len);
 			break;
 		}
 	}
@@ -637,24 +647,37 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
 	if (!id || !name)
 		return;
 =

-	rec =3D l_queue_find(radio_info, radio_info_match_id, L_UINT_TO_PTR(*id));
-	if (rec) {
-		old =3D true;
-		memcpy(&prev_rec, rec, sizeof(prev_rec));
+	for (entry =3D l_queue_get_entries(radio_info); entry;
+						entry =3D entry->next) {
+		struct radio_info_rec *r =3D entry->data;
 =

-		if (strlen(rec->name) !=3D name_len ||
-				memcmp(rec->name, name, name_len))
-			name_change =3D true;
+		if (*id =3D=3D r->id) {
+			changed =3D true;
+			memcpy(&prev_rec, r, sizeof(prev_rec));
 =

-		l_free(rec->name);
-	} else {
-		old =3D false;
+			if (strcmp(r->name, name))
+				name_change =3D true;
+
+			l_free(r->name);
+			r->name =3D l_steal_ptr(name);
+
+			rec =3D r;
+			break;
+		} else if (!strcmp(r->name, name)) {
+			rec =3D r;
+			rec->id =3D *id;
+
+			break;
+		}
+	}
+
+	if (!rec) {
+		new =3D true;
 		rec =3D l_new(struct radio_info_rec, 1);
 		rec->id =3D *id;
+		rec->name =3D l_steal_ptr(name);
 	}
 =

-	rec->name =3D l_strndup(name, name_len);
-
 	l_genl_attr_init(&attr, msg);
 =

 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
@@ -726,12 +749,12 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
 	if (!radio_info)
 		radio_info =3D l_queue_new();
 =

-	if (!old)
+	if (new)
 		l_queue_push_tail(radio_info, rec);
 =

 	path =3D radio_get_path(rec);
 =

-	if (!old) {
+	if (!changed) {
 		/* Create Dbus object */
 =

 		if (!l_dbus_object_add_interface(dbus, path,
@@ -758,23 +781,24 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
 	}
 =

 	/* Send pending CreateRadio reply */
-	if (pending_create_msg && pending_create_radio_id =3D=3D rec->id) {
-		struct l_dbus_message *reply =3D
-			l_dbus_message_new_method_return(pending_create_msg);
+	if (rec->pending) {
+		reply =3D l_dbus_message_new_method_return(rec->pending);
 =

 		l_dbus_message_set_arguments(reply, "o", path);
-		dbus_pending_reply(&pending_create_msg, reply);
+		dbus_pending_reply(&rec->pending, reply);
 	}
 =

 	return;
 =

 err_free_radio:
-	if (!old)
-		radio_free(rec);
+	if (rec->pending)
+		dbus_pending_reply(&rec->pending,
+					dbus_error_failed(rec->pending));
 =

-	if (pending_create_msg && pending_create_radio_id =3D=3D *id)
-		dbus_pending_reply(&pending_create_msg,
-					dbus_error_failed(pending_create_msg));
+	if (!new)
+		l_queue_remove(radio_info, rec);
+
+	radio_free(rec);
 }
 =

 static bool radio_ap_only(struct radio_info_rec *rec)
@@ -934,7 +958,7 @@ static void del_radio_event(struct l_genl_msg *msg)
 	struct l_genl_attr attr;
 	uint16_t type, len;
 	const void *data;
-	const uint32_t *id =3D NULL;
+	const int32_t *id =3D NULL;
 =

 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -947,6 +971,9 @@ static void del_radio_event(struct l_genl_msg *msg)
 =

 			id =3D data;
 =

+			if (L_WARN_ON(*id < 0))
+				return;
+
 			break;
 		}
 	}
@@ -955,7 +982,7 @@ static void del_radio_event(struct l_genl_msg *msg)
 		return;
 =

 	radio =3D l_queue_find(radio_info, radio_info_match_id,
-				L_UINT_TO_PTR(*id));
+				L_INT_TO_PTR(*id));
 	if (!radio)
 		return;
 =

@@ -1642,44 +1669,27 @@ static void unicast_handler(struct l_genl_msg *msg,=
 void *user_data)
 static void radio_manager_create_callback(struct l_genl_msg *msg,
 						void *user_data)
 {
+	struct radio_info_rec *radio =3D user_data;
 	struct l_dbus_message *reply;
-	struct l_genl_attr attr;
-	struct radio_info_rec *radio;
-	int err;
 =

-	/*
-	 * Note that the radio id is returned in the error field of
-	 * the returned message.
-	 */
-	if (l_genl_attr_init(&attr, msg))
-		goto error;
-
-	err =3D l_genl_msg_get_error(msg);
-	if (err < 0)
-		goto error;
+	radio->cmd_id =3D 0;
 =

-	pending_create_radio_id =3D err;
+	if (l_genl_msg_get_error(msg) >=3D 0)
+		return;
 =

 	/*
-	 * If the NEW_RADIO event has been received we'll have added the
-	 * radio to radio_info already but we can send the method return
-	 * only now that we know the ID returned by our command.
+	 * In theory pending should always be set. This is to handle the
+	 * NEW_RADIO event coming prior to this callback and this callback
+	 * also having an error. It doesn't seem possible for this to happen,
+	 * but who knows.
 	 */
-	radio =3D l_queue_find(radio_info, radio_info_match_id,
-				L_UINT_TO_PTR(pending_create_radio_id));
-	if (radio && pending_create_msg) {
-		const char *path =3D radio_get_path(radio);
-
-		reply =3D l_dbus_message_new_method_return(pending_create_msg);
-		l_dbus_message_set_arguments(reply, "o", path);
-		dbus_pending_reply(&pending_create_msg, reply);
+	if (radio->pending) {
+		reply =3D dbus_error_failed(radio->pending);
+		dbus_pending_reply(&radio->pending, reply);
 	}
 =

-	return;
-
-error:
-	reply =3D dbus_error_failed(pending_create_msg);
-	dbus_pending_reply(&pending_create_msg, reply);
+	l_queue_remove(radio_info, radio);
+	radio_free(radio);
 }
 =

 static struct l_dbus_message *radio_manager_create(struct l_dbus *dbus,
@@ -1694,9 +1704,7 @@ static struct l_dbus_message *radio_manager_create(st=
ruct l_dbus *dbus,
 	bool p2p =3D false;
 	const char *disabled_iftypes =3D NULL;
 	const char *disabled_ciphers =3D NULL;
-
-	if (pending_create_msg)
-		return dbus_error_busy(message);
+	struct radio_info_rec *radio;
 =

 	if (!l_dbus_message_get_arguments(message, "a{sv}", &dict))
 		goto invalid;
@@ -1720,13 +1728,15 @@ static struct l_dbus_message *radio_manager_create(=
struct l_dbus *dbus,
 			goto invalid;
 	}
 =

+	if (!name)
+		goto invalid;
+
 	new_msg =3D l_genl_msg_new(HWSIM_CMD_NEW_RADIO);
 	l_genl_msg_append_attr(new_msg, HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE,
 				0, NULL);
 =

-	if (name)
-		l_genl_msg_append_attr(new_msg, HWSIM_ATTR_RADIO_NAME,
-					strlen(name) + 1, name);
+	l_genl_msg_append_attr(new_msg, HWSIM_ATTR_RADIO_NAME,
+				strlen(name) + 1, name);
 =

 	if (p2p)
 		l_genl_msg_append_attr(new_msg, HWSIM_ATTR_SUPPORT_P2P_DEVICE,
@@ -1752,11 +1762,19 @@ static struct l_dbus_message *radio_manager_create(=
struct l_dbus *dbus,
 =

 	}
 =

-	l_genl_family_send(hwsim, new_msg, radio_manager_create_callback,
-				pending_create_msg, NULL);
+	radio =3D l_new(struct radio_info_rec, 1);
+	radio->pending =3D l_dbus_message_ref(message);
+	radio->name =3D l_strdup(name);
+	radio->id =3D -1;
+
+	if (!radio_info)
+		radio_info =3D l_queue_new();
 =

-	pending_create_msg =3D l_dbus_message_ref(message);
-	pending_create_radio_id =3D 0;
+	l_queue_push_tail(radio_info, radio);
+
+	radio->cmd_id =3D l_genl_family_send(hwsim, new_msg,
+						radio_manager_create_callback,
+						radio, NULL);
 =

 	return NULL;
 =

@@ -3088,9 +3106,6 @@ int main(int argc, char *argv[])
 	l_genl_family_free(nl80211);
 	l_genl_unref(genl);
 =

-	if (pending_create_msg)
-		l_dbus_message_unref(pending_create_msg);
-
 	l_dbus_destroy(dbus);
 	hwsim_radio_cache_cleanup();
 	l_queue_destroy(rules, l_free);
-- =

2.34.1

--===============4972399521575768092==--

