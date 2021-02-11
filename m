Content-Type: multipart/mixed; boundary="===============0019063998045994873=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] src: configure systemd-resolved's MulticastDNS= setting
Date: Thu, 11 Feb 2021 14:48:37 -0600
Message-ID: <518cc141-be71-f209-53cb-850c4caf7923@gmail.com>
In-Reply-To: <20210211181141.HsvTv%ephemient@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0019063998045994873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/11/21 12:11 PM, Daniel Lin wrote:
> When using iwd.conf:[General].EnableNetworkConfiguration=3Dtrue, it is not
> possible to configure systemd.network:[Network].MulticastDNS=3D as
> systemd-networkd considers the link to be unmanaged. This patch allows
> iwd to configure that setting on systemd-resolved directly.
> ---
>   src/iwd.config.rst |  7 +++++
>   src/netconfig.c    |  6 ++++
>   src/resolve.c      | 70 ++++++++++++++++++++++++++++++----------------
>   src/resolve.h      |  1 +
>   4 files changed, 60 insertions(+), 24 deletions(-)
> =


LGTM, only nitpick is..

> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index 0064dfd2..d430909a 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -212,6 +212,13 @@ The group ``[Network]`` contains network configurati=
on related settings.
>   =

>          If not specified, ``300`` is used as default.
>   =

> +   * - MulticastDNS
> +     - Values: true, **false**, resolve

As discussed in the v1 reply, we should not indicate a default and mention =
that =

this setting isn't set at all if omitted.

> +
> +       Configures multicast DNS. See ``man 5 systemd.network`` for detai=
ls.
> +
> +       Only applies when ``NameResolvingService=3Dsystemd``.
> +
>   Blacklist
>   ---------
>   =


Regards,
-Denis

--===============0019063998045994873==--

