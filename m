Content-Type: multipart/mixed; boundary="===============5769539295787938961=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/3] netdev: only call connect_ok in station/p2p_client
 mode
Date: Wed, 28 Apr 2021 11:36:21 -0500
Message-ID: <f1d09290-21bf-57c4-316a-06eb196ec192@gmail.com>
In-Reply-To: <20210427233452.97024-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5769539295787938961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/27/21 6:34 PM, James Prestwood wrote:
> netdev_connect_ok is only for station/p2p_client modes but AP
> also ends up on the same code path. Check the iftype before
> calling netdev_connect_ok.
> ---
>   src/netdev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Patch 2 & 3 applied, thanks.

Regards,
-Denis

--===============5769539295787938961==--

