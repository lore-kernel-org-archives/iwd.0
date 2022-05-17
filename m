Content-Type: multipart/mixed; boundary="===============0157788195570139810=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Tue, 17 May 2022 18:16:42 +0100
Message-ID: <20220517171642.147923-1-mjohnson459@gmail.com>

--===============0157788195570139810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allows granularly specifying the DHCP logging level. This allows the
user to tailor the output to what they need. By default always display
errors and warnings.

1 =3D INFO
2 =3D DEBUG
---
 src/netconfig.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6694a0e9..da9969f2 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1621,6 +1621,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
 	struct l_icmp6_client *icmp6;
+	const char *debug_level =3D NULL;
+	int dhcp_priority =3D L_LOG_WARNING;
 =

 	if (!netconfig_list)
 		return NULL;
@@ -1640,9 +1642,18 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 					netconfig_ipv4_dhcp_event_handler,
 					netconfig, NULL);
 =

-	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
-							"[DHCPv4] ", NULL);
+	debug_level =3D getenv("IWD_DHCP_DEBUG");
+	if (debug_level !=3D NULL)
+	{
+		// Convert from user 1 or 2 to L_LOG_*
+		if (*debug_level =3D=3D '1')
+			dhcp_priority =3D L_LOG_INFO;
+		else if (*debug_level =3D=3D '2')
+			dhcp_priority =3D L_LOG_DEBUG;
+	}
+
+	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
+					"[DHCPv4] ", NULL, dhcp_priority);
 =

 	netconfig->dhcp6_client =3D l_dhcp6_client_new(ifindex);
 	l_dhcp6_client_set_event_handler(netconfig->dhcp6_client,
-- =

2.25.1

--===============0157788195570139810==--

