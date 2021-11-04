Content-Type: multipart/mixed; boundary="===============8009839055905266142=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] station: set sysfs options required by HS2.0 spec
Date: Thu, 04 Nov 2021 10:57:57 -0700
Message-ID: <20211104175758.532953-4-prestwoj@gmail.com>
In-Reply-To: 20211104175758.532953-1-prestwoj@gmail.com

--===============8009839055905266142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Hotspot 2.0 spec has some requirements that IWD was missing depending
on a few bits in extended capabilities and the HS2.0 indication element.
These requirements correspond to a few sysfs options that can be set in
the kernel which are now set on CONNECTED and unset on DISCONNECTED.
---
 src/station.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index fcec0dfe..19f2aaeb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1400,6 +1400,31 @@ static void station_set_evict_nocarrier(struct stati=
on *station, bool value)
 					"ndisc_evict_nocarrier", v);
 }
 =

+/*
+ * Handles dropping ARP (IPv4) and neighbor advertisements (IPv6) settings.
+ */
+static void station_set_drop_neighbor_discovery(struct station *station,
+						bool value)
+{
+	char *v =3D value ? "1" : "0";
+
+	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
+				"drop_gratuitous_arp", v);
+	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
+				"drop_unsolicited_na", v);
+}
+
+static void station_set_drop_unicast_l2_multicast(struct station *station,
+							bool value)
+{
+	char *v =3D value ? "1" : "0";
+
+	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
+				"drop_unicast_in_l2_multicast", v);
+	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
+				"drop_unicast_in_l2_multicast", v);
+}
+
 static void station_enter_state(struct station *station,
 						enum station_state state)
 {
@@ -1452,11 +1477,36 @@ static void station_enter_state(struct station *sta=
tion,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE,
 					station);
-		/* Fall through */
+		periodic_scan_stop(station);
+
+		station_set_evict_nocarrier(station, true);
+
+		/*
+		 * Hotspot Specification 2.0 - Section 6.5
+		 *
+		 * " - Shall drop all received {gratuitous ARP, unsolicited
+		 *     Neighbor Advertisement} messages when the Proxy ARP field
+		 *     is set to 1 in the Extended Capabilities element of the
+		 *     serving AP.
+		 *
+		 *   - When the serving AP transmits frames containing an HS2.0
+		 *     Indication element in which the value of the DGAF Disable
+		 *     bit subfield is set to 0, the mobile device should
+		 *     discard all received unicast IP packets that were
+		 *     decrypted using the GTK"
+		 */
+		if (station->connected_bss->proxy_arp)
+			station_set_drop_neighbor_discovery(station, true);
+		if (station->connected_bss->hs20_dgaf_disable)
+			station_set_drop_unicast_l2_multicast(station, true);
+
+		break;
 	case STATION_STATE_DISCONNECTED:
 		periodic_scan_stop(station);
 =

 		station_set_evict_nocarrier(station, true);
+		station_set_drop_neighbor_discovery(station, false);
+		station_set_drop_unicast_l2_multicast(station, false);
 		break;
 	case STATION_STATE_DISCONNECTING:
 		break;
-- =

2.31.1

--===============8009839055905266142==--

