Content-Type: multipart/mixed; boundary="===============1550178854538478653=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: remove rates requirement for fmac cards
Date: Mon, 12 Apr 2021 11:22:45 -0700
Message-ID: <20210412182245.1555350-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1550178854538478653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was seen that some full mac cards/drivers do not include any
rate information with the NEW_STATION event. This was causing
the NEW_STATION event to be ignored, preventing AP mode from
working on these cards.

Since the full mac path does not even require sta->rates the
parsing can be removed completely.
---
 src/ap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 86451d42..46821c04 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -281,7 +281,9 @@ static void ap_sta_free(void *data)
 	struct sta_state *sta =3D data;
 	struct ap_state *ap =3D sta->ap;
 =

-	l_uintset_free(sta->rates);
+	if (sta->rates)
+		l_uintset_free(sta->rates);
+
 	l_free(sta->assoc_ies);
 =

 	if (sta->assoc_resp_cmd_id)
@@ -2329,7 +2331,9 @@ static bool ap_parse_new_station_ies(const void *data=
, uint16_t len,
 	}
 =

 	*rsn_out =3D rsn;
-	*rates_out =3D rates;
+
+	if (rates_out)
+		*rates_out =3D rates;
 =

 	return true;
 =

@@ -2352,7 +2356,6 @@ static void ap_handle_new_station(struct ap_state *ap=
, struct l_genl_msg *msg)
 	const void *data;
 	uint8_t mac[6];
 	uint8_t *assoc_rsne =3D NULL;
-	struct l_uintset *rates =3D NULL;
 =

 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -2360,11 +2363,11 @@ static void ap_handle_new_station(struct ap_state *=
ap, struct l_genl_msg *msg)
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_IE:
-			if (assoc_rsne || rates)
+			if (assoc_rsne)
 				goto cleanup;
 =

 			if (!ap_parse_new_station_ies(data, len, &assoc_rsne,
-							&rates))
+							NULL))
 				return;
 			break;
 		case NL80211_ATTR_MAC:
@@ -2376,7 +2379,7 @@ static void ap_handle_new_station(struct ap_state *ap=
, struct l_genl_msg *msg)
 		}
 	}
 =

-	if (!assoc_rsne || !rates)
+	if (!assoc_rsne)
 		goto cleanup;
 =

 	/*
@@ -2391,7 +2394,6 @@ static void ap_handle_new_station(struct ap_state *ap=
, struct l_genl_msg *msg)
 	memcpy(sta->addr, mac, 6);
 	sta->ap =3D ap;
 	sta->assoc_rsne =3D assoc_rsne;
-	sta->rates =3D rates;
 	sta->aid =3D ++ap->last_aid;
 =

 	sta->associated =3D true;
@@ -2415,7 +2417,6 @@ static void ap_handle_new_station(struct ap_state *ap=
, struct l_genl_msg *msg)
 =

 cleanup:
 	l_free(assoc_rsne);
-	l_uintset_free(rates);
 }
 =

 static void ap_handle_del_station(struct ap_state *ap, struct l_genl_msg *=
msg)
-- =

2.26.2

--===============1550178854538478653==--

