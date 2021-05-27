Content-Type: multipart/mixed; boundary="===============0481277451941034452=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH 1/3] network: sync known network frequency on BSS update
Date: Thu, 27 May 2021 16:22:27 +0200
Message-ID: <20210527142229.1213074-1-alvin@pqrs.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0481277451941034452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

When a scan_bss is updated in the BSS list of a known network, it may be
on a new frequency. Sync the known frequencies list accordingly.
---
 src/network.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/network.c b/src/network.c
index 617559e6b803..68542d52e24c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -691,6 +691,12 @@ bool network_bss_update(struct network *network, struc=
t scan_bss *bss)
 =

 	l_queue_insert(network->bss_list, bss, scan_bss_rank_compare, NULL);
 =

+	/* Sync frequency for already known networks */
+	if (network->info) {
+		known_network_add_frequency(network->info, bss->frequency);
+		known_network_frequency_sync(network->info);
+	}
+
 	return true;
 }
 =

-- =

2.31.1

--===============0481277451941034452==--

