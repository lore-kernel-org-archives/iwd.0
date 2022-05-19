Content-Type: multipart/mixed; boundary="===============8251285341716583761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Thu, 19 May 2022 09:53:23 -0500
Message-ID: <7a04d073-1b24-5d83-fe33-aebb787fd562@gmail.com>
In-Reply-To: 20220518143915.105007-1-mjohnson459@gmail.com

--===============8251285341716583761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/18/22 09:39, Michael Johnson wrote:
> Allows granularly specifying the DHCP logging level. This allows the
> user to tailor the output to what they need. By default, always display
> info, errors and warnings to match the rest of iwd.
> =

> Setting `IWD_DHCP_DEBUG` to "debug", "info", "warn", "error" will limit
> the logging to that level or higher allowing the default logging
> verbosity to be reduced.
> =

> Setting `IWD_DHCP_DEBUG` to "1" as per the current behavior will
> continue to enable debug level logging.
> ---
>   src/netconfig.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> =


<snip>

> +		if (strcmp("debug", debug_level) =3D=3D 0)

We prefer !strcmp instead of comparing with 0, so I amended this.

> +			dhcp_priority =3D L_LOG_DEBUG;
> +		else if (strcmp("info", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_INFO;
> +		else if (strcmp("warn", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_WARNING;
> +		else if (strcmp("error", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_ERR;
> +		else 	/* Default for backwards compatibility */

And I think there was a stray whitespace before <tab> that I took care of a=
s well.

> +			dhcp_priority =3D L_LOG_DEBUG;
> +	}
> +

Both patches applied, thanks!

Regards,
-Denis
--===============8251285341716583761==--

