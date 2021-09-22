Content-Type: multipart/mixed; boundary="===============7925585604970783779=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/4] scan: use oper_class/channel for OWE hidden scans
Date: Wed, 22 Sep 2021 12:34:17 -0700
Message-ID: <20210922193418.13072-3-prestwoj@gmail.com>
In-Reply-To: 20210922193418.13072-1-prestwoj@gmail.com

--===============7925585604970783779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If these are included in the OWE transition IE use them to scan
for the OWE hidden network.
---
 src/scan.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 3f36ea3e..96ce51e2 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -50,6 +50,7 @@
 #include "src/p2putil.h"
 #include "src/mpdu.h"
 #include "src/scan.h"
+#include "src/band.h"
 =

 /* User configurable options */
 static double RANK_5G_FACTOR;
@@ -670,6 +671,22 @@ uint32_t scan_active_full(uint64_t wdev_id,
 					trigger, notify, userdata, destroy);
 }
 =

+static void scan_add_owe_freq(struct scan_freq_set *freqs,
+				const struct scan_bss *bss)
+{
+	int freq;
+
+	if (bss->owe_trans->oper_class)
+		freq =3D oci_to_frequency(bss->owe_trans->oper_class,
+					bss->owe_trans->channel);
+	else
+		freq =3D bss->frequency;
+
+	L_WARN_ON(freq < 0);
+
+	scan_freq_set_add(freqs, freq);
+}
+
 static void add_owe_scan_cmd(struct scan_context *sc, struct scan_request =
*sr,
 				bool ignore_flush,
 				struct scan_freq_set *freqs,
@@ -681,7 +698,9 @@ static void add_owe_scan_cmd(struct scan_context *sc, s=
truct scan_request *sr,
 =

 	if (!freqs) {
 		tmp =3D scan_freq_set_new();
-		scan_freq_set_add(tmp, bss->frequency);
+
+		scan_add_owe_freq(tmp, bss);
+
 		params.freqs =3D tmp;
 	} else
 		params.freqs =3D freqs;
@@ -732,7 +751,7 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_que=
ue *list,
 	for (entry =3D l_queue_get_entries(list); entry; entry =3D entry->next) {
 		bss =3D entry->data;
 =

-		scan_freq_set_add(freqs, bss->frequency);
+		scan_add_owe_freq(freqs, bss);
 =

 		/* First */
 		if (!ssid) {
-- =

2.31.1

--===============7925585604970783779==--

