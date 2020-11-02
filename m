Content-Type: multipart/mixed; boundary="===============0878015248636552260=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] ap: allow DHCP settings in provisioning files
Date: Mon, 02 Nov 2020 10:28:50 -0800
Message-ID: <20201102182851.2580877-2-prestwoj@gmail.com>
In-Reply-To: <20201102182851.2580877-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0878015248636552260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Users can now supply an AP provisioning file containing an [IPv4]
section and define various DHCP settings:

[IPv4]
Address=3D<address>
Netmask=3D<netmask>
Gateway=3D<gateway>
IPRange=3D<start_address>,<end_address>
DNSList=3D<dns1>,<dns2>,...<dnsN>
LeaseTime=3D<lease_time>

There are a few notes/requirements to keep in mind when using a
provisioning file:

 - All settings are optional but [IPv4].Address is required if the
   interface does not already have an address set.
 - If no [IPv4].Address is defined in the provisioning file and the AP
   interface does not already have an address set, StartWithConfig()
   will fail with -EINVAL.
 - If a provisioning file is provided it will take precedence, and the
   AP will not pull from the IP pool.
 - A provisioning file containing an IPv4 section assumes DHCP is being
   enabled and will override [General].EnableNetworkConfiguration.
 - Any address that AP sets on the interface will be deleted when the AP
   is stopped.
---
 src/ap.c | 285 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 222 insertions(+), 63 deletions(-)

v2:
 * Updated to work with loading profiles on the fly.

diff --git a/src/ap.c b/src/ap.c
index 4aabcd89..c8aee0ad 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -80,9 +80,12 @@ struct ap_state {
 	struct l_dhcp_server *server;
 	uint32_t rtnl_add_cmd;
 	char *own_ip;
+	unsigned int ip_prefix;
 =

 	bool started : 1;
 	bool gtk_set : 1;
+	bool cleanup_ip : 1;
+	bool use_ip_pool : 1;
 };
 =

 struct sta_state {
@@ -315,13 +318,18 @@ static void ap_reset(struct ap_state *ap)
 =

 	ap->started =3D false;
 =

-	if (ap->own_ip) {
+	/* Delete IP if one was set by IWD */
+	if (ap->cleanup_ip)
 		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
-					pool.prefix, ap->own_ip,
+					ap->ip_prefix, ap->own_ip,
 					broadcast_from_ip(ap->own_ip),
 					NULL, NULL, NULL);
 =

-		ip_pool_put(ap->own_ip);
+	if (ap->own_ip) {
+		/* Release IP from pool if used */
+		if (ap->use_ip_pool)
+			ip_pool_put(ap->own_ip);
+
 		l_free(ap->own_ip);
 	}
 =

@@ -2212,28 +2220,214 @@ static void ap_mlme_notify(struct l_genl_msg *msg,=
 void *user_data)
 	}
 }
 =

