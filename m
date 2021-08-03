Content-Type: multipart/mixed; boundary="===============7694797513342366068=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] erp: refactor to eliminate references/put/remove
Date: Tue, 03 Aug 2021 10:27:59 -0700
Message-ID: <20210803172759.123297-6-prestwoj@gmail.com>
In-Reply-To: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7694797513342366068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ERP cache has now been isolated and no longer needs to
maintain external reference counts. This removes the need for
erp_cache_remove (done internally now), erp_cache_put,
and erp_cache_entry_get_identity, as well as the cache ref count.
---
 src/erp.c | 71 ++++++++-----------------------------------------------
 src/erp.h |  5 ----
 2 files changed, 10 insertions(+), 66 deletions(-)

diff --git a/src/erp.c b/src/erp.c
index 3ff277ea..50c9f02a 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -49,7 +49,6 @@ struct erp_cache_entry {
 	size_t session_len;
 	char *ssid;
 	uint64_t expire_time;
-	uint32_t ref;
 	bool invalid : 1;
 };
 =

@@ -147,9 +146,6 @@ static void erp_cache_entry_destroy(void *data)
 {
 	struct erp_cache_entry *entry =3D data;
 =

-	if (entry->ref)
-		l_error("ERP entry still has a reference on cleanup!");
-
 	l_free(entry->id);
 	l_free(entry->emsk);
 	l_free(entry->session_id);
@@ -181,11 +177,11 @@ void erp_cache_add(const char *id, const void *sessio=
n_id,
 	l_queue_push_head(key_cache, entry);
 }
 =

-static struct erp_cache_entry *find_keycache(const char *id, const char *s=
sid)
+static struct erp_cache_entry *find_keycache(const char *ssid)
 {
 	const struct l_queue_entry *entry;
 =

-	if (!id && !ssid)
+	if (!ssid)
 		return NULL;
 =

 	for (entry =3D l_queue_get_entries(key_cache); entry;
@@ -196,80 +192,30 @@ static struct erp_cache_entry *find_keycache(const ch=
ar *id, const char *ssid)
 			continue;
 =

 		if (l_time_after(l_time_now(), cache->expire_time)) {
-			if (!cache->ref) {
-				l_queue_remove(key_cache, cache);
-				erp_cache_entry_destroy(cache);
-			} else
-				cache->invalid =3D true;
-
+			cache->invalid =3D true;
 			continue;
 		}
 =

-		if (id && !strcmp(cache->id, id))
-			return cache;
-
-		if (ssid && !strcmp(cache->ssid, ssid))
+		if (!strcmp(cache->ssid, ssid))
 			return cache;
 	}
 =

 	return NULL;
 }
 =

-void erp_cache_remove(const char *id)
-{
-	struct erp_cache_entry *entry =3D find_keycache(id, NULL);
-
-	if (!entry)
-		return;
-
-	if (entry->ref) {
-		entry->invalid =3D true;
-		return;
-	}
-
-	l_queue_remove(key_cache, entry);
-
-	erp_cache_entry_destroy(entry);
-}
-
 struct erp_cache_entry *erp_cache_get(const char *ssid)
 {
-	struct erp_cache_entry *cache =3D find_keycache(NULL, ssid);
+	struct erp_cache_entry *cache =3D find_keycache(ssid);
 =

 	if (!cache)
 		return NULL;
 =

-	cache->ref++;
-
 	return cache;
 }
 =

-void erp_cache_put(struct erp_cache_entry *cache)
-{
-	cache->ref--;
-
-	if (cache->ref)
-		return;
-
-	if (!cache->invalid)
-		return;
-
-	/*
-	 * Cache entry marked as invalid, either it expired or something
-	 * attempted to remove it. Either way, it can now be removed.
-	 */
-	l_queue_remove(key_cache, cache);
-	erp_cache_entry_destroy(cache);
-}
-
-const char *erp_cache_entry_get_identity(struct erp_cache_entry *cache)
-{
-	return cache->id;
-}
-
 bool erp_cache_check_identity(const char *ssid, const char *identity)
 {
-	struct erp_cache_entry *cache =3D find_keycache(NULL, ssid);
+	struct erp_cache_entry *cache =3D find_keycache(ssid);
 =

 	if (!cache)
 		return false;
@@ -365,7 +311,10 @@ struct erp_state *erp_new(struct erp_cache_entry *cach=
e,
 =

 void erp_free(struct erp_state *erp)
 {
-	erp_cache_put(erp->cache);
+	if (erp->cache->invalid) {
+		l_queue_remove(key_cache, erp->cache);
+		erp_cache_entry_destroy(erp->cache);
+	}
 =

 	explicit_bzero(erp->rmsk, sizeof(erp->rmsk));
 	explicit_bzero(erp->r_ik, sizeof(erp->r_ik));
diff --git a/src/erp.h b/src/erp.h
index 433b11c9..a6310cb9 100644
--- a/src/erp.h
+++ b/src/erp.h
@@ -45,11 +45,6 @@ void erp_cache_add(const char *id, const void *session_i=
d, size_t session_len,
 			const void *emsk, size_t emsk_len,
 			const char *ssid);
 =

-void erp_cache_remove(const char *id);
-
 struct erp_cache_entry *erp_cache_get(const char *ssid);
-void erp_cache_put(struct erp_cache_entry *cache);
-
-const char *erp_cache_entry_get_identity(struct erp_cache_entry *cache);
 =

 bool erp_cache_check_identity(const char *ssid, const char *identity);
-- =

2.31.1

--===============7694797513342366068==--

