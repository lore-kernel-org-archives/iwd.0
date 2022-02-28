Content-Type: multipart/mixed; boundary="===============5423399829132615451=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Scan while AP - testing
Date: Mon, 28 Feb 2022 08:57:19 -0800
Message-ID: <eeb01d8bb14fdea14fc3a5bcb9297cc14318725a.camel@gmail.com>
In-Reply-To: CAG17S_OWQPk7kZ15L3y-xdKap94NC0yP041NxpDSNiiR01FV8g@mail.gmail.com

--===============5423399829132615451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Thu, 2022-02-24 at 19:45 -0600, KeithG wrote:
> James,
> =

> your v2 seems to work. If I do:
> # iwctl ap wlan0 scan
> # iwctl ap wlan0 get-networks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Networks
> -----------------------------------------------------------------------
> ---------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Proper=
ty=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value
> -----------------------------------------------------------------------
> ---------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 spg2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signal=
Strength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -4100
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Type=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 psk
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 spg3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signal=
Strength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -5700
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Type=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 psk
> =

> Now how do we get connman to scan when iwd is in ap mode... I guess I
> need to post to that group once this gets put in the released version.

This would need to be added to connman since its a completely new DBus
API.

FYI I asked on linux-wireless about this missing AP scan feature for
brcmfmac and someone else also needed very similar functionality, but
achieved it by adding an AP interface along side a station one. I tried
this on brcmfmac and was able to start an AP and concurrently scan on a
station interface.

https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf(a)bang-olufsen.dk/

I think Denis mentioned this back in May but wanted to put it out there
again just so you know it's an option. Still no response from anyone
from broadcom but at least doing an AP + station interface is supported
in terms of iface combinations where scanning on an AP interface is
unclear (yes it works, but I would be worried about putting a
dependency on a feature that isn't advertised). Hopefully we can get a
definitive answer about this.

Thanks,
James

> This is really nice. Thanks for doing this
> =

> Keith
> =

> On Thu, Feb 24, 2022 at 10:36 AM James Prestwood <prestwoj(a)gmail.com>
> wrote:
> > =

> > Hi Keith,
> > =

> > On Thu, 2022-02-24 at 10:24 -0600, KeithG wrote:
> > > Hmmm. Bummer.
> > > =

> > > Can you explain to a less savvy user, how my Pi3b+ is able to scan
> > > while I am running hostapd?
> > > When I run hostapd, I am also running iwd/connman and I can be
> > > connected to the Pi via the hopstapd and with iwd running it can
> > > dynamically scan for available networks. I thought that AP Scan was
> > > a
> > > function/feature of the Pi3 hardware that both programs were able
> > > to
> > > access it and use it simultaneously.
> > =

> > After I replied last night I was thinking perhaps the Pi doesn't
> > advertise the feature... and indeed this is true. I removed the check
> > and scanning worked just fine on the RPi3. So brcmfmac is just lazy
> > and
> > never bothered to include this feature.
> > =

> > I guess, once again, we need to tailor our code to handle this
> > driver,
> > ugh.
> > =

> > I'll send v2 soon.
> > =

> > > =

> > > # iw list | grep supports
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device supports roaming.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device supports scan flush.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device supports randomizin=
g MAC-addr in sched scans.
> > > =

> > > Keith
> > > =

> > > =

> > > On Wed, Feb 23, 2022 at 7:28 PM James Prestwood
> > > <prestwoj(a)gmail.com>
> > > wrote:
> > > > =

> > > > Hi Keith,
> > > > =

> > > > On Wed, 2022-02-23 at 19:08 -0600, KeithG wrote:
> > > > > I applied James' latest suggested patches and was trying to see
> > > > > how
> > > > > this works.
> > > > > =

> > > > > IWD starts and I can get into AP mode and can connect. I tried
> > > > > connman
> > > > > to see if it would scan and got no response.=C2=A0 So I went into
> > > > > iwctl to
> > > > > see and saw this:
> > > > > =

> > > > > Access Point:
> > > > > =C2=A0 ap list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 List
> > > > > devices
> > > > > in
> > > > > AP mode
> > > > > =C2=A0 ap <wlan> start <"network name"> <passphrase>=C2=A0=C2=A0=
=C2=A0=C2=A0 Start an
> > > > > access
> > > > > point
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 called
> > > > > "network
> > > > > name" with
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 a
> > > > > passphrase
> > > > > =C2=A0 ap <wlan> start-profile <"network name">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Start an
> > > > > access
> > > > > point based on a disk profile
> > > > > =C2=A0 ap <wlan> stop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Stop a
> > > > > started
> > > > > access
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 point
> > > > > =C2=A0 ap <wlan> show=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Show AP
> > > > > info
> > > > > =C2=A0 ap <wlan> scan=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Start an AP
> > > > > scan
> > > > > =C2=A0 ap <wlan> get-networks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Get network
> > > > > list
> > > > > after scanning
> > > > > =

> > > > > looking good, but tried it and did not get anything:
> > > > > =

> > > > > [iwd]# ap wlan0 show
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Access Point Interface
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =C2=A0 Settable=C2=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Started=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 yes
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 RuneAudioAP
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Scanning=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 no
> > > > > =

> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cl=
ient 0
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Value
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Address=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 60:f2:62:ae:70:fe
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 TxBitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=
4000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Kbit/s
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 RxBitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=
4000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Kbit/s
> > > > > =

> > > > > [iwd]# ap wlan0 scan
> > > > > Operation not supported
> > > > > [iwd]# ap wlan0 get-networks
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ne=
tworks
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Value
> > > > > ---------------------------------------------------------------
> > > > > --
> > > > > ----
> > > > > -----------
> > > > > =

> > > > > Is this the 'right way'? Are there more settings I need in my
> > > > > main.conf?
> > > > =

> > > > Yes you're doing everything correctly, but most likely your
> > > > driver
> > > > doesn't actually support scanning in AP mode. I had to go through
> > > > a
> > > > few
> > > > of my USB dongles to find one that did.
> > > > =

> > > > You can check support with iw list, and should see this:
> > > > =

> > > > "Device supports AP scan"
> > > > =

> > > > Thanks,
> > > > James
> > > > =

> > > > > =

> > > > > Keith
> > > > =

> > > > =

> > =

> > =



--===============5423399829132615451==--

