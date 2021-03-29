Content-Type: multipart/mixed; boundary="===============0743311985565641635=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: unify firmware/normal roaming
Date: Mon, 29 Mar 2021 12:07:41 -0700
Message-ID: <20210329190742.713249-2-prestwoj@gmail.com>
In-Reply-To: <20210329190742.713249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0743311985565641635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This doesn't change much functionally but does unify the
two roaming paths by ending with 'station_roamed()'.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 0d4cd47d..acf77ec8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2332,7 +2332,7 @@ static void station_event_roamed(struct station *stat=
ion, struct scan_bss *new)
 =

 	l_queue_insert(station->bss_list, new, scan_bss_rank_compare, NULL);
 =

-	station_enter_state(station, STATION_STATE_CONNECTED);
+	station_roamed(station);
 }
 =

 static void station_rssi_level_changed(struct station *station,
-- =

2.26.2

--===============0743311985565641635==--

