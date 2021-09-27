Content-Type: multipart/mixed; boundary="===============5459609312279460675=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 9/9] station: remove signal_low check for FT-over-DS
Date: Mon, 27 Sep 2021 10:04:04 -0700
Message-ID: <20210927170404.1292107-9-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============5459609312279460675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the AP advertises FT-over-DS support it likely wants us to use
it. Additionally signal_low is probably going to be true since IWD
has started a roam attempt.
---
 src/station.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 96794998..9da5c595 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2022,8 +2022,7 @@ static void station_transition_start(struct station *=
station,
 		vendor_ies =3D network_info_get_extra_ies(info, bss, &iov_elems);
 		handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 =

-		/* FT-over-DS can be better suited for these situations */
-		if ((hs->mde[4] & 1) && station->signal_low) {
+		if ((hs->mde[4] & 1)) {
 			ret =3D netdev_fast_transition_over_ds(station->netdev,
 					bss, station->connected_bss,
 					station_fast_transition_cb);
-- =

2.31.1

--===============5459609312279460675==--

