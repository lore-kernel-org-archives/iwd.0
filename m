Content-Type: multipart/mixed; boundary="===============8347519175826509342=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/10] ap: Load profile before calling ap_start,
 extend Address syntax
Date: Fri, 05 Mar 2021 16:09:27 +0100
Message-ID: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8347519175826509342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the profile support was added some settings were passed to
ap_start() through the ap_config struct and others were loaded inside
ap_start() based on the profile path.  Instead make profiles transparent
to ap_start():

* don't pass the profile path to ap_start(),
* add storage for the profile settings directly to ap_config,
* load and validate the settings from the profile file directly
  in the caller (ap_dbus_start_profile).

Now any user of the ap_start() api can set those values and the
difference between .Start and .StartProfile is only that one loads the
extra settings from the profile whlie the other relies on the defaults.

Temporarily drop most of the DHCP setup code as it needs to be rewritten
to account for the new setting syntax and setup order, this happens in
the subsequent commits in steps.

While I'm rewriting the profile loading I also expand the [IPv4].Address
syntax to allow a new format: a list of <IP>/<prefix_len> -form strings
that define the address space for subnet address selection.
---
 src/ap.c | 425 ++++++++++++++++++++++---------------------------------
 src/ap.h |  10 +-
 2 files changed, 180 insertions(+), 255 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 2042cde6..677ba8fa 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -225,6 +225,171 @@ static const char *broadcast_from_ip(const char *ip)
 	return inet_ntoa(ia);
 }
 =

