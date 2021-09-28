Content-Type: multipart/mixed; boundary="===============8883225719328815788=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 9/9] netdev: rebuild RSNE for FT-over-DS
Date: Tue, 28 Sep 2021 11:06:30 -0500
Message-ID: <98c78701-b4ff-6b2f-8e0a-ee7b6c521b8b@gmail.com>
In-Reply-To: 20210928154658.2382597-9-prestwoj@gmail.com

--===============8883225719328815788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 9/28/21 10:46 AM, James Prestwood wrote:
> FT-over-DS cannot use OCV due to how the kernel works. This means
> we could connect initially with OCVC set, but a FT-over-DS attempt
> needs to unset OCVC. To do this we must rebuild the RSNE and
> explicitly set OCVC to false.
> ---
>   src/netdev.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 53a0a184..fb3f04c8 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -4097,6 +4097,8 @@ static int netdev_ft_tx_associate(struct iovec *ft_=
iov, size_t n_ft_iov,
>   static void prepare_ft(struct netdev *netdev, const struct scan_bss *ta=
rget_bss)
>   {
>   	struct netdev_handshake_state *nhs;
> +	uint8_t rsne_buf[256];
> +	struct ie_rsn_info info;
>   =

>   	/*
>   	 * We reuse the handshake_state object and reset what's needed.
> @@ -4119,6 +4121,19 @@ static void prepare_ft(struct netdev *netdev, cons=
t struct scan_bss *target_bss)
>   	netdev->operational =3D false;
>   	netdev->in_ft =3D true;
>   =

> +	/* Always disable OCVC for FT-over-DS */
> +	if (netdev->handshake->mde[4] & 1) {

Is this really a good indicator of whether we're using FT-over-DS or not? =

Station might choose different heuristics / policy at a later time, so maki=
ng =

this more explicit would be better.

> +		ie_parse_rsne_from_data(netdev->handshake->supplicant_ie,
> +					netdev->handshake->supplicant_ie[1] + 2,
> +					&info);
> +
> +		info.ocvc =3D false;
> +
> +		ie_build_rsne(&info, rsne_buf);
> +
> +		handshake_state_set_supplicant_ie(netdev->handshake, rsne_buf);

Also, why are you rebuilding the RSN here and not prior to sending the =

ReAssociate, where it is being rebuilt anyway?

> +	}
> +
>   	handshake_state_set_chandef(netdev->handshake, NULL);
>   =

>   	/*
> =


Regards,
-Denis
--===============8883225719328815788==--

