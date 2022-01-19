Content-Type: multipart/mixed; boundary="===============6509113578465415224=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: fix OWE scan logic with autoconnect
Date: Wed, 19 Jan 2022 11:03:45 -0800
Message-ID: <20220119190345.2265563-1-prestwoj@gmail.com>

--===============6509113578465415224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

station_set_scan_results takes an autoconnect flag which was being
set true in both regular/quick autoconnect scans. Since OWE networks
are processed after setting the scan results IWD could end up
connecting to a network before all the OWE hidden networks are
populated.

To fix this regular/quick autoconnect results will set the flag to
false, then process OWE networks, then start autoconnect. If any
OWE network scans are pending station_autoconnect_start will fail
but will pick back up after the hidden OWE scan.
---
 src/station.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 38d0757c..e2f4a9f0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1231,10 +1231,13 @@ static bool new_scan_results(int err, struct l_queu=
e *bss_list,
 	if (err)
 		return false;
 =

-	station_set_scan_results(station, bss_list, freqs, true);
+	station_set_scan_results(station, bss_list, freqs, false);
 =

 	station_process_owe_transition_networks(station);
 =

+	station->autoconnect_can_start =3D true;
+	station_autoconnect_start(station);
+
 	return true;
 }
 =

@@ -1303,10 +1306,13 @@ static bool station_quick_scan_results(int err, str=
uct l_queue *bss_list,
 	if (err)
 		goto done;
 =

-	station_set_scan_results(station, bss_list, freqs, true);
+	station_set_scan_results(station, bss_list, freqs, false);
 =

 	station_process_owe_transition_networks(station);
 =

+	station->autoconnect_can_start =3D true;
+	station_autoconnect_start(station);
+
 done:
 	if (station->state =3D=3D STATION_STATE_AUTOCONNECT_QUICK)
 		/*
-- =

2.31.1

--===============6509113578465415224==--

