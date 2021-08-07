Content-Type: multipart/mixed; boundary="===============8162389549297417804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] netdev: move flag setting in netdev_reassociate
Date: Fri, 06 Aug 2021 22:47:49 -0500
Message-ID: <8a07355f-48be-e87d-7596-8c01456d8aa8@gmail.com>
In-Reply-To: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8162389549297417804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/6/21 6:02 PM, James Prestwood wrote:
> In the real world setting the flags prior to netdev_connect_common
> should never cause a problem, but using the developer Roam()
> command will because it forces a roam to occur with no roam scan.
> This ends up running the connect work item immediately which sets
> netdev->connected=3Dtrue, then netdev_reassociate ends
> up setting it false again right after.
> =

> To handle both ways of roaming set the flags prior to
> netdev_connect_common and if it does fail reset them back to
> their original values.
> ---
>   src/netdev.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 74eb349c..e9b4a42c 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -3611,19 +3611,19 @@ int netdev_reassociate(struct netdev *netdev, str=
uct scan_bss *target_bss,
>   	old_sm =3D netdev->sm;
>   	old_hs =3D netdev->handshake;
>   =

> +	netdev->associated =3D false;
> +	netdev->operational =3D false;
> +	netdev->connected =3D false;
> +	netdev->in_reassoc =3D true;
> +

Hmm, so why are we saving/restoring all 4 flags when it is only really conn=
ected =

that is the problem?

>   	ret =3D netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, =
0,
>   					event_filter, cb, user_data);
>   	if (ret < 0)
> -		return ret;
> +		goto reset_flags;

I wonder if we can do something nicer?

One idea might be to call netdev_handshake_state_setup_connection_type() =

earlier, prior to netdev_connect_common as that is the only source of failu=
re =

inside it.  We can then make netdev_connect_common() return void.

Another idea might be to set netdev->connected to false afterward only if =

netdev->ap exists and the work item hasn't started...?

Regards,
-Denis
--===============8162389549297417804==--

