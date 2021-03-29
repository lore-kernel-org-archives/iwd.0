Content-Type: multipart/mixed; boundary="===============1793482494174131303=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: clear out roam frequencies after roam
Date: Mon, 29 Mar 2021 12:07:40 -0700
Message-ID: <20210329190742.713249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1793482494174131303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/station.c b/src/station.c
index ba4483e6..0d4cd47d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1442,6 +1442,11 @@ static void station_roamed(struct station *station)
 	if (station->netconfig)
 		netconfig_reconfigure(station->netconfig);
 =

+	if (station->roam_freqs) {
+		scan_freq_set_free(station->roam_freqs);
+		station->roam_freqs =3D NULL;
+	}
+
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

-- =

2.26.2

--===============1793482494174131303==--

