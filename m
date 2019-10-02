Content-Type: multipart/mixed; boundary="===============5738403939526236698=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/5] netconfig: Install IPv6 DNS
Date: Wed, 02 Oct 2019 12:14:29 -0500
Message-ID: <9fc2ff3a-b0c6-fe3f-f6e8-c63cba5793aa@gmail.com>
In-Reply-To: <20191001234425.22913-5-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5738403939526236698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/1/19 6:44 PM, Tim Kourt wrote:
> ---
>   src/netconfig.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 129fe518..65ba5330 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -323,6 +323,50 @@ static char *netconfig_ipv6_get_gateway(struct netco=
nfig *netconfig)
>   	return NULL;
>   }
>   =

> +static char **netconfig_ipv6_get_dns(struct netconfig *netconfig, uint8_=
t proto)
> +{
> +	struct in6_addr in6_addr;
> +	char **dns_list;
> +	char **p;
> +
> +	switch (proto) {
> +	case RTPROT_STATIC:
> +		if (!netconfig->active_settings)
> +			return NULL;
> +

Took out this check, same reasoning as the previous commit.

Applied, thanks.

Regards,
-Denis
--===============5738403939526236698==--

