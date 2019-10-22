Content-Type: multipart/mixed; boundary="===============2959668800876087367=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/11] netdev: Report RSSI to frame watch callbacks
Date: Mon, 21 Oct 2019 22:34:24 -0500
Message-ID: <4e176e94-776d-0474-9a2f-4a565c72cead@gmail.com>
In-Reply-To: <20191021135510.12657-2-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2959668800876087367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

<snip>

> diff --git a/src/netdev.c b/src/netdev.c
> index 526480dd..23fd980d 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -36,6 +36,7 @@
>   #include <linux/filter.h>
>   #include <sys/socket.h>
>   #include <errno.h>
> +#include <limits.h>

This would suck to have to use INT_MIN everywhere...

>   =

>   #include <ell/ell.h>
>   =


<snip>

> @@ -3511,6 +3512,7 @@ static void netdev_mgmt_frame_event(struct l_genl_m=
sg *msg,
>   	const struct mmpdu_header *mpdu =3D NULL;
>   	const uint8_t *body;
>   	struct frame_prefix_info info;
> +	int rssi =3D INT_MIN;

The kernel uses 0 as a flag value, so can't we do the same?

>   =

>   	if (!l_genl_attr_init(&attr, msg))
>   		return;
> @@ -3527,6 +3529,11 @@ static void netdev_mgmt_frame_event(struct l_genl_=
msg *msg,
>   =

>   			frame_len =3D len;
>   			break;
> +		case NL80211_ATTR_RX_SIGNAL_DBM:
> +			if (len !=3D 4)
> +				break;
> +
> +			rssi =3D *(const int32_t *) data;
>   		}
>   	}
>   =


Regards,
-Denis
--===============2959668800876087367==--

