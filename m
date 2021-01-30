Content-Type: multipart/mixed; boundary="===============6308924553218657268=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] ap: Fix cleanup on ap_parse_new_station_ies errors
Date: Fri, 29 Jan 2021 20:11:24 -0600
Message-ID: <1dddf52f-579a-eed7-9754-c12fc2afee83@gmail.com>
In-Reply-To: <20210129232740.27393-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6308924553218657268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/29/21 5:27 PM, Andrew Zaborowski wrote:
> ---
>   src/ap.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> =

> diff --git a/src/ap.c b/src/ap.c
> index c4715696..1e028122 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -2211,14 +2211,15 @@ static bool ap_parse_new_station_ies(const void *=
data, uint16_t len,
>   	while (ie_tlv_iter_next(&iter)) {
>   		switch (ie_tlv_iter_get_tag(&iter)) {
>   		case IE_TYPE_RSN:
> -			if (ie_parse_rsne(&iter, NULL) < 0)
> +			if (rsn || ie_parse_rsne(&iter, NULL) < 0)

This may be going beyond being simply paranoid since the kernel is giving t=
hese =

messages to us, but ok...

>   				goto parse_error;
>   =

>   			rsn =3D l_memdup(ie_tlv_iter_get_data(&iter) - 2,
>   					ie_tlv_iter_get_length(&iter) + 2);
>   			break;
>   		case IE_TYPE_EXTENDED_SUPPORTED_RATES:
> -			if (ap_parse_supported_rates(&iter, &rates) < 0)
> +			if (rates || ap_parse_supported_rates(&iter, &rates) <
> +					0)
>   				goto parse_error;
>   =

>   			break;

Applied, thanks.

Regards,
-Denis
--===============6308924553218657268==--

