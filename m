Content-Type: multipart/mixed; boundary="===============6184298009672100665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/5] netconfig: Install IPv6 default route
Date: Wed, 02 Oct 2019 12:12:12 -0500
Message-ID: <84e26ce7-27b1-d24d-2115-9bb59c42cb36@gmail.com>
In-Reply-To: <20191001234425.22913-4-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6184298009672100665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/1/19 6:44 PM, Tim Kourt wrote:
> ---
>   src/netconfig.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 7d26acb0..129fe518 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -289,6 +289,40 @@ proceed:
>   	return NULL;
>   }
>   =

> +static char *netconfig_ipv6_get_gateway(struct netconfig *netconfig)
> +{
> +	struct in6_addr in6_addr;
> +	char *gateway;
> +
> +	switch (netconfig->rtm_v6_protocol) {
> +	case RTPROT_STATIC:
> +		if (!netconfig->active_settings)
> +			return NULL;
> +

I took out this check.  active_settings should never be NULL, so thee =

principle of crash early applies.  Also, since we're moving validation =

to _configure eventually, the need for this check is even less justifiable.

Applied, thanks.

Regards,
-Denis
--===============6184298009672100665==--

