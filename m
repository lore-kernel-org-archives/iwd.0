Content-Type: multipart/mixed; boundary="===============6162846348198765113=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/18] netconfig: Implement netconfig_get_dhcp_server_ipv4
Date: Sat, 11 Jul 2020 03:00:50 +0200
Message-ID: <20200711010053.224223-15-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6162846348198765113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This uses l_dhcp_lease_get_server_id to get the IP of the server that
offered us our current lease.  l_dhcp_lease_get_server_id returns the
vaue of the L_DHCP_OPTION_SERVER_IDENTIFIER option, which is the address
that any unicast DHCP frames are supposed to be sent to so it seems to
be the best way to get the P2P group owner's IP address as a P2P-client.
---
 src/netconfig.c | 14 ++++++++++++++
 src/netconfig.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6a618e8f..701ae38b 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1149,6 +1149,20 @@ bool netconfig_reset(struct netconfig *netconfig)
 	return true;
 }
 =

+char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig)
+{
+	const struct l_dhcp_lease *lease;
+
+	if (!netconfig->dhcp_client)
+		return NULL;
+
+	lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
+	if (!lease)
+		return NULL;
+
+	return l_dhcp_lease_get_server_id(lease);
+}
+
 struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netconfig *netconfig;
diff --git a/src/netconfig.h b/src/netconfig.h
index 5a527950..2c68cb1c 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -36,6 +36,7 @@ bool netconfig_configure(struct netconfig *netconfig,
 				void *user_data);
 bool netconfig_reconfigure(struct netconfig *netconfig);
 bool netconfig_reset(struct netconfig *netconfig);
+char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig);
 =

 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
-- =

2.25.1

--===============6162846348198765113==--

