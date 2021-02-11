Content-Type: multipart/mixed; boundary="===============1775064245544033726=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] src: configure systemd-resolved's MulticastDNS= setting
Date: Thu, 11 Feb 2021 15:08:02 -0600
Message-ID: <b9d6e5a9-b16b-cc55-fc19-871cd6dd229c@gmail.com>
In-Reply-To: <20210211205417.U5ob5%ephemient@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1775064245544033726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 2/11/21 2:54 PM, Daniel Lin wrote:
> When using iwd.conf:[General].EnableNetworkConfiguration=3Dtrue, it is not
> possible to configure systemd.network:[Network].MulticastDNS=3D as
> systemd-networkd considers the link to be unmanaged. This patch allows
> iwd to configure that setting on systemd-resolved directly.
> ---
>   src/iwd.config.rst |  9 ++++++
>   src/netconfig.c    |  6 ++++
>   src/resolve.c      | 70 ++++++++++++++++++++++++++++++----------------
>   src/resolve.h      |  1 +
>   4 files changed, 62 insertions(+), 24 deletions(-)
> =


I tweaked the line breaks in the patch slightly to fit on 80 char columns.

Applied, thanks.

Regards,
-Denis

--===============1775064245544033726==--

