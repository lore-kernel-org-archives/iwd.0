Content-Type: multipart/mixed; boundary="===============2057025659933477736=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] netdev: implement netdev_handshake_state_set_pmk
Date: Thu, 08 Apr 2021 15:14:21 -0500
Message-ID: <c26a63f4-1f49-64fc-ff01-49e909d3e142@gmail.com>
In-Reply-To: <20210408154646.1182833-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2057025659933477736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/8/21 10:46 AM, James Prestwood wrote:
> The 8021x offloading procedure still does EAP in userspace which
> negotiates the PMK. The kernel then expects to obtain this PMK
> from userspace by calling SET_PMK. This then allows the firmware
> to begin the 4-way handshake.
> =

> netdev_handshake_set_pmk kicks off the final userspace
> actions prior to the firmware starting the 4-way handshake:
> =

>   - SET_PMK using PMK negotiated with EAP
>   - SET_STATION (concurrently with SET_PMK)
>   - Emit SETTING_KEYS event
>   - netdev_connect_ok
> =

> One thing to note is that the kernel provides no way of knowing if
> the 4-way handshake completed. Assuming SET_PMK/SET_STATION come
> back with no errors, IWD assumes the PMK was valid. If not, or
> due to some other issue in the 4-way, the kernel will send a
> disconnect.
> ---
>   src/netdev.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  2 ++
>   2 files changed, 87 insertions(+)
> =


<snip>

> +void netdev_handshake_set_pmk(struct handshake_state *hs)
> +{
> +	struct l_genl_msg *msg;
> +	struct netdev_handshake_state *nhs =3D l_container_of(hs,
> +				struct netdev_handshake_state, super);
> +	struct netdev *netdev =3D nhs->netdev;
> +
> +	/* Only relevent for 8021x offload */
> +	if (nhs->type !=3D CONNECTION_TYPE_8021X_OFFLOAD)
> +		return;
> +
> +	msg =3D l_genl_msg_new(NL80211_CMD_SET_PMK);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6, netdev->handshake->aa);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK,
> +				netdev->handshake->pmk_len,
> +				netdev->handshake->pmk);
> +
> +	nhs->set_pmk_cmd_id =3D l_genl_family_send(nl80211, msg,
> +							netdev_set_pmk_cb,
> +							nhs, NULL);
> +	if (!nhs->set_pmk_cmd_id) {
> +		l_error("Failed to set SET_PMK");
> +		netdev_setting_keys_failed(nhs, -EIO);
> +		return;
> +	}
> +
> +	msg =3D nl80211_build_set_station_authorized(netdev->index,
> +							netdev->handshake->aa);

I seem to recall that brcmfmac reports a -ENOTSUP error for SET_STATION.  S=
o is =

this even needed?

> +
> +	nhs->set_station_cmd_id =3D l_genl_family_send(nl80211, msg,
> +						netdev_set_station_offload_cb,
> +						nhs, NULL);
> +	if (!nhs->set_station_cmd_id) {
> +		l_error("Failed to SET_STATION");
> +		netdev_setting_keys_failed(nhs, -EIO);
> +	}
> +}
> +

Regards,
-Denis
--===============2057025659933477736==--

