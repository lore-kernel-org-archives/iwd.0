Content-Type: multipart/mixed; boundary="===============6013132105141167013=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] p2p: fix out of scope read
Date: Fri, 30 Jul 2021 08:07:27 -0700
Message-ID: <20210730150727.199809-2-prestwoj@gmail.com>
In-Reply-To: <20210730150727.199809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6013132105141167013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The authorized macs pointer was being set to either the wsc_beacon
or wsc_probe_response structures, which were initialized out of
scope to where 'amacs' was being used. This resulted in an out of
scope read, caught by address sanitizers.
---
 src/p2p.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index abdb69d2..4c059173 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1817,6 +1817,8 @@ static bool p2p_provision_scan_notify(int err, struct=
 l_queue *bss_list,
 		struct p2p_capability_attr *capability;
 		enum wsc_device_password_id device_password_id;
 		const uint8_t *amacs;
+		struct wsc_probe_response wsc_probe_info;
+		struct wsc_beacon wsc_beacon_info;
 =

 		/*
 		 * Check if we found our target GO, some of these checks may
@@ -1844,15 +1846,13 @@ static bool p2p_provision_scan_notify(int err, stru=
ct l_queue *bss_list,
 		}
 =

 		if (bss->source_frame =3D=3D SCAN_BSS_PROBE_RESP) {
-			struct wsc_probe_response wsc_info;
-
 			if (!bss->p2p_probe_resp_info) {
 				l_error("SSID matched but no valid P2P IE");
 				continue;
 			}
 =

 			if (wsc_parse_probe_response(bss->wsc, bss->wsc_size,
-							&wsc_info) < 0) {
+							&wsc_probe_info) < 0) {
 				l_error("SSID matched but can't parse WSC "
 					"Probe Response info");
 				continue;
@@ -1860,30 +1860,28 @@ static bool p2p_provision_scan_notify(int err, stru=
ct l_queue *bss_list,
 =

 			group_id =3D bss->p2p_probe_resp_info->
 				device_info.device_addr;
-			selected_reg =3D wsc_info.selected_registrar;
+			selected_reg =3D wsc_probe_info.selected_registrar;
 			capability =3D &bss->p2p_probe_resp_info->capability;
-			device_password_id =3D wsc_info.device_password_id;
-			amacs =3D wsc_info.authorized_macs;
+			device_password_id =3D wsc_probe_info.device_password_id;
+			amacs =3D wsc_probe_info.authorized_macs;
 		} else if (bss->source_frame =3D=3D SCAN_BSS_BEACON) {
-			struct wsc_beacon wsc_info;
-
 			if (!bss->p2p_beacon_info) {
 				l_error("SSID matched but no valid P2P IE");
 				continue;
 			}
 =

 			if (wsc_parse_beacon(bss->wsc, bss->wsc_size,
-						&wsc_info) < 0) {
+						&wsc_beacon_info) < 0) {
 				l_error("SSID matched but can't parse WSC "
 					"Beacon info");
 				continue;
 			}
 =

 			group_id =3D bss->p2p_beacon_info->device_addr;
-			selected_reg =3D wsc_info.selected_registrar;
+			selected_reg =3D wsc_beacon_info.selected_registrar;
 			capability =3D &bss->p2p_beacon_info->capability;
-			device_password_id =3D wsc_info.device_password_id;
-			amacs =3D wsc_info.authorized_macs;
+			device_password_id =3D wsc_beacon_info.device_password_id;
+			amacs =3D wsc_beacon_info.authorized_macs;
 		} else
 			continue;
 =

-- =

2.31.1

--===============6013132105141167013==--

