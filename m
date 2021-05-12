Content-Type: multipart/mixed; boundary="===============5693074282651734612=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/11] network: add network_bss_list_get_entries
Date: Wed, 12 May 2021 14:46:04 -0700
Message-ID: <20210512214610.361080-5-prestwoj@gmail.com>
In-Reply-To: <20210512214610.361080-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5693074282651734612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gets the first l_queue_entry in the networks BSS list. Useful
for iterating only a given networks BSS's outside of network.c.
---
 src/network.c | 6 ++++++
 src/network.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/src/network.c b/src/network.c
index 5bd57777..9e858663 100644
--- a/src/network.c
+++ b/src/network.c
@@ -761,6 +761,12 @@ bool network_has_erp_identity(struct network *network)
 	return ret;
 }
 =

+const struct l_queue_entry *network_bss_list_get_entries(
+						struct network *network)
+{
+	return l_queue_get_entries(network->bss_list);
+}
+
 struct scan_bss *network_bss_select(struct network *network,
 						bool fallback_to_blacklist)
 {
diff --git a/src/network.h b/src/network.h
index 84fc4fba..bd51945f 100644
--- a/src/network.h
+++ b/src/network.h
@@ -81,3 +81,6 @@ const struct iovec *network_get_extra_ies(struct network =
*network,
 						size_t *num_elems);
 =

 bool network_has_erp_identity(struct network *network);
+
+const struct l_queue_entry *network_bss_list_get_entries(
+						struct network *network);
-- =

2.31.1

--===============5693074282651734612==--

