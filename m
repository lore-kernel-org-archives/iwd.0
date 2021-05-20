Content-Type: multipart/mixed; boundary="===============7360690464032104930=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: How to configure an IoT wifi setup
Date: Thu, 20 May 2021 05:54:32 +0000
Message-ID: <
 <DB6PR0102MB2630BD1102B35C45A9A2D091882A9@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <CAG17S_N2U3A4CJWrZLHwxzVinq8L8MayPgy1g4VKDFAHP_Nz5w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7360690464032104930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: KeithG <ys3al35l@gmail.com>
> Sent: 20 May 2021 00:41
> To: Denis Kenzior <denkenz@gmail.com>
> Cc: connman(a)lists.01.org; iwd(a)lists.01.org
> Subject: Re: How to configure an IoT wifi setup
> =

> On Wed, May 19, 2021 at 4:20 PM Denis Kenzior <denkenz@gmail.com>
> wrote:
> <snip>
> > So do you know how this works, exactly?
> >
> I think so.
> > >
> > > I have tried with iwctl as well:
> > > set up /etc/iwd/main.conf
> > > [General]
> > > EnableNetworkConfiguration=3Dtrue
> > > APRanges=3D192.168.1.0/24
> > >
> > > # iwctl device wlan0 set-property Mode ap
> > > # iwctl ap wlan0 start SSID password
> > >
> > > With this I can connect, but once again, I cannot scan for any
> > > available SSIDs to connect to. It is not important that I be able to
> > > connect, but I do need to see the SSIDs so the user can set it up then
> > > reboot (or restart connman/iwd) to connect to the new 'known' SSID.
> >
> > So I think there are two ways of doing this:
> >
> > 1. Being able to scan while in AP mode.  This is something that has been
> brought
> > up before as desirable, etc.  But no one has made any contributions just
> yet.
> > All this does is lets you see the surrounding SSIDs...
> >
> > 2. Use multiple interfaces if your hw supports them.  So 1 interface in=
 AP
> mode,
> > the other in station mode.  Then you could connect to the headless devi=
ce
> on the
> > ap interface and run iwd on the station interface as usual to set up the
> network.
> >
> > In theory 2 can be done today, either by iwd or combo iwd/hostapd with
> some
> > manual magic.

We do exactly this on our devices, when we explored things a while back it =
was not really an option to do it all with iwd, so we use iwd for the clien=
t part, create a new interface on the same WiFi adapter and fire up a hosta=
pd + dnsmasq combo on it as a "configuration AP", if the device is not conf=
igured yet.  The advantage is that iwd works in parallel in client mode so =
we can get the list of available networks and test that the configuration p=
rovided by the user really works without having to disconnect the user from=
 the "configuration AP" until configuration is complete.

Creating a second interface in AP mode works on all the WiFi adapters we ha=
ve encountered, which are mainly Intel and Qualcomm.

> >
> > Regards,
> > -Denis
> another way today is to:
> 3) start in station mode, scan and save the stations then switch to AP
> mode allow a
> connection then allow the user to set up the SSID. I have done this,
> but was hoping
> iwd could do both simultaneously.
> =

> I believe hostapd does this with modern wifi adapters. It does seem to
> work with the
> Broadcom fmac cards onboard the newer RPIs.I can be connected in AP
> mode with hostapd
> and also scan via 'connman scan wifi' or 'iwctl station wlan0 scan'
> then 'iwctl station wlan0
> get-networks' and get a list of the available networks. This allows me
> to get a 'current'
> list.
> =

> Keith
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

-- =

Diego Santa Cruz, PhD
Technology Architect
spinetix.com

=20
--===============7360690464032104930==--

