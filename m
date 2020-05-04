Content-Type: multipart/mixed; boundary="===============8601914973998910244=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] manager: move debug print in dump callback
Date: Mon, 04 May 2020 08:24:17 -0700
Message-ID: <20200504152420.27210-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8601914973998910244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This callback gets called way to many times to have a debug print
in the location that it was. Instead only print if a NEW wiphy is
found, and also print the name/id.
---
 src/manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index f351c780..5462418b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -519,8 +519,6 @@ static void manager_wiphy_dump_callback(struct l_genl_m=
sg *msg, void *user_data)
 	struct wiphy *wiphy;
 	struct wiphy_setup_state *state;
 =

-	l_debug("");
-
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &id,
 					NL80211_ATTR_WIPHY_NAME, &name,
 					NL80211_ATTR_UNSPEC) < 0)
@@ -543,6 +541,8 @@ static void manager_wiphy_dump_callback(struct l_genl_m=
sg *msg, void *user_data)
 	state->id =3D id;
 	state->wiphy =3D wiphy;
 =

+	l_debug("New wiphy %s added (%d)", name, id);
+
 	l_queue_push_tail(pending_wiphys, state);
 =

 done:
-- =

2.21.1

--===============8601914973998910244==--

