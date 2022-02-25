Content-Type: multipart/mixed; boundary="===============0312352733638730093=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/3] station: check supported frequencies in neighbor report
Date: Fri, 25 Feb 2022 14:03:37 -0800
Message-ID: <20220225220338.2942516-2-prestwoj@gmail.com>
In-Reply-To: 20220225220338.2942516-1-prestwoj@gmail.com

--===============0312352733638730093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the report has an unsupported frequency don't add it to the list.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index cd119ff1..dd924c00 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1715,6 +1715,8 @@ static void parse_neighbor_report(struct station *sta=
tion,
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq =3D 0;
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
+	const struct scan_freq_set *supported =3D
+				wiphy_get_supported_freqs(station->wiphy);
 =

 	freq_set_md =3D scan_freq_set_new();
 	freq_set_no_md =3D scan_freq_set_new();
@@ -1751,6 +1753,10 @@ static void parse_neighbor_report(struct station *st=
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

--===============0312352733638730093==--

