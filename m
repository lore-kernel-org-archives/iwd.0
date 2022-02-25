Content-Type: multipart/mixed; boundary="===============5703068039530856655=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Re: Scan while AP - testing
Date: Thu, 24 Feb 2022 19:45:24 -0600
Message-ID: <CAG17S_OWQPk7kZ15L3y-xdKap94NC0yP041NxpDSNiiR01FV8g@mail.gmail.com>
In-Reply-To: 9ad40e74f71d6ffc947234580b6be7e39dfc4b3a.camel@gmail.com

--===============5703068039530856655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James,

your v2 seems to work. If I do:
# iwctl ap wlan0 scan
# iwctl ap wlan0 get-networks
                                    Networks
---------------------------------------------------------------------------=
-----
            Property            Value
---------------------------------------------------------------------------=
-----
            Name                spg2
            SignalStrength      -4100
            Type                psk

            Name                spg3
            SignalStrength      -5700
            Type                psk

Now how do we get connman to scan when iwd is in ap mode... I guess I
need to post to that group once this gets put in the released version.
This is really nice. Thanks for doing this

Keith

On Thu, Feb 24, 2022 at 10:36 AM James Prestwood <prestwoj(a)gmail.com> wro=
te:
>
> Hi Keith,
>
> On Thu, 2022-02-24 at 10:24 -0600, KeithG wrote:
> > Hmmm. Bummer.
> >
> > Can you explain to a less savvy user, how my Pi3b+ is able to scan
> > while I am running hostapd?
> > When I run hostapd, I am also running iwd/connman and I can be
> > connected to the Pi via the hopstapd and with iwd running it can
> > dynamically scan for available networks. I thought that AP Scan was a
> > function/feature of the Pi3 hardware that both programs were able to
> > access it and use it simultaneously.
>
> After I replied last night I was thinking perhaps the Pi doesn't
> advertise the feature... and indeed this is true. I removed the check
> and scanning worked just fine on the RPi3. So brcmfmac is just lazy and
> never bothered to include this feature.
>
> I guess, once again, we need to tailor our code to handle this driver,
> ugh.
>
> I'll send v2 soon.
>
> >
> > # iw list | grep supports
> >         Device supports roaming.
> >         Device supports scan flush.
> >         Device supports randomizing MAC-addr in sched scans.
> >
> > Keith
> >
> >
> > On Wed, Feb 23, 2022 at 7:28 PM James Prestwood <prestwoj(a)gmail.com>
> > wrote:
> > >
> > > Hi Keith,
> > >
> > > On Wed, 2022-02-23 at 19:08 -0600, KeithG wrote:
> > > > I applied James' latest suggested patches and was trying to see
> > > > how
> > > > this works.
> > > >
> > > > IWD starts and I can get into AP mode and can connect. I tried
> > > > connman
> > > > to see if it would scan and got no response.  So I went into
> > > > iwctl to
> > > > see and saw this:
> > > >
> > > > Access Point:
> > > >   ap list                                           List devices
> > > > in
> > > > AP mode
> > > >   ap <wlan> start <"network name"> <passphrase>     Start an
> > > > access
> > > > point
> > > >                                                     called
> > > > "network
> > > > name" with
> > > >                                                     a passphrase
> > > >   ap <wlan> start-profile <"network name">          Start an
> > > > access
> > > > point based on a disk profile
> > > >   ap <wlan> stop                                    Stop a
> > > > started
> > > > access
> > > >                                                     point
> > > >   ap <wlan> show                                    Show AP info
> > > >   ap <wlan> scan                                    Start an AP
> > > > scan
> > > >   ap <wlan> get-networks                            Get network
> > > > list
> > > > after scanning
> > > >
> > > > looking good, but tried it and did not get anything:
> > > >
> > > > [iwd]# ap wlan0 show
> > > >                              Access Point Interface
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >   Settable  Property            Value
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >             Started             yes
> > > >             Name                RuneAudioAP
> > > >             Scanning            no
> > > >
> > > >                                     Client 0
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >             Property            Value
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >             Address             60:f2:62:ae:70:fe
> > > >             TxBitrate           54000                Kbit/s
> > > >             RxBitrate           54000                Kbit/s
> > > >
> > > > [iwd]# ap wlan0 scan
> > > > Operation not supported
> > > > [iwd]# ap wlan0 get-networks
> > > >                                     Networks
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >             Property            Value
> > > > -----------------------------------------------------------------
> > > > ----
> > > > -----------
> > > >
> > > > Is this the 'right way'? Are there more settings I need in my
> > > > main.conf?
> > >
> > > Yes you're doing everything correctly, but most likely your driver
> > > doesn't actually support scanning in AP mode. I had to go through a
> > > few
> > > of my USB dongles to find one that did.
> > >
> > > You can check support with iw list, and should see this:
> > >
> > > "Device supports AP scan"
> > >
> > > Thanks,
> > > James
> > >
> > > >
> > > > Keith
> > >
> > >
>
>
--===============5703068039530856655==--

