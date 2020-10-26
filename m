Content-Type: multipart/mixed; boundary="===============3681578217673377181=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v5 4/6] ap: add support for DHCPv4 server
Date: Mon, 26 Oct 2020 11:23:35 -0700
Message-ID: <8fc8db22a8947fb64f70e070d028c4959eb97e96.camel@gmail.com>
In-Reply-To: <20201026180544.2130802-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3681578217673377181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-26 at 11:05 -0700, James Prestwood wrote:
> The DHCP server can be enabled by enabling network configuration
> with [General].EnableNetworkConfiguration. If an IP is not set
> on the interface before the AP is started a valid IP range must
> also be provided under [General].APRanges in IP prefix format e.g.
> =

> [General]
> EnableNetworkConfiguration=3Dtrue
> APRanges=3D192.168.1.1/24
> =

> Each AP started will get assigned a new subnet within the range
> specified by APRanges as to not conflict with other AP interfaces.
> If there are no subnets left in the pool when an AP is started
> it will fail with -EEXIST. Any AP's that are stopped will release
> their subnet back into the pool to be used with other APs.
> =

> The DHCP IP pool will be automatically chosen by the ELL DHCP
> implementation (+1 the AP's IP to *.254). The remaining DHCP
> settings will be defaults chosen by ELL (DNS, lease time, etc).
> ---
>  src/ap.c | 258
> +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 252 insertions(+), 6 deletions(-)
> =

> v5:
>  * Added IP pool rather than hard coded IP address
> =

> diff --git a/src/ap.c b/src/ap.c
> index b10b65ae..17877ddd 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -26,6 +26,8 @@
>  =

>  #include <errno.h>
>  #include <linux/if_ether.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
>  =

>  #include <ell/ell.h>
>  =

> @@ -74,6 +76,10 @@ struct ap_state {
>  	uint16_t last_aid;
>  	struct l_queue *sta_states;
>  =

> +	struct l_dhcp_server *server;
> +	uint32_t rtnl_add_cmd;
> +	char *own_ip;
> +
>  	bool started : 1;
>  	bool gtk_set : 1;
>  };
> @@ -104,7 +110,99 @@ struct ap_wsc_pbc_probe_record {
>  	uint64_t timestamp;
>  };
>  =

> +struct ap_ip_pool {
> +	uint32_t start;
> +	uint32_t end;
> +	char *mask;
> +	uint8_t prefix;
> +
> +	/* Fist/last valid subnet */
> +	uint8_t sub_start;
> +	uint8_t sub_end;
> +
> +	struct l_uintset *used;
> +};
> +
> +struct ap_ip_pool pool;
>  static uint32_t netdev_watch;
> +struct l_netlink *rtnl;
> +
> +/*
> + * Creates pool of IPs which AP intefaces can use. Each call to
> ip_pool_get
> + * will advance the subnet +1 so there are no IP conflicts between
> AP
> + * interfaces
> + */
> +static bool ip_pool_create(const char *ip_prefix)
> +{
> +	struct in_addr ia;
> +	uint32_t mask;
> +
> +	if (!util_ip_prefix_tohl(ip_prefix, &pool.prefix, &pool.start,
> +					&pool.end, &mask))
> +		return false;
> +
> +	ia.s_addr =3D htonl(mask);
> +	pool.mask =3D l_strdup(inet_ntoa(ia));
> +
> +	/*
> +	 * Find the number of subnets we can use, this will dictate the
> number
> +	 * of AP interfaces that can be created (when using DHCP)
> +	 */
> +	pool.sub_start =3D (pool.start & 0x0000ff00) >> 8;
> +	pool.sub_end =3D (pool.end & 0x0000ff00) >> 8;
> +
> +	pool.used =3D l_uintset_new_from_range(pool.sub_start,
> pool.sub_end);
> +
> +	return true;
> +}
> +
> +static char *ip_pool_get()
> +{
> +	uint32_t ip;
> +	struct in_addr ia;
> +	uint8_t next_subnet =3D
> (uint8_t)l_uintset_find_unused_min(pool.used);
> +
> +	/* This shouldn't happen */
> +	if (next_subnet < pool.sub_start || next_subnet > pool.sub_end)
> +		return NULL;
> +
> +	l_uintset_put(pool.used, next_subnet);
> +
> +	ip =3D pool.start;
> +	ip &=3D 0xffff00ff;
> +	ip |=3D (next_subnet << 8);
> +
> +	ia.s_addr =3D htonl(ip);
> +	return l_strdup(inet_ntoa(ia));
> +}
> +
> +static bool ip_pool_put(const char *address)
> +{
> +	struct in_addr ia;
> +	uint32_t ip;
> +	uint8_t subnet;
> +
> +	if (inet_aton(address, &ia) < 0)
> +		return false;
> +
> +	ip =3D ntohl(ia.s_addr);
> +
> +	subnet =3D (ip & 0x0000ff00) >> 8;
> +
> +	if (subnet < pool.sub_start || subnet > pool.sub_end)
> +		return false;
> +
> +	return l_uintset_take(pool.used, subnet);
> +}
> +
> +static void ip_pool_destroy()
> +{
> +	if (pool.used)
> +		l_uintset_free(pool.used);
> +
> +	if (pool.mask)
> +		l_free(pool.mask);
> +}
>  =

>  void ap_config_free(struct ap_config *config)
>  {
> @@ -181,6 +279,9 @@ static void ap_reset(struct ap_state *ap)
>  	if (ap->start_stop_cmd_id)
>  		l_genl_family_cancel(ap->nl80211, ap-
> >start_stop_cmd_id);
>  =

> +	if (ap->rtnl_add_cmd)
> +		l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
> +
>  	l_queue_destroy(ap->sta_states, ap_sta_free);
>  =

>  	if (ap->rates)
> @@ -192,6 +293,14 @@ static void ap_reset(struct ap_state *ap)
>  	l_queue_destroy(ap->wsc_pbc_probes, l_free);
>  =

>  	ap->started =3D false;
> +
> +	if (ap->own_ip) {
> +		ip_pool_put(ap->own_ip);
> +		l_free(ap->own_ip);
> +	}
> +
> +	if (ap->server)
> +		l_dhcp_server_stop(ap->server);
>  }
>  =

>  static void ap_del_station(struct sta_state *sta, uint16_t reason,
> @@ -1900,6 +2009,22 @@ static void ap_deauth_cb(const struct
> mmpdu_header *hdr, const void *body,
>  	ap_sta_free(sta);
>  }
>  =

> +static void do_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	l_info("%s%s", prefix, str);
> +}
> +
> +static void ap_start_failed(struct ap_state *ap)
> +{
> +	ap->ops->handle_event(AP_EVENT_START_FAILED, NULL, ap-
> >user_data);
> +	ap_reset(ap);
> +	l_genl_family_free(ap->nl80211);
> +
> +	l_free(ap);
> +}
> +
>  static void ap_start_cb(struct l_genl_msg *msg, void *user_data)
>  {
>  	struct ap_state *ap =3D user_data;
> @@ -1909,16 +2034,26 @@ static void ap_start_cb(struct l_genl_msg
> *msg, void *user_data)
>  	if (l_genl_msg_get_error(msg) < 0) {
>  		l_error("START_AP failed: %i",
> l_genl_msg_get_error(msg));
>  =

> -		ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
> -					ap->user_data);
> -		ap_reset(ap);
> -		l_genl_family_free(ap->nl80211);
> -		l_free(ap);
> -		return;
> +		goto failed;
> +	}
> +
> +	/*
> +	 * TODO: Add support for provisioning files where user could
> configure
> +	 * specific DHCP sever settings.
> +	 */
> +
> +	if (ap->server && !l_dhcp_server_start(ap->server)) {
> +		l_error("DHCP server failed to start");
> +		goto failed;
>  	}
>  =

>  	ap->started =3D true;
>  	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
> +
> +	return;
> +
> +failed:
> +	ap_start_failed(ap);
>  }
>  =

