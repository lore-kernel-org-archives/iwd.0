Content-Type: multipart/mixed; boundary="===============4221497267129621126=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] ap: Drop struct ap_config in favor of l_settings
Date: Mon, 26 Apr 2021 15:26:36 +0200
Message-ID: <20210426132638.758600-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210426132638.758600-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4221497267129621126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change ap_start to load all of the AP configuration from a struct
l_settings, moving the 6 or so parameters from struct ap_config members
to the l_settings groups and keys.  This extends the ap profile concept
used for the DHCP settings.  ap_start callers create the l_settings
object and fill the values in it or read the settings in from a file.

Since ap_setup_dhcp and ap_load_profile_and_dhcp no longer do the
settings file loading, they needed to be refactored and some issues were
fixed in their logic, e.g. l_dhcp_server_set_ip_address() was never
called when the "IP pool" was used.  Also the IP pool was previously only
used if the ap->config->profile was NULL and this didn't match what the
docs said:
"If [IPv4].Address is not provided and no IP address is set on the
interface prior to calling StartProfile the IP pool will be used."
---
 src/ap.c  | 542 ++++++++++++++++++++++++++++++++----------------------
 src/ap.h  |  19 +-
 src/p2p.c |  53 ++++--
 3 files changed, 354 insertions(+), 260 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 46821c04..d8b2a441 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -61,7 +61,15 @@ struct ap_state {
 	const struct ap_ops *ops;
 	ap_stopped_func_t stopped_func;
 	void *user_data;
-	struct ap_config *config;
+
+	char ssid[33];
+	char passphrase[64];
+	uint8_t psk[32];
+	uint8_t channel;
+	uint8_t *authorized_macs;
+	unsigned int authorized_macs_num;
+	char wsc_name[33];
+	struct wsc_primary_device_type wsc_primary_device_type;
 =

 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
@@ -228,24 +236,6 @@ static const char *broadcast_from_ip(const char *ip)
 	return inet_ntoa(ia);
 }
 =

