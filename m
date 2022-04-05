Content-Type: multipart/mixed; boundary="===============0574479026904624061=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: ignore AP directed roams if not connected
Date: Tue, 05 Apr 2022 10:23:41 -0500
Message-ID: <20220405152341.10955-1-denkenz@gmail.com>
In-Reply-To: 1077324508f3b40f15026b53b08e46f2@lausen.nl

--===============0574479026904624061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/station.c b/src/station.c
index b83e6372ba2f..33c8bdd0d378 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2642,6 +2642,11 @@ static void station_ap_directed_roam(struct station =
*station,
 		pos +=3D url_len;
 	}
 =

+	if (station->state !=3D STATION_STATE_CONNECTED) {
+		l_debug("roam: unexpected AP directed roam -- ignore");
+		return;
+	}
+
 	station->ap_directed_roaming =3D true;
 	station->preparing_roam =3D true;
 =

-- =

2.32.0

--===============0574479026904624061==--

