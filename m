Content-Type: multipart/mixed; boundary="===============8305975488468958761=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: Problems attempting to use ad-hoc mode, link state remains dormant
Date: Wed, 08 Apr 2020 16:25:18 +0000
Message-ID: <
 <VI1PR01MB51672539A45DA230833C35A788C00@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <310f0fa3-59b8-af57-4d64-1de5229861d4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8305975488468958761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Diego,
> =

> > However, "ip link show dev wlan0" shows "NO-CARRIER" on both devices
> > with state DORMANT and mode DORMANT.
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
> qdisc mq
> > state DORMANT mode DORMANT group default qlen 1000
> >
> >  =C2=A0=C2=A0=C2=A0 link/ether 34:e1:2d:24:03:42 brd ff:ff:ff:ff:ff:ff
> >
> > When doing it manually with iw the state was UP and the mode DEFAULT,
> so
> > I manually changed the state with "ip link set wlan0 state up". After
> > that "ip link" no longer shows NO-CARRIER and pings worked. Changing the
> > mode was not necessary.
> >
> > Is there something that I am missing? Or maybe something which is
> > missing in iwd in adhoc mode?
> =

> This is indeed a bug in iwd.  We somehow missed sending the required
> linkmode / operstate changes when adhoc is operated in the 'open' mode.
> i.e. a call to l_rtnl_set_linkmode_and_operstate is missing in
> src/adhoc.c adhoc_new_station() around line 415.
> =

> The tricky part is that adhoc doesn't initialize its own rtnl object, so
> I need to think about a good fix for this.
> =


Thanks for the information, indeed it looked to me that there was something=
 missing but I could not really figure it out for sure from the code. I do =
not think I can help out there.

I am looking into ap mode now and I got it to work by putting the either th=
e Intel AC 9260 or Intel 8265 / 8275 (that is putting either in ap mode and=
 connection from the other in station mode work fine).

However, I have another device with an Atheros QCA6174 (ath10k_pci driver) =
and if I put it into ap mode no other station sees it (Windows laptop, Linu=
x laptop, iPhone). Do you know if there is anything special to do to use ap=
 mode on these devices?

Best,
Diego

 =

-- =

Diego Santa Cruz, PhD
Technology Architect
spinetix.com
=20
--===============8305975488468958761==--

