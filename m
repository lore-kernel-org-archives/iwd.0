Content-Type: multipart/mixed; boundary="===============1066688431149142329=="
MIME-Version: 1.0
From: Kourt, Tim A <tim.a.kourt@linux.intel.com>
Subject: Re: Cannot get ap mode to work
Date: Wed, 03 Jun 2020 11:19:53 -0700
Message-ID: <11473749-6da8-4431-95aa-799a633867ae@linux.intel.com>
In-Reply-To: <CAG17S_NU=nmTMUf=z5ceSEZ4ow2Cw4kfHTZ9NBZ6zvXMynNksA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1066688431149142329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 6/3/2020 10:17 AM, KeithG wrote:
>
> ~# iwctl device wlan0 show
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Device: wlan0
> -------------------------------------------------------------------------=
-------
> =C2=A0 Settable =C2=A0Property =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0V=
alue
> -------------------------------------------------------------------------=
-------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wlan0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0Mode =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ap
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0Powered =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Address =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 b8:27:eb:52:cc:d0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 phy0
>
> ~# iwctl ap wlan0 start "MyNet" "password"
>
If the quotes are not part of the password, try to remove them.

Regards,
Tim

--===============1066688431149142329==--

