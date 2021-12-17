Content-Type: multipart/mixed; boundary="===============1189041280868464126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v5 2/4] dpp: add DPP authentication protocol
Date: Fri, 17 Dec 2021 14:19:11 -0600
Message-ID: <a2bfc724-dfb8-8c75-7f05-1ee6523b48ad@gmail.com>
In-Reply-To: 20211217191451.179444-2-prestwoj@gmail.com

--===============1189041280868464126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/17/21 13:14, James Prestwood wrote:
> This implements the DPP protocol used to authenticate to a
> DPP configurator.
> =

> Note this is not a full implementation of the protocol and
> there are a few missing features which will be added as
> needed:
> =

>   - Mutual authentication (needed for BLE bootstrapping)
>   - Configurator support
>   - Initiator role
> ---
>   src/dpp.c | 491 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 491 insertions(+)
> =

> v5:
>   * Updated use of wrap/unwrap APIs.
>   * Better commented how AAD is used with wrapping/unwrapping
> =


<snip>

> +static void dpp_free_auth_data(struct dpp_sm *dpp)
> +{
> +	if (dpp->proto_public) {
> +		l_ecc_point_free(dpp->proto_public);
> +		dpp->proto_public =3D NULL;
> +	}
> +
> +	if (dpp->proto_private) {
> +		l_ecc_scalar_free(dpp->proto_private);
> +		dpp->proto_private =3D NULL;
> +	}
> +
> +	if (dpp->i_proto_public) {
> +		l_ecc_point_free(dpp->i_proto_public);
> +		dpp->i_proto_public =3D NULL;
> +	}

Should we be paranoid and explicit_bzero the nonces and keys?

Applied, thanks.

Regards,
-Denis
--===============1189041280868464126==--

