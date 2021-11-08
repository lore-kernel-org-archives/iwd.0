Content-Type: multipart/mixed; boundary="===============8940491814407652265=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 5/9] netconfig: Try calling the agent before setting new values
Date: Mon, 08 Nov 2021 12:28:34 +0100
Message-ID: <20211108112838.372416-5-andrew.zaborowski@intel.com>
In-Reply-To: 20211108112838.372416-1-andrew.zaborowski@intel.com

--===============8940491814407652265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement the logic where, after netconfig decides on what address,
gateway, DNS, etc. data to use, it calls the NetworkConfigurationAgent
that may be registered and relies on it to commit the new values.  If no
agent is registered it will proceed to set the new values as usual.  If
it does make an agent call, it wlil wait for the call to return before
signalling NETCONFIG_EVENT_CONNECTED.
---
 src/netconfig.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/netconfig.h |   1 +
 src/station.c   |   4 ++
 3 files changed, 119 insertions(+)

diff --git a/src/netconfig.c b/src/netconfig.c
index 885e34a8..3a67c890 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -49,6 +49,7 @@
 #include "src/resolve.h"
 #include "src/util.h"
 #include "src/ie.h"
+#include "src/agent.h"
 #include "src/netconfig.h"
 #include "src/sysfs.h"
 =

@@ -97,6 +98,10 @@ struct netconfig {
 	uint32_t addr6_add_cmd_id;
 	uint32_t route4_add_gateway_cmd_id;
 	uint32_t route6_add_cmd_id;
+
+	const char *dbus_obj_path;
+	unsigned int agent_v4_req_id;
+	unsigned int agent_v6_req_id;
 };
 =

 static struct l_netlink *rtnl;
@@ -1031,6 +1036,92 @@ static void netconfig_ifaddr_del_cmd_cb(int error, u=
int16_t type,
 				"Error %d: %s", error, strerror(-error));
 }
 =

