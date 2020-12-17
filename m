Content-Type: multipart/mixed; boundary="===============7907980126680330497=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/11] hwsim: check pending_create_msg before replying
Date: Thu, 17 Dec 2020 11:36:02 -0800
Message-ID: <20201217193611.1177006-2-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7907980126680330497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the NEW_RADIO callback hwsim was assuming that DBus had no
yet replied to the Create() method. In some cases the NEW_RADIO
event fires before the actual callback which will respond to
DBus. This causes a crash in the create callback.
---
 tools/hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 641a6c6f..c17792bf 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1579,7 +1579,7 @@ static void radio_manager_create_callback(struct l_ge=
nl_msg *msg,
 	 */
 	radio =3D l_queue_find(radio_info, radio_info_match_id,
 				L_UINT_TO_PTR(pending_create_radio_id));
-	if (radio) {
+	if (radio && pending_create_msg) {
 		const char *path =3D radio_get_path(radio);
 =

 		reply =3D l_dbus_message_new_method_return(pending_create_msg);
-- =

2.26.2

--===============7907980126680330497==--

