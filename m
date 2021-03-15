Content-Type: multipart/mixed; boundary="===============7981430765340597240=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] network: add network_bss_update
Date: Mon, 15 Mar 2021 12:15:27 -0700
Message-ID: <20210315191529.186554-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7981430765340597240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will swap out a scan_bss object with a duplicate that may
exist in a networks bss_list. The duplicate will be removed by
since the object is owned by station it is assumed that it will
be freed elsewhere.
---
 src/network.c | 21 +++++++++++++++++++++
 src/network.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/src/network.c b/src/network.c
index 5a8d93ee..0f5106b7 100644
--- a/src/network.c
+++ b/src/network.c
@@ -672,6 +672,27 @@ bool network_bss_add(struct network *network, struct s=
can_bss *bss)
 	return true;
 }
 =

+static bool match_addr(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+
+	return memcmp(bss->addr, b, 6) =3D=3D 0;
+}
+
+/*
+ * Replaces an old scan_bss (if exists) in the bss list with a new bss obj=
ect.
+ * Note this BSS is *not* freed and must be by the caller. scan_bss object=
s are
+ * shared between network/station but station technically owns them.
+ */
+bool network_bss_update(struct network *network, struct scan_bss *bss)
+{
+	l_queue_remove_if(network->bss_list, match_addr, bss->addr);
+
+	l_queue_insert(network->bss_list, bss, scan_bss_rank_compare, NULL);
+
+	return true;
+}
+
 bool network_bss_list_isempty(struct network *network)
 {
 	return l_queue_isempty(network->bss_list);
diff --git a/src/network.h b/src/network.h
index 30d8145e..17890496 100644
--- a/src/network.h
+++ b/src/network.h
@@ -55,6 +55,7 @@ void network_set_info(struct network *network, struct net=
work_info *info);
 int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
+bool network_bss_update(struct network *network, struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 void network_bss_list_clear(struct network *network);
 struct scan_bss *network_bss_list_pop(struct network *network);
-- =

2.26.2

--===============7981430765340597240==--

