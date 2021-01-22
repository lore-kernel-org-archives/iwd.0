Content-Type: multipart/mixed; boundary="===============6826676805405093827=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 15:23:49 +0100
Message-ID: <977EC844-07CA-4C62-9D07-ED47C97A52E8@holtmann.org>
In-Reply-To: <eea8d062-2ffb-a1d9-8bbc-5b9b7eafca5b@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6826676805405093827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

>>> systemd specifies a special passive target unit 'network-pre.target'
>>> which may be pulled in by services that want to run before any network
>>> interface is brought up or configured. Correspondingly, network
>>> management services such as iwd and ead should specify
>>> After=3Dnetwork-pre.target to ensure a proper ordering with respect to
>>> this special target.
>>> =

>>> For more information, see systemd.special(7) and [1].
>>> =

>>> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fwww.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2FNetworkTarget%2F&amp;dat=
a=3D04%7C01%7CALSI%40bang-olufsen.dk%7Ca9129a1177e04d6a153008d8bedee80e%7C2=
10d08b883f7470abc96381193ca14a1%7C0%7C0%7C637469211873327131%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;sdata=3DK3cEG17BYuVdWg9JlwqCIpmOkGYa1esk8gdFbGewuME%3D&amp;res=
erved=3D0
>> =

>> so what does this really do in practice. Both daemons are fully hotplug =
aware and it makes no difference when they are started.
> =

> I can give two examples.
> =

> The first is practical and we encountered it in our embedded system. The =

> second is hypothetical, but perhaps a little more convincing.
> =

> 1. We have a oneshot service which must run to perform some platform =

> specific configuration of our wireless network interface before it is =

> ready to be used. One such thing is does is set the MAC address =

> according to some data in an EEPROM. While restructuring the service =

> file for this oneshot service I removed the line:
> =

> 	Before=3Diwd.service systemd-networkd.service
> =

> and replaced it with:
> =

> 	Before=3Dnetwork-pre.target
> =

> ... as is suggested in systemd's documentation. This seemed good to me =

> because it is more generic.
> =

> I then noticed that during boot, iwd would run before this service and =

> connect to an AP. The AP was then kicking us off during the MAC address =

> change. This is how I noticed that iwd was not respecting the =

> network-pre.target order.
> =

> FYI we are using a driver (brcmfmac) which doesn't allow =

> creating/destroying the primary interface.
> =

> 2. Since iwd (and ead? never used it) can also do IP network =

> configuration, it's possible that it runs and does this stuff before =

> certain firewall rules are applied. This is the rationale given in the =

> systemd documentation.

fair points. Please put them into the commit message so that when we ever g=
it blame this change, we know why it made sense.

Just to note, I always hate that if you have to delay a service from starti=
ng up as early as possible and get the hardware ready to be used. Nobody wo=
rried about these things until we made it so blazing fast that WiFi will be=
 ready and connected before you need it. They way how it should have been f=
rom the start.

Regards

Marcel

--===============6826676805405093827==--

