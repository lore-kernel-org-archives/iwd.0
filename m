Content-Type: multipart/mixed; boundary="===============8194759195349014368=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Wed, 19 May 2021 17:40:36 -0500
Message-ID: <CAG17S_N2U3A4CJWrZLHwxzVinq8L8MayPgy1g4VKDFAHP_Nz5w@mail.gmail.com>
In-Reply-To: <9edf45db-6cb5-1a9c-68da-5f08ff9332e9@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8194759195349014368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 4:20 PM Denis Kenzior <denkenz@gmail.com> wrote:
<snip>
> So do you know how this works, exactly?
>
I think so.
> >
> > I have tried with iwctl as well:
> > set up /etc/iwd/main.conf
> > [General]
> > EnableNetworkConfiguration=3Dtrue
> > APRanges=3D192.168.1.0/24
> >
> > # iwctl device wlan0 set-property Mode ap
> > # iwctl ap wlan0 start SSID password
> >
> > With this I can connect, but once again, I cannot scan for any
> > available SSIDs to connect to. It is not important that I be able to
> > connect, but I do need to see the SSIDs so the user can set it up then
> > reboot (or restart connman/iwd) to connect to the new 'known' SSID.
>
> So I think there are two ways of doing this:
>
> 1. Being able to scan while in AP mode.  This is something that has been =
brought
> up before as desirable, etc.  But no one has made any contributions just =
yet.
> All this does is lets you see the surrounding SSIDs...
>
> 2. Use multiple interfaces if your hw supports them.  So 1 interface in A=
P mode,
> the other in station mode.  Then you could connect to the headless device=
 on the
> ap interface and run iwd on the station interface as usual to set up the =
network.
>
> In theory 2 can be done today, either by iwd or combo iwd/hostapd with so=
me
> manual magic.
>
> Regards,
> -Denis
another way today is to:
3) start in station mode, scan and save the stations then switch to AP
mode allow a
connection then allow the user to set up the SSID. I have done this,
but was hoping
iwd could do both simultaneously.

I believe hostapd does this with modern wifi adapters. It does seem to
work with the
Broadcom fmac cards onboard the newer RPIs.I can be connected in AP
mode with hostapd
and also scan via 'connman scan wifi' or 'iwctl station wlan0 scan'
then 'iwctl station wlan0
get-networks' and get a list of the available networks. This allows me
to get a 'current'
list.

Keith
--===============8194759195349014368==--

