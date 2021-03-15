Content-Type: multipart/mixed; boundary="===============5565736022679437081=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] station: use network_bss_update
Date: Mon, 15 Mar 2021 12:15:29 -0700
Message-ID: <20210315191529.186554-3-prestwoj@gmail.com>
In-Reply-To: <20210315191529.186554-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5565736022679437081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes a dangling pointer in network where station was
freeing the scan_bss but network still had a pointer to it
in its own bss_list.
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 3a082d02..2e577290 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2303,6 +2303,8 @@ static void station_event_roamed(struct station *stat=
ion, struct scan_bss *new)
 {
 	struct scan_bss *stale;
 =

+	network_bss_update(station->connected_network, new);
+
 	/* Remove new BSS if it exists in past scan results */
 	stale =3D l_queue_remove_if(station->bss_list, bss_match_bssid,
 					new->addr);
-- =

2.26.2

--===============5565736022679437081==--

