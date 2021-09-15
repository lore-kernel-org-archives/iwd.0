Content-Type: multipart/mixed; boundary="===============1326202075333966265=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 11/13] network: prefer OWE transition BSS over open
Date: Wed, 15 Sep 2021 10:36:22 -0700
Message-ID: <20210915173624.11917-11-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============1326202075333966265==
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
 src/network.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/network.c b/src/network.c
index 48314a05..cda507b5 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1130,6 +1130,14 @@ struct scan_bss *network_bss_select(struct network *=
network,
 		if (!candidate)
 			candidate =3D bss;
 =

+		/*
+		 * Do what we can to NOT connect to the Open BSS of an OWE
+		 * transition network. This can still happen if this is the only
+		 * BSS, or if the BSS's were improperly configured.
+		 */
+		if (!l_memeqzero(bss->owe_trans_bssid, 6) && !bss->rsne)
+			continue;
+
 		/* check if temporarily blacklisted */
 		if (l_queue_find(network->blacklist, match_bss, bss))
 			continue;
-- =

2.31.1

--===============1326202075333966265==--

