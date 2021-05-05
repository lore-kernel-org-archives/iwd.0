Content-Type: multipart/mixed; boundary="===============8248121788260873852=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] iwd-dbus: deny Roam() method for shipped dbus config
Date: Wed, 05 May 2021 18:03:26 +0200
Message-ID: <0951707C-1373-4A11-A158-375A60EAEEF6@holtmann.org>
In-Reply-To: <20210505155328.431557-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8248121788260873852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> This is not a production method and it is recommended to deny access
> unless being used for testing.
> ---
> src/iwd-dbus.conf | 4 ++++
> 1 file changed, 4 insertions(+)
> =

> diff --git a/src/iwd-dbus.conf b/src/iwd-dbus.conf
> index 6b07ba9e..c36401c8 100644
> --- a/src/iwd-dbus.conf
> +++ b/src/iwd-dbus.conf
> @@ -11,20 +11,24 @@
>     <allow own=3D"net.connman.iwd"/>
>     <allow send_destination=3D"net.connman.iwd"/>
>     <allow send_interface=3D"net.connman.iwd.Agent"/>
> +    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_memb=
er=3D"Roam"/>
>   </policy>
> =

>   <policy group=3D"wheel">
>     <allow send_destination=3D"net.connman.iwd"/>
>     <allow send_interface=3D"net.connman.iwd.Agent"/>
> +    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_memb=
er=3D"Roam"/>
>   </policy>
> =

>   <policy at_console=3D"true">
>     <allow send_destination=3D"net.connman.iwd"/>
>     <allow send_interface=3D"net.connman.iwd.Agent"/>
> +    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_memb=
er=3D"Roam"/>
>   </policy>
> =

>   <policy context=3D"default">
>     <deny send_destination=3D"net.connman.iwd"/>
> +    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_memb=
er=3D"Roam"/>
>   </policy>
> =

> </busconfig>

I actually dislike this. If something that is just for developers, then we =
should add a switch that starts iwd in developer mode and then these method=
s are added.

My problem is that even if you add a policy here, the D-Bus introspection w=
ill still show the method to everybody.

Regards

Marcel

--===============8248121788260873852==--

