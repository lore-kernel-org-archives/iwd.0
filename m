Content-Type: multipart/mixed; boundary="===============4729933621824284254=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/7] netdev: handle non-fatal auth-proto returns
Date: Wed, 08 Sep 2021 14:43:15 -0500
Message-ID: <3d251684-ab1e-4486-c75d-9fec639fbb4a@gmail.com>
In-Reply-To: <20210908181904.84594-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4729933621824284254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 1:19 PM, James Prestwood wrote:
> This adds -EBADMSG/-ENOMSG to returns which won't result in
> a deauth/failed connection.
> ---
>   src/netdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 7909c37e..8bbd5abb 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -2715,7 +2715,8 @@ static void netdev_authenticate_event(struct l_genl=
_msg *msg,
>   		status_code =3D L_CPU_TO_LE16(auth->status);
>   =

>   		ret =3D auth_proto_rx_authenticate(netdev->ap, frame, frame_len);
> -		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN)
> +		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN || ret =3D=3D -EBADMSG ||
> +						ret =3D=3D -ENOMSG)

So we may have to be a bit careful here.  If we receive -EBADMSG/-ENOMSG an=
d the =

status_code !=3D 0, kernel won't keep retransmitting the Authenticate frame=
.  So =

we would never actually leave the connecting state in this case...

I guess we could ignore EBADMSG/ENOMSG only if status_code =3D=3D 0, and ot=
herwise =

just let the connection fail.

>   			return;
>   		else if (ret > 0)
>   			status_code =3D (uint16_t)ret;
> =


Regards,
-Denis
--===============4729933621824284254==--

