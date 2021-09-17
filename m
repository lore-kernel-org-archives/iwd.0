Content-Type: multipart/mixed; boundary="===============7676199716582333487=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 3/4] network: prefer OWE transition BSS over open
Date: Fri, 17 Sep 2021 12:39:03 -0700
Message-ID: <20210917193904.16413-3-prestwoj@gmail.com>
In-Reply-To: 20210917193904.16413-1-prestwoj@gmail.com

--===============7676199716582333487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There isn't much control station has with how BSS's are inserted to
a network object. The rank algorithm makes that decision. Because of
this we could end up in a situation where the Open BSS is preferred
over the OWE transition BSS.

In attempt to better handle this any Open BSS in this type of network
will not be chosen unless its the only candidate (e.g. no other BSSs,
inability to connect with OWE, or an improperly configured network).
---
 src/network.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/network.c b/src/network.c
index 4768b872..bc35ddea 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1105,6 +1105,11 @@ const struct l_queue_entry *network_bss_list_get_ent=
ries(
 	return l_queue_get_entries(network->bss_list);
 }
 =

+static bool bss_is_owe(struct scan_bss *bss)
+{
+	return !l_memeqzero(bss->owe_trans_bssid, 6) && bss->rsne;
+}
+
 struct scan_bss *network_bss_select(struct network *network,
 						bool fallback_to_blacklist)
 {
@@ -1130,6 +1135,17 @@ struct scan_bss *network_bss_select(struct network *=
network,
 		if (!candidate)
 			candidate =3D bss;
 =

+		/* OWE Transition BSS */
+		if (!l_memeqzero(bss->owe_trans_bssid, 6)) {
+			/* Don't want to connect to the Open BSS if possible */
+			if (!bss->rsne)
+				continue;
+
+			/* Candidate is not OWE, set this as new candidate */
+			if (!bss_is_owe(candidate))
+				candidate =3D bss;
+		}
+
 		/* check if temporarily blacklisted */
 		if (l_queue_find(network->blacklist, match_bss, bss))
 			continue;
-- =

2.31.1

--===============7676199716582333487==--

