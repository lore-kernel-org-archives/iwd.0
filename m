Content-Type: multipart/mixed; boundary="===============2280495023815871316=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/7] netdev: allow PSK offload for FT AKMs
Date: Tue, 30 Mar 2021 15:25:22 -0500
Message-ID: <204a38aa-6fc4-df73-3fc3-27296662147a@gmail.com>
In-Reply-To: <20210330184808.744574-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2280495023815871316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/30/21 1:48 PM, James Prestwood wrote:
> If the handshake has offloading set, use ATTR_PMK (for WPA2)
> which enables PSK offloading.
> =

> The CMD_ROAM event path was also modified to take into account
> handshake offloading. If the handshake is offloaded we still
> must issue GET_SCAN, but not start eapol since the firmware
> takes care of this.
> ---
>   src/netdev.c | 44 +++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 914f6479..5c5fcd86 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -1992,19 +1992,7 @@ process_resp_ies:
>   	if (netdev->handshake->offload)
>   		goto done;
>   =


Hmm, would it not be simpler to move the above check into the below if stat=
ement =

instead?

> -	if (netdev->sm) {
> -		/*
> -		 * Let station know about the roam so a state change can occur.
> -		 */
> -		if (cmd =3D=3D NL80211_CMD_ROAM) {
> -			if (netdev->event_filter)
> -				netdev->event_filter(netdev,
> -						NETDEV_EVENT_ROAMING,
> -						NULL, netdev->user_data);
> -			/* EAPoL started after GET_SCAN */
> -			return;
> -		}
> -
> +	if (netdev->sm && cmd !=3D NL80211_CMD_ROAM) {
>   		/*
>   		 * Start processing EAPoL frames now that the state machine
>   		 * has all the input data even in FT mode.
> @@ -2016,6 +2004,19 @@ process_resp_ies:
>   	}
>   =

>   done:
> +	/*
> +	 * Let station know about the roam so a state change can occur.
> +	 */
> +	if (cmd =3D=3D NL80211_CMD_ROAM) {
> +		if (netdev->event_filter)
> +			netdev->event_filter(netdev,
> +						NETDEV_EVENT_ROAMING,
> +						NULL, netdev->user_data);
> +		/* EAPoL started after GET_SCAN */
> +		if (!netdev->handshake->offload)
> +			return;
> +	}
> +
>   	netdev_connect_ok(netdev);
>   =

>   	return;
> @@ -2641,6 +2642,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(=
struct netdev *netdev,
>   		if (IE_AKM_IS_SAE(hs->akm_suite))
>   			l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PASSWORD,
>   					strlen(hs->passphrase), hs->passphrase);
> +		else
> +			l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
>   	}
>   =

>   	if (prev_bssid)
> @@ -4000,7 +4003,7 @@ static bool netdev_get_fw_scan_cb(int err, struct l=
_queue *bss_list,
>   	 * In this case we should just ignore this and allow the disconnect
>   	 * logic to continue.
>   	 */
> -	if (!netdev->sm)
> +	if (!netdev->handshake->offload && !netdev->sm)
>   		return false;
>   =

>   	if (err < 0) {
> @@ -4028,6 +4031,11 @@ static bool netdev_get_fw_scan_cb(int err, struct =
l_queue *bss_list,
>   =

>   	handshake_state_set_authenticator_ie(netdev->handshake, bss->rsne);
>   =

> +	if (netdev->handshake->offload) {
> +		netdev_connect_ok(netdev);

Hmm... netdev_connect_ok seems to invoke HANDSHAKE_EVENT_SETTING_KEYS event =

which is probably wrong on an offloaded roam event.

> +		return false;
> +	}
> +
>   	eapol_start(netdev->sm);
>   =

>   	return false;
> @@ -4063,14 +4071,20 @@ static bool netdev_roam_event(struct l_genl_msg *=
msg, struct netdev *netdev)
>   		goto failed;
>   	}
>   =

> +	/* Handshake completed in firmware, just get the roamed BSS */
> +	if (netdev->handshake->offload)
> +		goto get_fw_scan;
> +
>   	/* Reset handshake state */
>   	nhs->complete =3D false;
>   	nhs->ptk_installed =3D false;
>   	nhs->gtk_installed =3D true;
>   	nhs->igtk_installed =3D true;
> -	handshake_state_set_authenticator_address(netdev->handshake, mac);
>   	netdev->handshake->ptk_complete =3D false;
>   =

> +get_fw_scan:
> +	handshake_state_set_authenticator_address(netdev->handshake, mac);
> +
>   	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_cb,
>   					netdev, NULL))
>   		goto failed;
> =


Regards,
-Denis
--===============2280495023815871316==--

