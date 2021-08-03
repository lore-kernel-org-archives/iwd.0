Content-Type: multipart/mixed; boundary="===============5606078933547336413=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] station: network: rework ERP/FILS code path
Date: Tue, 03 Aug 2021 13:23:26 -0700
Message-ID: <20210803202328.140665-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5606078933547336413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This refactors some code to eliminate getting the ERP entry twice
by simply returning it from network_has_erp_identity (now renamed
to network_get_erp_cache). In addition this code was moved into
station_build_handshake_rsn and properly cleaned up in case there
was an error or if a FILS AKM was not chosen.
---
 src/network.c | 15 ++++++++-------
 src/network.h |  3 ++-
 src/station.c | 33 +++++++++++++++++++--------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/src/network.c b/src/network.c
index b78a7cbf..a6da0cab 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1056,7 +1056,7 @@ static bool match_bss(const void *a, const void *b)
 	return a =3D=3D b;
 }
 =

-bool network_has_erp_identity(struct network *network)
+struct erp_cache_entry *network_get_erp_cache(struct network *network)
 {
 	struct erp_cache_entry *cache;
 	struct l_settings *settings;
@@ -1066,16 +1066,16 @@ bool network_has_erp_identity(struct network *netwo=
rk)
 =

 	settings =3D network_get_settings(network);
 	if (!settings)
-		return false;
+		return NULL;
 =

 	check_id =3D l_settings_get_string(settings, "Security", "EAP-Identity");
 	if (!check_id)
-		return false;
+		return NULL;
 =

 	cache =3D erp_cache_get(network_get_ssid(network));
 	if (!cache) {
 		l_free(check_id);
-		return false;
+		return NULL;
 	}
 =

 	identity =3D erp_cache_entry_get_identity(cache);
@@ -1083,17 +1083,18 @@ bool network_has_erp_identity(struct network *netwo=
rk)
 	ret =3D strcmp(check_id, identity) =3D=3D 0;
 =

 	l_free(check_id);
-	erp_cache_put(cache);
 =

 	/*
 	 * The settings file must have change out from under us. In this
 	 * case we want to remove the ERP entry because it is no longer
 	 * valid.
 	 */
-	if (!ret)
+	if (!ret) {
 		erp_cache_remove(identity);
+		return NULL;
+	}
 =

-	return ret;
+	return cache;
 }
 =

 const struct l_queue_entry *network_bss_list_get_entries(
diff --git a/src/network.h b/src/network.h
index 58c26e6b..2cca7ffb 100644
--- a/src/network.h
+++ b/src/network.h
@@ -29,6 +29,7 @@ struct station;
 struct network;
 struct scan_bss;
 struct handshake_state;
+struct erp_cache_entry;
 =

 void network_connected(struct network *network);
 void network_disconnected(struct network *network);
@@ -87,7 +88,7 @@ void network_blacklist_add(struct network *network, struc=
t scan_bss *bss);
 const struct iovec *network_get_extra_ies(struct network *network,
 						size_t *num_elems);
 =

-bool network_has_erp_identity(struct network *network);
+struct erp_cache_entry *network_get_erp_cache(struct network *network);
 =

 const struct l_queue_entry *network_bss_list_get_entries(
 						struct network *network);
diff --git a/src/station.c b/src/station.c
index e914abb3..5414283c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -743,7 +743,7 @@ static int station_build_handshake_rsn(struct handshake=
_state *hs,
 {
 	enum security security =3D network_get_security(network);
 	bool add_mde =3D false;
-	bool fils_hint =3D false;
+	struct erp_cache_entry *erp_cache =3D NULL;
 =

 	struct ie_rsn_info bss_info;
 	uint8_t rsne_buf[256];
@@ -764,10 +764,10 @@ static int station_build_handshake_rsn(struct handsha=
ke_state *hs,
 	 * wiphy may select FILS if supported by the AP.
 	 */
 	if (security =3D=3D SECURITY_8021X && hs->support_fils)
-		fils_hint =3D network_has_erp_identity(network);
+		erp_cache =3D network_get_erp_cache(network);
 =

 	info.akm_suites =3D wiphy_select_akm(wiphy, bss, security,
-							&bss_info, fils_hint);
+						&bss_info, erp_cache !=3D NULL);
 =

 	/*
 	 * Special case for OWE. With OWE we still need to build up the
@@ -848,6 +848,19 @@ build_ie:
 	if (IE_AKM_IS_FT(info.akm_suites))
 		add_mde =3D true;
 =

+	/*
+	 * If FILS was chosen, the ERP cache has been verified to exist. Take
+	 * a reference now so it remains valid (in case of expiration) until
+	 * FILS starts.
+	 */
+	if (hs->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA256 |
+				IE_RSN_AKM_SUITE_FILS_SHA384 |
+				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
+				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+		hs->erp_cache =3D erp_cache;
+	else if (erp_cache)
+		erp_cache_put(erp_cache);
+
 open_network:
 	if (security =3D=3D SECURITY_NONE)
 		/* Perform FT association if available */
@@ -867,6 +880,9 @@ open_network:
 	return 0;
 =

 not_supported:
+	if (erp_cache)
+		erp_cache_put(erp_cache);
+
 	return -ENOTSUP;
 }
 =

@@ -889,17 +905,6 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 	if (network_handshake_setup(network, hs) < 0)
 		goto not_supported;
 =

-	/*
-	 * If FILS was chosen, the ERP cache has been verified to exist. We
-	 * wait to get it until here because@this point so there are no
-	 * failure paths before fils_sm_new
-	 */
-	if (hs->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FILS_SHA384 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
-		hs->erp_cache =3D erp_cache_get(network_get_ssid(network));
-
 	return hs;
 =

 not_supported:
-- =

2.31.1

--===============5606078933547336413==--

