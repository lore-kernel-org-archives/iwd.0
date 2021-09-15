Content-Type: multipart/mixed; boundary="===============4203943568627628251=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 02/13] ie: add ie_parse_owe_transition_from_data
Date: Wed, 15 Sep 2021 14:45:41 -0500
Message-ID: <b4c01b16-b13e-1d27-3890-e2e0738e9cdb@gmail.com>
In-Reply-To: 20210915173624.11917-2-prestwoj@gmail.com

--===============4203943568627628251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/21 12:36 PM, James Prestwood wrote:
> This is a parser for the WFA OWE Transition element. For now the
> optional band/channel bytes will not be parsed as hostapd does not
> yet support these and would also require the 802.11 appendix E-1
> to be added to IWD. Because of this OWE Transition networks are
> assumed to be on the same channel as their open counterpart.
> ---
>   src/ie.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   src/ie.h |  3 +++
>   2 files changed, 46 insertions(+)
> =


<snip>

> +
> +int ie_parse_owe_transition(const void *data, size_t len, uint8_t *bssid,
> +				char ssid[33])

Can we change the signature as follows:
int ie_parse_owe_transition(const void *data,
		size_t len,
		uint8_t out_bssid[static 6],
		char out_ssid[static 33])

See [1] for reasons why

> +{
> +	const uint8_t *ie =3D data;
> +	size_t slen;
> +
> +	if (len < 14 || ie[0] !=3D IE_TYPE_VENDOR_SPECIFIC)
> +		return -ENOMSG;
> +
> +	if (!is_ie_wfa_ie(ie + 2, len - 2, IE_WFA_OI_OWE_TRANSITION))
> +		return -ENOMSG;
> +
> +	slen =3D l_get_u8(ie + 12);
> +	if (slen > 32)
> +		return -ENOMSG;
> +
> +	/*
> +	 * WFA OWE Specification 2.3.1
> +	 *
> +	 * "Band Info and Channel Info are optional fields. If configured,
> +	 * both fields shall be included in an OWE Transition Mode element"
> +	 *
> +	 * TODO: Support Band/Channel bytes:
> +	 * For the time being the OWE transition AP is assumed to be on the same
> +	 * channel as the open AP. This means there should be no band/channel
> +	 * bytes at the end of the IE. Currently hostapd has no support for this
> +	 * so it can be skipped. In addition 802.11 Appendix E-1 needs to be
> +	 * encoded as a table to map Country/operating class to channels to make
> +	 * any sense of it.
> +	 */
> +	if (len !=3D slen + 13)
> +		return -ENOMSG;
> +
> +	memcpy(bssid, ie + 6, 6);
> +
> +	memcpy(ssid, ie + 13, slen);
> +	ssid[slen] =3D '\0';

So we have to be careful here since ssid is not guaranteed to be utf8.  Thi=
s is =

why the scan_bss and handshake_state structures store ssid + length.  For =

anything user-visible we enforce SSID to be UTF8, but in the case of OWE Hi=
dden =

BSS it should be acceptable to have an SSID that isn't.

Regards,
-Denis
--===============4203943568627628251==--

