Content-Type: multipart/mixed; boundary="===============0443316401839564052=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] dpp: print error if CMD_FRAME fails
Date: Fri, 15 Apr 2022 09:59:19 -0700
Message-ID: <20220415165921.9892-2-prestwoj@gmail.com>
In-Reply-To: 20220415165921.9892-1-prestwoj@gmail.com

--===============0443316401839564052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index e817ca5a..090a3211 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -282,9 +282,10 @@ static void dpp_free(struct dpp_sm *dpp)
 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct dpp_sm *dpp =3D user_data;
+	int err =3D l_genl_msg_get_error(msg);
 =

-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("Error sending frame");
+	if (err < 0) {
+		l_error("Error sending frame (%d)", err);
 		return;
 	}
 =

-- =

2.34.1

--===============0443316401839564052==--

