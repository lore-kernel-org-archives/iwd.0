Content-Type: multipart/mixed; boundary="===============5367237902215052834=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems attempting to use ad-hoc mode, link state remains dormant
Date: Wed, 08 Apr 2020 15:40:32 +0000
Message-ID: <310f0fa3-59b8-af57-4d64-1de5229861d4@gmail.com>
In-Reply-To: <VI1PR01MB516745587146DE6E49DAD11488C00@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5367237902215052834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

> However, =E2=80=9Cip link show dev wlan0" shows =E2=80=9CNO-CARRIER=E2=80=
=9D on both devices =

> with state DORMANT and mode DORMANT.
> =

> 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq =

> state DORMANT mode DORMANT group default qlen 1000
> =

>  =C2=A0=C2=A0=C2=A0 link/ether 34:e1:2d:24:03:42 brd ff:ff:ff:ff:ff:ff
> =

> When doing it manually with iw the state was UP and the mode DEFAULT, so =

> I manually changed the state with =E2=80=9Cip link set wlan0 state up". A=
fter =

> that =E2=80=9Cip link=E2=80=9D no longer shows NO-CARRIER and pings worke=
d. Changing the =

> mode was not necessary.
> =

> Is there something that I am missing? Or maybe something which is =

> missing in iwd in adhoc mode?

This is indeed a bug in iwd.  We somehow missed sending the required =

linkmode / operstate changes when adhoc is operated in the 'open' mode. =

i.e. a call to l_rtnl_set_linkmode_and_operstate is missing in =

src/adhoc.c adhoc_new_station() around line 415.

The tricky part is that adhoc doesn't initialize its own rtnl object, so =

I need to think about a good fix for this.

Regards,
-Denis
--===============5367237902215052834==--

