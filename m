Content-Type: multipart/mixed; boundary="===============4177440479537440384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] ie: add is_ie_default_sae_group_oui
Date: Wed, 25 Aug 2021 08:57:53 -0500
Message-ID: <ba5eda39-cf42-8b24-83d9-73710365242b@gmail.com>
In-Reply-To: <20210823234149.610336-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4177440479537440384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/23/21 6:41 PM, James Prestwood wrote:
> Start an OUI list of vendors who have buggy SAE group negotiation
> ---
>   src/ie.c | 25 +++++++++++++++++++++++++
>   src/ie.h |  2 ++
>   2 files changed, 27 insertions(+)
> =

> diff --git a/src/ie.c b/src/ie.c
> index a73d5bbc..3bf3b5f0 100644
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -1363,6 +1363,31 @@ bool is_ie_wpa_ie(const uint8_t *data, uint8_t len)
>   	return false;
>   }
>   =

> +/*
> + * List of vendor OUIs which require the default SAE group to be used
> + */
> +static uint8_t use_default_sae_group_ouis[][3] =3D {
> +	{ 0xf4, 0xf5, 0xe8 },

I wonder if blacklisting the entire vendor oui is a good idea.  The Nest se=
ems =

to send a subtype of '05' of the vendor IE.  Maybe we should limit it to th=
at =

for now?

> +};
> +
> +bool is_ie_default_sae_group_oui(const void *data, uint16_t len)
> +{
> +	unsigned int i =3D 0;
> +
> +	if (len < 3)
> +		return false;
> +
> +	while (i < L_ARRAY_SIZE(use_default_sae_group_ouis)) {
> +		if (!memcmp(use_default_sae_group_ouis[i], data, 3))
> +			return true;

So supporting matching by OUI or OUI + type might be nice.

> +
> +		i++;
> +	}
> +
> +	return false;
> +}
> +
> +

double empty line

Regards,
-Denis
--===============4177440479537440384==--

