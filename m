Content-Type: multipart/mixed; boundary="===============7428047838884769204=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] network: use erp_cache_check_identity
Date: Tue, 03 Aug 2021 10:27:58 -0700
Message-ID: <20210803172759.123297-5-prestwoj@gmail.com>
In-Reply-To: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7428047838884769204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will both check, and remove an invalidated entry if needed.
---
 src/network.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/src/network.c b/src/network.c
index b78a7cbf..ec52e2bd 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1058,10 +1058,8 @@ static bool match_bss(const void *a, const void *b)
 =

 bool network_has_erp_identity(struct network *network)
 {
-	struct erp_cache_entry *cache;
 	struct l_settings *settings;
 	char *check_id;
-	const char *identity;
 	bool ret;
 =

 	settings =3D network_get_settings(network);
@@ -1072,26 +1070,9 @@ bool network_has_erp_identity(struct network *networ=
k)
 	if (!check_id)
 		return false;
 =

-	cache =3D erp_cache_get(network_get_ssid(network));
-	if (!cache) {
-		l_free(check_id);
-		return false;
-	}
-
-	identity =3D erp_cache_entry_get_identity(cache);
-
-	ret =3D strcmp(check_id, identity) =3D=3D 0;
+	ret =3D erp_cache_check_identity(network->ssid, check_id);
 =

 	l_free(check_id);
-	erp_cache_put(cache);
-
-	/*
-	 * The settings file must have change out from under us. In this
-	 * case we want to remove the ERP entry because it is no longer
-	 * valid.
-	 */
-	if (!ret)
-		erp_cache_remove(identity);
 =

 	return ret;
 }
-- =

2.31.1

--===============7428047838884769204==--

