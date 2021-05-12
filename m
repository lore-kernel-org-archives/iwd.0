Content-Type: multipart/mixed; boundary="===============4516621617356085286=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] station: remove ap_directed_roam check for over-DS
Date: Wed, 12 May 2021 12:21:39 -0700
Message-ID: <20210512192144.348398-2-prestwoj@gmail.com>
In-Reply-To: <20210512192144.348398-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4516621617356085286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This flag was being checked but it is explicitly being set to
false prior.
---
 src/station.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index bdb8859a..b9368ef2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1867,8 +1867,7 @@ static void station_transition_start(struct station *=
station,
 		}
 =

 		/* FT-over-DS can be better suited for these situations */
-		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
-				station->signal_low)) {
+		if ((hs->mde[4] & 1) && station->signal_low) {
 			if (netdev_fast_transition_over_ds_action(
 					station->netdev, bss,
 					station_fast_transition_ds_cb,
-- =

2.31.1

--===============4516621617356085286==--