-void ap_config_free(struct ap_config *config)
-{
-	if (unlikely(!config))
-		return;
-
-	l_free(config->ssid);
-
-	explicit_bzero(config->passphrase, sizeof(config->passphrase));
-	explicit_bzero(config->psk, sizeof(config->psk));
-	l_free(config->authorized_macs);
-	l_free(config->wsc_name);
-
-	if (config->profile)
-		l_free(config->profile);
-
-	l_free(config);
-}
-
 static void ap_stop_handshake(struct sta_state *sta)
 {
 	if (sta->sm) {
@@ -301,6 +291,14 @@ static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
 =

+	explicit_bzero(ap->passphrase, sizeof(ap->passphrase));
+	explicit_bzero(ap->psk, sizeof(ap->psk));
+
+	if (ap->authorized_macs_num) {
+		l_free(ap->authorized_macs);
+		ap->authorized_macs_num =3D 0;
+	}
+
 	if (ap->mlme_watch)
 		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
 =

@@ -317,9 +315,6 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

-	ap_config_free(ap->config);
-	ap->config =3D NULL;
-
 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
 =

 	ap->started =3D false;
@@ -666,25 +661,23 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 =

 		wsc_pr.response_type =3D WSC_RESPONSE_TYPE_AP;
 		memcpy(wsc_pr.uuid_e, ap->wsc_uuid_r, sizeof(wsc_pr.uuid_e));
-		wsc_pr.primary_device_type =3D
-			ap->config->wsc_primary_device_type;
+		wsc_pr.primary_device_type =3D ap->wsc_primary_device_type;
 =

-		if (ap->config->wsc_name)
-			l_strlcpy(wsc_pr.device_name, ap->config->wsc_name,
+		if (ap->wsc_name)
+			l_strlcpy(wsc_pr.device_name, ap->wsc_name,
 					sizeof(wsc_pr.device_name));
 =

 		wsc_pr.config_methods =3D
 			WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
 =

-		if (ap->config->authorized_macs_num) {
-			size_t len;
+		if (ap->authorized_macs_num) {
+			size_t len =3D ap->authorized_macs_num * 6;
 =

-			len =3D ap->config->authorized_macs_num * 6;
 			if (len > sizeof(wsc_pr.authorized_macs))
 				len =3D sizeof(wsc_pr.authorized_macs);
 =

 			memcpy(wsc_pr.authorized_macs,
-				ap->config->authorized_macs, len);
+				ap->authorized_macs, len);
 		}
 =

 		wsc_data =3D wsc_build_probe_response(&wsc_pr, &wsc_data_size);
@@ -701,15 +694,14 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
 		}
 =

-		if (ap->config->authorized_macs_num) {
-			size_t len;
+		if (ap->authorized_macs_num) {
+			size_t len =3D ap->authorized_macs_num * 6;
 =

-			len =3D ap->config->authorized_macs_num * 6;
 			if (len > sizeof(wsc_beacon.authorized_macs))
 				len =3D sizeof(wsc_beacon.authorized_macs);
 =

 			memcpy(wsc_beacon.authorized_macs,
-				ap->config->authorized_macs, len);
+				ap->authorized_macs, len);
 		}
 =

 		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);
@@ -831,8 +823,7 @@ static size_t ap_build_beacon_pr_head(struct ap_state *=
ap,
 =

 	/* SSID IE */
 	ie_tlv_builder_next(&builder, IE_TYPE_SSID);
-	ie_tlv_builder_set_data(&builder, ap->config->ssid,
-				strlen(ap->config->ssid));
+	ie_tlv_builder_set_data(&builder, ap->ssid, strlen(ap->ssid));
 =

 	/* Supported Rates IE */
 	ie_tlv_builder_next(&builder, IE_TYPE_SUPPORTED_RATES);
@@ -857,7 +848,7 @@ static size_t ap_build_beacon_pr_head(struct ap_state *=
ap,
 =

 	/* DSSS Parameter Set IE for DSSS, HR, ERP and HT PHY rates */
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
-	ie_tlv_builder_set_data(&builder, &ap->config->channel, 1);
+	ie_tlv_builder_set_data(&builder, &ap->channel, 1);
 =

 	ie_tlv_builder_finalize(&builder, &len);
 	return 36 + len;
@@ -938,8 +929,7 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					frame_xchg_cb_t callback,
 					void *user_data)
 {
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
-						SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
 	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
 	struct iovec iov[2];
 =

@@ -958,8 +948,7 @@ static void ap_start_handshake(struct sta_state *sta, b=
ool use_eapol_start,
 	struct ie_rsn_info rsn;
 	uint8_t bss_rsne[64];
 =

-	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
-					strlen(ap->config->ssid));
+	handshake_state_set_ssid(sta->hs, (void *) ap->ssid, strlen(ap->ssid));
 	handshake_state_set_authenticator_address(sta->hs, own_addr);
 	handshake_state_set_supplicant_address(sta->hs, sta->addr);
 =

@@ -1026,7 +1015,7 @@ static void ap_start_rsna(struct sta_state *sta, cons=
t uint8_t *gtk_rsc)
 	handshake_state_set_authenticator(sta->hs, true);
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, sta->ap->config->psk, 32);
+	handshake_state_set_pmk(sta->hs, sta->ap->psk, 32);
 	ap_start_handshake(sta, false, gtk_rsc);
 }
 =

@@ -1144,16 +1133,15 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 				WSC_RF_BAND_2_4_GHZ);
 	l_settings_set_uint(sta->wsc_settings, "WSC", "ConfigurationMethods",
 				WSC_CONFIGURATION_METHOD_PUSH_BUTTON);
-	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID",
-				ap->config->ssid);
+	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID", ap->ssid);
 =

-	if (ap->config->passphrase[0])
+	if (ap->passphrase[0])
 		l_settings_set_string(sta->wsc_settings,
 					"WSC", "WPA2-Passphrase",
-					ap->config->passphrase);
+					ap->passphrase);
 	else
 		l_settings_set_bytes(sta->wsc_settings,
-					"WSC", "WPA2-PSK", ap->config->psk, 32);
+					"WSC", "WPA2-PSK", ap->psk, 32);
 =

 	sta->hs =3D netdev_handshake_state_new(ap->netdev);
 	handshake_state_set_authenticator(sta->hs, true);
