Content-Type: multipart/mixed; boundary="===============6374851518887848873=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 6/7] station: check supported frequencies in neighbor report
Date: Fri, 25 Feb 2022 15:32:50 -0800
Message-ID: <20220225233251.2958102-6-prestwoj@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============6374851518887848873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the report has an unsupported frequency don't add it to the list.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 637d03d1..00f3d178 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1712,6 +1712,8 @@ static void parse_neighbor_report(struct station *sta=
tion,
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq =3D 0;
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
+	const struct scan_freq_set *supported =3D
+				wiphy_get_supported_freqs(station->wiphy);
 =

 	freq_set_md =3D scan_freq_set_new();
 	freq_set_no_md =3D scan_freq_set_new();
@@ -1748,6 +1750,10 @@ static void parse_neighbor_report(struct station *st=
ation,
 		if (!(band & wiphy_get_supported_bands(station->wiphy)))
 			continue;
 =

+		/* Skip if frequency is not supported */
+		if (!scan_freq_set_contains(supported, freq))
+			continue;
+
 		if (!memcmp(info.addr,
 				station->connected_bss->addr, ETH_ALEN)) {
 			/*
-- =

2.34.1

--===============6374851518887848873==--

