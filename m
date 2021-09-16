Content-Type: multipart/mixed; boundary="===============6693327456898183729=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/7] scan: allow non-utf8 SSIDs to be scanned for
Date: Thu, 16 Sep 2021 09:30:41 -0700
Message-ID: <20210916163046.30817-2-prestwoj@gmail.com>
In-Reply-To: 20210916163046.30817-1-prestwoj@gmail.com

--===============6693327456898183729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IWD has restricted SSIDs to only utf8 so they can be displayed but
with the addition of OWE transition networks this is an unneeded
restriction (for these networks). The SSID of an OWE transition
network is never displayed to the user so limiting to utf8 isn't
required.

Allow non-utf8 SSIDs to be scanned for by including the length in
the scan parameters and not relying on strlen().
---
 src/p2p.c     |  6 ++++--
 src/scan.c    |  2 +-
 src/scan.h    |  3 ++-
 src/station.c | 10 +++++++---
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 3328271b..3bfb771a 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1980,7 +1980,8 @@ static void p2p_provision_scan_start(struct p2p_devic=
e *dev)
 =

 	params.flush =3D true;
 	params.no_cck_rates =3D true;
-	params.ssid =3D dev->go_group_id.ssid;
+	params.ssid =3D (const uint8_t *)dev->go_group_id.ssid;
+	params.ssid_len =3D strlen(dev->go_group_id.ssid);
 	params.extra_ie =3D p2p_build_scan_ies(dev, buf, sizeof(buf),
 						&params.extra_ie_size);
 	L_WARN_ON(!params.extra_ie);
@@ -3783,7 +3784,8 @@ static bool p2p_device_scan_start(struct p2p_device *=
dev)
 	L_WARN_ON(!params.extra_ie);
 	params.flush =3D true;
 	/* P2P Wildcard SSID because we don't need legacy networks to reply */
-	params.ssid =3D "DIRECT-";
+	params.ssid =3D (const uint8_t *)"DIRECT-";
+	params.ssid_len =3D strlen("DIRECT-");
 	/*
 	 * Must send probe requests at 6Mb/s, OFDM only.  The no-CCK rates
 	 * flag forces the drivers to do exactly this for 2.4GHz frames.
diff --git a/src/scan.c b/src/scan.c
index cdc14dbd..1224e18b 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -542,7 +542,7 @@ static void scan_cmds_add(struct l_queue *cmds, struct =
scan_context *sc,
 	if (params->ssid) {
 		/* direct probe request scan */
 		l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID,
-					strlen(params->ssid), params->ssid);
+					params->ssid_len, params->ssid);
 		l_genl_msg_leave_nested(cmd);
 =

 		l_queue_push_tail(cmds, cmd);
diff --git a/src/scan.h b/src/scan.h
index be8912e6..aa3974df 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -97,7 +97,8 @@ struct scan_parameters {
 	bool randomize_mac_addr_hint : 1;
 	bool no_cck_rates : 1;
 	bool duration_mandatory : 1;
-	const char *ssid;	/* Used for direct probe request */
+	const uint8_t *ssid;	/* Used for direct probe request */
+	size_t ssid_len;
 	const uint8_t *source_mac;
 };
 =

diff --git a/src/station.c b/src/station.c
index 6de5fd4a..2bd9ecfe 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2009,9 +2009,12 @@ static int station_roam_scan(struct station *station,
 =

 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 =

-	if (station->connected_network)
+	if (station->connected_network) {
+		const char *ssid =3D network_get_ssid(station->connected_network);
 		/* Use direct probe request */
-		params.ssid =3D network_get_ssid(station->connected_network);
+		params.ssid =3D (const uint8_t *)ssid;
+		params.ssid_len =3D strlen(ssid);
+	}
 =

 	if (!freq_set)
 		station->roam_scan_full =3D true;
@@ -2916,7 +2919,8 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 		return dbus_error_not_hidden(message);
 	}
 =

-	params.ssid =3D ssid;
+	params.ssid =3D (const uint8_t *)ssid;
+	params.ssid_len =3D strlen(ssid);
 =

 	/* HW cannot randomize our MAC if connected */
 	if (!station->connected_bss)
-- =

2.31.1

--===============6693327456898183729==--