@@ -1611,8 +1599,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		}
 =

 	if (!rates || !ssid || (!wsc_data && !rsn) ||
-			ssid_len !=3D strlen(ap->config->ssid) ||
-			memcmp(ssid, ap->config->ssid, ssid_len)) {
+			ssid_len !=3D strlen(ap->ssid) ||
+			memcmp(ssid, ap->ssid, ssid_len)) {
 		err =3D MMPDU_REASON_CODE_INVALID_IE;
 		goto bad_frame;
 	}
@@ -1922,11 +1910,11 @@ static void ap_probe_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 =

 	if (!ssid || ssid_len =3D=3D 0) /* Wildcard SSID */
 		match =3D true;
-	else if (ssid && ssid_len =3D=3D strlen(ap->config->ssid) && /* One SSID =
*/
-			!memcmp(ssid, ap->config->ssid, ssid_len))
+	else if (ssid && ssid_len =3D=3D strlen(ap->ssid) && /* One SSID */
+			!memcmp(ssid, ap->ssid, ssid_len))
 		match =3D true;
 	else if (ssid && ssid_len =3D=3D 7 && !memcmp(ssid, "DIRECT-", 7) &&
-			!memcmp(ssid, ap->config->ssid, 7)) /* P2P wildcard */
+			!memcmp(ssid, ap->ssid, 7)) /* P2P wildcard */
 		match =3D true;
 	else if (ssid_list) { /* SSID List */
 		ie_tlv_iter_init(&iter, ssid_list, ssid_list_len);
@@ -1938,16 +1926,15 @@ static void ap_probe_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 			ssid =3D (const char *) ie_tlv_iter_get_data(&iter);
 			ssid_len =3D ie_tlv_iter_get_length(&iter);
 =

-			if (ssid_len =3D=3D strlen(ap->config->ssid) &&
-					!memcmp(ssid, ap->config->ssid,
-						ssid_len)) {
+			if (ssid_len =3D=3D strlen(ap->ssid) &&
+					!memcmp(ssid, ap->ssid, ssid_len)) {
 				match =3D true;
 				break;
 			}
 		}
 	}
 =

-	if (dsss_channel !=3D 0 && dsss_channel !=3D ap->config->channel)
+	if (dsss_channel !=3D 0 && dsss_channel !=3D ap->channel)
 		match =3D false;
 =

 	if (!match)
@@ -2053,15 +2040,15 @@ static void ap_auth_cb(const struct mmpdu_header *h=
dr, const void *body,
 			memcmp(hdr->address_3, bssid, 6))
 		return;
 =

-	if (ap->config->authorized_macs_num) {
+	if (ap->authorized_macs_num) {
 		unsigned int i;
 =

-		for (i =3D 0; i < ap->config->authorized_macs_num; i++)
-			if (!memcmp(from, ap->config->authorized_macs + i * 6,
+		for (i =3D 0; i < ap->authorized_macs_num; i++)
+			if (!memcmp(from, ap->authorized_macs + i * 6,
 					6))
 				break;
 =

-		if (i =3D=3D ap->config->authorized_macs_num) {
+		if (i =3D=3D ap->authorized_macs_num) {
 			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
 			return;
 		}
@@ -2210,8 +2197,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
 	uint32_t wpa_version =3D NL80211_WPA_VERSION_2;
 	uint32_t auth_type =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->config->channel,
-						SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
 	uint32_t ch_width =3D NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 =

@@ -2233,7 +2219,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 		return NULL;
 =

 	cmd =3D l_genl_msg_new_sized(NL80211_CMD_START_AP, 256 + head_len +
-					tail_len + strlen(ap->config->ssid));
+					tail_len + strlen(ap->ssid));
 =

 	/* SET_BEACON attrs */
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_BEACON_HEAD, head_len, head);
@@ -2247,8 +2233,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 				&ap->beacon_interval);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_DTIM_PERIOD, 4, &dtim_period);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_IFINDEX, 4, &ifindex);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID, strlen(ap->config->ssid),
-				ap->config->ssid);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID, strlen(ap->ssid),
+				ap->ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_HIDDEN_SSID, 4,
 				&hidden_ssid);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
@@ -2493,7 +2479,8 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
 	}
 }
 =

