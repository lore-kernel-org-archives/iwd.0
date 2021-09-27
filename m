Content-Type: multipart/mixed; boundary="===============6146673360224821037=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 6/9] ft: get OCI prior to reassociation
Date: Mon, 27 Sep 2021 12:55:40 -0500
Message-ID: <8cf91f8d-cf64-08e8-3e14-656f6f70e07a@gmail.com>
In-Reply-To: 20210927170404.1292107-6-prestwoj@gmail.com

--===============6146673360224821037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/27/21 12:04 PM, James Prestwood wrote:
> This modifies the FT logic to fist call get_oci() before
> reassociation. This allows the OCI to be included in reassociation
> and in the 4-way handshake later on.
> ---
>   src/ft.c     | 13 ++++++++++++-
>   src/ft.h     |  2 ++
>   src/netdev.c | 20 +++++++++++++++++++-
>   3 files changed, 33 insertions(+), 2 deletions(-)
> =


<snip>

> @@ -2074,6 +2074,21 @@ static void netdev_get_oci_cb(struct l_genl_msg *m=
sg, void *user_data)
>   	handshake_state_set_chandef(netdev->handshake, l_steal_ptr(chandef));
>   =

>   done:
> +	if (netdev->ap) {
> +		/*
> +		 * Cant do much here. IWD assumes every kernel/driver supports
> +		 * this. There is no way of detecting support either.
> +		 */
> +		if (L_WARN_ON(err < 0))
> +			netdev_connect_failed(netdev,
> +					NETDEV_RESULT_AUTHENTICATION_FAILED,
> +					MMPDU_STATUS_CODE_UNSPECIFIED);

You could just let the other side reject our Association or reset ocvc, but=
 okay.

> +		else
> +			auth_proto_rx_oci(netdev->ap);
> +
> +		return;
> +	}
> +
>   	L_WARN_ON(!eapol_start(netdev->sm));
>   }
>   =


Otherwise looks fine.  Not sure if this patch requires changes due to comme=
nts =

in patch 7.

Regards,
-Denis
--===============6146673360224821037==--

