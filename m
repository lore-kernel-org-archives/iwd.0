Content-Type: multipart/mixed; boundary="===============8826199865328759870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/8] netdev: parse rates in netdev_get_station
Date: Tue, 12 Jan 2021 13:54:14 -0600
Message-ID: <6ccf25e6-3346-8e0a-6bc9-529cf7c9f3a9@gmail.com>
In-Reply-To: <20210112171723.3025-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8826199865328759870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/12/21 11:17 AM, James Prestwood wrote:
> ---
>   src/netdev.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  9 ++++++++
>   2 files changed, 72 insertions(+)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 879bd275..be24c999 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -368,11 +368,49 @@ int netdev_set_powered(struct netdev *netdev, bool =
powered,
>   	return 0;
>   }
>   =

> +static bool netdev_parse_bitrate(struct l_genl_attr *attr, uint32_t *rat=
e_out,
> +					uint8_t *mcs_out)
> +{
> +	uint16_t type, len;
> +	const void *data;
> +	uint32_t rate =3D 0;
> +	uint8_t mcs =3D 0;
> +
> +	while (l_genl_attr_next(attr, &type, &len, &data)) {
> +		switch (type) {
> +		case NL80211_RATE_INFO_BITRATE32:
> +			if (len !=3D 4)
> +				return false;
> +
> +			rate =3D *(const uint32_t *) data;
> +
> +			break;
> +
> +		case NL80211_RATE_INFO_MCS:
> +			if (len !=3D 1)
> +				return false;
> +
> +			mcs =3D *(const uint8_t *) data;
> +
> +			break;
> +		}
> +	}
> +
> +	if (!rate || !mcs)

So looking at how the kernel reports MCS info, I'm not sure this is entirel=
y =

right.  It seems the kernel can report the VHT MCS index instead of the reg=
ular =

one (or HE one).  So the question is, do we want to report the VHT/non-VHT =
MCS =

indexes separately or report either of them in the mcs index variable.  If =
the =

latter, then we'd need to add some sort of 'tech attribute' to distinguish =
what =

MCS is being meant.  i.e. is it a VHT (802.11ac) MCS index or not.

We should also probably report the bandwidth (5/10/20/40/80/160, etc)

> +		return false;
> +
> +	*rate_out =3D rate;
> +	*mcs_out =3D mcs;
> +
> +	return true;
> +}
> +

Regards,
-Denis
--===============8826199865328759870==--

