Content-Type: multipart/mixed; boundary="===============4970647281878987072=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 10:50:59 -0500
Message-ID: <f01c200b-daa1-1070-057a-0ec53f305fc9@gmail.com>
In-Reply-To: CAOf5uwnuGdxHVriSBEeS=UMOSRf_4RksbqbMKLoM8cOP5fUObw@mail.gmail.com

--===============4970647281878987072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

>> Our (preliminary) thinking on this was to add a main.conf entry that tel=
ls iwd
>> how it should manage wiphys by default.  Something like: "sta-only", "st=
a+p2p",
>> "sta+ap".  Based on the configured setting, iwd would then create the in=
terfaces
> =

> I think that this the best is to extend the mode and add Mode =3D sta+ap
> =


Oh, and I guess you meant extending net.connman.iwd.Device.Mode.  That can'=
t =

really be done since Device maps to a netdev.  The choice of STA+AP vs STA-=
only =

would be on the wiphy level (net.connman.iwd.Adapter).

Regards,
-Denis
--===============4970647281878987072==--

