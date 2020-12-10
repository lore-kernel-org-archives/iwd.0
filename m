Content-Type: multipart/mixed; boundary="===============3346894693906752478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] netconfig: add ACD client for static configuration
Date: Thu, 10 Dec 2020 22:20:47 +0000
Message-ID: <f68e8699-ef76-78c8-730a-20dab69d6561@gmail.com>
In-Reply-To: <20201210212210.880245-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3346894693906752478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/10/20 3:22 PM, James Prestwood wrote:
> When the IP is configured to be static we can now use ACD in
> order to check that the IP is available and not already in
> use. If a conflict is found netconfig will be reset and no IP
> will be set on the interface. The ACD client is left with
> the default 'defend once' policy, and probes are not turned
> off. This will increase connection time, but for static IP's
> it is the best approach.
> ---
>   src/netconfig.c | 94 +++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 76 insertions(+), 18 deletions(-)
> =

> v2:
>   * Added netconfig_reset_v4 to allow a failed ACD attempt to
>     reset only the IPv4 data.
>   * Distinguish between CONFLICT/LOST events. For conflicts
>     no IP was ever set in the kernel, so we can just clean up
>     the rtnl address directly. For LOST events an address was
>     set, so it would need to be deleted.
> =


Both applied, thanks

Regards,
-Denis

--===============3346894693906752478==--

