Content-Type: multipart/mixed; boundary="===============0750413510331359019=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] erp: add erp_cache_check_identity
Date: Tue, 03 Aug 2021 10:27:57 -0700
Message-ID: <20210803172759.123297-4-prestwoj@gmail.com>
In-Reply-To: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0750413510331359019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This offloads the ERP book keeping from network_has_erp_identity
into erp.c itself. Currently network needs to grab a cache
reference, check the identity, and potentially remove the entry
if not found. By moving this entirely into erp.c we can avoid the
need for ERP references all together as well as remove several
exposed APIs.
---
 src/erp.c | 23 +++++++++++++++++++++++
 src/erp.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/src/erp.c b/src/erp.c
index 4db32feb..3ff277ea 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -267,6 +267,29 @@ const char *erp_cache_entry_get_identity(struct erp_ca=
che_entry *cache)
 	return cache->id;
 }
 =

+bool erp_cache_check_identity(const char *ssid, const char *identity)
+{
+	struct erp_cache_entry *cache =3D find_keycache(NULL, ssid);
+
+	if (!cache)
+		return false;
+
+	if (!strcmp(identity, cache->id))
+		return true;
+
+	/*
+	 * The identity passed here is assumed to be 'verified' i.e. it exists
+	 * in a network provisioning file. If the cache entry we have does not
+	 * match it is invalid and should be removed. This could happen if the
+	 * ERP identity was updated in the provisioning file after already
+	 * establishing an ERP cache from a past connection.
+	 */
+	l_queue_remove(key_cache, cache);
+	erp_cache_entry_destroy(cache);
+
+	return false;
+}
+
 #define ERP_RRK_LABEL	"EAP Re-authentication Root Key(a)ietf.org"
 #define ERP_RIK_LABEL	"Re-authentication Integrity Key(a)ietf.org"
 #define ERP_RMSK_LABEL	"Re-authentication Master Session Key(a)ietf.org"
diff --git a/src/erp.h b/src/erp.h
index d2c9da96..433b11c9 100644
--- a/src/erp.h
+++ b/src/erp.h
@@ -51,3 +51,5 @@ struct erp_cache_entry *erp_cache_get(const char *ssid);
 void erp_cache_put(struct erp_cache_entry *cache);
 =

 const char *erp_cache_entry_get_identity(struct erp_cache_entry *cache);
+
+bool erp_cache_check_identity(const char *ssid, const char *identity);
-- =

2.31.1

--===============0750413510331359019==--