-static bool ap_load_profile(struct ap_state *ap)
+static bool dhcp_load_settings(struct ap_state *ap, struct l_settings *set=
tings)
+{
+	struct l_dhcp_server *server =3D ap->server;
+	struct in_addr ia;
+
+	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
+							"IPv4", "Netmask");
+	L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settings,
+							"IPv4", "Gateway");
+	char **dns =3D l_settings_get_string_list(settings, "IPv4",
+							"DNSList", ',');
+	char **ip_range =3D l_settings_get_string_list(settings, "IPv4",
+							"IPRange", ',');
+	unsigned int lease_time;
+	bool ret =3D false;
+
+	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_time))
+		lease_time =3D 0;
+
+	if (ip_range && l_strv_length(ip_range) !=3D 2)
+		goto parse_error;
+
+	if (netmask && !l_dhcp_server_set_netmask(server, netmask))
+		goto parse_error;
+
+	if (gateway && !l_dhcp_server_set_gateway(server, gateway))
+		goto parse_error;
+
+	if (dns && !l_dhcp_server_set_dns(server, dns))
+		goto parse_error;
+
+	if (ip_range && !l_dhcp_server_set_ip_range(server, ip_range[0],
+							ip_range[1]))
+		goto parse_error;
+
+	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time))
+		goto parse_error;
+
+	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
+		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
+	else
+		ap->ip_prefix =3D 24;
+
+	ret =3D true;
+
+parse_error:
+	l_strv_free(dns);
+	l_strv_free(ip_range);
+	return ret;
+}
+
+/*
+ * This will determine the IP being used for DHCP. The IP will be automati=
cally
+ * set to ap->own_ip.
+ *
+ * The address to set (or keep) is determined in this order:
+ * 1. Address defined in provisioning file
+ * 2. Address already set on interface
+ * 3. Address in IP pool.
+ *
+ * Returns:  0 if an IP was successfully selected and needs to be set
+ *          -EALREADY if an IP was already set on the interface
+ *          -EEXIST if the IP pool ran out of IP's
+ *          -EINVAL if there was an error.
+ */
+static int ap_setup_dhcp(struct ap_state *ap, struct l_settings *settings)
+{
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	struct in_addr ia;
+	uint32_t address =3D 0;
+	int ret =3D -EINVAL;
+
+	ap->server =3D l_dhcp_server_new(ifindex);
+	if (!ap->server) {
+		l_error("Failed to create DHCP server on %u", ifindex);
+		return -EINVAL;;
+	}
+
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(ap->server, do_debug,
+							"[DHCPv4 SERV] ", NULL);
+
+	/* get the current address if there is one */
+	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
+		address =3D ia.s_addr;
+
+	if (ap->config->profile) {
+		char *addr;
+
+		addr =3D l_settings_get_string(settings, "IPv4", "Address");
+		if (addr) {
+			if (inet_pton(AF_INET, addr, &ia) < 0)
+				goto free_addr;
+
+			/* Is a matching address already set on interface? */
+			if (ia.s_addr =3D=3D address)
+				ret =3D -EALREADY;
+			else
+				ret =3D 0;
+		} else if (address) {
+			/* No address in config, but interface has one set */
+			addr =3D l_strdup(inet_ntoa(ia));
+			ret =3D -EALREADY;
+		} else
+			goto free_addr;
+
+		/* Set the remaining DHCP options in config file */
+		if (!dhcp_load_settings(ap, settings)) {
+			ret =3D -EINVAL;
+			goto free_addr;
+		}
+
+		if (!l_dhcp_server_set_ip_address(ap->server, addr)) {
+			ret =3D -EINVAL;
+			goto free_addr;
+		}
+
+		ap->own_ip =3D l_strdup(addr);
+
+free_addr:
+		l_free(addr);
+
+		return ret;
+	} else if (address) {
+		/* No config file and address is already set */
+		ap->own_ip =3D l_strdup(inet_ntoa(ia));
+
+		return -EALREADY;
+	} else if (pool.used) {
+		/* No config file, no address set. Use IP pool */
+		ap->own_ip =3D ip_pool_get();
+		if (!ap->own_ip) {
+			l_error("No more IP's in pool, cannot start AP on %u",
+					ifindex);
+			return -EEXIST;
+		}
+
+		ap->use_ip_pool =3D true;
+		ap->ip_prefix =3D pool.prefix;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ap_load_profile_and_dhcp(struct ap_state *ap, bool *wait_dhcp)
 {
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	char *passphrase;
-	L_AUTO_FREE_VAR(struct l_settings *, settings) =3D l_settings_new();
+	L_AUTO_FREE_VAR(struct l_settings *, settings) =3D NULL;
+	int err;
 =

-	if (!l_settings_load_from_file(settings, ap->config->profile))
-		return false;
+	/* No profile or DHCP settings */
+	if (!ap->config->profile && !pool.used)
+		return 0;
+
+	if (ap->config->profile) {
+		settings =3D l_settings_new();
 =

-	passphrase =3D l_settings_get_string(settings, "Security", "Passphrase");
-	if (passphrase) {
-		if (strlen(passphrase) > 63) {
-			l_error("[Security].Passphrase must not exceed "
-					"63 characters");
+		if (!l_settings_load_from_file(settings, ap->config->profile))
+			return -EINVAL;
+
+		passphrase =3D l_settings_get_string(settings, "Security",
+							"Passphrase");
+		if (passphrase) {
+			if (strlen(passphrase) > 63) {
+				l_error("[Security].Passphrase must not exceed "
+						"63 characters");
+				return -EINVAL;
+			}
+
+			strcpy(ap->config->passphrase, passphrase);
+			l_free(passphrase);
+		}
+
+		if (!l_settings_has_group(settings, "IPv4")) {
+			*wait_dhcp =3D false;
+			return 0;
+		}
+	}
+
+	err =3D ap_setup_dhcp(ap, settings);
+	if (err =3D=3D 0) {
+		/* Address change required */
+		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
+					ap->ip_prefix, ap->own_ip,
+					broadcast_from_ip(ap->own_ip),
+					ap_ifaddr4_added_cb, ap, NULL);
+
+		if (!ap->rtnl_add_cmd) {
+			l_error("Failed to add IPv4 address");
 			return false;
 		}
 =

-		strcpy(ap->config->passphrase, passphrase);
-		l_free(passphrase);
+		ap->cleanup_ip =3D true;
+
+		*wait_dhcp =3D true;
+
+		return 0;
+	/* Selected address already set, continue normally */
+	} else if (err =3D=3D -EALREADY) {
+		*wait_dhcp =3D false;
+
+		return 0;
 	}
 =

-	l_info("Loaded AP configuration %s", ap->config->ssid);
-	return true;
+	return err;
 }
 =

 /*
@@ -2256,9 +2450,8 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
 	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
-	uint32_t ifindex =3D netdev_get_ifindex(netdev);
-	struct in_addr ia;
 	int err =3D -EINVAL;
+	bool wait_on_address =3D false;
 =

 	if (err_out)
 		*err_out =3D err;
@@ -2277,7 +2470,14 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 	ap->ops =3D ops;
 	ap->user_data =3D user_data;
 =

-	if (config->profile && !ap_load_profile(ap))
+	/*
+	 * This both loads a profile if required and loads DHCP settings either
+	 * by the profile itself or the IP pool (or does nothing in the case
+	 * of a profile-less configuration). wait_on_address will be set true
+	 * if an address change is required.
+	 */
+	err =3D ap_load_profile_and_dhcp(ap, &wait_on_address);
+	if (err < 0)
 		goto error;
 =

 	if (!config->channel)
@@ -2361,54 +2561,13 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct ap_config *config,
 	if (!ap->mlme_watch)
 		l_error("Registering for MLME notification failed");
 =

-	/* No IP pool initialized, DHCP is not being used */
-	if (!pool.used)
-		goto done;
-
-	ap->server =3D l_dhcp_server_new(ifindex);
-	if (!ap->server) {
-		l_error("Failed to create DHCP server on %u", ifindex);
-		goto error;
-	}
-
-	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp_server_set_debug(ap->server, do_debug,
-							"[DHCPv4 SERV] ", NULL);
-
-	/*
-	 * If there is no IP set on the interface use one from the IP pool
-	 * defined in main.conf.
-	 */
-	if (!l_net_get_address(ifindex, &ia) || ia.s_addr =3D=3D 0) {
-		ap->own_ip =3D ip_pool_get();
-
-		if (!ap->own_ip) {
-			l_error("No more IP's in pool, cannot start AP on %u",
-					ifindex);
-			err =3D -EEXIST;
-			goto error;
-		}
-
-		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
-					pool.prefix, ap->own_ip,
-					broadcast_from_ip(ap->own_ip),
-					ap_ifaddr4_added_cb, ap, NULL);
-
-		if (!ap->rtnl_add_cmd) {
-			l_error("Failed to add IPv4 address");
-			goto error;
-		}
-
-
+	if (wait_on_address) {
 		if (err_out)
 			*err_out =3D 0;
 =

-		/* Finish starting AP in added callback */
 		return ap;
 	}
-	/* Else honor the IP set on the interface prior to calling Start() */
 =

-done:
 	cmd =3D ap_build_cmd_start_ap(ap);
 	if (!cmd)
 		goto error;
@@ -2876,10 +3035,10 @@ static int ap_init(void)
 =

 		if (!ip_pool_create(ip_prefix))
 			return -EINVAL;
-
-		rtnl =3D iwd_get_rtnl();
 	}
 =

+	rtnl =3D iwd_get_rtnl();
+
 	return 0;
 }
 =

-- =

2.26.2

--===============0878015248636552260==--

