Content-Type: multipart/mixed; boundary="===============5279845893841274394=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] wiphy: add fils_hint to wiphy_can_connect
Date: Tue, 27 Apr 2021 11:06:26 -0700
Message-ID: <20210427180626.40974-3-prestwoj@gmail.com>
In-Reply-To: <20210427180626.40974-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5279845893841274394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A prior commit refactored the AKM selection in wiphy.c. This
ended up breaking FILS tests due to the hard coding of a
false fils_hint in wiphy_select_akm. Since our FILS tests
only advertise FILS AKMs wiphy_can_connect would return false
for these networks.

Similar to wiphy_select_akm, add a fils hint parameter to
wiphy_can_connect and pass that down directly to wiphy_select_akm.
---
 src/network.c | 3 ++-
 src/station.c | 3 ++-
 src/wiphy.c   | 5 +++--
 src/wiphy.h   | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index 8b68f9e1..1b1f7f86 100644
--- a/src/network.c
+++ b/src/network.c
@@ -768,6 +768,7 @@ struct scan_bss *network_bss_select(struct network *net=
work,
 	struct wiphy *wiphy =3D station_get_wiphy(network->station);
 	const struct l_queue_entry *bss_entry;
 	struct scan_bss *candidate =3D NULL;
+	bool fils_hint =3D network_has_erp_identity(network);
 =

 	for (bss_entry =3D l_queue_get_entries(bss_list); bss_entry;
 			bss_entry =3D bss_entry->next) {
@@ -776,7 +777,7 @@ struct scan_bss *network_bss_select(struct network *net=
work,
 		switch (network_get_security(network)) {
 		case SECURITY_PSK:
 		case SECURITY_8021X:
-			if (!wiphy_can_connect(wiphy, bss))
+			if (!wiphy_can_connect(wiphy, bss, fils_hint))
 				continue;
 			/* fall through */
 		case SECURITY_NONE:
diff --git a/src/station.c b/src/station.c
index ae9d1f24..8a940cc6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1938,6 +1938,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 	uint16_t mdid;
 	enum security orig_security, security;
 	bool seen =3D false;
+	bool fils_hint =3D network_has_erp_identity(network);
 =

 	if (err) {
 		station_roam_failed(station);
@@ -1994,7 +1995,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 =

 		seen =3D true;
 =

-		if (!wiphy_can_connect(station->wiphy, bss))
+		if (!wiphy_can_connect(station->wiphy, bss, fils_hint))
 			goto next;
 =

 		if (blacklist_contains_bss(bss->addr))
diff --git a/src/wiphy.c b/src/wiphy.c
index 7d5dc4b5..7d491913 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -397,7 +397,8 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 =

-bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss)
+bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss,
+			bool fils_hint)
 {
 	struct ie_rsn_info rsn_info;
 	int r;
@@ -416,7 +417,7 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct scan=
_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

-		return wiphy_select_akm(wiphy, bss, false);
+		return wiphy_select_akm(wiphy, bss, fils_hint);
 	} else if (r !=3D -ENOENT)
 		return false;
 =

diff --git a/src/wiphy.h b/src/wiphy.h
index 50fcb182..c5891f73 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -78,7 +78,8 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
-bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss);
+bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss,
+				bool fils_hint);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
-- =

2.26.2

--===============5279845893841274394==--

