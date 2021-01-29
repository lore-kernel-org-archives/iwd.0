Content-Type: multipart/mixed; boundary="===============4209299454777489783=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] ap: rename ap_parse_ie to be more descriptive
Date: Fri, 29 Jan 2021 10:47:24 -0800
Message-ID: <20210129184725.90862-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4209299454777489783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is only used for NEW_STATION parsing so name appropriately
---
 src/ap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 7ff15097..0b96e2ab 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2197,8 +2197,9 @@ error:
 	ap_start_failed(ap);
 }
 =

-static bool ap_parse_ie(const void *data, uint16_t len, uint8_t **rsn_out,
-				struct l_uintset **rates_out)
+static bool ap_parse_new_station_ies(const void *data, uint16_t len,
+					uint8_t **rsn_out,
+					struct l_uintset **rates_out)
 {
 	struct ie_tlv_iter iter;
 	uint8_t *rsn =3D NULL;
@@ -2255,7 +2256,8 @@ static void ap_handle_new_station(struct ap_state *ap=
, struct l_genl_msg *msg)
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_IE:
-			if (!ap_parse_ie(data, len, &assoc_rsne, &rates))
+			if (!ap_parse_new_station_ies(data, len, &assoc_rsne,
+							&rates))
 				return;
 			break;
 		case NL80211_ATTR_MAC:
-- =

2.26.2

--===============4209299454777489783==--

