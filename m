Content-Type: multipart/mixed; boundary="===============6833609117961304389=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Fri, 21 May 2021 00:20:02 -0500
Message-ID: <CAG17S_MhhFo=No8O5ki4pTq-ZxXxb6bcOLuKioKWZGBGzb_vGA@mail.gmail.com>
In-Reply-To: <CAG17S_OnKkzs0rZtS+tr3s8SCJiQ==TQ0zOc2nML8ZLNXb4gMA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6833609117961304389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 7:29 PM KeithG <ys3al35l@gmail.com> wrote:
>
> On Thu, May 20, 2021 at 1:36 PM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi Diego,
> >
> > >>> In theory 2 can be done today, either by iwd or combo iwd/hostapd w=
ith
> > >> some
> > >>> manual magic.
> > >
> > > We do exactly this on our devices, when we explored things a while ba=
ck it was not really an option to do it all with iwd, so we use iwd for the=
 client part, create a new interface on the same WiFi adapter and fire up a=
 hostapd + dnsmasq combo on it as a "configuration AP", if the device is no=
t configured yet.  The advantage is that iwd works in parallel in client mo=
de so we can get the list of available networks and test that the configura=
tion provided by the user really works without having to disconnect the use=
r from the "configuration AP" until configuration is complete.
> >
> > Awesome, thanks for confirming that this can be done.  In theory iwd sh=
ould be
> > getting to the point where our AP mode support should be good enough fo=
r simple
> > scenarios like this one.
> >
> > >
> > > Creating a second interface in AP mode works on all the WiFi adapters=
 we have encountered, which are mainly Intel and Qualcomm.
> > >
> >
> > Keith,
> >
> > Any P2P capable adapter should be able to do this (so pretty much any m=
odern
> > hardware).  There was an earlier discussion on the list where I suggest=
ed that
> > we add a config option to main.conf to start iwd either in station + p2=
p or
> > station + ap mode.
> >
> > Patches are always welcome!
> >
> > Regards,
> > -Denis
> Denis,
>
> I appreciate the confidence but this is way out of my depth! I will
> wait and hope that someone can contribute to this capability. I can
> confirm that the AP mode works quite well even with the broadcom fmac
> card. As I said, we are set up to start in station mode, collect the
> local ssids, put them in a redis key then switch to AP mode and allow
> the user to select one of the previously collected SSIDs to configure.
> I was just hoping for a real time scan capability when in AP mode.
>
> Regards,
>
> Keith

Messing around with ap mode and seeing what was possible, tonight. I
can reliably get the AP mode to work. I can reliably get iwd to scan
and can save the SSIDs. What I cannot seem to be able to do is get it
to 'tether' in this manner. I have a cable on eth0 (192.168.2.x) and
iwd is in AP mode on wlan0 (192.168.5.1). I cannot get it to NAT using
iptables. This works fine for hostapd, but every time my phone
connects, I get 'connected, no internet'.

I've tried variants, but the iptables lines for hostapd are:
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE'
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT'
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT'
sysctl net.ipv4.ip_forward=3D1

I've also tried this:
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state
RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

With either of these, I get no internet for wifi connected devices.
From cli, I can ping and wget, etc. What am I missing?
--===============6833609117961304389==--