+static void netconfig_agent_req_cb(unsigned int req_id, enum agent_result =
result,
+					void *user_data)
+{
+	struct netconfig *netconfig =3D user_data;
+	bool v4 =3D req_id =3D=3D netconfig->agent_v4_req_id;
+
+	if (v4)
+		netconfig->agent_v4_req_id =3D 0;
+	else
+		netconfig->agent_v6_req_id =3D 0;
+
+	if (result !=3D AGENT_RESULT_OK) {
+		l_error("Netconfig agent request for %s failed",
+			v4 ? "IPv4" : "IPv6");
+		/* TODO: report to user if v4 */
+		return;
+	}
+
+	l_debug("Netconfig agent request success for %s", v4 ? "IPv4" : "IPv6");
+
+	if (!v4)
+		return;
+
+	if (netconfig->notify) {
+		netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+					netconfig->user_data);
+		netconfig->notify =3D NULL;
+	}
+}
+
+static bool netconfig_try_agent(struct netconfig *netconfig, uint8_t af)
+{
+	struct netconfig_data data =3D { .family =3D af };
+	const struct l_rtnl_address *addr;
+	char addr_str[INET6_ADDRSTRLEN];
+	char *v4_domains[] =3D { netconfig->v4_domain, NULL };
+	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
+	unsigned int *id =3D (af =3D=3D AF_INET) ?
+		&netconfig->agent_v4_req_id : &netconfig->agent_v6_req_id;
+
+	if (!netconfig->dbus_obj_path)
+		return false;
+
+	addr =3D (af =3D=3D AF_INET) ? netconfig->v4_address : netconfig->v6_addr=
ess;
+
+	if ((af =3D=3D AF_INET && netconfig->rtm_protocol =3D=3D RTPROT_STATIC) ||
+			(af =3D=3D AF_INET6 &&
+			 netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC))
+		data.method =3D NETCONFIG_METHOD_STATIC;
+	else if ((af =3D=3D AF_INET && netconfig->rtm_protocol =3D=3D RTPROT_DHCP=
) ||
+			(af =3D=3D AF_INET6 &&
+			 netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP))
+		data.method =3D NETCONFIG_METHOD_AUTO;
+	else
+		return true;
+
+	if (addr) {
+		if (l_rtnl_address_get_address(addr, addr_str))
+			data.addr =3D addr_str;
+
+		data.prefix_len =3D l_rtnl_address_get_prefix_length(addr);
+	}
+
+	data.gateway_addr =3D (af =3D=3D AF_INET) ?
+		netconfig->v4_gateway_str : netconfig->v6_gateway_str;
+	data.dns =3D (af =3D=3D AF_INET) ?
+		netconfig->dns4_list : netconfig->dns6_list;
+	data.domain_names =3D (af =3D=3D AF_INET) ?
+		(v4_domains[0] ? v4_domains : NULL) : netconfig->v6_domains;
+
+	if (*id)
+		agent_request_cancel(*id, -ECANCELED);
+
+	*id =3D agent_request_netconfig(netconfig->dbus_obj_path,
+						netdev_get_name(netdev),
+						&data,
+						netconfig_agent_req_cb,
+						netconfig, NULL);
+	if (!*id)
+		return false;
+
+	l_debug("Netconfig request for %s on %s sent to agent",
+		(af =3D=3D AF_INET) ? "IPv4" : "IPv6", netdev_get_name(netdev));
+	return true;
+}
+
 static bool netconfig_address_cmp_address(const struct l_rtnl_address *a,
 						const struct l_rtnl_address *b)
 {
@@ -1068,6 +1159,9 @@ static void netconfig_set(struct netconfig *netconfig=
, uint8_t af,
 {
 	struct l_rtnl_address *stale_addr;
 =

+	if (netconfig_try_agent(netconfig, af))
+		return;
+
 	if (af =3D=3D AF_INET)
 		stale_addr =3D l_steal_ptr(netconfig->stale_v4_address);
 	else
@@ -1390,6 +1484,12 @@ static void netconfig_reset_v4(struct netconfig *net=
config)
 =

 		l_acd_destroy(netconfig->acd);
 		netconfig->acd =3D NULL;
+
+		if (netconfig->agent_v4_req_id) {
+			agent_request_cancel(netconfig->agent_v4_req_id,
+						-ECANCELED);
+			netconfig->agent_v4_req_id =3D 0;
+		}
 	}
 }
 =

@@ -1429,6 +1529,12 @@ static void netconfig_reset_v6(struct netconfig *net=
config)
 =

 		sysfs_write_ipv6_setting(netdev_get_name(netdev),
 						"disable_ipv6", "1");
+
+		if (netconfig->agent_v6_req_id) {
+			agent_request_cancel(netconfig->agent_v6_req_id,
+						-ECANCELED);
+			netconfig->agent_v6_req_id =3D 0;
+		}
 	}
 }
 =

@@ -1785,6 +1891,8 @@ bool netconfig_reconfigure(struct netconfig *netconfi=
g, bool set_arp_gw)
 =

 bool netconfig_reset(struct netconfig *netconfig)
 {
+	netconfig->dbus_obj_path =3D NULL;
+
 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
 		netconfig->route4_add_gateway_cmd_id =3D 0;
@@ -1925,6 +2033,11 @@ void netconfig_destroy(struct netconfig *netconfig)
 	netconfig_free(netconfig);
 }
 =

+void netconfig_set_dbus_path(struct netconfig *netconfig, const char *path)
+{
+	netconfig->dbus_obj_path =3D path;
+}
+
 bool netconfig_enabled(void)
 {
 	bool enabled;
@@ -2004,3 +2117,4 @@ static void netconfig_exit(void)
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
+IWD_MODULE_DEPENDS(netconfig, agent)
diff --git a/src/netconfig.h b/src/netconfig.h
index 48018bc1..77855b26 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -61,5 +61,6 @@ void netconfig_handle_fils_ip_resp(struct netconfig *netc=
onfig,
 =

 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
+void netconfig_set_dbus_path(struct netconfig *netconfig, const char *path=
);
 =

 bool netconfig_enabled(void);
diff --git a/src/station.c b/src/station.c
index 19f2aaeb..aca59550 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2816,6 +2816,10 @@ static void station_connect_ok(struct station *stati=
on)
 			}
 		}
 =

+		/* The path remains valid until connected_network changes */
+		netconfig_set_dbus_path(station->netconfig,
+				network_get_path(station->connected_network));
+
 		if (L_WARN_ON(!netconfig_configure(station->netconfig,
 						station_netconfig_event_handler,
 						station)))
-- =

2.32.0

--===============8940491814407652265==--

