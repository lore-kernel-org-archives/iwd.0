Content-Type: multipart/mixed; boundary="===============1400555853352062736=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] netconfig: netconfig_reconfigure check bool for setting
 ARP
Date: Wed, 03 Nov 2021 15:15:02 -0700
Message-ID: <20211103221502.470442-4-prestwoj@gmail.com>
In-Reply-To: 20211103221502.470442-1-prestwoj@gmail.com

--===============1400555853352062736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only set the gateway to the ARP cache if the caller requests.
---
 src/netconfig.c | 5 +++--
 src/netconfig.h | 2 +-
 src/station.c   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6e885546..e7fd4855 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1468,7 +1468,7 @@ bool netconfig_configure(struct netconfig *netconfig,
 	return true;
 }
 =

-bool netconfig_reconfigure(struct netconfig *netconfig)
+bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 {
 	/*
 	 * Starting with kernel 4.20, ARP cache is flushed when the netdev
@@ -1477,7 +1477,8 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g)
 	 * lost or delayed.  Try to force the gateway into the ARP cache
 	 * to alleviate this
 	 */
-	netconfig_gateway_to_arp(netconfig);
+	if (set_arp_gw)
+		netconfig_gateway_to_arp(netconfig);
 =

 	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
 		/* TODO l_dhcp_client sending a DHCP inform request */
diff --git a/src/netconfig.h b/src/netconfig.h
index c2e6a6f9..c9ac6f8f 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -36,7 +36,7 @@ bool netconfig_load_settings(struct netconfig *netconfig,
 bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify,
 				void *user_data);
-bool netconfig_reconfigure(struct netconfig *netconfig);
+bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw);
 bool netconfig_reset(struct netconfig *netconfig);
 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig);
 bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
diff --git a/src/station.c b/src/station.c
index 4bb8e60f..fcec0dfe 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1851,7 +1851,8 @@ static void station_roamed(struct station *station)
 		station_roam_timeout_rearm(station, roam_retry_interval);
 =

 	if (station->netconfig)
-		netconfig_reconfigure(station->netconfig);
+		netconfig_reconfigure(station->netconfig,
+					!supports_arp_evict_nocarrier);
 =

 	if (station->roam_freqs) {
 		scan_freq_set_free(station->roam_freqs);
-- =

2.31.1

--===============1400555853352062736==--

