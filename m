Content-Type: multipart/mixed; boundary="===============3572129618963041601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] p2p: Do DHCP as part of connection setup
Date: Fri, 01 May 2020 11:39:43 -0500
Message-ID: <a2abc59b-27ea-ed05-218e-9b252def26af@gmail.com>
In-Reply-To: <20200430134847.62234-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3572129618963041601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/30/20 8:48 AM, Andrew Zaborowski wrote:
> Use netconfig.c functions to unconditionally run DHCP negotiation,
> fail the connection setup if DHCP fails.  Only report connection success
> after netconfig returns.
> ---
>   src/p2p.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 82 insertions(+), 7 deletions(-)
> =


Patch 1 applied, I ..

> +static void p2p_start_dhcp(struct p2p_device *dev)
> +{
> +	uint32_t ifindex =3D netdev_get_ifindex(dev->conn_netdev);
> +	unsigned int dhcp_timeout_val;
> +
> +	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
> +					&dhcp_timeout_val))
> +		dhcp_timeout_val =3D 10;	/* 10s default */
> +
> +	dev->conn_netconfig =3D netconfig_new(ifindex);
> +	if (!dev->conn_netconfig) {
> +		p2p_connect_failed(dev);
> +		return;
> +	}
> +
> +	netconfig_configure(dev->conn_netconfig, p2p_dhcp_settings,
> +				dev->conn_addr, p2p_netconfig_event_handler,
> +				dev);
> +	dev->conn_dhcp_timeout =3D l_timeout_create(dhcp_timeout_val,
> +						p2p_dhcp_timeout, dev,
> +						p2p_dhcp_timeout_destroy);
> +	return;

squashed this superfluous return and applied this as well.

> +}
> +
>   static void p2p_netdev_connect_cb(struct netdev *netdev,
>   					enum netdev_result result,
>   					void *event_data, void *user_data)


Regards,
-Denis
--===============3572129618963041601==--

