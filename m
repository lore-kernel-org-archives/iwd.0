Content-Type: multipart/mixed; boundary="===============3173954873317597216=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Sat, 09 Nov 2019 03:06:48 +0100
Message-ID: <6D926FBC-216A-4512-8040-B0CA569B0754@holtmann.org>
In-Reply-To: <20191108220402.10282-4-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3173954873317597216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

> ---
> src/scan.c | 82 ++++++++++++++++++++++++++++--------------------------
> 1 file changed, 42 insertions(+), 40 deletions(-)
> =

> diff --git a/src/scan.c b/src/scan.c
> index a3d6e5d8..f99ad1e7 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -308,6 +308,45 @@ static void scan_build_attr_ie(struct l_genl_msg *ms=
g,
> 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, iov_elems);
> }
> =

> +static void scan_build_attr_tx_no_cck_rates(struct l_genl_msg *msg,
> +							struct scan_context *sc)
> +{
> +	static const uint8_t b_rates[] =3D { 2, 4, 11, 22 };
> +	uint8_t *scan_rates;
> +	const uint8_t *supported;
> +	unsigned int num_supported;
> +	unsigned int count;
> +	unsigned int i;
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0, NULL);
> +
> +	/*
> +	 * Assume if we're sending the probe requests at OFDM bit
> +	 * rates we don't want to advertise support for 802.11b rates.
> +	 */
> +	if (L_WARN_ON(!(supported =3D wiphy_get_supported_rates(sc->wiphy,
> +							NL80211_BAND_2GHZ,
> +							&num_supported))))
> +		return;

these kind of =E2=80=9Cnested=E2=80=9D statements become really hard to rea=
d and check if they are correct.

	supported =3D wiphy_get_supported_rates(sc->wiphy, ..);
	if (L_WARN_ON(!supported))
		return;

I realize that this code is the same as below, but lets improve readability=
 as well. It is fine to submit a cleanup patch to improve readability if we=
 find such places.

Regards

Marcel

--===============3173954873317597216==--