>  static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
> @@ -1989,6 +2124,37 @@ static struct l_genl_msg
> *ap_build_cmd_start_ap(struct ap_state *ap)
>  	return cmd;
>  }
>  =

> +static void ap_ifaddr4_added_cb(int error, uint16_t type, const void
> *data,
> +				uint32_t len, void *user_data)
> +{
> +	struct ap_state *ap =3D user_data;
> +	struct l_genl_msg *cmd;
> +
> +	ap->rtnl_add_cmd =3D 0;
> +
> +	if (error) {
> +		l_error("Failed to set IP address");
> +		goto error;
> +	}
> +
> +	cmd =3D ap_build_cmd_start_ap(ap);
> +	if (!cmd)
> +		goto error;
> +
> +	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
> +							ap_start_cb,
> ap, NULL);
> +	if (!ap->start_stop_cmd_id) {
> +		l_genl_msg_unref(cmd);
> +		goto error;
> +	}
> +
> +	return;
> +
> +error:
> +	ap_start_failed(ap);
> +}
> +
> +
>  static void ap_mlme_notify(struct l_genl_msg *msg, void *user_data)
>  {
>  	struct ap_state *ap =3D user_data;
> @@ -2040,6 +2206,8 @@ struct ap_state *ap_start(struct netdev
> *netdev, struct ap_config *config,
>  	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
>  	struct l_genl_msg *cmd;
>  	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
> +	uint32_t ifindex =3D netdev_get_ifindex(netdev);
> +	struct in_addr ia;
>  	int err =3D -EINVAL;
>  =

>  	if (err_out)
> @@ -2140,6 +2308,53 @@ struct ap_state *ap_start(struct netdev
> *netdev, struct ap_config *config,
>  	if (!ap->mlme_watch)
>  		l_error("Registering for MLME notification failed");
>  =

> +	/* No IP pool initialized, DHCP is not being used */
> +	if (!pool.used)
> +		goto done;
> +
> +	ap->server =3D l_dhcp_server_new(ifindex);
> +	if (!ap->server) {
> +		l_error("Failed to create DHCP server on %u", ifindex);
> +		goto error;
> +	}
> +
> +	if (getenv("IWD_DHCP_DEBUG"))
> +		l_dhcp_server_set_debug(ap->server, do_debug,
> +							"[DHCPv4 SERV]
> ", NULL);
> +
> +	/*
> +	 * If there is no IP set on the interface use one from the IP
> pool
> +	 * defined in main.conf.
> +	 */
> +	if (!l_net_get_address(ifindex, &ia) || ia.s_addr =3D=3D 0) {
> +		ap->own_ip =3D ip_pool_get();
> +
> +		if (!ap->own_ip) {
> +			l_error("No more IP's in pool, cannot start AP
> on %u",
> +					ifindex);
> +			err =3D -EEXIST;
> +			goto error;
> +		}
> +
> +		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
> +					pool.prefix, ap->own_ip,
> pool.mask,
> +					ap_ifaddr4_added_cb, ap, NULL);
> +
> +		if (!ap->rtnl_add_cmd) {
> +			l_error("Failed to add IPv4 address");
> +			goto error;
> +		}
> +
> +
> +		if (*err_out)

Should be checking 'err_out' not '*err_out'

> +			*err_out =3D 0;
> +
> +		/* Finish starting AP in added callback */
> +		return ap;
> +	}
> +	/* Else honor the IP set on the interface prior to calling
> Start() */
> +
> +done:
>  	cmd =3D ap_build_cmd_start_ap(ap);
>  	if (!cmd)
>  		goto error;
> @@ -2160,6 +2375,7 @@ error:
>  	if (err_out)
>  		*err_out =3D err;
>  =

> +	ap->config =3D NULL;
>  	ap_reset(ap);
>  	l_genl_family_free(ap->nl80211);
>  	l_free(ap);
> @@ -2266,6 +2482,8 @@ void ap_free(struct ap_state *ap)
>  {
>  	ap_reset(ap);
>  	l_genl_family_free(ap->nl80211);
> +	if (ap->server)
> +		l_dhcp_server_destroy(ap->server);
>  	l_free(ap);
>  }
>  =

> @@ -2542,11 +2760,37 @@ static void ap_netdev_watch(struct netdev
> *netdev,
>  =

>  static int ap_init(void)
>  {
> +	const struct l_settings *settings =3D iwd_get_config();
> +	bool dhcp_enable =3D false;
> +
>  	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
>  =

>  	l_dbus_register_interface(dbus_get_bus(), IWD_AP_INTERFACE,
>  			ap_setup_interface, ap_destroy_interface,
> false);
>  =

> +	/*
> +	 * Reusing [General].EnableNetworkConfiguration as a switch to
> enable
> +	 * DHCP server. If no value is found or it is false do not
> create a
> +	 * DHCP server.
> +	 */
> +	l_settings_get_bool(settings, "General",
> "EnableNetworkConfiguration",
> +				&dhcp_enable);
> +
> +	if (dhcp_enable) {
> +		L_AUTO_FREE_VAR(char *, ip_prefix);
> +
> +		ip_prefix =3D l_settings_get_string(settings, "General",
> +							"APRanges");
> +		if (!ip_prefix) {
> +			l_error("[General].APRanges must be set for
> DHCP");
> +			return -EINVAL;
> +		}
> +
> +		ip_pool_create(ip_prefix);
> +
> +		rtnl =3D iwd_get_rtnl();
> +	}
> +
>  	return 0;
>  }
>  =

> @@ -2554,6 +2798,8 @@ static void ap_exit(void)
>  {
>  	netdev_watch_remove(netdev_watch);
>  	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
> +
> +	ip_pool_destroy();
>  }
>  =

>  IWD_MODULE(ap, ap_init, ap_exit)

--===============3681578217673377181==--

