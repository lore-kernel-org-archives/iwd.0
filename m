Content-Type: multipart/mixed; boundary="===============6796577490823143557=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd problems on Arch Linux
Date: Thu, 15 Oct 2020 11:48:03 -0500
Message-ID: <92041f9d-0da3-1701-bb39-929e6ac4ab77@gmail.com>
In-Reply-To: <CAG17S_O-2pk_b9sDt2-MNdeH4mrbhpzhurGybaYA=NBfVf9U6w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6796577490823143557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 10/14/20 6:52 PM, KeithG wrote:
> I have been struggling with this problem for a while and *think* I have n=
arrowed =

> it down to an Arch Linux problem. My main focus is to get iwd/connman to =
work on =

> my RPis as iwd connects so much faster when it works. Current versions on=
 Arch =

> Linux are Connman =3D 1.38 and iwd =3D 1.9. The kernel I'm running is 5.4=
.70.
> =

> It does not behave absolutely consistently but there are themes. If I hav=
e =

> connman managing the connections, when the SSID goes away, iwd stops scan=
ning. =

> This is very consistent. It does it first time every time. SSID goes down=
, it =

> disconnects and sits there. On Arch Linux, it does not seem to be depende=
nt on =

> card (broadcom/intel) or hardware (x86_64,armv6/armv7/aarch64). iwd quits =

> scanning when the SSID goes away. The monitor-iwd script shows 'Scanning =
=3D =

> False' and it never rescans.

Connman invokes Station.Disconnect() which tells iwd to also not enter into=
 its =

own Autoconnect phase.  I think the idea is for ConnMan to scan periodicall=
y, =

but I guess it doesn't do this for whatever reason.

> When I use systemd-networkd with iwd, I get better behavior, but it can a=
lso get =

> to a point where it quits scanning. This happens after a few times of tur=
ning =

> off then on the AP on the router. When it quits scanning, monitor-iwd say=
s =

> "Scanning =3D False" and it never rescans. The last time I ran it, the mo=
nitor-iwd =

> script says Scanning =3D True then immediately Scanning =3D False but not=
hing was =

> scanned. It did this 13 times but never 'saw' anything nor connected. If =
I down =

> then up the interface (ifconfig wlan0 down; ifconfig wlan0 up), it immedi=
ately =

> connects. I now have a script that runs when the interface goes down to d=
o this =

> (down/up), but shouldn't iwd eventually reconnect?

We would need to see iwd debug logs and iwmon logs to say much more...

https://iwd.wiki.kernel.org/debugging

> =

> This contrasts with the same computer running RasPiOS. It is running the =
same =

> kernel and the same broadcom firmware (I updated both to be identical) co=
nnman =

> is 1.36 and iwd is 0.14, but it works every time all the time. I cannot g=
et it =

> to not reconnect. In fact it connects faster than the web page for the ro=
uter =

> registers it.
> =

> I built iwd 0.14 and connman 1.36 for the Arch install and it behaves the=
 same =

> as iwd 1.9 or the iwd git master build. It just quits.
> =

> What underlying OS issues could cause this? I have built the kernel with =
the =

> same config options for both installations with the same computer doing t=
he =

> building. Both installations are using the same kernel, firmware and driv=
er =

> version (built with the kernel).
> =


Hard to say without logs...

Regards,
-Denis
--===============6796577490823143557==--

