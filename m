Content-Type: multipart/mixed; boundary="===============1793253447551506094=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netconfig: Enable DHCP info+ logging by default
Date: Wed, 18 May 2022 13:30:28 +0100
Message-ID: <20220518123027.79824-1-mjohnson459@gmail.com>

--===============1793253447551506094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rest of iwd logs info, warn, and errors by default so this patch
just copies that behavior for the DHCP client. Debug logging is enabled
via the IWD_DHCP_DEBUG env as before.
---
 src/netconfig.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6694a0e9..91f2b9ff 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1621,6 +1621,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
 	struct l_icmp6_client *icmp6;
+	int dhcp_debug =3D L_LOG_INFO;
 =

 	if (!netconfig_list)
 		return NULL;
@@ -1641,8 +1642,10 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 					netconfig, NULL);
 =

 	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
-							"[DHCPv4] ", NULL);
+		dhcp_debug =3D L_LOG_DEBUG;
+
+	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
+						"[DHCPv4] ", NULL, dhcp_debug);
 =

 	netconfig->dhcp6_client =3D l_dhcp6_client_new(ifindex);
 	l_dhcp6_client_set_event_handler(netconfig->dhcp6_client,
-- =

2.25.1

--===============1793253447551506094==--

