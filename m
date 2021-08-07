Content-Type: multipart/mixed; boundary="===============7448331238494549756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: allow reassociation for auth-protos
Date: Fri, 06 Aug 2021 22:08:56 -0500
Message-ID: <dea8921a-3044-61e7-135c-dbd8721114ca@gmail.com>
In-Reply-To: <20210806225905.381445-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7448331238494549756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/6/21 5:59 PM, James Prestwood wrote:
> This adds support in netdev_reassociate for all the auth
> protocols (SAE/FILS/OWE) by moving the bulk of netdev_connect
> into netdev_connect_common. In addition PREV_BSSID is set
> in the associate message if 'in_reassoc' is true.
> ---
>   src/netdev.c | 140 ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 76 insertions(+), 64 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7448331238494549756==--