+#define AP_DEFAULT_IPV4_PREFIX_LEN 28
+
+struct ap_config *ap_config_load_profile(const char *ssid)
+{
+	L_AUTO_FREE_VAR(char *, profile_path) =3D
+		storage_get_path("ap/%s.ap", ssid);
+	L_AUTO_FREE_OBJ(l_settings, profile) =3D l_settings_new();
+	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
+	struct ap_config *config;
+	uint32_t static_addr4 =3D 0;
+	unsigned int lease_time;
+
+	if (!l_settings_load_from_file(profile, profile_path))
+		return NULL;
+
+	passphrase =3D l_settings_get_string(profile, "Security",
+							"Passphrase");
+	if (!passphrase) {
+		l_error("[Security].Passphrase not found in "
+			"AP profile");
+		return NULL;
+	}
+
+	/* Full checks done later in crypto_passphrase_is_valid() */
+	if (strlen(passphrase) > 63) {
+		l_error("[Security].Passphrase must not exceed "
+			"63 characters");
+		return NULL;
+	}
+
+	config =3D l_new(struct ap_config, 1);
+	config->ssid =3D l_strdup(ssid);
+	strcpy(config->passphrase, passphrase);
+
+	if (!l_settings_has_group(profile, "IPv4")) {
+		config->disable_netconfig4 =3D true;
+		return config;
+	}
+
+	if (l_settings_get_value(profile, "IPv4", "Address")) {
+		struct in_addr ia;
+
+		config->addr4_str_list =3D l_settings_get_string_list(profile,
+								"IPv4",
+								"Address", ',');
+		if (!config->addr4_str_list || !*config->addr4_str_list) {
+			l_error("Can't parse the profile [IPv4].Address "
+				"setting as a string list");
+			goto invalid_format;
+		}
+
+		/* Check for the static IP syntax: Address=3D<IP> */
+		if (l_strv_length((char **) config->addr4_str_list) =3D=3D 1 &&
+				inet_pton(AF_INET, *config->addr4_str_list,
+						&ia) =3D=3D 1)
+			static_addr4 =3D ntohl(ia.s_addr);
+	}
+
+	if (l_settings_get_value(profile, "IPv4", "Netmask")) {
+		L_AUTO_FREE_VAR(char *, netmask_str) =3D
+			l_settings_get_string(profile, "IPv4", "Netmask");
+		struct in_addr ia;
+
+		if (inet_pton(AF_INET, netmask_str, &ia) !=3D 1) {
+			l_error("Can't parse the profile [IPv4].Netmask "
+				"setting");
+			goto invalid_format;
+		}
+
+		config->prefix_len4 =3D __builtin_popcount(ia.s_addr);
+
+		if (ntohl(ia.s_addr) !=3D
+				util_netmask_from_prefix(config->prefix_len4)) {
+			l_error("Invalid profile [IPv4].Netmask value");
+			goto invalid_format;
+		}
+	}
+
+	if (l_settings_get_value(profile, "IPv4", "DNSList")) {
+		config->dns_addr4_str_list =3D l_settings_get_string_list(
+								profile, "IPv4",
+								"DNSList", ',');
+		if (!config->dns_addr4_str_list ||
+				!*config->dns_addr4_str_list) {
+			l_error("Can't parse the profile [IPv4].DNSList "
+				"setting as a string list");
+			goto invalid_format;
+		}
+	}
+
+	if (l_settings_get_value(profile, "IPv4", "IPRange")) {
+		char **ip_range =3D l_settings_get_string_list(profile, "IPv4",
+								"IPRange", ',');
+		int i;
+		uint32_t netmask;
+
+		if (!static_addr4 || !config->prefix_len4) {
+			l_error("[IPv4].IPRange only makes sense in an AP "
+				"profile if a static local address and "
+				"netmask have also been specified");
+			l_strv_free(ip_range);
+			goto invalid_format;
+		}
+
+		if (!ip_range || l_strv_length(ip_range) !=3D 2) {
+			l_error("Can't parse the profile [IPv4].IPRange "
+				"setting as two address strings");
+			l_strv_free(ip_range);
+			goto invalid_format;
+		}
+
+		netmask =3D util_netmask_from_prefix(config->prefix_len4);
+
+		for (i =3D 0; i < 2; i++) {
+			struct in_addr range_addr;
+
+			if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
+				l_error("Can't parse address in "
+					"[IPv4].IPRange[%i]", i + 1);
+				goto invalid_format;
+			}
+
+			if ((static_addr4 ^ ntohl(range_addr.s_addr)) &
+					netmask) {
+				struct in_addr addr =3D { htonl(static_addr4) };
+
+				l_error("[IPv4].IPRange[%i] is not in the "
+					"%s/%i subnet", i + 1,
+					inet_ntoa(addr), config->prefix_len4);
+				goto invalid_format;
+			}
+
+			if (i =3D=3D 0)
+				config->dhcp_start_addr4 =3D
+					ntohl(range_addr.s_addr);
+			else
+				config->dhcp_end_addr4 =3D
+					ntohl(range_addr.s_addr);
+		}
+	}
+
+	if (l_settings_get_value(profile, "IPv4", "Gateway")) {
+		L_AUTO_FREE_VAR(char *, gateway_str) =3D
+			l_settings_get_string(profile, "IPv4", "Gateway");
+		struct in_addr ia;
+
+		if (inet_pton(AF_INET, gateway_str, &ia) !=3D 1) {
+			l_error("Can't parse the profile [IPv4].Gateway "
+				"setting");
+			goto invalid_format;
+		}
+
+		config->dhcp_gateway_addr4 =3D ntohl(ia.s_addr);
+	}
+
+	if (l_settings_get_uint(profile, "IPv4", "LeaseTime", &lease_time))
+		config->dhcp_lease_time =3D lease_time;
+
+	return config;
+
+invalid_format:
+	ap_config_free(config);
+	return NULL;
+}
+
 void ap_config_free(struct ap_config *config)
 {
 	if (unlikely(!config))
@@ -236,10 +401,8 @@ void ap_config_free(struct ap_config *config)
 	explicit_bzero(config->psk, sizeof(config->psk));
 	l_free(config->authorized_macs);
 	l_free(config->wsc_name);
-
-	if (config->profile)
-		l_free(config->profile);
-
+	l_strv_free(config->addr4_str_list);
+	l_strv_free(config->dns_addr4_str_list);
 	l_free(config);
 }
 =

@@ -2394,233 +2557,6 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	}
 }
 =

