Content-Type: multipart/mixed; boundary="===============0896408144547703489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 10:19:31 -0500
Message-ID: <a71d991f-16cb-202e-74f4-744c70bd3952@gmail.com>
In-Reply-To: CAOf5uwnuGdxHVriSBEeS=UMOSRf_4RksbqbMKLoM8cOP5fUObw@mail.gmail.com

--===============0896408144547703489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

>> automagically (assuming hardware/driver supports it,  falling back to "s=
ta-only"
>> if not).
> =

> Some hardware has the limitation to use only one channel
> in this configuration. The idea is to able to decide to go on not go
> in this configuration using dbus
> =


I haven't looked into this in much detail.  I know nl80211 APIs do provide =
some =

information as to what interface combinations the hardware supports.  Not s=
ure =

if/how it tells userspace about channel limitations.  If you know more, ple=
ase =

share.

But yes, we probably would need to expose some of this info via D-Bus or te=
ach =

AccessPoint.Start/StartProfile to only use the active STA channel if the =

hardware has such limitations.

Regards,
-Denis
--===============0896408144547703489==--

