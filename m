Content-Type: multipart/mixed; boundary="===============8726357162559836573=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] station: specially handle FT-over-DS failure
Date: Thu, 15 Apr 2021 15:45:07 -0700
Message-ID: <20210415224508.1823614-7-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8726357162559836573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on the netdev result, FT-over-DS failure may not need to
be fatal. If the result is an Authentication failure this just means
that FT-over-DS did not successfully send or receive the initial
action frames. This means we cannot roam, but it does not mean the
connection needs to be fully terminated. A new flag was added to
signal FT-over-DS, and the failure code treats an authentication
failure specially if this flag is set.
---
 src/station.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 064872c6..80609607 100644
--- a/src/station.c
+++ b/src/station.c
@@ -112,6 +112,7 @@ struct station {
 	bool ap_directed_roaming : 1;
 	bool scanning : 1;
 	bool autoconnect : 1;
+	bool ft_over_ds : 1;
 };
 =

 struct anqp_entry {
@@ -1625,10 +1626,17 @@ static void station_roam_failed(struct station *sta=
tion)
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

 	/*
-	 * If we attempted a reassociation or a fast transition, and ended up
-	 * here then we are now disconnected.
+	 * If we attempted a reassociation or a fast transition (except DS),
+	 * and ended up here then we are now disconnected. In the case of
+	 * FT over DS we can remain connected to the AP even if the transition
+	 * fails.
 	 */
 	if (station->state =3D=3D STATION_STATE_ROAMING) {
+		if (station->ft_over_ds) {
+			station_enter_state(station, STATION_STATE_CONNECTED);
+			goto delayed_retry;
+		}
+
 		station_disassociated(station);
 		return;
 	}
@@ -1657,6 +1665,7 @@ delayed_retry:
 	station->preparing_roam =3D false;
 	station->roam_scan_full =3D false;
 	station->ap_directed_roaming =3D false;
+	station->ft_over_ds =3D false;
 =

 	if (station->signal_low)
 		station_roam_timeout_rearm(station, roam_retry_interval);
@@ -1708,6 +1717,16 @@ static void station_fast_transition_cb(struct netdev=
 *netdev,
 	if (station->state !=3D STATION_STATE_ROAMING)
 		return;
 =

+	/*
+	 * Auth failures are handled special here for FT-over-DS since this only
+	 * means we cannot roam to that AP. Any other failure cannot be
+	 * salvaged. In this case unset the flag so station_roam_failed can
+	 * properly clean up.
+	 */
+	if (result !=3D NETDEV_RESULT_AUTHENTICATION_FAILED &&
+				station->ft_over_ds)
+		station->ft_over_ds =3D false;
+
 	if (result =3D=3D NETDEV_RESULT_OK)
 		station_roamed(station);
 	else
@@ -1839,6 +1858,8 @@ static void station_transition_start(struct station *=
station,
 		/* FT-over-DS can be better suited for these situations */
 		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
 				station->signal_low)) {
+			station->ft_over_ds =3D true;
+
 			if (netdev_fast_transition_over_ds(station->netdev, bss,
 					station_fast_transition_cb) < 0) {
 				station_roam_failed(station);
-- =

2.26.2

--===============8726357162559836573==--

