Content-Type: multipart/mixed; boundary="===============3787443156251508898=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: print reason why autoconnect failed
Date: Tue, 04 May 2021 08:09:18 -0700
Message-ID: <20210504150918.385215-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3787443156251508898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 442f8ee2..d2234e15 100644
--- a/src/station.c
+++ b/src/station.c
@@ -180,10 +180,11 @@ static void station_autoconnect_next(struct station *=
station)
 	int r;
 =

 	while ((entry =3D l_queue_pop_head(station->autoconnect_list))) {
+		const char *ssid =3D network_get_ssid(entry->network);
+
 		l_debug("Considering autoconnecting to BSS '%s' with SSID: %s,"
 			" freq: %u, rank: %u, strength: %i",
-			util_address_to_string(entry->bss->addr),
-			network_get_ssid(entry->network),
+			util_address_to_string(entry->bss->addr), ssid,
 			entry->bss->frequency, entry->rank,
 			entry->bss->signal_strength);
 =

@@ -206,7 +207,8 @@ static void station_autoconnect_next(struct station *st=
ation)
 			}
 =

 			return;
-		}
+		} else
+			l_debug("Failed to autoconnect to %s (%d)", ssid, r);
 	}
 }
 =

-- =

2.26.2

--===============3787443156251508898==--

