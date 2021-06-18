Content-Type: multipart/mixed; boundary="===============1059005651256668406=="
MIME-Version: 1.0
From: mjohnson459@gmail.com
Subject: [PATCH] Send hostname as part of DHCP request.
Date: Fri, 18 Jun 2021 14:00:06 +0000
Message-ID: <20210618140006.2820.65634@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1059005651256668406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is based on a previous patch by Roberto Santalla Fern=C3=A1ndez.

A new config is introduced into the network config file under IPv4
called SendHostname. If this is set to true then we add the hostname
into all DHCP requests. The default is false.
---
 src/iwd.network.rst |  6 ++++++
 src/netconfig.c     | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 083b2103..472caca8 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -322,6 +322,12 @@ network configuration with the static addresses.
        `optional`. DomainName setting can be used to override the DomainNa=
me
        value obtained from the DHCP server.
 =

+   * - SendHostname
+     - Values: true, **false**
+
+       Configures DHCP to include the hostname in the request. This setting
+       is disabled by default.
+
 The group ``[IPv6]`` contains settings for Internet Protocol version 6 (IP=
v6)
 network configuration.
 =

diff --git a/src/netconfig.c b/src/netconfig.c
index 316431ee..eb6d80ff 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1004,6 +1004,8 @@ bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify, void *user_data)
 {
 	char *mdns;
+	char hostname[HOST_NAME_MAX + 1];
+	bool send_hostname;
 =

 	netconfig->dns4_overrides =3D l_settings_get_string_list(active_settings,
 							"IPv4", "DNS", ' ');
@@ -1044,6 +1046,19 @@ bool netconfig_configure(struct netconfig *netconfig,
 	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
 							mac_address, ETH_ALEN);
 =

+	if (!l_settings_get_bool(active_settings,
+					"IPv4", "SendHostname", &send_hostname))
+		send_hostname =3D false;
+
+	if (send_hostname) {
+		if (gethostname(hostname, sizeof(hostname)) =3D=3D 0) {
+			l_dhcp_client_set_hostname(
+				netconfig->dhcp_client, hostname);
+		} else {
+			l_warn("netconfig: Unable to get hostname");
+		}
+	}
+
 	netconfig_ipv4_select_and_install(netconfig);
 =

 	netconfig_ipv6_select_and_install(netconfig);
-- =

2.25.1
--===============1059005651256668406==--

