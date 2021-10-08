Content-Type: multipart/mixed; boundary="===============5995239199647908974=="
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael at amarulasolutions.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 18:40:38 +0200
Message-ID: <CAOf5uwmuz-S8_XO9HD-h_2rr5YOi6M50Fg4nh9yXYkCh2mEVTA@mail.gmail.com>
In-Reply-To: f01c200b-daa1-1070-057a-0ec53f305fc9@gmail.com

--===============5995239199647908974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 8, 2021 at 5:52 PM Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> >> Our (preliminary) thinking on this was to add a main.conf entry that t=
ells iwd
> >> how it should manage wiphys by default.  Something like: "sta-only", "=
sta+p2p",
> >> "sta+ap".  Based on the configured setting, iwd would then create the =
interfaces
> >
> > I think that this the best is to extend the mode and add Mode =3D sta+ap
> >
>
> Oh, and I guess you meant extending net.connman.iwd.Device.Mode.  That ca=
n't
> really be done since Device maps to a netdev.  The choice of STA+AP vs ST=
A-only
> would be on the wiphy level (net.connman.iwd.Adapter).

Ok

Anyway I have tested but it seems that it does not work for me.
Virtual node are there
but iwd pick one of them and they are not destroyed as you said

Michael


>
> Regards,
> -Denis



-- =

Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael(a)amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info(a)amarulasolutions.com
www.amarulasolutions.com
--===============5995239199647908974==--

