Content-Type: multipart/mixed; boundary="===============2800332870394175609=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] hwsim: don't print on when send frame fails
Date: Mon, 14 Feb 2022 12:34:37 -0800
Message-ID: <20220214203439.989936-1-prestwoj@gmail.com>

--===============2800332870394175609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This happens quite often and spams the console with this error.
---
 tools/hwsim.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 7c32b869..f74dd82e 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1336,11 +1336,7 @@ static void send_frame_callback(struct l_genl_msg *m=
sg, void *user_data)
 {
 	struct send_frame_info *info =3D user_data;
 =

-	if (l_genl_msg_get_error(msg) < 0)
-		/* Radio address or frequency didn't match */
-		l_debug("HWSIM_CMD_FRAME failed for destination %s",
-			util_address_to_string(info->radio->addrs[0]));
-	else {
+	if (l_genl_msg_get_error(msg) =3D=3D 0) {
 		info->frame->acked =3D true;
 		info->frame->ack_radio =3D info->radio;
 	}
-- =

2.34.1

--===============2800332870394175609==--

