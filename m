Content-Type: multipart/mixed; boundary="===============1106140313951806016=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] network: replace l_queue_get_entries loop
Date: Mon, 15 Mar 2021 12:15:28 -0700
Message-ID: <20210315191529.186554-2-prestwoj@gmail.com>
In-Reply-To: <20210315191529.186554-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1106140313951806016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After adding network_bss_update, network now has a match_addr
queue function which can be used to replace an unneeded
l_queue_get_entries loop with l_queue_find.
---
 src/network.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/network.c b/src/network.c
index 0f5106b7..53fc98a1 100644
--- a/src/network.c
+++ b/src/network.c
@@ -712,17 +712,7 @@ struct scan_bss *network_bss_list_pop(struct network *=
network)
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 						const uint8_t *addr)
 {
-	const struct l_queue_entry *bss_entry;
-
-	for (bss_entry =3D l_queue_get_entries(network->bss_list); bss_entry;
-						bss_entry =3D bss_entry->next) {
-		struct scan_bss *bss =3D bss_entry->data;
-
-		if (!memcmp(bss->addr, addr, sizeof(bss->addr)))
-			return bss;
-	}
-
-	return NULL;
+	return l_queue_find(network->bss_list, match_addr, addr);
 }
 =

 static bool match_bss(const void *a, const void *b)
-- =

2.26.2

--===============1106140313951806016==--

