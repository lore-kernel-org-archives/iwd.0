Content-Type: multipart/mixed; boundary="===============4415278849752181508=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: allow no group traffic on GET_KEY error
Date: Thu, 28 Jan 2021 10:33:52 -0800
Message-ID: <20210128183352.1004552-2-prestwoj@gmail.com>
In-Reply-To: <20210128183352.1004552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4415278849752181508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some fullmac cards were found to be buggy with getting the GTK
where it returns a BIP key for the GTK index, even after creating
a GTK with NEW_KEY explicitly. In an effort to get these cards
semi-working we can treat this just as a warning and continue with
the handshake without a GTK set which disables group traffic. A
warning is printed in this case so the user is not completely in
the dark.
---
 src/ap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index c781ade4..5768233b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -790,10 +790,18 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, v=
oid *user_data)
 =

 	sta->gtk_query_cmd_id =3D 0;
 =

-	gtk_rsc =3D nl80211_parse_get_key_seq(msg);
-	if (!gtk_rsc)
+	if (l_genl_msg_get_error(msg) < 0)
 		goto error;
 =

+	gtk_rsc =3D nl80211_parse_get_key_seq(msg);
+	if (!gtk_rsc) {
+		/* Try allowing connection with no group traffic */
+		l_warn("Failed to get GTK. This may be a driver/FW issue, "
+			"disabling group traffic");
+		ap_start_rsna(sta, NULL);
+		return;
+	}
+
 	ap_start_rsna(sta, gtk_rsc);
 	return;
 =

-- =

2.26.2

--===============4415278849752181508==--

