Content-Type: multipart/mixed; boundary="===============3997941170751500499=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: handle GET_KEY error setting RSC to zero
Date: Fri, 29 Jan 2021 10:47:25 -0800
Message-ID: <20210129184725.90862-2-prestwoj@gmail.com>
In-Reply-To: <20210129184725.90862-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3997941170751500499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rather than the previous hack which disabled group traffic it
was found that the GTK RSC could be manually set to zero which
allows group traffic. This appears to fix AP mode on brcmfmac
along with the previous fixes. This is not documented in
nl80211, but appears to work with this driver.
---
 src/ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 0b96e2ab..e695a67e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -787,6 +787,7 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, voi=
d *user_data)
 {
 	struct sta_state *sta =3D user_data;
 	const void *gtk_rsc;
+	uint8_t zero_gtk_rsc[6];
 =

 	sta->gtk_query_cmd_id =3D 0;
 =

@@ -795,11 +796,8 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, vo=
id *user_data)
 =

 	gtk_rsc =3D nl80211_parse_get_key_seq(msg);
 	if (!gtk_rsc) {
-		/* Try allowing connection with no group traffic */
-		l_warn("Failed to get GTK. This may be a driver/FW issue, "
-			"disabling group traffic");
-		ap_start_rsna(sta, NULL);
-		return;
+		memset(zero_gtk_rsc, 0, 6);
+		gtk_rsc =3D zero_gtk_rsc;
 	}
 =

 	ap_start_rsna(sta, gtk_rsc);
-- =

2.26.2

--===============3997941170751500499==--

