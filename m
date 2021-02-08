Content-Type: multipart/mixed; boundary="===============0489326797722671539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] fils: check return of ie_parse_rsne_from_data
Date: Mon, 08 Feb 2021 15:25:50 -0600
Message-ID: <252443a6-03e5-6fd0-4715-3910bb78f7d7@gmail.com>
In-Reply-To: <20210208211812.612391-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0489326797722671539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 3:18 PM, James Prestwood wrote:
> ---
>   src/fils.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> =

> diff --git a/src/fils.c b/src/fils.c
> index acead506..3917ca40 100644
> --- a/src/fils.c
> +++ b/src/fils.c
> @@ -108,9 +108,11 @@ static void fils_erp_tx_func(const uint8_t *eap_data=
, size_t len,
>   =

>   	ie_tlv_builder_init(&builder, ptr, sizeof(data) - 4);
>   =

> -	ie_parse_rsne_from_data(fils->hs->supplicant_ie,
> +	if (ie_parse_rsne_from_data(fils->hs->supplicant_ie,
>   				fils->hs->supplicant_ie[1] + 2,
> -				&rsn_info);
> +				&rsn_info) < 0)
> +		return;
> +

This really shouldn't fail.  We parse and check the rsne for errors when =

building the handshake_state (
handshake_state_set_supplicant_ie).  So it should be checked then.

If we're paranoid about this, I'd do the checking in fils_sm_new or fils_st=
art =

or something

>   	rsne =3D alloca(256);
>   	ie_build_rsne(&rsn_info, rsne);
>   =

> =


Regards,
-Denis
--===============0489326797722671539==--

