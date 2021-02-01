Content-Type: multipart/mixed; boundary="===============8176332826797794694=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] client: ap: handle NotFound on diagnostic interface
Date: Mon, 01 Feb 2021 14:05:15 -0800
Message-ID: <20210201220518.36975-2-prestwoj@gmail.com>
In-Reply-To: <20210201220518.36975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8176332826797794694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can happen when 'ap <wlan> show' is used on an AP interface
which has not been started. This isn't an error per-se so it
should be handled and print nothing rather than print an error.
---
 client/ap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/client/ap.c b/client/ap.c
index 7130bb9a..9a7f8642 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -201,9 +201,18 @@ static void ap_get_diagnostics_callback(struct l_dbus_=
message *message,
 	struct l_dbus_message_iter iter;
 	uint16_t idx =3D 0;
 	char client_num[15];
+	const char *name;
+	const char *text;
 =

-	if (dbus_message_has_error(message))
+	if (l_dbus_message_get_error(message, &name, &text)) {
+		if (!strcmp(name, "net.connman.iwd.NotFound")) {
+			display_table_footer();
+			return;
+		}
+
+		display_error(text);
 		return;
+	}
 =

 	if (!l_dbus_message_get_arguments(message, "aa{sv}", &array)) {
 		display("Failed to parse GetDiagnostics message");
-- =

2.26.2

--===============8176332826797794694==--