-static bool dhcp_load_settings(struct ap_state *ap, struct l_settings *set=
tings)
+static bool dhcp_load_settings(struct ap_state *ap,
+				const struct l_settings *settings)
 {
 	struct l_dhcp_server *server =3D ap->server;
 	struct in_addr ia;
@@ -2568,77 +2555,41 @@ error:
  * 3. Address in IP pool.
  *
  * Returns:  0 if an IP was successfully selected and needs to be set
- *          -EALREADY if an IP was already set on the interface
+ *          -EALREADY if an IP was already set on the interface or
+ *            IP configuration was not enabled,
  *          -EEXIST if the IP pool ran out of IP's
  *          -EINVAL if there was an error.
  */
-static int ap_setup_dhcp(struct ap_state *ap, struct l_settings *settings)
+static int ap_setup_dhcp(struct ap_state *ap, const struct l_settings *set=
tings)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	struct in_addr ia;
 	uint32_t address =3D 0;
+	L_AUTO_FREE_VAR(char *, addr) =3D NULL;
 	int ret =3D -EINVAL;
 =

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
 	/* get the current address if there is one */
 	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
 		address =3D ia.s_addr;
 =

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
+	addr =3D l_settings_get_string(settings, "IPv4", "Address");
+	if (addr) {
+		if (inet_pton(AF_INET, addr, &ia) < 0)
+			return -EINVAL;
 =

-		return ret;
+		/* Is a matching address already set on interface? */
+		if (ia.s_addr =3D=3D address)
+			ret =3D -EALREADY;
+		else
+			ret =3D 0;
 	} else if (address) {
-		/* No config file and address is already set */
-		ap->own_ip =3D l_strdup(inet_ntoa(ia));
-
-		return -EALREADY;
+		/* No address in config, but interface has one set */
+		addr =3D l_strdup(inet_ntoa(ia));
+		ret =3D -EALREADY;
 	} else if (pool.used) {
 		/* No config file, no address set. Use IP pool */
-		ap->own_ip =3D ip_pool_get();
-		if (!ap->own_ip) {
+		addr =3D ip_pool_get();
+		if (!addr) {
 			l_error("No more IP's in pool, cannot start AP on %u",
 					ifindex);
 			return -EEXIST;
@@ -2646,52 +2597,41 @@ free_addr:
 =

 		ap->use_ip_pool =3D true;
 		ap->ip_prefix =3D pool.prefix;
+		ret =3D 0;
+	} else
+		return -EALREADY;
 =

-		return 0;
+	ap->server =3D l_dhcp_server_new(ifindex);
+	if (!ap->server) {
+		l_error("Failed to create DHCP server on %u", ifindex);
+		return -EINVAL;
 	}
 =

-	return -EINVAL;
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(ap->server, do_debug,
+							"[DHCPv4 SERV] ", NULL);
+
+	/* Set the remaining DHCP options in config file */
+	if (!dhcp_load_settings(ap, settings))
+		return -EINVAL;
+
+	if (!l_dhcp_server_set_ip_address(ap->server, addr))
+		return -EINVAL;
+
+	ap->own_ip =3D l_steal_ptr(addr);
+	return ret;
 }
 =

-static int ap_load_profile_and_dhcp(struct ap_state *ap, bool *wait_dhcp)
+static int ap_load_dhcp(struct ap_state *ap, const struct l_settings *conf=
ig,
+			bool *wait_dhcp)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	char *passphrase;
-	struct l_settings *settings =3D NULL;
 	int err =3D -EINVAL;
 =

-	/* No profile or DHCP settings */
-	if (!ap->config->profile && !pool.used)
+	if (!l_settings_has_group(config, "IPv4"))
 		return 0;
 =

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
+	err =3D ap_setup_dhcp(ap, config);
 	if (err =3D=3D 0) {
 		/* Address change required */
 		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
@@ -2701,8 +2641,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 =

 		if (!ap->rtnl_add_cmd) {
 			l_error("Failed to add IPv4 address");
-			err =3D -EIO;
-			goto cleanup;
+			return -EIO;
 		}
 =

 		ap->cleanup_ip =3D true;
@@ -2715,24 +2654,196 @@ static int ap_load_profile_and_dhcp(struct ap_stat=
e *ap, bool *wait_dhcp)
 		err =3D 0;
 	}
 =

-cleanup:
-	l_settings_free(settings);
 	return err;
 }
 =

+static bool ap_load_psk(struct ap_state *ap, const struct l_settings *conf=
ig)
+{
+	size_t psk_len;
+	L_AUTO_FREE_VAR(uint8_t *, psk) =3D l_settings_get_bytes(config,
+								"Security",
+								"PreSharedKey",
+								&psk_len);
+	L_AUTO_FREE_VAR(char *, passphrase) =3D l_settings_get_string(config,
+								"Security",
+								"Passphrase");
+	int err;
+
+	if (l_settings_get_value(config, "Security", "PreSharedKey")) {
+		if (!psk || psk_len !=3D 32) {
+			l_error("AP [Security].PreSharedKey must be a 32-byte "
+				"hexstring");
+			return false;
+		}
+
+		memcpy(ap->psk, psk, 32);
+		return true;
+	}
+
+	if (!passphrase) {
+		l_error("AP requires one of [Security].PreSharedKey or "
+			"[Security].Passphrase to be present");
+		return false;
+	}
+
+	if (strlen(passphrase) > 63) {
+		l_error("AP [Security].Passphrase must not exceed "
+			"63 characters");
+		return false;
+	}
+
+	err =3D crypto_psk_from_passphrase(passphrase, (uint8_t *) ap->ssid,
+						strlen(ap->ssid), ap->psk);
+	if (err < 0) {
+		l_error("AP couldn't generate the PSK from given "
+			"[Security].Passphrase value: %s (%i)",
+			strerror(-err), -err);
+		return false;
+	}
+
+	strcpy(ap->passphrase, passphrase);
+	return true;
+}
+
+static int ap_load_config(struct ap_state *ap, const struct l_settings *co=
nfig,
+				bool *out_wait_dhcp, bool *out_cck_rates)
+{
+	size_t len;
+	L_AUTO_FREE_VAR(char *, strval) =3D NULL;
+	int err;
+
+	strval =3D l_settings_get_string(config, "General", "SSID");
+	if (L_WARN_ON(!strval))
+		return -ENOMSG;
+
+	len =3D strlen(strval);
+	if (len < 1 || len > 32) {
+		l_error("AP SSID length outside the [1, 32] range");
+		return -EINVAL;
+	}
+
+	if (L_WARN_ON(!l_utf8_validate(strval, len, NULL)))
+		return -EINVAL;
+
+	strcpy(ap->ssid, strval);
+	l_free(l_steal_ptr(strval));
+
+	if (!ap_load_psk(ap, config))
+		return -EINVAL;
+
+	/*
+	 * This loads DHCP settings either from the l_settings object or uses
+	 * the defaults. wait_on_address will be set true if an address change
+	 * is required.
+	 */
+	err =3D ap_load_dhcp(ap, config, out_wait_dhcp);
+	if (err)
+		return err;
+
+	if (l_settings_get_value(config, "General", "Channel")) {
+		unsigned int uintval;
+
+		if (!l_settings_get_uint(config, "General", "Channel",
+						&uintval) ||
+				!scan_channel_to_freq(uintval,
+							SCAN_BAND_2_4_GHZ)) {
+			l_error("AP Channel value unsupported");
+			return -EINVAL;
+		}
+
+		ap->channel =3D uintval;
+	} else
+		/* TODO: Start a Get Survey to decide the channel */
+		ap->channel =3D 6;
+
+	strval =3D l_settings_get_string(config, "WSC", "DeviceName");
+	if (strval) {
+		len =3D strlen(strval);
+
+		if (len > 32) {
+			l_error("AP WSC name length outside the [1, 32] range");
+			return -EINVAL;
+		}
+
+		if (L_WARN_ON(!l_utf8_validate(strval, len, NULL)))
+			return -EINVAL;
+
+		strcpy(ap->wsc_name, strval);
+		l_free(l_steal_ptr(strval));
+	} else
+		memcpy(ap->wsc_name, ap->ssid, 33);
+
+	strval =3D l_settings_get_string(config, "WSC", "PrimaryDeviceType");
+	if (strval) {
+		bool ok =3D wsc_device_type_from_setting_str(strval,
+						&ap->wsc_primary_device_type);
+
+		if (!ok) {
+			l_error("AP [WSC].PrimaryDeviceType format unknown");
+			return -EINVAL;
+		}
+	} else {
+		/* Make ourselves a WFA standard PC by default */
+		ap->wsc_primary_device_type.category =3D 1;
+		memcpy(ap->wsc_primary_device_type.oui, wsc_wfa_oui, 3);
+		ap->wsc_primary_device_type.oui_type =3D 0x04;
+		ap->wsc_primary_device_type.subcategory =3D 1;
+	}
+
+	if (l_settings_get_value(config, "WSC", "AuthorizedMACs")) {
+		char **strvval;
+		unsigned int i;
+
+		strvval =3D l_settings_get_string_list(config, "WSC",
+							"AuthorizedMACs", ',');
+		if (!strvval) {
+			l_error("AP Authorized MACs list format wrong");
+			return -EINVAL;
+		}
+
+		ap->authorized_macs_num =3D l_strv_length(strvval);
+		ap->authorized_macs =3D l_malloc(ap->authorized_macs_num * 6);
+
+		for (i =3D 0; strvval[i]; i++)
+			if (!util_string_to_address(strvval[i],
+						ap->authorized_macs + i * 6)) {
+				l_error("Bad authorized MAC format: %s",
+					strvval[i]);
+				l_strfreev(strvval);
+				return -EINVAL;
+			}
+
+		l_strfreev(strvval);
+	}
+
+	if (l_settings_get_value(config, "General", "NoCCKRates")) {
+		bool boolval;
+
+		if (!l_settings_get_bool(config, "General", "NoCCKRates",
+						&boolval)) {
+			l_error("AP [General].NoCCKRates not a valid "
+				"boolean");
+			return -EINVAL;
+		}
+
+		*out_cck_rates =3D !boolval;
+	} else
+		*out_cck_rates =3D true;
+
+	return 0;
+}
+
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
  * @ops.handle_event is required and must react to AP_EVENT_START_FAILED
  * and AP_EVENT_STOPPING by forgetting the ap_state struct, which is
  * going to be freed automatically.
- * In the @config struct the .ssid field is required and one of
- * .passphrase and .psk must be filled in.  All other fields are optional.
- * If @ap_start succeeds, the returned ap_state takes ownership of
- * @config and the caller shouldn't free it or any of the memory pointed
- * to by its members (which also can't be static).
+ * In the @config struct the [General].SSID key is required and one of
+ * [Security].Passphrase and [Security].PreSharedKey must be filled in.
+ * All other fields are optional.
  */
-struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
+struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 				const struct ap_ops *ops, int *err_out,
 				void *user_data)
 {
@@ -2742,57 +2853,37 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct ap_config *config,
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 	int err =3D -EINVAL;
 	bool wait_on_address =3D false;
+	bool cck_rates =3D true;
 =

 	if (err_out)
 		*err_out =3D err;
 =

-	if (L_WARN_ON(!config->ssid))
-		return NULL;
-
-	if (L_WARN_ON(!config->profile && !config->passphrase[0] &&
-			l_memeqzero(config->psk, sizeof(config->psk))))
+	if (L_WARN_ON(!config))
 		return NULL;
 =

 	ap =3D l_new(struct ap_state, 1);
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
-	ap->config =3D config;
 	ap->netdev =3D netdev;
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
+	err =3D ap_load_config(ap, config, &wait_on_address, &cck_rates);
+	if (err)
 		goto error;
 =

-	if (!config->channel)
-		/* TODO: Start a Get Survey to decide the channel */
-		config->channel =3D 6;
-
-	if (!config->wsc_name)
-		config->wsc_name =3D l_strdup(config->ssid);
-
-	if (!config->wsc_primary_device_type.category) {
-		/* Make ourselves a WFA standard PC by default */
-		config->wsc_primary_device_type.category =3D 1;
-		memcpy(config->wsc_primary_device_type.oui, wsc_wfa_oui, 3);
-		config->wsc_primary_device_type.oui_type =3D 0x04;
-		config->wsc_primary_device_type.subcategory =3D 1;
-	}
+	err =3D -EINVAL;
 =

 	/* TODO: Add all ciphers supported by wiphy */
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval =3D 100;
+
+	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
+
 	ap->rates =3D l_uintset_new(200);
 =

 	/* TODO: Pick from actual supported rates */
-	if (config->no_cck_rates) {
+	if (!cck_rates) {
 		l_uintset_put(ap->rates, 12); /* 6 Mbps*/
 		l_uintset_put(ap->rates, 18); /* 9 Mbps*/
 		l_uintset_put(ap->rates, 24); /* 12 Mbps*/
@@ -2807,15 +2898,6 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
 	}
 =

-	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
-
-	if (config->passphrase[0] &&
-			crypto_psk_from_passphrase(config->passphrase,
-						(uint8_t *) config->ssid,
-						strlen(config->ssid),
-						config->psk) < 0)
-		goto error;
-
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST << 4),
 			NULL, 0, ap_assoc_req_cb, ap, NULL))
