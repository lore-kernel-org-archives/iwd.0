Content-Type: multipart/mixed; boundary="===============0965372321906946684=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/7] dbus: add helper for appending a dictionary
Date: Mon, 11 Jan 2021 13:34:56 -0800
Message-ID: <20210111213502.551370-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0965372321906946684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arrays of dictionaries are quite common, and for basic
types this API makes things much more convenient by
putting all the enter/append/leave calls in one place.
---
 src/dbus.c | 24 ++++++++++++++++++++++++
 src/dbus.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/src/dbus.c b/src/dbus.c
index ceede5c8..d6bfc52d 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -202,6 +202,30 @@ void dbus_pending_reply(struct l_dbus_message **msg,
 	*msg =3D NULL;
 }
 =

+/*
+ * Convenience helper for appending a dictionary "{sv}". This only works w=
hen
+ * the variant is a basic type.
+ */
+bool dbus_append_dict_basic(struct l_dbus_message_builder *builder,
+				const char *name, const char *type,
+				const void *data)
+{
+	if (!l_dbus_message_builder_enter_dict(builder, "sv"))
+		return false;
+	if (!l_dbus_message_builder_append_basic(builder, 's', name))
+		return false;
+	if (!l_dbus_message_builder_enter_variant(builder, type))
+		return false;
+	if (!l_dbus_message_builder_append_basic(builder, type[0], data))
+		return false;
+	if (!l_dbus_message_builder_leave_variant(builder))
+		return false;
+	if (!l_dbus_message_builder_leave_dict(builder))
+		return false;
+
+	return true;
+}
+
 struct l_dbus *dbus_get_bus(void)
 {
 	return g_dbus;
diff --git a/src/dbus.h b/src/dbus.h
index 3e2018d8..3a055482 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -51,6 +51,9 @@ struct l_dbus *dbus_get_bus(void);
 =

 void dbus_pending_reply(struct l_dbus_message **msg,
 				struct l_dbus_message *reply);
+bool dbus_append_dict_basic(struct l_dbus_message_builder *builder,
+				const char *name, const char *type,
+				const void *data);
 =

 const char *dbus_iftype_to_string(unsigned int iftype);
 =

-- =

2.26.2

--===============0965372321906946684==--

