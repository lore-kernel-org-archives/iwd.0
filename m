Content-Type: multipart/mixed; boundary="===============1587522594727171989=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: set connected to false in netdev_reassociate
Date: Fri, 30 Apr 2021 16:22:13 -0500
Message-ID: <9bea686d-64d2-03e9-6930-aa1161c79916@gmail.com>
In-Reply-To: <20210430211526.291301-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1587522594727171989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/30/21 4:15 PM, James Prestwood wrote:
> Commit 1fe5070 added a workaround for drivers which may send the
> connect event prior to the connect callback/ack. This caused IWD
> to fail to start eapol if reassociation was used due to
> netdev_reassociate never setting netdev->connected =3D false.
> =

> netdev_reassociate uses the same code path as normal connections,
> but when the connect callback came in connected was already set
> to true which then prevents eapol from being registered. Then,
> once the connect event comes in, there is no frame watch for
> eapol and IWD doesn't respond to any handshake frames.
> ---
>   src/netdev.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============1587522594727171989==--

