Content-Type: multipart/mixed; boundary="===============8582914284276982282=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/4] netdev: move failure point out of
 netdev_connect_common
Date: Thu, 12 Aug 2021 13:07:19 -0500
Message-ID: <644a844c-f902-b066-8b38-5e825dd3f9da@gmail.com>
In-Reply-To: <20210809174259.537399-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8582914284276982282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/9/21 12:42 PM, James Prestwood wrote:
> The only point of failure in netdev_connect_common was setting
> up the handshake type. Moving this outside of netdev_connect_common
> makes the code flow much better in netdev_{connect,reassociate} as
> nothing needs to be reset upon failure.
> ---
>   src/netdev.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> =


<snip>

> @@ -3534,7 +3532,7 @@ build_cmd_connect:
>   	wiphy_radio_work_insert(netdev->wiphy, &netdev->work, 1,
>   				&connect_work_ops);
>   =

> -	return 0;
> +	return;

I amended to get rid of this un-needed return statement

>   }
>   =

>   int netdev_connect(struct netdev *netdev, struct scan_bss *bss,

Applied, thanks.

Regards,
-Denis
--===============8582914284276982282==--

