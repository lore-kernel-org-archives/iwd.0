Content-Type: multipart/mixed; boundary="===============4637171823214485903=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] station: Prevent a NULL pointer access
Date: Sun, 07 Nov 2021 02:03:38 +0100
Message-ID: <CFJ55REIK1NJ.3RPA8HBGL04MQ@hostname>
In-Reply-To: 3c0e6c34-3054-276c-9f0f-44c57b173f84@gmail.com

--===============4637171823214485903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>From 7b1ced9001b70b9644afca502ff744dd221cceab Mon Sep 17 00:00:00 2001
From: Torsten Schmitz <noreply.torsten(a)gmail.com>
Date: Sat, 6 Nov 2021 01:42:40 +0100
Subject: [PATCH] station: Prevent a NULL pointer access

There is an unchecked NULL pointer access in network_has_open_pair.
open_info can be NULL, when out of multiple APs in range that advertise
the same SSID some advertise OWE transition elments and some don't.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 19f2aaeb..245fd780 100644
--- a/src/station.c
+++ b/src/station.c
@@ -698,6 +698,10 @@ static bool network_has_open_pair(struct network *netw=
ork, struct scan_bss *owe)
 		struct scan_bss *open =3D entry->data;
 		struct ie_owe_transition_info *open_info =3D open->owe_trans;
 =

+		/* AP does not advertise owe transition */
+		if (!open_info)
+			continue;
+
 		/*
 		 * Check if this is an Open/Hidden pair:
 		 *
-- =

2.33.1

--===============4637171823214485903==--

