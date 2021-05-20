Content-Type: multipart/mixed; boundary="===============0523418243238679520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Thu, 20 May 2021 13:36:48 -0500
Message-ID: <d027b362-9ed8-efae-0dd3-efb5e0e0c067@gmail.com>
In-Reply-To: <DB6PR0102MB2630BD1102B35C45A9A2D091882A9@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0523418243238679520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

>>> In theory 2 can be done today, either by iwd or combo iwd/hostapd with
>> some
>>> manual magic.
> =

> We do exactly this on our devices, when we explored things a while back i=
t was not really an option to do it all with iwd, so we use iwd for the cli=
ent part, create a new interface on the same WiFi adapter and fire up a hos=
tapd + dnsmasq combo on it as a "configuration AP", if the device is not co=
nfigured yet.  The advantage is that iwd works in parallel in client mode s=
o we can get the list of available networks and test that the configuration=
 provided by the user really works without having to disconnect the user fr=
om the "configuration AP" until configuration is complete.

Awesome, thanks for confirming that this can be done.  In theory iwd should=
 be =

getting to the point where our AP mode support should be good enough for si=
mple =

scenarios like this one.

> =

> Creating a second interface in AP mode works on all the WiFi adapters we =
have encountered, which are mainly Intel and Qualcomm.
> =


Keith,

Any P2P capable adapter should be able to do this (so pretty much any moder=
n =

hardware).  There was an earlier discussion on the list where I suggested t=
hat =

we add a config option to main.conf to start iwd either in station + p2p or =

station + ap mode.

Patches are always welcome!

Regards,
-Denis
--===============0523418243238679520==--

