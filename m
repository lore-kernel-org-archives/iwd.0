Content-Type: multipart/mixed; boundary="===============8823457171390919591=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netdev: Initialize signal level during connection attempt
Date: Mon, 23 May 2022 12:38:32 -0500
Message-ID: <939cb234-1f21-e1ba-6865-0d853a1e5d16@gmail.com>
In-Reply-To: 20220523042843.14058-1-jesse@twosheds.org

--===============8823457171390919591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/22/22 23:28, Jesse Lentz wrote:
> The call to netdev_rssi_level_init() in netdev_connect_common() is
> currently a no-op, because netdev->connected has not yet been set at
> this stage of the connection attempt. Because netdev_rssi_level_init()
> is only used twice, it's been replaced by two inlined calls to
> netdev_set_rssi_level_idx().
> ---
>   src/netdev.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8823457171390919591==--

