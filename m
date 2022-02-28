Content-Type: multipart/mixed; boundary="===============0920772544692510560=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Re: Scan while AP - testing
Date: Mon, 28 Feb 2022 14:16:25 -0600
Message-ID: <CAG17S_O4L3pZk_HXVWYXbX0Y1DwzOasd6yYGDXC_EK7_1ZO-nw@mail.gmail.com>
In-Reply-To: eeb01d8bb14fdea14fc3a5bcb9297cc14318725a.camel@gmail.com

--===============0920772544692510560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jamews,

Thanks for the update. I saw that this patch is now accepted into the
code base. I guess I need to start poking the connman list to get the
hooks added. I'd like to continue to use connman only because we
configured all our scripts around it, but could modify them if it is
not doable for connman.

Thanks, again!

Keith

On Mon, Feb 28, 2022 at 10:57 AM James Prestwood <prestwoj(a)gmail.com> wro=
te:
>
> Hi Keith,
>
> On Thu, 2022-02-24 at 19:45 -0600, KeithG wrote:
> > James,
> >
> > your v2 seems to work. If I do:
> > # iwctl ap wlan0 scan
> > # iwctl ap wlan0 get-networks
> >                                     Networks
> > -----------------------------------------------------------------------
> > ---------
> >             Property            Value
> > -----------------------------------------------------------------------
> > ---------
> >             Name                spg2
> >             SignalStrength      -4100
> >             Type                psk
> >
> >             Name                spg3
> >             SignalStrength      -5700
> >             Type                psk
> >
> > Now how do we get connman to scan when iwd is in ap mode... I guess I
> > need to post to that group once this gets put in the released version.
>
> This would need to be added to connman since its a completely new DBus
> API.
>
> FYI I asked on linux-wireless about this missing AP scan feature for
> brcmfmac and someone else also needed very similar functionality, but
> achieved it by adding an AP interface along side a station one. I tried
> this on brcmfmac and was able to start an AP and concurrently scan on a
> station interface.
>
> https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf(a)bang-olufsen.dk/
>
> I think Denis mentioned this back in May but wanted to put it out there
> again just so you know it's an option. Still no response from anyone
> from broadcom but at least doing an AP + station interface is supported
> in terms of iface combinations where scanning on an AP interface is
> unclear (yes it works, but I would be worried about putting a
> dependency on a feature that isn't advertised). Hopefully we can get a
> definitive answer about this.
>
> Thanks,
> James
>
> > This is really nice. Thanks for doing this
> >
> > Keith
> >
> > On Thu, Feb 24, 2022 at 10:36 AM James Prestwood <prestwoj(a)gmail.com>
> > wrote:
> > >
> > > Hi Keith,
> > >
> > > On Thu, 2022-02-24 at 10:24 -0600, KeithG wrote:
> > > > Hmmm. Bummer.
> > > >
> > > > Can you explain to a less savvy user, how my Pi3b+ is able to scan
> > > > while I am running hostapd?
> > > > When I run hostapd, I am also running iwd/connman and I can be
> > > > connected to the Pi via the hopstapd and with iwd running it can
> > > > dynamically scan for available networks. I thought that AP Scan was
> > > > a
> > > > function/feature of the Pi3 hardware that both programs were able
> > > > to
> > > > access it and use it simultaneously.
> > >
> > > After I replied last night I was thinking perhaps the Pi doesn't
> > > advertise the feature... and indeed this is true. I removed the check
> > > and scanning worked just fine on the RPi3. So brcmfmac is just lazy
> > > and
> > > never bothered to include this feature.
> > >
> > > I guess, once again, we need to tailor our code to handle this
> > > driver,
> > > ugh.
> > >
> > > I'll send v2 soon.
> > >
> > > >
> > > > # iw list | grep supports
> > > >         Device supports roaming.
> > > >         Device supports scan flush.
> > > >         Device supports randomizing MAC-addr in sched scans.
> > > >
> > > > Keith
> > > >
> > > >
> > > > On Wed, Feb 23, 2022 at 7:28 PM James Prestwood
> > > > <prestwoj(a)gmail.com>
> > > > wrote:
> > > > >
> > > > > Hi Keith,
> > > > >
> > > > > On Wed, 2022-02-23 at 19:08 -0600, KeithG wrote:
> > > > > > I applied James' latest suggested patches and was trying to see
> > > > > > how
> > > > > > this works.
> > > > > >
> > > > > > IWD starts and I can get into AP mode and can connect. I tried
> > > > > > connman
> > > > > > to see if it would scan and got no response.  So I went into
> > > > > > iwctl to
> > > > > > see and saw this:
> > > > > >
> > > > > > Access Point:
> > > > > >   ap list                                           List
> > > > > > devices
> > > > > > in
> > > > > > AP mode
> > > > > >   ap <wlan> start <"network name"> <passphrase>     Start an
> > > > > > access
> > > > > > point
> > > > > >                                                     called
> > > > > > "network
> > > > > > name" with
> > > > > >                                                     a
> > > > > > passphrase
> > > > > >   ap <wlan> start-profile <"network name">          Start an
> > > > > > access
> > > > > > point based on a disk profile
> > > > > >   ap <wlan> stop                                    Stop a
> > > > > > started
> > > > > > access
> > > > > >                                                     point
> > > > > >   ap <wlan> show                                    Show AP
> > > > > > info
> > > > > >   ap <wlan> scan                                    Start an AP
> > > > > > scan
> > > > > >   ap <wlan> get-networks                            Get network
> > > > > > list
> > > > > > after scanning
> > > > > >
> > > > > > looking good, but tried it and did not get anything:
> > > > > >
> > > > > > [iwd]# ap wlan0 show
> > > > > >                              Access Point Interface
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >   Settable  Property            Value
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >             Started             yes
> > > > > >             Name                RuneAudioAP
> > > > > >             Scanning            no
> > > > > >
> > > > > >                                     Client 0
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >             Property            Value
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >             Address             60:f2:62:ae:70:fe
> > > > > >             TxBitrate           54000                Kbit/s
> > > > > >             RxBitrate           54000                Kbit/s
> > > > > >
> > > > > > [iwd]# ap wlan0 scan
> > > > > > Operation not supported
> > > > > > [iwd]# ap wlan0 get-networks
> > > > > >                                     Networks
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >             Property            Value
> > > > > > ---------------------------------------------------------------
> > > > > > --
> > > > > > ----
> > > > > > -----------
> > > > > >
> > > > > > Is this the 'right way'? Are there more settings I need in my
> > > > > > main.conf?
> > > > >
> > > > > Yes you're doing everything correctly, but most likely your
> > > > > driver
> > > > > doesn't actually support scanning in AP mode. I had to go through
> > > > > a
> > > > > few
> > > > > of my USB dongles to find one that did.
> > > > >
> > > > > You can check support with iw list, and should see this:
> > > > >
> > > > > "Device supports AP scan"
> > > > >
> > > > > Thanks,
> > > > > James
> > > > >
> > > > > >
> > > > > > Keith
> > > > >
> > > > >
> > >
> > >
>
>
--===============0920772544692510560==--

