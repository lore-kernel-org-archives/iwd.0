Content-Type: multipart/mixed; boundary="===============3561859016879741398=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 6/6] dpp: allow config response handling without station
Date: Fri, 07 Jan 2022 16:13:33 -0800
Message-ID: <20220108001333.723634-6-prestwoj@gmail.com>
In-Reply-To: 20220108001333.723634-1-prestwoj@gmail.com

--===============3561859016879741398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the device is not in station mode DPP can still write out
the credentials and finish without attempting to connect or
scan.
---
 src/dpp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 35807a8c..84e89f6c 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -496,7 +496,7 @@ static void dpp_handle_config_response_frame(const stru=
ct mmpdu_header *frame,
 	_auto_(l_free) uint8_t *unwrapped =3D NULL;
 	struct dpp_configuration *config;
 	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
-	struct network *network;
+	struct network *network =3D NULL;
 	struct scan_bss *bss =3D NULL;
 	char ssid[33];
 =

@@ -622,18 +622,24 @@ static void dpp_handle_config_response_frame(const st=
ruct mmpdu_header *frame,
 		return;
 	}
 =

-	memcpy(ssid, config->ssid, config->ssid_len);
-	ssid[config->ssid_len] =3D '\0';
+	/*
+	 * We should have a station device, but if not DPP can write the
+	 * credentials out and be done
+	 */
+	if (station) {
+		memcpy(ssid, config->ssid, config->ssid_len);
+		ssid[config->ssid_len] =3D '\0';
 =

-	network =3D station_network_find(station, ssid, SECURITY_PSK);
-	if (network)
-		bss =3D network_bss_select(network, true);
+		network =3D station_network_find(station, ssid, SECURITY_PSK);
+		if (network)
+			bss =3D network_bss_select(network, true);
+	}
 =

 	dpp_write_config(config, network);
 =

 	if (network && bss)
 		__station_connect_network(station, network, bss);
-	else {
+	else if (station) {
 		dpp->connect_scan_id =3D scan_active(dpp->wdev_id, NULL, 0,
 						dpp_scan_triggered,
 						dpp_scan_results, dpp,
-- =

2.31.1

--===============3561859016879741398==--