-static bool dhcp_load_settings(struct ap_state *ap, struct l_settings *set=
tings)
-{
-	struct l_dhcp_server *server =3D ap->server;
-	struct in_addr ia;
-
-	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
-							"IPv4", "Netmask");
-	L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settings,
-							"IPv4", "Gateway");
-	char **dns =3D l_settings_get_string_list(settings, "IPv4",
-							"DNSList", ',');
-	char **ip_range =3D l_settings_get_string_list(settings, "IPv4",
-							"IPRange", ',');
-	unsigned int lease_time;
-	bool ret =3D false;
-
-	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_time))
-		lease_time =3D 0;
-
-	if (gateway && !l_dhcp_server_set_gateway(server, gateway)) {
-		l_error("[IPv4].Gateway value error");
-		goto error;
-	}
-
-	if (dns && !l_dhcp_server_set_dns(server, dns)) {
-		l_error("[IPv4].DNSList value error");
-		goto error;
-	}
-
-	if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
-		l_error("[IPv4].Netmask value error");
-		goto error;
-	}
-
-	if (ip_range) {
-		if (l_strv_length(ip_range) !=3D 2) {
-			l_error("Two addresses expected in [IPv4].IPRange");
-			goto error;
-		}
-
-		if (!l_dhcp_server_set_ip_range(server, ip_range[0],
-							ip_range[1])) {
-			l_error("Error setting IP range from [IPv4].IPRange");
-			goto error;
-		}
-	}
-
-	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time)) {
-		l_error("[IPv4].LeaseTime value error");
-		goto error;
-	}
-
-	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
-		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
-	else
-		ap->ip_prefix =3D 24;
-
-	ret =3D true;
-
-error:
-	l_strv_free(dns);
-	l_strv_free(ip_range);
-	return ret;
-}
-
-/*
- * This will determine the IP being used for DHCP. The IP will be automati=
cally
- * set to ap->own_ip.
- *
- * The address to set (or keep) is determined in this order:
- * 1. Address defined in provisioning file
- * 2. Address already set on interface
- * 3. Address in IP pool.
- *
- * Returns:  0 if an IP was successfully selected and needs to be set
- *          -EALREADY if an IP was already set on the interface
- *          -EEXIST if the IP pool ran out of IP's
- *          -EINVAL if there was an error.
- */
-static int ap_setup_dhcp(struct ap_state *ap, struct l_settings *settings)
-{
-	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	struct in_addr ia;
-	uint32_t address =3D 0;
-	int ret =3D -EINVAL;
-
-	ap->server =3D l_dhcp_server_new(ifindex);
-	if (!ap->server) {
-		l_error("Failed to create DHCP server on %u", ifindex);
-		return -EINVAL;;
-	}
-
-	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp_server_set_debug(ap->server, do_debug,
-							"[DHCPv4 SERV] ", NULL);
-
-	/* get the current address if there is one */
-	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
-		address =3D ia.s_addr;
-
-	if (ap->config->profile) {
-		char *addr;
-
-		addr =3D l_settings_get_string(settings, "IPv4", "Address");
-		if (addr) {
-			if (inet_pton(AF_INET, addr, &ia) < 0)
-				goto free_addr;
-
-			/* Is a matching address already set on interface? */
-			if (ia.s_addr =3D=3D address)
-				ret =3D -EALREADY;
-			else
-				ret =3D 0;
-		} else if (address) {
-			/* No address in config, but interface has one set */
-			addr =3D l_strdup(inet_ntoa(ia));
-			ret =3D -EALREADY;
-		} else
-			goto free_addr;
-
-		/* Set the remaining DHCP options in config file */
-		if (!dhcp_load_settings(ap, settings)) {
-			ret =3D -EINVAL;
-			goto free_addr;
-		}
-
-		if (!l_dhcp_server_set_ip_address(ap->server, addr)) {
-			ret =3D -EINVAL;
-			goto free_addr;
-		}
-
-		ap->own_ip =3D l_strdup(addr);
-
-free_addr:
-		l_free(addr);
-
-		return ret;
-	} else if (address) {
-		/* No config file and address is already set */
-		ap->own_ip =3D l_strdup(inet_ntoa(ia));
-
-		return -EALREADY;
-	} else if (pool.used) {
-		/* No config file, no address set. Use IP pool */
-		ap->own_ip =3D ip_pool_get();
-		if (!ap->own_ip) {
-			l_error("No more IP's in pool, cannot start AP on %u",
-					ifindex);
-			return -EEXIST;
-		}
-
-		ap->use_ip_pool =3D true;
-		ap->ip_prefix =3D pool.prefix;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int ap_load_profile_and_dhcp(struct ap_state *ap, bool *wait_dhcp)
-{
-	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	char *passphrase;
-	struct l_settings *settings =3D NULL;
-	int err =3D -EINVAL;
-
-	/* No profile or DHCP settings */
-	if (!ap->config->profile && !pool.used)
-		return 0;
-
-	if (ap->config->profile) {
-		settings =3D l_settings_new();
-
-		if (!l_settings_load_from_file(settings, ap->config->profile))
-			goto cleanup;
-
-		passphrase =3D l_settings_get_string(settings, "Security",
-							"Passphrase");
-		if (passphrase) {
-			if (strlen(passphrase) > 63) {
-				l_error("[Security].Passphrase must not exceed "
-						"63 characters");
-				l_free(passphrase);
-				goto cleanup;
-			}
-
-			strcpy(ap->config->passphrase, passphrase);
-			l_free(passphrase);
-		}
-
-		if (!l_settings_has_group(settings, "IPv4")) {
-			*wait_dhcp =3D false;
-			err =3D 0;
-			goto cleanup;
-		}
-	}
-
-	err =3D ap_setup_dhcp(ap, settings);
-	if (err =3D=3D 0) {
-		/* Address change required */
-		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
-					ap->ip_prefix, ap->own_ip,
-					broadcast_from_ip(ap->own_ip),
-					ap_ifaddr4_added_cb, ap, NULL);
-
-		if (!ap->rtnl_add_cmd) {
-			l_error("Failed to add IPv4 address");
-			err =3D -EIO;
-			goto cleanup;
-		}
-
-		ap->cleanup_ip =3D true;
-
-		*wait_dhcp =3D true;
-		err =3D 0;
-	/* Selected address already set, continue normally */
-	} else if (err =3D=3D -EALREADY) {
-		*wait_dhcp =3D false;
-		err =3D 0;
-	}
-
-cleanup:
-	l_settings_free(settings);
-	return err;
-}
-
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
@@ -2642,7 +2578,6 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 	int err =3D -EINVAL;
-	bool wait_on_address =3D false;
 =

 	if (err_out)
 		*err_out =3D err;
@@ -2650,7 +2585,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	if (L_WARN_ON(!config->ssid))
 		return NULL;
 =

-	if (L_WARN_ON(!config->profile && !config->passphrase[0] &&
+	if (L_WARN_ON(!config->passphrase[0] &&
 			util_mem_is_zero(config->psk, sizeof(config->psk))))
 		return NULL;
 =

@@ -2661,16 +2596,6 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 	ap->ops =3D ops;
 	ap->user_data =3D user_data;
 =

-	/*
-	 * This both loads a profile if required and loads DHCP settings either
-	 * by the profile itself or the IP pool (or does nothing in the case
-	 * of a profile-less configuration). wait_on_address will be set true
-	 * if an address change is required.
-	 */
-	err =3D ap_load_profile_and_dhcp(ap, &wait_on_address);
-	if (err < 0)
-		goto error;
-
 	if (!config->channel)
 		/* TODO: Start a Get Survey to decide the channel */
 		config->channel =3D 6;
@@ -2752,13 +2677,6 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 	if (!ap->mlme_watch)
 		l_error("Registering for MLME notification failed");
 =

-	if (wait_on_address) {
-		if (err_out)
-			*err_out =3D 0;
-
-		return ap;
-	}
-
 	cmd =3D ap_build_cmd_start_ap(ap);
 	if (!cmd)
 		goto error;
@@ -3113,10 +3031,9 @@ static struct l_dbus_message *ap_dbus_start_profile(=
struct l_dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "s", &ssid))
 		return dbus_error_invalid_args(message);
 =

-	config =3D l_new(struct ap_config, 1);
-	config->ssid =3D l_strdup(ssid);
-	/* This tells ap_start to pull settings from a profile on disk */
-	config->profile =3D storage_get_path("ap/%s.ap", ssid);
+	config =3D ap_config_load_profile(ssid);
+	if (!config)
+		return dbus_error_invalid_format(message);
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
 	if (!ap_if->ap)
diff --git a/src/ap.h b/src/ap.h
index dc57a0bb..cad00846 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -64,7 +64,14 @@ struct ap_config {
 	char *wsc_name;
 	struct wsc_primary_device_type wsc_primary_device_type;
 =

-	char *profile;
+	bool disable_netconfig4;
+	char **addr4_str_list;
+	char **dns_addr4_str_list;
+	uint8_t prefix_len4;
+	uint32_t dhcp_start_addr4;
+	uint32_t dhcp_end_addr4;
+	uint32_t dhcp_gateway_addr4;
+	unsigned int dhcp_lease_time;
 =

 	bool no_cck_rates : 1;
 };
@@ -74,6 +81,7 @@ struct ap_ops {
 				void *user_data);
 };
 =

+struct ap_config *ap_config_load_profile(const char *ssid);
 void ap_config_free(struct ap_config *config);
 =

 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
-- =

2.27.0

--===============8347519175826509342==--

