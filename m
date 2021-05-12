Content-Type: multipart/mixed; boundary="===============0599411920161761089=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/11] station: factor out logic for choosing FT
Date: Wed, 12 May 2021 16:01:38 -0700
Message-ID: <20210512230148.370858-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0599411920161761089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index 479f81f5..bdb8859a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1823,13 +1823,30 @@ static void station_preauthenticate_cb(struct netde=
v *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 =

+static bool station_can_fast_transition(struct handshake_state *hs,
+					struct scan_bss *bss)
+{
+	uint16_t mdid;
+
+	if (!hs->mde)
+		return false;
+
+	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
+						&mdid, NULL, NULL) < 0)
+		return false;
+
+	if (bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
+		return true;
+
+	return false;
+}
+
 static void station_transition_start(struct station *station,
 							struct scan_bss *bss)
 {
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
 	struct network *connected =3D station->connected_network;
 	enum security security =3D network_get_security(connected);
-	uint16_t mdid;
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 =

@@ -1839,12 +1856,8 @@ static void station_transition_start(struct station =
*station,
 	/* Reset AP roam flag, at this point the roaming behaves the same */
 	station->ap_directed_roaming =3D false;
 =

-	if (hs->mde)
-		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
-							&mdid, NULL, NULL);
-
 	/* Can we use Fast Transition? */
-	if (hs->mde && bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid) {
+	if (station_can_fast_transition(hs, bss)) {
 		/* Rebuild handshake RSN for target AP */
 		if (station_build_handshake_rsn(hs, station->wiphy,
 				station->connected_network, bss) < 0) {
-- =

2.31.1

--===============0599411920161761089==--

