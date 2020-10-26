Content-Type: multipart/mixed; boundary="===============7481144568707505483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] util: add util_ip_prefix_tohl
Date: Mon, 26 Oct 2020 16:17:01 -0500
Message-ID: <93c1ec58-afaa-8107-57c1-a984b904314a@gmail.com>
In-Reply-To: <20201026203514.2164608-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7481144568707505483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/26/20 3:35 PM, James Prestwood wrote:
> Parses an IP prefix notation string into prefix, start, end, and
> netmask. All values are returned in host order.
> ---
>   src/util.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/util.h |  3 ++
>   2 files changed, 93 insertions(+)
> =

>   - Moved these two into their own set
>   - Changed the loop to only iterate over the maximum IP string size (16).
>     This prevents looping through a really long (invalid) IP string
>   - Use l_strlcpy instead of memcpy + NULL terminate

<snip>

> +	/*
> +	 * Only iterate over the max length of an IP in case of invalid long
> +	 * inputs.
> +	 */
> +	for (i =3D 0; i < INET_ADDRSTRLEN && ip[i] !=3D '\0'; i++) {
> +		/* Found '/', check the next byte exists and parse prefix */
> +		if (ip[i] =3D=3D '/' && ip[i + 1] !=3D '\0') {
> +			prefix =3D strtol(ip + i + 1, &endp, 10);

I changed this to strtoul and..

> +			if (*endp !=3D '\0')
> +				return false;
> +
> +			break;
> +		}
> +	}

Both applied, thanks.

--===============7481144568707505483==--

