Content-Type: multipart/mixed; boundary="===============3279219537747512789=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] station: set handshake offload if supported
Date: Wed, 03 Mar 2021 14:50:07 -0600
Message-ID: <c256b015-080c-a8ad-be18-625aa29a3ca0@gmail.com>
In-Reply-To: <20210303174730.6738-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3279219537747512789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/3/21 11:47 AM, James Prestwood wrote:
> When setting up the handshake check if wiphy supports handshake
> offload for PSK networks (not including SAE, for now).
> ---
>   src/station.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/src/station.c b/src/station.c
> index 6496be10..93701e7f 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -986,6 +986,8 @@ static struct handshake_state *station_handshake_setu=
p(struct station *station,
>   				goto no_psk;
>   =

>   			handshake_state_set_pmk(hs, psk, 32);
> +
> +			hs->offload_psk =3D wiphy_can_offload(wiphy, bss);

I actually wonder whether we need to put some of the logic from =

wiphy_can_offload into wiphy_select_akm instead?  Maybe the offload bit can=
 be =

an extra out parameter?

I suspect we need to implement the logic for offloaded SAE to really know w=
hat =

will look best.

>   		}
>   	} else if (security =3D=3D SECURITY_8021X)
>   		handshake_state_set_8021x_config(hs,
> =


Regards,
-Denis
--===============3279219537747512789==--

