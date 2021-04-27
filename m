Content-Type: multipart/mixed; boundary="===============4472587802688750436=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] network: copy station_has_erp_identity
Date: Tue, 27 Apr 2021 11:06:24 -0700
Message-ID: <20210427180626.40974-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4472587802688750436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This API is internal to station, but acts only on the network
object so it is being moved into network.c and exposed.
---
 src/network.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/network.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/src/network.c b/src/network.c
index 53fc98a1..8b68f9e1 100644
--- a/src/network.c
+++ b/src/network.c
@@ -50,6 +50,7 @@
 #include "src/network.h"
 #include "src/blacklist.h"
 #include "src/util.h"
+#include "src/erp.h"
 =

 static uint32_t known_networks_watch;
 static uint32_t anqp_watch;
@@ -720,6 +721,46 @@ static bool match_bss(const void *a, const void *b)
 	return a =3D=3D b;
 }
 =

+bool network_has_erp_identity(struct network *network)
+{
+	struct erp_cache_entry *cache;
+	struct l_settings *settings;
+	char *check_id;
+	const char *identity;
+	bool ret;
+
+	settings =3D network_get_settings(network);
+	if (!settings)
+		return false;
+
+	check_id =3D l_settings_get_string(settings, "Security", "EAP-Identity");
+	if (!check_id)
+		return false;
+
+	cache =3D erp_cache_get(network_get_ssid(network));
+	if (!cache) {
+		l_free(check_id);
+		return false;
+	}
+
+	identity =3D erp_cache_entry_get_identity(cache);
+
+	ret =3D strcmp(check_id, identity) =3D=3D 0;
+
+	l_free(check_id);
+	erp_cache_put(cache);
+
+	/*
+	 * The settings file must have change out from under us. In this
+	 * case we want to remove the ERP entry because it is no longer
+	 * valid.
+	 */
+	if (!ret)
+		erp_cache_remove(identity);
+
+	return ret;
+}
+
 struct scan_bss *network_bss_select(struct network *network,
 						bool fallback_to_blacklist)
 {
diff --git a/src/network.h b/src/network.h
index 17890496..84fc4fba 100644
--- a/src/network.h
+++ b/src/network.h
@@ -79,3 +79,5 @@ void network_blacklist_add(struct network *network, struc=
t scan_bss *bss);
 =

 const struct iovec *network_get_extra_ies(struct network *network,
 						size_t *num_elems);
+
+bool network_has_erp_identity(struct network *network);
-- =

2.26.2

--===============4472587802688750436==--

