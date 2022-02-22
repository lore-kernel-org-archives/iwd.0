Content-Type: multipart/mixed; boundary="===============4542477973623510367=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/7] station: replace station_parse_bss_security
Date: Tue, 22 Feb 2022 14:57:13 -0800
Message-ID: <20220222225718.2485794-2-prestwoj@gmail.com>
In-Reply-To: 20220222225718.2485794-1-prestwoj@gmail.com

--===============4542477973623510367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replaces this with scan_bss_get_security
---
 src/station.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/src/station.c b/src/station.c
index cd119ff1..9e58e3d6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -346,25 +346,6 @@ static int bss_signal_strength_compare(const void *a, =
const void *b, void *user)
 	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 =

-static int station_parse_bss_security(struct station *station,
-				struct scan_bss *bss,
-				enum security *security_out)
-{
-	struct ie_rsn_info info;
-	int r;
-
-	r =3D scan_bss_get_rsn_info(bss, &info);
-	if (r < 0) {
-		if (r !=3D -ENOENT)
-			return r;
-
-		*security_out =3D security_determine(bss->capability, NULL);
-	} else
-		*security_out =3D security_determine(bss->capability, &info);
-
-	return 0;
-}
-
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -400,7 +381,7 @@ static struct network *station_add_seen_bss(struct stat=
ion *station,
 		return NULL;
 	}
 =

-	if (station_parse_bss_security(station, bss, &security) < 0)
+	if (scan_bss_get_security(bss, &security) < 0)
 		return NULL;
 =

 	/* Hidden OWE transition network */
@@ -2315,7 +2296,7 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
 			goto next;
 =

-		if (station_parse_bss_security(station, bss, &security) < 0)
+		if (scan_bss_get_security(bss, &security) < 0)
 			goto next;
 =

 		if (security !=3D orig_security)
@@ -3457,7 +3438,7 @@ static struct l_dbus_message *station_dbus_get_hidden=
_access_points(
 		int16_t signal_strength =3D bss->signal_strength;
 		enum security security;
 =

-		if (station_parse_bss_security(station, bss, &security) < 0)
+		if (scan_bss_get_security(bss, &security) < 0)
 			continue;
 =

 		l_dbus_message_builder_enter_struct(builder, "sns");
@@ -4224,7 +4205,7 @@ static struct network *station_find_network_from_bss(=
struct station *station,
 	memcpy(ssid, bss->ssid, bss->ssid_len);
 	ssid[bss->ssid_len] =3D '\0';
 =

-	if (station_parse_bss_security(station, bss, &security) < 0)
+	if (scan_bss_get_security(bss, &security) < 0)
 		return NULL;
 =

 	return station_network_find(station, ssid, security);
-- =

2.34.1

--===============4542477973623510367==--

