Content-Type: multipart/mixed; boundary="===============1700192997219971179=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] ap: Refactor DHCP settings loading
Date: Tue, 01 Jun 2021 10:10:24 -0500
Message-ID: <72f940b6-08df-fe80-c2fe-de89e6511d45@gmail.com>
In-Reply-To: <20210528004737.2878442-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1700192997219971179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Extend the [IPv4].Address setting's syntax to allow a new format: a list
> of <IP>/<prefix_len> -form strings that define the address space from
> which a subnet is selected.  Rewrite the DHCP settings loading with
> other notable changes:
> =

>   * validate some of the settings more thoroughly,
>   * name all netconfig-related ap_state members with the netconfig_
>     prefix,
>   * make sure we always call l_dhcp_server_set_netmask(),
>   * allow netmasks other than 24-bit and change the default to 28 bits,
>   * as requested avoid using the l_net_ ioctl-based functions although
>     l_dhcp still uses them internally,
>   * as requested avoid touching the ap_state members until the end of
>     some functions so that on error they're basically a no-op (for
>     readabaility).

I fixed this typo above and..

> ---
>   src/ap.c | 451 +++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 288 insertions(+), 163 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1700192997219971179==--

