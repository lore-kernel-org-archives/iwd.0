Content-Type: multipart/mixed; boundary="===============4490657308201394854=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netconfig: Set address at configure time
Date: Tue, 28 Sep 2021 10:12:09 -0500
Message-ID: <9fd8b8c2-f341-343d-9ae5-8762c56d8a37@gmail.com>
In-Reply-To: 20210927164214.16006-1-denkenz@gmail.com

--===============4490657308201394854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 9/27/21 11:42 AM, Denis Kenzior wrote:
> netconfig_load_settings is called when establishing a new initial
> association to a network.  This function tries to update dhcp/dhcpv6
> clients with the MAC address of the netdev being used.  However, it is
> too early to update the MAC here since netdev might need to powercycle
> the underlying network device in order to update the MAC (i.e. when
> AddressRandomization=3D"network" is used).
> =

> If the MAC is set incorrectly, DHCP clients are unable to obtain the
> lease properly and station is stuck in "connecting" mode indefinitely.
> Fix this by delaying MAC address update until netconfig_configure() is
> invoked.
> =

> Fixes: ad228461abbf ("netconfig: Move loading settings to new method, ref=
actor")
> ---
>   src/netconfig.c | 17 +++++++++--------
>   src/netconfig.h |  3 +--
>   src/p2p.c       |  3 +--
>   src/station.c   |  3 +--
>   4 files changed, 12 insertions(+), 14 deletions(-)
> =


Applied.

Regards,
-Denis

--===============4490657308201394854==--

