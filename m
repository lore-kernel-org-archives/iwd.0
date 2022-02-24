Content-Type: multipart/mixed; boundary="===============1531936364572618611=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Re: Scan while AP - testing
Date: Thu, 24 Feb 2022 10:24:46 -0600
Message-ID: <CAG17S_OfkSYZLY0WsrqmH-ecoZbi9jNy0jmhgCT0TZ1ZC1T9UQ@mail.gmail.com>
In-Reply-To: c46880dbbea8e8dc04e7a137c8763bb42b0e1c46.camel@gmail.com

--===============1531936364572618611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hmmm. Bummer.

Can you explain to a less savvy user, how my Pi3b+ is able to scan
while I am running hostapd?
When I run hostapd, I am also running iwd/connman and I can be
connected to the Pi via the hopstapd and with iwd running it can
dynamically scan for available networks. I thought that AP Scan was a
function/feature of the Pi3 hardware that both programs were able to
access it and use it simultaneously.

# iw list | grep supports
        Device supports roaming.
        Device supports scan flush.
        Device supports randomizing MAC-addr in sched scans.

Keith


On Wed, Feb 23, 2022 at 7:28 PM James Prestwood <prestwoj(a)gmail.com> wrot=
e:
>
> Hi Keith,
>
> On Wed, 2022-02-23 at 19:08 -0600, KeithG wrote:
> > I applied James' latest suggested patches and was trying to see how
> > this works.
> >
> > IWD starts and I can get into AP mode and can connect. I tried
> > connman
> > to see if it would scan and got no response.  So I went into iwctl to
> > see and saw this:
> >
> > Access Point:
> >   ap list                                           List devices in
> > AP mode
> >   ap <wlan> start <"network name"> <passphrase>     Start an access
> > point
> >                                                     called "network
> > name" with
> >                                                     a passphrase
> >   ap <wlan> start-profile <"network name">          Start an access
> > point based on a disk profile
> >   ap <wlan> stop                                    Stop a started
> > access
> >                                                     point
> >   ap <wlan> show                                    Show AP info
> >   ap <wlan> scan                                    Start an AP scan
> >   ap <wlan> get-networks                            Get network list
> > after scanning
> >
> > looking good, but tried it and did not get anything:
> >
> > [iwd]# ap wlan0 show
> >                              Access Point Interface
> > ---------------------------------------------------------------------
> > -----------
> >   Settable  Property            Value
> > ---------------------------------------------------------------------
> > -----------
> >             Started             yes
> >             Name                RuneAudioAP
> >             Scanning            no
> >
> >                                     Client 0
> > ---------------------------------------------------------------------
> > -----------
> >             Property            Value
> > ---------------------------------------------------------------------
> > -----------
> >             Address             60:f2:62:ae:70:fe
> >             TxBitrate           54000                Kbit/s
> >             RxBitrate           54000                Kbit/s
> >
> > [iwd]# ap wlan0 scan
> > Operation not supported
> > [iwd]# ap wlan0 get-networks
> >                                     Networks
> > ---------------------------------------------------------------------
> > -----------
> >             Property            Value
> > ---------------------------------------------------------------------
> > -----------
> >
> > Is this the 'right way'? Are there more settings I need in my
> > main.conf?
>
> Yes you're doing everything correctly, but most likely your driver
> doesn't actually support scanning in AP mode. I had to go through a few
> of my USB dongles to find one that did.
>
> You can check support with iw list, and should see this:
>
> "Device supports AP scan"
>
> Thanks,
> James
>
> >
> > Keith
>
>
--===============1531936364572618611==--

