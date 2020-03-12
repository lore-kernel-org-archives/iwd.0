Content-Type: multipart/mixed; boundary="===============7817511699341488155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: update use of l_rtnl_set_mac
Date: Thu, 12 Mar 2020 10:47:04 -0500
Message-ID: <9859fa53-2b51-92ab-6267-87ad845be8eb@gmail.com>
In-Reply-To: <20200311225251.1322818-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7817511699341488155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/11/20 5:52 PM, James Prestwood wrote:
> This API was updated to take an extra boolean which will
> automatically power up the device while changing the MAC
> address. Since this is what IWD does anyways we can avoid
> the need for an intermediate callback and go right into
> netdev_initial_up_cb.
> ---
>   src/netdev.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7817511699341488155==--

