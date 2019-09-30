Content-Type: multipart/mixed; boundary="===============2054046496797986744=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/15] netconfig: Decouple netconfig from station obj. for
 MAC assignment
Date: Mon, 30 Sep 2019 11:11:27 -0500
Message-ID: <6bf69907-a77b-9814-1e61-73c45828076b@gmail.com>
In-Reply-To: <20190927195230.15998-3-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2054046496797986744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 9/27/19 2:52 PM, Tim Kourt wrote:
> netconfig defines netconfig_mac_address_func_t type. This function
> pointier can be implemented by the callers to provide the netconfig=E2=80=
=99s
> DHCP clients with an updated MAC address when it is about to be used.
> This patch is decoupling netconfig from station object and foreseeing
> the randomization of the MAC addresses in the future.
> ---
>   src/netconfig.c | 38 +++++++++++++++++++++++++++++---------
>   src/netconfig.h |  6 +++++-
>   src/station.c   | 11 ++++++++++-
>   3 files changed, 44 insertions(+), 11 deletions(-)
>

<snip>

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 2074689f..b12e29fd 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -48,6 +48,9 @@ struct netconfig {
>   	struct l_dhcp_client *dhcp_client;
>   	struct l_queue *ifaddr_list;
>   	uint8_t rtm_protocol;
> +
> +	netconfig_mac_address_func_t mac_address;
> +	void *user_data;

So I don't think this is necessary.  The mac address right now will be =

static for the duration of netconfig's lifetime.  So providing the mac =

at configure time (and maybe teardown) is sufficient.

Regards,
-Denis
--===============2054046496797986744==--

