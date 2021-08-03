Content-Type: multipart/mixed; boundary="===============1539281845029945790=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/3] erp: take cache ref in erp_new
Date: Tue, 03 Aug 2021 14:40:45 -0700
Message-ID: <20210803214045.153011-3-prestwoj@gmail.com>
In-Reply-To: <20210803214045.153011-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1539281845029945790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the erp_state is holding a pointer to the ERP cache, as
well as calling erp_cache_put on free, it should take a reference
for symmetry.
---
 src/erp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/erp.c b/src/erp.c
index 4db32feb..59e6033c 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -336,6 +336,7 @@ struct erp_state *erp_new(struct erp_cache_entry *cache,
 	erp->tx_packet =3D tx_packet;
 	erp->user_data =3D user_data;
 	erp->cache =3D cache;
+	cache->ref++;
 =

 	return erp;
 }
-- =

2.31.1

--===============1539281845029945790==--

