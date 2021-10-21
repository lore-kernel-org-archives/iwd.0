Content-Type: multipart/mixed; boundary="===============9063251148251389594=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 05/12] netconfig: Track local domains lists
Date: Thu, 21 Oct 2021 10:50:34 +0200
Message-ID: <20211021085041.294524-5-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============9063251148251389594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cache the latest v4 and v6 domain string lists in struct netconfig state
to be able to more easily detect changes in those values in future
commits.  For that split netconfig_set_domains's code into this function,
which now only commits the values in netconfig->v{4,6}_domain{,s} to the
resolver, and netconfig_domains_update() which figures out the active
domains string list and saves it into netconfig->v{4,6}_domain{,s}.  This
probably saves some cycles as the callers can now decide to only
recalculate the domains list which may have changed.

While there simplify netconfig_set_domains return type to void as the
result was always 0 anyway and was never checked by callers.
---
 src/netconfig.c | 88 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 3856b264..f4bf944e 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -67,6 +67,8 @@ struct netconfig {
 	struct ie_fils_ip_addr_response_info *fils_override;
 	char *v4_gateway_str;
 	char *v6_gateway_str;
+	char *v4_domain;
+	char **v6_domains;
 =

 	const struct l_settings *active_settings;
 =

@@ -353,47 +355,71 @@ static void append_domain(char **domains, unsigned in=
t *n_domains,
 	*n_domains +=3D 1;
 }
 =

-static int netconfig_set_domains(struct netconfig *netconfig)
+static void netconfig_set_domains(struct netconfig *netconfig)
 {
 	char *domains[31];
 	unsigned int n_domains =3D 0;
-	char *v4_domain =3D NULL;
-	char **v6_domains =3D NULL;
 	char **p;
 =

 	memset(domains, 0, sizeof(domains));
 =

-	/* Allow to override the DHCP domain name with setting entry. */
-	v4_domain =3D l_settings_get_string(netconfig->active_settings,
-							"IPv4", "DomainName");
-	if (!v4_domain && netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp_lease *lease =3D
-			l_dhcp_client_get_lease(netconfig->dhcp_client);
+	append_domain(domains, &n_domains,
+			L_ARRAY_SIZE(domains) - 1, netconfig->v4_domain);
 =

-		if (lease)
-			v4_domain =3D l_dhcp_lease_get_domain_name(lease);
-	}
+	for (p =3D netconfig->v6_domains; p && *p; p++)
+		append_domain(domains, &n_domains,
+				L_ARRAY_SIZE(domains) - 1, *p);
 =

-	append_domain(domains, &n_domains,
-					L_ARRAY_SIZE(domains) - 1, v4_domain);
+	resolve_set_domains(netconfig->resolve, domains);
+}
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
-		const struct l_dhcp6_lease *lease =3D
-			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
+static bool netconfig_domains_update(struct netconfig *netconfig, uint8_t =
af)
+{
+	bool changed =3D false;
 =

-		if (lease)
-			v6_domains =3D l_dhcp6_lease_get_domains(lease);
-	}
+	if (af =3D=3D AF_INET) {
+		/* Allow to override the DHCP domain name with setting entry. */
+		char *v4_domain =3D l_settings_get_string(
+						netconfig->active_settings,
+						"IPv4", "DomainName");
 =

-	for (p =3D v6_domains; p && *p; p++)
-		append_domain(domains, &n_domains,
-					L_ARRAY_SIZE(domains) - 1, *p);
+		if (!v4_domain && netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
+			const struct l_dhcp_lease *lease =3D
+				l_dhcp_client_get_lease(netconfig->dhcp_client);
 =

-	resolve_set_domains(netconfig->resolve, domains);
-	l_strv_free(v6_domains);
-	l_free(v4_domain);
+			if (lease)
+				v4_domain =3D l_dhcp_lease_get_domain_name(lease);
+		}
 =

-	return 0;
+		if (l_streq0(v4_domain, netconfig->v4_domain))
+			l_free(v4_domain);
+		else {
+			l_free(netconfig->v4_domain);
+			netconfig->v4_domain =3D v4_domain;
+			changed =3D true;
+		}
+	} else {
+		char **v6_domains =3D NULL;
+
+		if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
+			const struct l_dhcp6_lease *lease =3D
+				l_dhcp6_client_get_lease(
+						netconfig->dhcp6_client);
+
+			if (lease)
+				v6_domains =3D l_dhcp6_lease_get_domains(lease);
+		}
+
+		if (l_strv_eq(netconfig->v6_domains, v6_domains))
+			l_strv_free(v6_domains);
+		else {
+			l_strv_free(netconfig->v6_domains);
+			netconfig->v6_domains =3D v6_domains;
+			changed =3D true;
+		}
+	}
+
+	return changed;
 }
 =

 static struct l_rtnl_address *netconfig_get_static4_address(
@@ -1022,6 +1048,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct =
l_dhcp_client *client,
 		}
 =

 		netconfig_dns_list_update(netconfig, AF_INET);
+		netconfig_domains_update(netconfig, AF_INET);
 =

 		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
 				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
@@ -1093,6 +1120,7 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 		netconfig->v6_address =3D address;
 =

 		netconfig_dns_list_update(netconfig, AF_INET6);
+		netconfig_domains_update(netconfig, AF_INET6);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		break;
@@ -1100,6 +1128,7 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
 		l_debug("Lease for interface %u expired", netconfig->ifindex);
 		netconfig_dns_list_update(netconfig, AF_INET6);
+		netconfig_domains_update(netconfig, AF_INET6);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		l_rtnl_address_free(netconfig->v6_address);
@@ -1143,6 +1172,8 @@ static void netconfig_reset_v4(struct netconfig *netc=
onfig)
 		netconfig->acd =3D NULL;
 =

 		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+
+		l_free(l_steal_ptr(netconfig->v4_domain));
 	}
 }
 =

@@ -1220,6 +1251,7 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 			return false;
 =

 		netconfig_dns_list_update(netconfig, AF_INET);
+		netconfig_domains_update(netconfig, AF_INET);
 =

 		netconfig->acd =3D l_acd_new(netconfig->ifindex);
 		l_acd_set_event_handler(netconfig->acd,
@@ -1542,6 +1574,8 @@ bool netconfig_reset(struct netconfig *netconfig)
 						"disable_ipv6", "1");
 =

 		l_free(l_steal_ptr(netconfig->v6_gateway_str));
+
+		l_strv_free(l_steal_ptr(netconfig->v6_domains));
 	}
 =

 	l_free(l_steal_ptr(netconfig->fils_override));
-- =

2.32.0

--===============9063251148251389594==--

