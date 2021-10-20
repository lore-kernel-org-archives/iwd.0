Content-Type: multipart/mixed; boundary="===============8329440094677507917=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] network: fix autoconnect for Open networks
Date: Wed, 20 Oct 2021 13:53:30 -0700
Message-ID: <20211020205331.734405-3-prestwoj@gmail.com>
In-Reply-To: 20211020205331.734405-1-prestwoj@gmail.com

--===============8329440094677507917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This code path was never tested and used to ensure a OWE transition
candidate gets selected over an open one (e.g. if all the BSS's are
blacklisted). But this logic was incorrect and the path was being
taken for BSS's that did not contain the owe_trans element, basically
all BSS's. For RSN's this was somewhat fine since the final check
would set a candidate, but for open BSS's the loop would start over
and potentially complete the loop without ever returning a candidate.
If fallback was false, NULL would be returned.

To fix this only take the OWE transition path if its an OWE transition
BSS, i.e. inverse the logic.
---
 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 110c8577..9a2d12cf 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1136,7 +1136,7 @@ struct scan_bss *network_bss_select(struct network *n=
etwork,
 			candidate =3D bss;
 =

 		/* OWE Transition BSS */
-		if (!bss->owe_trans) {
+		if (bss->owe_trans) {
 			/* Don't want to connect to the Open BSS if possible */
 			if (!bss->rsne)
 				continue;
-- =

2.31.1

--===============8329440094677507917==--

