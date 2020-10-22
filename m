Content-Type: multipart/mixed; boundary="===============5483636606344175839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] ap: add support for DHCPv4 server
Date: Thu, 22 Oct 2020 09:27:16 -0500
Message-ID: <bd3c2493-2f0a-64e6-1ccb-df32a60203e8@gmail.com>
In-Reply-To: <20201021184427.1730146-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5483636606344175839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/21/20 1:44 PM, James Prestwood wrote:
> The DHCP server can be enabled by enabling network configuration
> with [General].EnableNetworkConfiguration. For now, the default
> DHCP settings will be used. The only requirement is that the
> AP network interface must have an IP set prior to calling Start().
> ---
>   src/ap.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 6 deletions(-)
> =


<snip>

> +static bool ap_start_dhcp(struct ap_state *ap)
> +{
> +	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> +	const struct l_settings *settings =3D iwd_get_config();
> +	bool enabled =3D false;
> +
> +	/*
> +	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
> +	 * DHCP server. If no value is found or it is false do not create a
> +	 * DHCP server.
> +	 */
> +	if (!l_settings_get_bool(settings, "General",
> +					"EnableNetworkConfiguration", &enabled))
> +		return true;
> +
> +	if (!enabled)
> +		return true;
> +
> +	ap->server =3D l_dhcp_server_new(ifindex);
> +	if (!ap->server) {
> +		l_error("Failed to create DHCP server on %u", ifindex);
> +		return false;
> +	}

Hmm, looks like the server is relying on some external entity to setup the =
IP =

address.  I thought we decided to have ap allocate this and set the address=
 all =

by itself?

Regards,
-Denis
--===============5483636606344175839==--

