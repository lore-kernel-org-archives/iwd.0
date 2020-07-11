Content-Type: multipart/mixed; boundary="===============5555267481355991244=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/18] p2p: Use nl80211_parse_attrs
Date: Sat, 11 Jul 2020 03:00:39 +0200
Message-ID: <20200711010053.224223-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5555267481355991244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Simplify p2p_device_update_from_genl by making use of nl80211_parse_attrs.
---
 src/p2p.c | 72 +++++++++++++------------------------------------------
 1 file changed, 16 insertions(+), 56 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index c3e4d8dd..0d580ce3 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3044,74 +3044,34 @@ static void p2p_mlme_notify(struct l_genl_msg *msg,=
 void *user_data)
 struct p2p_device *p2p_device_update_from_genl(struct l_genl_msg *msg,
 						bool create)
 {
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	const void *data;
-	const uint8_t *ifaddr =3D NULL;
-	const uint64_t *wdev_id =3D NULL;
-	struct wiphy *wiphy =3D NULL;
+	const uint8_t *ifaddr;
+	uint32_t iftype;
+	uint64_t wdev_id;
+	uint32_t wiphy_id;
+	struct wiphy *wiphy;
 	struct p2p_device *dev;
 	char hostname[HOST_NAME_MAX + 1];
 	char *str;
 	unsigned int uint_val;
 =

-	if (!l_genl_attr_init(&attr, msg))
-		return NULL;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_WDEV:
-			if (len !=3D sizeof(uint64_t)) {
-				l_warn("Invalid wdev index attribute");
-				return NULL;
-			}
-
-			wdev_id =3D data;
-			break;
-
-		case NL80211_ATTR_WIPHY:
-			if (len !=3D sizeof(uint32_t)) {
-				l_warn("Invalid wiphy attribute");
-				return NULL;
-			}
-
-			wiphy =3D wiphy_find(*((uint32_t *) data));
-			break;
-
-		case NL80211_ATTR_IFTYPE:
-			if (len !=3D sizeof(uint32_t)) {
-				l_warn("Invalid interface type attribute");
-				return NULL;
-			}
-
-			if (*((uint32_t *) data) !=3D NL80211_IFTYPE_P2P_DEVICE)
-				return NULL;
-
-			break;
-
-		case NL80211_ATTR_MAC:
-			if (len !=3D ETH_ALEN) {
-				l_warn("Invalid interface address attribute");
-				return NULL;
-			}
-
-			ifaddr =3D data;
-			break;
-		}
-	}
-
-	if (!wiphy || !wdev_id || !ifaddr) {
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
+				NL80211_ATTR_WIPHY, &wiphy_id,
+				NL80211_ATTR_IFTYPE, &iftype,
+				NL80211_ATTR_MAC, &ifaddr,
+				NL80211_ATTR_UNSPEC) < 0 ||
+			L_WARN_ON(!(wiphy =3D wiphy_find(wiphy_id))) ||
+			L_WARN_ON(iftype !=3D NL80211_IFTYPE_P2P_DEVICE)) {
 		l_warn("Unable to parse interface information");
 		return NULL;
 	}
 =

 	if (create) {
-		if (p2p_device_find(*wdev_id)) {
-			l_debug("Duplicate p2p device %" PRIx64, *wdev_id);
+		if (p2p_device_find(wdev_id)) {
+			l_debug("Duplicate p2p device %" PRIx64, wdev_id);
 			return NULL;
 		}
 	} else {
-		dev =3D p2p_device_find(*wdev_id);
+		dev =3D p2p_device_find(wdev_id);
 		if (!dev)
 			return NULL;
 =

@@ -3120,7 +3080,7 @@ struct p2p_device *p2p_device_update_from_genl(struct=
 l_genl_msg *msg,
 	}
 =

 	dev =3D l_new(struct p2p_device, 1);
-	dev->wdev_id =3D *wdev_id;
+	dev->wdev_id =3D wdev_id;
 	memcpy(dev->addr, ifaddr, ETH_ALEN);
 	dev->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	dev->wiphy =3D wiphy;
-- =

2.25.1

--===============5555267481355991244==--

