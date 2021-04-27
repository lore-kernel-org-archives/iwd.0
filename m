Content-Type: multipart/mixed; boundary="===============5434742894710675915=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: update to use network_has_erp_identity
Date: Tue, 27 Apr 2021 11:06:25 -0700
Message-ID: <20210427180626.40974-2-prestwoj@gmail.com>
In-Reply-To: <20210427180626.40974-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5434742894710675915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/src/station.c b/src/station.c
index 79ba23dc..ae9d1f24 100644
--- a/src/station.c
+++ b/src/station.c
@@ -755,46 +755,6 @@ static void station_handshake_event(struct handshake_s=
tate *hs,
 	va_end(args);
 }
 =

-static bool station_has_erp_identity(struct network *network)
-{
-	struct erp_cache_entry *cache;
-	struct l_settings *settings;
-	char *check_id;
-	const char *identity;
-	bool ret;
-
-	settings =3D network_get_settings(network);
-	if (!settings)
-		return false;
-
-	check_id =3D l_settings_get_string(settings, "Security", "EAP-Identity");
-	if (!check_id)
-		return false;
-
-	cache =3D erp_cache_get(network_get_ssid(network));
-	if (!cache) {
-		l_free(check_id);
-		return false;
-	}
-
-	identity =3D erp_cache_entry_get_identity(cache);
-
-	ret =3D strcmp(check_id, identity) =3D=3D 0;
-
-	l_free(check_id);
-	erp_cache_put(cache);
-
-	/*
-	 * The settings file must have change out from under us. In this
-	 * case we want to remove the ERP entry because it is no longer
-	 * valid.
-	 */
-	if (!ret)
-		erp_cache_remove(identity);
-
-	return ret;
-}
-
 static int station_build_handshake_rsn(struct handshake_state *hs,
 					struct wiphy *wiphy,
 					struct network *network,
@@ -823,7 +783,7 @@ static int station_build_handshake_rsn(struct handshake=
_state *hs,
 	 * wiphy may select FILS if supported by the AP.
 	 */
 	if (security =3D=3D SECURITY_8021X && hs->support_fils)
-		fils_hint =3D station_has_erp_identity(network);
+		fils_hint =3D network_has_erp_identity(network);
 =

 	info.akm_suites =3D wiphy_select_akm(wiphy, bss, fils_hint);
 =

-- =

2.26.2

--===============5434742894710675915==--

