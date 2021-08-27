Content-Type: multipart/mixed; boundary="===============2974729997166787156=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] netconfig: FILS IP assigment API
Date: Fri, 27 Aug 2021 05:02:04 +0200
Message-ID: <20210827030207.353705-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210827030207.353705-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2974729997166787156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two methods that will allow station to implement FILS IP Address
Assigment, one method to decide whether to send the request during
association, and fill in the values to be used in the request IE, and
another to handle the response IE values received from the server and
apply them.  The netconfig->rtm_protocol value used when the address is
assigned this way remains RTPROT_DHCP because from the user's point of
view this is automatic IP assigment by the server, a replacement for
DHCP.
---
 src/netconfig.c | 167 ++++++++++++++++++++++++++++++++++++++++++++----
 src/netconfig.h |   6 ++
 2 files changed, 159 insertions(+), 14 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 10c9b90c..6e1e1aa7 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -48,6 +48,7 @@
 #include "src/network.h"
 #include "src/resolve.h"
 #include "src/util.h"
+#include "src/ie.h"
 #include "src/netconfig.h"
 =

 struct netconfig {
@@ -59,6 +60,7 @@ struct netconfig {
 	struct l_rtnl_address *v4_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
+	struct ie_fils_ip_addr_response_info *fils_override;
 =

 	const struct l_settings *active_settings;
 =

@@ -164,6 +166,36 @@ static struct netconfig *netconfig_find(uint32_t ifind=
ex)
 			dest[index++] =3D *p;			\
 	} while (0)						\
 =

+static inline char *netconfig_ipv4_to_string(uint32_t addr)
+{
+	struct in_addr in_addr =3D { .s_addr =3D addr };
+	char *addr_str =3D l_malloc(INET_ADDRSTRLEN);
+
+	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET, &in_addr, addr_str,
+						INET_ADDRSTRLEN)))) {
+		l_free(addr_str);
+		return NULL;
+	}
+
+	return addr_str;
+}
+
+static inline char *netconfig_ipv6_to_string(const uint8_t *addr)
+{
+	struct in6_addr in6_addr;
+	char *addr_str =3D l_malloc(INET6_ADDRSTRLEN);
+
+	memcpy(in6_addr.__in6_u.__u6_addr8, addr, 16);
+
+	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET6, &in6_addr, addr_str,
+						INET6_ADDRSTRLEN)))) {
+		l_free(addr_str);
+		return NULL;
+	}
+
+	return addr_str;
+}
+
 static int netconfig_set_dns(struct netconfig *netconfig)
 {
 	char **dns6_list =3D NULL;
@@ -173,19 +205,30 @@ static int netconfig_set_dns(struct netconfig *netcon=
fig)
 =

 	if (!netconfig->dns4_overrides &&
 			netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp_lease *lease =3D
-			l_dhcp_client_get_lease(netconfig->dhcp_client);
-
-		if (lease)
+		const struct l_dhcp_lease *lease;
+
+		if (netconfig->fils_override &&
+				netconfig->fils_override->ipv4_dns) {
+			dns4_list =3D l_new(char *, 2);
+			dns4_list[0] =3D netconfig_ipv4_to_string(
+					netconfig->fils_override->ipv4_dns);
+		} else if ((lease =3D l_dhcp_client_get_lease(
+						netconfig->dhcp_client)))
 			dns4_list =3D l_dhcp_lease_get_dns(lease);
 	}
 =

 	if (!netconfig->dns6_overrides &&
 			netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp6_lease *lease =3D
-			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
-
-		if (lease)
+		const struct l_dhcp6_lease *lease;
+
+		if (netconfig->fils_override &&
+				!l_memeqzero(netconfig->fils_override->ipv6_dns,
+						16)) {
+			dns6_list =3D l_new(char *, 2);
+			dns6_list[0] =3D netconfig_ipv6_to_string(
+					netconfig->fils_override->ipv6_dns);
+		} else if ((lease =3D l_dhcp6_client_get_lease(
+						netconfig->dhcp6_client)))
 			dns6_list =3D l_dhcp6_lease_get_dns(lease);
 	}
 =

@@ -335,6 +378,11 @@ static char *netconfig_ipv4_get_gateway(struct netconf=
ig *netconfig)
 		return gateway;
 =

 	case RTPROT_DHCP:
+		if (netconfig->fils_override &&
+				netconfig->fils_override->ipv4_gateway)
+			return netconfig_ipv4_to_string(
+					netconfig->fils_override->ipv4_gateway);
+
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
 		if (!lease)
 			return NULL;
@@ -390,7 +438,13 @@ static struct l_rtnl_route *netconfig_get_static6_gate=
way(
 =

 	gateway =3D l_settings_get_string(netconfig->active_settings,
 						"IPv6", "Gateway");
-	if (!gateway)
+	if (!gateway && netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
+			netconfig->fils_override &&
+			!l_memeqzero(netconfig->fils_override->ipv6_gateway,
+					16))
+		gateway =3D netconfig_ipv6_to_string(
+					netconfig->fils_override->ipv6_gateway);
+	else if (!gateway)
 		return NULL;
 =

 	ret =3D l_rtnl_route_new_gateway(gateway);
@@ -520,7 +574,9 @@ static void netconfig_ifaddr_ipv6_added(struct netconfi=
g *netconfig,
 	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex,
 			ip, ifa->ifa_prefixlen);
 =

-	if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+	if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP ||
+			(netconfig->fils_override &&
+			 !l_memeqzero(netconfig->fils_override->ipv6_addr, 16)))
 		return;
 =

 	inet_pton(AF_INET6, ip, &in6);
@@ -898,7 +954,35 @@ static void netconfig_ipv4_acd_event(enum l_acd_event =
event, void *user_data)
 =

 static bool netconfig_ipv4_select_and_install(struct netconfig *netconfig)
 {
-	if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC) {
+	bool set_address =3D (netconfig->rtm_protocol =3D=3D RTPROT_STATIC);
+
+	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP &&
+			netconfig->fils_override &&
+			netconfig->fils_override->ipv4_addr) {
+		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv4_to_string(
+					netconfig->fils_override->ipv4_addr);
+		uint8_t prefix_len =3D netconfig->fils_override->ipv4_prefix_len;
+
+		if (unlikely(!addr_str))
+			return false;
+
+		if (L_WARN_ON(unlikely(!(netconfig->v4_address =3D
+						l_rtnl_address_new(addr_str,
+								prefix_len)))))
+			return false;
+
+		l_rtnl_address_set_noprefixroute(netconfig->v4_address, true);
+		set_address =3D true;
+
+		/*
+		 * TODO: If netconfig->fils_override->ipv4_lifetime is set,
+		 * start a timeout to renew the address using FILS IP Address
+		 * Assignment or perhaps just start the DHCP client at that
+		 * time.
+		 */
+	}
+
+	if (set_address) {
 		char ip[INET6_ADDRSTRLEN];
 =

 		if (L_WARN_ON(!netconfig->v4_address ||
@@ -941,6 +1025,7 @@ static bool netconfig_ipv4_select_and_install(struct n=
etconfig *netconfig)
 static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
 {
 	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
+	struct l_rtnl_address *address =3D NULL;
 =

 	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
 		l_debug("IPV6 configuration disabled");
@@ -949,11 +1034,34 @@ static bool netconfig_ipv6_select_and_install(struct=
 netconfig *netconfig)
 =

 	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC) {
-		struct l_rtnl_address *address =3D
-			netconfig_get_static6_address(
+	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
+		address =3D netconfig_get_static6_address(
 						netconfig->active_settings);
+	else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP &&
+			netconfig->fils_override &&
+			!l_memeqzero(netconfig->fils_override->ipv6_addr, 16)) {
+		uint8_t prefix_len =3D netconfig->fils_override->ipv6_prefix_len;
+		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv6_to_string(
+					netconfig->fils_override->ipv6_addr);
+
+		if (unlikely(!addr_str))
+			return false;
+
+		if (L_WARN_ON(unlikely(!(address =3D l_rtnl_address_new(addr_str,
+								prefix_len)))))
+			return false;
 =

+		l_rtnl_address_set_noprefixroute(address, true);
+
+		/*
+		 * TODO: If netconfig->fils_override->ipv6_lifetime is set,
+		 * start a timeout to renew the address using FILS IP Address
+		 * Assignment or perhaps just start the DHCP client at that
+		 * time.
+		 */
+	}
+
+	if (address) {
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
 			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex, address,
 					netconfig_ipv6_ifaddr_add_cmd_cb,
@@ -1184,6 +1292,8 @@ bool netconfig_reset(struct netconfig *netconfig)
 						"disable_ipv6", "1");
 	}
 =

+	l_free(l_steal_ptr(netconfig->fils_override));
+
 	return true;
 }
 =

@@ -1201,6 +1311,35 @@ char *netconfig_get_dhcp_server_ipv4(struct netconfi=
g *netconfig)
 	return l_dhcp_lease_get_server_id(lease);
 }
 =

+bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
+				struct ie_fils_ip_addr_request_info *info)
+{
+	/*
+	 * Fill in the fields used for building the FILS IP Address Assigment
+	 * IE during connection if we're configured to do automatic network
+	 * configuration (usually DHCP).  If we're configured with static
+	 * values return false to mean the IE should not be sent.
+	 */
+	if (netconfig->rtm_protocol !=3D RTPROT_DHCP &&
+			netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+		return false;
+
+	memset(info, 0, sizeof(*info));
+	info->ipv4 =3D (netconfig->rtm_protocol =3D=3D RTPROT_DHCP);
+	info->ipv6 =3D (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP);
+	info->dns =3D (info->ipv4 && !netconfig->dns4_overrides) ||
+		(info->ipv6 && !netconfig->dns6_overrides);
+
+	return true;
+}
+
+void netconfig_handle_fils_ip_resp(struct netconfig *netconfig,
+			const struct ie_fils_ip_addr_response_info *info)
+{
+	l_free(netconfig->fils_override);
+	netconfig->fils_override =3D l_memdup(info, sizeof(*info));
+}
+
 struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
diff --git a/src/netconfig.h b/src/netconfig.h
index 73e4df8b..fa46c7c8 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -21,6 +21,8 @@
  */
 =

 struct netconfig;
+struct ie_fils_ip_addr_request_info;
+struct ie_fils_ip_addr_response_info;
 =

 enum netconfig_event {
 	NETCONFIG_EVENT_CONNECTED,
@@ -38,6 +40,10 @@ bool netconfig_configure(struct netconfig *netconfig,
 bool netconfig_reconfigure(struct netconfig *netconfig);
 bool netconfig_reset(struct netconfig *netconfig);
 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig);
+bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
+				struct ie_fils_ip_addr_request_info *info);
+void netconfig_handle_fils_ip_resp(struct netconfig *netconfig,
+			const struct ie_fils_ip_addr_response_info *info);
 =

 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
-- =

2.30.2

--===============2974729997166787156==--

