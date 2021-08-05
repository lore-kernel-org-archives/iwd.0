Content-Type: multipart/mixed; boundary="===============5435079094861835384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] netdev: allow SAE reassociation
Date: Thu, 05 Aug 2021 12:23:55 -0500
Message-ID: <4313fd3e-026a-041c-908a-6bffe5aaff9b@gmail.com>
In-Reply-To: <20210805165914.293926-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5435079094861835384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/5/21 11:59 AM, James Prestwood wrote:
> This adds support in netdev_reassociate for SAE. An SAE auth
> protocol is created rather than the connect command and from
> here there is virtually no difference to a normal connection
> attempt. The only differences are 'in_roam' is set as to

Did you mean 'in_reassoc' here?

> ignore the inevitable disconnect event and PREV_BSSID is
> appended to CMD_ASSOCIATE only for this new reassociation case.
> ---
>   src/netdev.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> =


Please rebase on top of git HEAD.

> @@ -2716,6 +2719,11 @@ static void netdev_sae_tx_associate(void *user_dat=
a)
>   =

>   	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, n_used);
>   =

> +	/* If doing a non-FT Reassociation */
> +	if (netdev->in_reassoc && !IE_AKM_IS_FT(netdev->handshake->akm_suite))
> +		l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, 6,
> +					netdev->prev_bssid);
> +

Actually I added auth_proto::prev_bssid just recently with exactly this in =
mind.

>   	if (!l_genl_family_send(nl80211, msg, netdev_assoc_cb, netdev, NULL)) {
>   		l_genl_msg_unref(msg);
>   		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
> @@ -3584,7 +3592,7 @@ int netdev_reassociate(struct netdev *netdev, struc=
t scan_bss *target_bss,
>   			netdev_event_func_t event_filter,
>   			netdev_connect_cb_t cb, void *user_data)
>   {
> -	struct l_genl_msg *cmd_connect;
> +	struct l_genl_msg *cmd_connect =3D NULL;
>   	struct netdev_handshake_state;
>   	struct handshake_state *old_hs;
>   	struct eapol_sm *sm =3D NULL, *old_sm;
> @@ -3594,16 +3602,21 @@ int netdev_reassociate(struct netdev *netdev, str=
uct scan_bss *target_bss,
>   	if (netdev_handshake_state_setup_connection_type(hs) < 0)
>   		return -ENOTSUP;
>   =

> -	/* TODO: SoftMac SAE/FILS Re-Associations are not suppored yet */
> -	if (L_WARN_ON(IE_AKM_IS_SAE(hs->akm_suite) ||
> -				IE_AKM_IS_FILS(hs->akm_suite)))
> +	/* TODO: SoftMac FILS Re-Associations are not suppored yet */
> +	if (L_WARN_ON(IE_AKM_IS_FILS(hs->akm_suite)))
>   		return -ENOTSUP;
>   =

> -	cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
> +	if (IE_AKM_IS_SAE(hs->akm_suite))
> +		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
> +						netdev_sae_tx_associate,
> +						netdev);
> +	else {
> +		cmd_connect =3D netdev_build_cmd_connect(netdev, target_bss, hs,
>   						orig_bss->addr, NULL, 0);

This should be taking SAE offload into account, similar to netdev_connect p=
ath...

>   =

> -	if (is_rsn)
> -		sm =3D eapol_sm_new(hs);
> +		if (is_rsn)
> +			sm =3D eapol_sm_new(hs);
> +	}
>   =

>   	old_sm =3D netdev->sm;
>   	old_hs =3D netdev->handshake;

Regards,
-Denis
--===============5435079094861835384==--

