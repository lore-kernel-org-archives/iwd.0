Content-Type: multipart/mixed; boundary="===============2131859861069267515=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/13] ap: add support for DHCPv4 server
Date: Tue, 20 Oct 2020 13:28:45 -0500
Message-ID: <205ed45c-de0a-bb33-c5ae-a9630bfd1257@gmail.com>
In-Reply-To: <20201020180256.1630120-12-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2131859861069267515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/20/20 1:02 PM, James Prestwood wrote:
> The DHCP server can be enabled by including an [IPv4] group
> in the AP provisioning file and including at least a subnet
> mask.

Any chance we can add this code to the current implementation without chang=
ing =

the API just yet?  I think it is safe to assume that if the address is set =
prior =

to AP starting on a given interface, then we should not start our own DHCP,=
 and =

if the address isn't set, then start DHCP server.  If the address is provid=
ed by =

provisioning, then start our own DHCP as well, overriding whatever we picke=
d.

> ---
>   src/ap.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>   src/ap.h |   8 +++++
>   2 files changed, 110 insertions(+), 6 deletions(-)
> =

> diff --git a/src/ap.c b/src/ap.c
> index 41de69a9..e9f79e5a 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -76,6 +76,8 @@ struct ap_state {
>   	uint16_t last_aid;
>   	struct l_queue *sta_states;
>   =

> +	struct l_dhcp_server *server;
> +
>   	bool started : 1;
>   	bool gtk_set : 1;
>   };
> @@ -120,6 +122,13 @@ void ap_config_free(struct ap_config *config)
>   	explicit_bzero(config->psk, sizeof(config->psk));
>   	l_free(config->authorized_macs);
>   	l_free(config->wsc_name);
> +
> +	l_free(config->address);
> +	l_free(config->gateway);
> +	l_free(config->netmask);
> +	l_strv_free(config->dns_list);
> +	l_strv_free(config->ip_range);
> +
>   	l_free(config);
>   }
>   =

> @@ -198,6 +207,9 @@ static void ap_reset(struct ap_state *ap)
>   	l_queue_destroy(ap->wsc_pbc_probes, l_free);
>   =

>   	ap->started =3D false;
> +
> +	if (ap->server)
> +		l_dhcp_server_stop(ap->server);
>   }
>   =

>   static void ap_del_station(struct sta_state *sta, uint16_t reason,
> @@ -1906,6 +1918,55 @@ static void ap_deauth_cb(const struct mmpdu_header=
 *hdr, const void *body,
>   	ap_sta_free(sta);
>   }
>   =

> +static bool ap_start_dhcp(struct ap_state *ap)
> +{
> +	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> +
> +	/*
> +	 * [IPv4].Netmask is the only required property since .Address and
> +	 * .Gateway may inherit from the interfaces IP that was already set.
> +	 * If this is not found we assume DHCP is not being used.

Netmask is also inherited actually.  Its the prefix len...

denkenz(a)localhost ~/iwd-master $ ip addr
...
inet 192.168.1.249/24 brd 192.168.1.255 scope global dynamic noprefixroute
...

/24 =3D 255.255.255.0

> +	 */
> +	if (!ap->config->netmask)
> +		return true;
> +
> +	ap->server =3D l_dhcp_server_new(ifindex);
> +	if (!ap->server) {
> +		l_error("Failed to create DHCP server on %u", ifindex);
> +		return false;
> +	}
> +
> +	/* TODO: set address via rtnl */
> +	if (ap->config->address)
> +		if (!l_dhcp_server_set_ip_address(ap->server,
> +							ap->config->address))
> +			return false;
> +
> +	if (ap->config->gateway)
> +		if (!l_dhcp_server_set_gateway(ap->server, ap->config->gateway))
> +			return false;
> +
> +	if (ap->config->dns_list)
> +		if (!l_dhcp_server_set_dns(ap->server, ap->config->dns_list))
> +			return false;
> +
> +	if (ap->config->lease_time)
> +		if (!l_dhcp_server_set_lease_time(ap->server,
> +						ap->config->lease_time))
> +			return false;
> +
> +	if (ap->config->ip_range)
> +		if (!l_dhcp_server_set_ip_range(ap->server,
> +						ap->config->ip_range[0],
> +						ap->config->ip_range[1]))
> +			return false;
> +
> +	if (!l_dhcp_server_set_netmask(ap->server, ap->config->netmask))
> +		return false;
> +
> +	return l_dhcp_server_start(ap->server);
> +}
> +
>   static void ap_start_cb(struct l_genl_msg *msg, void *user_data)
>   {
>   	struct ap_state *ap =3D user_data;
> @@ -1915,16 +1976,24 @@ static void ap_start_cb(struct l_genl_msg *msg, v=
oid *user_data)
>   	if (l_genl_msg_get_error(msg) < 0) {
>   		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
>   =

> -		ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
> -					ap->user_data);
> -		ap_reset(ap);
> -		l_genl_family_free(ap->nl80211);
> -		l_free(ap);
> -		return;
> +		goto failed;
> +	}
> +
> +	if (!ap_start_dhcp(ap)) {
> +		l_error("DHCP server failed to start");
> +		goto failed;
>   	}
>   =

>   	ap->started =3D true;
>   	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
> +
> +	return;
> +
> +failed:
> +	ap->ops->handle_event(AP_EVENT_START_FAILED, NULL, ap->user_data);
> +	ap_reset(ap);
> +	l_genl_family_free(ap->nl80211);
> +	l_free(ap);
>   }
>   =

>   static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
> @@ -2563,6 +2632,33 @@ static struct ap_config *ap_config_from_settings(s=
truct l_settings *settings,
>   		l_free(passphrase);
>   	}
>   =

> +	if (!l_settings_has_group(settings, "IPv4"))
> +		goto done;
> +
> +	config->address =3D l_settings_get_string(settings, "IPv4", "Address");
> +	config->gateway =3D l_settings_get_string(settings, "IPv4", "Gateway");
> +	config->netmask =3D l_settings_get_string(settings, "IPv4", "Netmask");
> +	config->dns_list =3D l_settings_get_string_list(settings, "IPv4",
> +							"DNSList", ',');
> +	config->ip_range =3D l_settings_get_string_list(settings, "IPv4",
> +							"IPRange", ',');
> +
> +	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime",
> +					&config->lease_time))
> +		config->lease_time =3D 0;
> +
> +
> +	if (!config->netmask) {
> +		l_error("[IPv4].Netmask is a required value for DHCP");
> +		goto failed;
> +	}
> +
> +	if (config->ip_range && l_strv_length(config->ip_range) !=3D 2) {
> +		l_error("IP range must be 2 values");
> +		goto failed;
> +	}
> +
> +
>   done:
>   	l_info("Loaded AP configuration %s", config->ssid);
>   	return config;
> diff --git a/src/ap.h b/src/ap.h
> index 90497008..277a5a2f 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -63,6 +63,14 @@ struct ap_config {
>   	unsigned int authorized_macs_num;
>   	char *wsc_name;
>   	struct wsc_primary_device_type wsc_primary_device_type;
> +
> +	char *address;
> +	char *gateway;
> +	char *netmask;
> +	char **dns_list;
> +	char **ip_range;
> +	uint32_t lease_time;
> +

I think we may need Andrew's opinion on whether these should be part of =

ap_config.  P2P might not really care about setting up these variables and =
would =

prefer for ap.c to just figure things out.

>   	bool no_cck_rates : 1;
>   	bool no_free : 1;
>   };
> =


Regards,
-Denis
--===============2131859861069267515==--

