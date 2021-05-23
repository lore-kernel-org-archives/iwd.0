Content-Type: multipart/mixed; boundary="===============2357783952094172708=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Sun, 23 May 2021 16:21:49 -0500
Message-ID: <CAG17S_OXeFgfPkuK1K=S0AcVaV-UUiuuStG8dsGbA3v5YKSuJg@mail.gmail.com>
In-Reply-To: <CAG17S_MhhFo=No8O5ki4pTq-ZxXxb6bcOLuKioKWZGBGzb_vGA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2357783952094172708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 12:20 AM KeithG <ys3al35l@gmail.com> wrote:
>
> On Thu, May 20, 2021 at 7:29 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > On Thu, May 20, 2021 at 1:36 PM Denis Kenzior <denkenz@gmail.com> wro=
te:
> > >
> > > Hi Diego,
> > >
> > > >>> In theory 2 can be done today, either by iwd or combo iwd/hostapd=
 with
> > > >> some
> > > >>> manual magic.
> > > >
> > > > We do exactly this on our devices, when we explored things a while =
back it was not really an option to do it all with iwd, so we use iwd for t=
he client part, create a new interface on the same WiFi adapter and fire up=
 a hostapd + dnsmasq combo on it as a "configuration AP", if the device is =
not configured yet.  The advantage is that iwd works in parallel in client =
mode so we can get the list of available networks and test that the configu=
ration provided by the user really works without having to disconnect the u=
ser from the "configuration AP" until configuration is complete.
> > >
> > > Awesome, thanks for confirming that this can be done.  In theory iwd =
should be
> > > getting to the point where our AP mode support should be good enough =
for simple
> > > scenarios like this one.
> > >
> > > >
> > > > Creating a second interface in AP mode works on all the WiFi adapte=
rs we have encountered, which are mainly Intel and Qualcomm.
> > > >
> > >
> > > Keith,
> > >
> > > Any P2P capable adapter should be able to do this (so pretty much any=
 modern
> > > hardware).  There was an earlier discussion on the list where I sugge=
sted that
> > > we add a config option to main.conf to start iwd either in station + =
p2p or
> > > station + ap mode.
> > >
> > > Patches are always welcome!
> > >
> > > Regards,
> > > -Denis
> > Denis,
> >
> > I appreciate the confidence but this is way out of my depth! I will
> > wait and hope that someone can contribute to this capability. I can
> > confirm that the AP mode works quite well even with the broadcom fmac
> > card. As I said, we are set up to start in station mode, collect the
> > local ssids, put them in a redis key then switch to AP mode and allow
> > the user to select one of the previously collected SSIDs to configure.
> > I was just hoping for a real time scan capability when in AP mode.
> >
> > Regards,
> >
> > Keith
>
> Messing around with ap mode and seeing what was possible, tonight. I
> can reliably get the AP mode to work. I can reliably get iwd to scan
> and can save the SSIDs. What I cannot seem to be able to do is get it
> to 'tether' in this manner. I have a cable on eth0 (192.168.2.x) and
> iwd is in AP mode on wlan0 (192.168.5.1). I cannot get it to NAT using
> iptables. This works fine for hostapd, but every time my phone
> connects, I get 'connected, no internet'.
>
> I've tried variants, but the iptables lines for hostapd are:
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE'
> iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT'
> iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT'
> sysctl net.ipv4.ip_forward=3D1
>
> I've also tried this:
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> iptables -A FORWARD -i eth0 -o wlan0 -m state --state
> RELATED,ESTABLISHED -j ACCEPT
> iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
>
> With either of these, I get no internet for wifi connected devices.
> From cli, I can ping and wget, etc. What am I missing?

Still messing with this. I decided to try to start an ad-hoc network
from the RPi to see how it works. This is on an RPi 3B (broadcom
fmac). I am running iwd built from git at e8eb05f. When I try to start
an ad-hoc network, I get 'Operation Failed'

# iwctl device wlan0 show
                                 Device: wlan0
---------------------------------------------------------------------------=
-----
  Settable  Property            Value
---------------------------------------------------------------------------=
-----
            Name                wlan0
         *  Mode                ad-hoc
         *  Powered             on
            Address             b8:27:eb:28:7d:8f
            Adapter             phy0
~# /usr/bin/iwctl ad-hoc wlan0 start test password
Operation failed

in the log:
May 23 10:03:23 runeaudio iwd[15027]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 3
May 23 10:03:23 runeaudio iwd[15027]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 3
May 23 10:04:22 runeaudio iwd[15027]: src/agent.c:agent_register()
agent register called
May 23 10:04:22 runeaudio iwd[15027]: src/agent.c:agent_register()
agent :1.569 path /agent/15328
May 23 10:04:22 runeaudio iwd[15027]: Failed to join adhoc network, -22
May 23 10:04:22 runeaudio iwd[15027]: src/agent.c:agent_disconnect()
agent :1.569 disconnected
May 23 10:04:22 runeaudio iwd[15027]: src/agent.c:agent_free() agent
free 0x1f257c0

I thought this should be easy, but am confused trying to set up a NAT
between the wlan0 connected devices (iwd running in AP mode) and the
eth0 connman managed DHCP connection to the router.

Keith
--===============2357783952094172708==--