@@ -2878,7 +2960,6 @@ error:
 	if (err_out)
 		*err_out =3D err;
 =

-	ap->config =3D NULL;
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
 	l_free(ap);
@@ -3128,7 +3209,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 {
 	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid, *wpa2_passphrase;
-	struct ap_config *config;
+	struct l_settings *config;
 	int err;
 =

 	if (ap_if->ap && ap_if->ap->started)
@@ -3141,16 +3222,17 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
 						&ssid, &wpa2_passphrase))
 		return dbus_error_invalid_args(message);
 =

-	config =3D l_new(struct ap_config, 1);
-	config->ssid =3D l_strdup(ssid);
-	l_strlcpy(config->passphrase, wpa2_passphrase,
-			sizeof(config->passphrase));
+	config =3D l_settings_new();
+	l_settings_set_string(config, "General", "SSID", ssid);
+	l_settings_set_string(config, "Security", "Passphrase",
+				wpa2_passphrase);
+	l_settings_add_group(config, "IPv4");
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
-	if (!ap_if->ap) {
-		ap_config_free(config);
+	l_settings_free(config);
+
+	if (!ap_if->ap)
 		return dbus_error_from_errno(err, message);
-	}
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
@@ -3200,7 +3282,8 @@ static struct l_dbus_message *ap_dbus_start_profile(s=
truct l_dbus *dbus,
 {
 	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid;
-	struct ap_config *config;
+	struct l_settings *config;
+	char *config_path;
 	int err;
 =

 	if (ap_if->ap && ap_if->ap->started)
@@ -3212,19 +3295,32 @@ static struct l_dbus_message *ap_dbus_start_profile=
(struct l_dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "s", &ssid))
 		return dbus_error_invalid_args(message);
 =

-	config =3D l_new(struct ap_config, 1);
-	config->ssid =3D l_strdup(ssid);
-	/* This tells ap_start to pull settings from a profile on disk */
-	config->profile =3D storage_get_path("ap/%s.ap", ssid);
+	config =3D l_settings_new();
+	config_path =3D storage_get_path("ap/%s.ap", ssid);
+	err =3D l_settings_load_from_file(config, config_path) ? 0 : -EIO;
+	l_free(config_path);
+
+	if (err)
+		goto error;
+
+	/*
+	 * Since [General].SSID is not an allowed setting for a profile on
+	 * disk, we're free to potentially overwrite it with the SSID that
+	 * the DBus user asked for.
+	 */
+	l_settings_set_string(config, "General", "SSID", ssid);
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
-	if (!ap_if->ap) {
-		ap_config_free(config);
-		return dbus_error_from_errno(err, message);
-	}
+	l_settings_free(config);
+
+	if (!ap_if->ap)
+		goto error;
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
+
+error:
+	return dbus_error_from_errno(err, message);
 }
 =

 static bool ap_dbus_property_get_started(struct l_dbus *dbus,
@@ -3247,11 +3343,11 @@ static bool ap_dbus_property_get_name(struct l_dbus=
 *dbus,
 {
 	struct ap_if_data *ap_if =3D user_data;
 =

-	if (!ap_if->ap || !ap_if->ap->config || !ap_if->ap->started)
+	if (!ap_if->ap || !ap_if->ap->started)
 		return false;
 =

 	l_dbus_message_builder_append_basic(builder, 's',
-						ap_if->ap->config->ssid);
+						ap_if->ap->ssid);
 =

 	return true;
 }
diff --git a/src/ap.h b/src/ap.h
index 729a6648..b0100f34 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -58,21 +58,6 @@ struct ap_event_registration_success_data {
 =

 typedef void (*ap_stopped_func_t)(void *user_data);
 =

-struct ap_config {
-	char *ssid;
-	char passphrase[64];
-	uint8_t psk[32];
-	uint8_t channel;
-	uint8_t *authorized_macs;
-	unsigned int authorized_macs_num;
-	char *wsc_name;
-	struct wsc_primary_device_type wsc_primary_device_type;
-
-	char *profile;
-
-	bool no_cck_rates : 1;
-};
-
 struct ap_ops {
 	void (*handle_event)(enum ap_event_type type, const void *event_data,
 				void *user_data);
@@ -100,9 +85,7 @@ struct ap_ops {
 					uint8_t *out_buf, void *user_data);
 };
 =

-void ap_config_free(struct ap_config *config);
-
-struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
+struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 				const struct ap_ops *ops, int *err,
 				void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
diff --git a/src/p2p.c b/src/p2p.c
index 89d8c4ac..580eb53f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1187,13 +1187,32 @@ static const struct ap_ops p2p_go_ops =3D {
 =

 static void p2p_group_start(struct p2p_device *dev)
 {
-	struct ap_config *config =3D l_new(struct ap_config, 1);
-
-	config->ssid =3D l_strdup(dev->go_group_id.ssid);
-	config->channel =3D dev->listen_channel;
-	config->wsc_name =3D l_strdup(dev->device_info.device_name);
-	config->wsc_primary_device_type =3D dev->device_info.primary_device_type;
-	config->no_cck_rates =3D true;
+	struct l_settings *config =3D l_settings_new();
+	uint8_t psk[32];
+	char *macs[2] =3D {};
+	const struct wsc_primary_device_type *pdt =3D
+		&dev->device_info.primary_device_type;
+	uint64_t pdt_uint =3D
+		((uint64_t) pdt->category << 48) |
+		((uint64_t) pdt->oui[0] << 40) |
+		((uint64_t) pdt->oui[1] << 32) |
+		((uint64_t) pdt->oui[2] << 24) |
+		((uint64_t) pdt->oui_type << 16) |
+		pdt->subcategory;
+
+	l_settings_set_string(config, "General", "SSID", dev->go_group_id.ssid);
+	l_settings_set_uint(config, "General", "Channel", dev->listen_channel);
+	l_settings_set_bool(config, "General", "NoCCKRates", true);
+	l_settings_set_string(config, "WSC", "DeviceName",
+				dev->device_info.device_name);
+	l_settings_set_uint64(config, "WSC", "PrimaryDeviceType", pdt_uint);
+	/*
+	 * Section 3.1.4.4: "It shall only allow association by the
+	 * P2P Device that it is currently in Group Formation with."
+	 */
+	macs[0] =3D (char *) util_address_to_string(
+						dev->conn_peer_interface_addr);
+	l_settings_set_string_list(config, "WSC", "AuthorizedMACs", macs, ',');
 =

 	/*
 	 * Section 3.2.1: "The Credentials for a P2P Group issued to a
@@ -1207,29 +1226,25 @@ static void p2p_group_start(struct p2p_device *dev)
 	 * it's a little costlier to generate for the same cryptographic
 	 * strength as the PSK.
 	 */
-	if (!l_getrandom(config->psk, 32)) {
+	if (!l_getrandom(psk, 32)) {
 		l_error("l_getrandom() failed");
-		ap_config_free(config);
+		l_settings_free(config);
 		p2p_connect_failed(dev);
 		return;
 	}
 =

-	/*
-	 * Section 3.1.4.4: "It shall only allow association by the
-	 * P2P Device that it is currently in Group Formation with."
-	 */
-	config->authorized_macs =3D l_memdup(dev->conn_peer_interface_addr, 6);
-	config->authorized_macs_num =3D 1;
+	l_settings_set_bytes(config, "Security", "PreSharedKey", psk, 32);
+
+	l_settings_add_group(config, "IPv4");
 =

 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GROUP_FORMATION;
 =

 	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, NULL, dev);
-	if (!dev->group) {
-		ap_config_free(config);
+	l_settings_free(config);
+
+	if (!dev->group)
 		p2p_connect_failed(dev);
-		return;
-	}
 }
 =

 static void p2p_netconfig_event_handler(enum netconfig_event event,
-- =

2.27.0

--===============4221497267129621126==--

