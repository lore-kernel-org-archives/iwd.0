Content-Type: multipart/mixed; boundary="===============3138236939152870269=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/9] monitor: Print WFD IE contents
Date: Fri, 20 Mar 2020 10:33:21 -0500
Message-ID: <149857cb-92cf-892c-fef9-46670e2bfba0@gmail.com>
In-Reply-To: <20200319211218.32083-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3138236939152870269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/19/20 4:12 PM, Andrew Zaborowski wrote:
> Only print the WFD version 2.1.0 spec subelements which removed all the
> low level video format details from the IEs so this code is much
> shorter.
> ---
>   monitor/nlmon.c | 317 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 303 insertions(+), 14 deletions(-)
> =

> diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> index 087b374f..91a223d6 100644
> --- a/monitor/nlmon.c
> +++ b/monitor/nlmon.c

<snip>

> @@ -3097,7 +3109,6 @@ static void print_p2p_capability(unsigned int level=
, const char *label,
>   	CHECK_CAPS_BIT(P2P_GROUP_CAP_IP_ALLOCATION,
>   			"IP Address Allocation");
>   }
> -#undef CHECK_CAPS_BIT

Don't know if this is intended, but you no longer undef CHECK_CAPS_BIT ...

>   =

>   static void print_p2p_go_intent(unsigned int level, const char *label,
>   				const void *data, uint16_t size)
> @@ -3658,11 +3669,294 @@ static void print_p2p_attributes(unsigned int le=
vel, const char *label,
>   	}
>   }
>   =

> +static void print_wfd_device_info_flags(unsigned int level, const char *=
label,
> +					uint16_t caps)
> +{
> +	static const char *dev_type[4] =3D {
> +		[WFD_DEV_INFO_TYPE_SOURCE] =3D "Source",
> +		[WFD_DEV_INFO_TYPE_PRIMARY_SINK] =3D "Primary sink",
> +		[WFD_DEV_INFO_TYPE_SECONDARY_SINK] =3D "Secondary sink",
> +		[WFD_DEV_INFO_TYPE_DUAL_ROLE] =3D "Dual-role possible",
> +	};
> +#pragma GCC diagnostic ignored "-Woverride-init"

Don't you want to #pragma push and pop instead of disabling this for the =

entire file?

What is this trying to fix anyway?

> +	static const char *session_avail[4] =3D {
> +		[0 ... 3] =3D "Reserved",

Perhaps not trying to initialize the entire array to "Reserved" first

> +		[WFD_DEV_INFO_SESSION_NOT_AVAILABLE >> 4] =3D
> +			"Not available for WFD Session",
> +		[WFD_DEV_INFO_SESSION_AVAILABLE >> 4] =3D
> +			"Available for WFD Session",

And resetting it later  would help?

> +	};
> +

Regards,
-Denis
--===============3138236939152870269==--

