Content-Type: multipart/mixed; boundary="===============7059793002083952619=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/7] network: use WPA version and privacy for ranking
Date: Fri, 07 May 2021 13:26:16 -0700
Message-ID: <20210507202620.93540-3-prestwoj@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7059793002083952619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These ranking factors were moved out of scan.c and into
network.c as they are more relevant for network ranking
than BSS ranking.
---
 src/network.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/network.c b/src/network.c
index 5bd57777..feedf99f 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1446,6 +1446,10 @@ int network_rank_compare(const void *a, const void *=
b, void *user)
 =

 void network_rank_update(struct network *network, bool connected)
 {
+	static const double RANK_RSNE_FACTOR =3D 1.2;
+	static const double RANK_WPA_FACTOR =3D 1.0;
+	static const double RANK_OPEN_FACTOR =3D 0.5;
+	static const double RANK_NO_PRIVACY_FACTOR =3D 0.5;
 	/*
 	 * Theoretically there may be difference between the BSS selection
 	 * here and in network_bss_select but those should be rare cases.
@@ -1485,6 +1489,21 @@ void network_rank_update(struct network *network, bo=
ol connected)
 		network->rank =3D rankmod_table[n] * best_bss->rank + USHRT_MAX;
 	} else
 		network->rank =3D best_bss->rank;
+
+	/*
+	 * Prefer RSNE first, WPA second.  Open networks are much less
+	 * desirable.
+	 */
+	if (best_bss->rsne)
+		network->rank *=3D RANK_RSNE_FACTOR;
+	else if (best_bss->wpa)
+		network->rank *=3D RANK_WPA_FACTOR;
+	else
+		network->rank *=3D RANK_OPEN_FACTOR;
+
+	/* We prefer networks with CAP PRIVACY */
+	if (!(best_bss->capability & IE_BSS_CAP_PRIVACY))
+		network->rank *=3D RANK_NO_PRIVACY_FACTOR;
 }
 =

 static void network_unset_hotspot(struct network *network, void *user_data)
-- =

2.31.1

--===============7059793002083952619==--

