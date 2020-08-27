Content-Type: multipart/mixed; boundary="===============6834481280563093572=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] wscutil: Add wsc_build_beacon
Date: Thu, 27 Aug 2020 14:16:58 -0500
Message-ID: <2927b86f-c1ef-82b4-efe0-ab0d8069b717@gmail.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6834481280563093572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> ---
>   src/wscutil.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/wscutil.h |  1 +
>   2 files changed, 60 insertions(+)
> =


<snip>

> +
> +	/* These two "should be provided" if dual-band */
> +	if (beacon->rf_bands & (beacon->rf_bands - 1)) {

I probably missed this in the earlier review, but would it be more clear to =

check rf_bands & ~WSC_RF_BAND_2_4_GHZ here instead?

> +		if (beacon->selected_registrar)
> +			build_uuid_e(builder, beacon->uuid_e);
> +
> +		build_rf_bands(builder, beacon->rf_bands);
> +	}
> +
> +	if (!beacon->version2)
> +		goto done;
> +
> +	START_WFA_VENDOR_EXTENSION();
> +
> +	if (!util_mem_is_zero(beacon->authorized_macs, 30)) {
> +		int count;
> +
> +		for (count =3D 1; count < 5; count++)
> +			if (util_mem_is_zero(beacon->authorized_macs + count * 6,
> +						30 - count * 6))
> +				break;
> +
> +		wsc_attr_builder_put_u8(builder,
> +					WSC_WFA_EXTENSION_AUTHORIZED_MACS);
> +		wsc_attr_builder_put_u8(builder, count * 6);
> +		wsc_attr_builder_put_bytes(builder, beacon->authorized_macs,
> +						count * 6);
> +	}

I'm guilty of copy-pasting as much as anyone, but could we make a utility f=
or =

this?  Also, wouldn't it make more sense to run util_mem_is_zero backwards =
6 =

bytes at a time instead of pounding the array 6 times?

Regards,
-Denis
--===============6834481280563093572==--

