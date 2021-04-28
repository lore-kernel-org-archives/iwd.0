Content-Type: multipart/mixed; boundary="===============6608336097542087487=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: zero out diagnostic info
Date: Wed, 28 Apr 2021 11:24:35 -0500
Message-ID: <ff2c412d-fa5d-45cc-bb3d-d97c147af67a@gmail.com>
In-Reply-To: <20210428162113.141720-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6608336097542087487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/28/21 11:21 AM, James Prestwood wrote:
> The info struct is on the stack which leads to the potential
> for uninitialized data access. Zero out the info struct prior
> to calling the get station callback:
> =

> =3D=3D141137=3D=3D Conditional jump or move depends on uninitialised valu=
e(s)
> =3D=3D141137=3D=3D    at 0x458A6F: diagnostic_info_to_dict (diagnostic.c:=
109)
> =3D=3D141137=3D=3D    by 0x41200B: station_get_diagnostic_cb (station.c:3=
620)
> =3D=3D141137=3D=3D    by 0x405BE1: netdev_get_station_cb (netdev.c:4783)
> =3D=3D141137=3D=3D    by 0x4722F9: process_unicast (genl.c:994)
> =3D=3D141137=3D=3D    by 0x4722F9: received_data (genl.c:1102)
> =3D=3D141137=3D=3D    by 0x46F28B: io_callback (io.c:120)
> =3D=3D141137=3D=3D    by 0x46E5AC: l_main_iterate (main.c:478)
> =3D=3D141137=3D=3D    by 0x46E65B: l_main_run (main.c:525)
> =3D=3D141137=3D=3D    by 0x46E65B: l_main_run (main.c:507)
> =3D=3D141137=3D=3D    by 0x46E86B: l_main_run_with_signal (main.c:647)
> =3D=3D141137=3D=3D    by 0x403EA8: main (main.c:490)
> ---
>   src/netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6608336097542087487==--

