Content-Type: multipart/mixed; boundary="===============5600549458594506576=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 10 May 2021 09:47:40 -0500
Message-ID: <CAG17S_OiVP-8e4PFzSaqzGEQiEKdyg8yv585ch-T1H0p-UkhbA@mail.gmail.com>
In-Reply-To: <CAG17S_NXf1_Jp-JsGYHko0JJSPi3j6fSPDMWhad1q+2NBsNCFA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5600549458594506576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James,

I am on iwd 1.14, now and still get the same error.

Keith

On Tue, Apr 27, 2021 at 4:56 PM KeithG <ys3al35l@gmail.com> wrote:
>
> James,
>
> Thanks for the heads up. Yes, this is on a RPi 1B with a USB dongle. I
> believe that we (Arch) use gcc 10.2. Your team seems to release about
> once a month and iwd is usually a day pr 2 behind that from Arch. I'll
> wait patiently.
>
> Keith
>
> On Mon, Apr 26, 2021 at 5:37 PM James Prestwood <prestwoj@gmail.com> wr=
ote:
> >
> > Hi Keith,
> >
> > On Mon, 2021-04-26 at 17:27 -0500, KeithG wrote:
> > > That did not work for me. I did a pcap instead.
> > >
> >
> > Sorry for the unneeded hostapd business. I went over the logs again and
> > it actually looks like a very recent compiler/optimization bug we found
> > and fixed with:
> >
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3D32=
84ed4e8ee29d66ba4f90cba5d3508f1ca244f9
> >
> > I'm gonna guess you are on a Raspberry Pi? If so this is most likely
> > the problem and the above patch should fix it. It is not yet in a
> > release but should be sometime soon.
> >
> > Thanks,
> > James
> >
> >
> > > Keith
> > >
> > >
> > > On Mon, Apr 26, 2021 at 4:53 PM James Prestwood <prestwoj@gmail.com>
> > > wrote:
> > > > Hi Keith,
> > > >
> > > > On Mon, 2021-04-26 at 16:26 -0500, KeithG wrote:
> > > > > James,
> > > > >
> > > > > Here it is. This is hostapd. I connect via putty to get the
> > > > > results.
> > > > > If you need a full report, I would like your help getting this
> > > > > piped
> > > > > to a file for your review if it is inadequate.
> > > >
> > > > Yeah... looks like this isn't the full output. All I see is probes
> > > > and
> > > > beacons, no actual connections. I assume you are just copying the
> > > > output from the putty terminal? Instead you could pipe to a file:
> > > >
> > > > ./iwmon > output.txt
> > > >
> > > > Then kill that once you see IWD connect.
> > > >
> > > > Thanks,
> > > > James
> > > >
> > > > > Keith
> > > > >
> > > > > On Mon, Apr 26, 2021 at 2:24 PM James Prestwood <
> > > > > prestwoj(a)gmail.com>
> > > > > wrote:
> > > > > > Hi Keith,
> > > > > >
> > > > > > On Mon, 2021-04-26 at 14:03 -0500, KeithG wrote:
> > > > > > > James,
> > > > > > >
> > > > > > > This is an iwmon report.
> > > > > >
> > > > > > Thanks for this. As I thought the station is not responding to
> > > > > > the
> > > > > > 4-
> > > > > > way handshake. My first thought would be the EAPoL protocol
> > > > > > version
> > > > > > as
> > > > > > this has caused issues in the past with stations, but I have
> > > > > > yet to
> > > > > > see
> > > > > > this with IWD in AP mode. Maybe others have?
> > > > > >
> > > > > > You had said hostapd worked fine? It would also be nice to have
> > > > > > an
> > > > > > iwmon trace with that working. This would tell us for sure if
> > > > > > it
> > > > > > was an
> > > > > > issue with the protocol version.
> > > > > >
> > > > > > AFAIK hostapd uses the same default protcol version as IWD ('2'
> > > > > > /
> > > > > > 2004).
> > > > > >
> > > > > > Thanks,
> > > > > > James
> > > > > >
> > > > > > > Keith
> > > > > > >
> > > > > > > On Mon, Apr 26, 2021 at 1:58 PM KeithG <ys3al35l@gmail.com>
> > > > > > > wrote:
> > > > > > > > James,
> > > > > > > >
> > > > > > > > I set iwd -d and collected this log of an attempt to
> > > > > > > > connect.
> > > > > > > >
> > > > > > > > Keith
> > > > > > > >
> > > > > > > >
> > > > > > > > On Wed, Apr 21, 2021 at 2:19 PM James Prestwood <
> > > > > > > > prestwoj(a)gmail.com
> > > > > > > > > wrote:
> > > > > > > > > Hi Keith,
> > > > > > > > >
> > > > > > > > > <snip>
> > > > > > > > > > ...
> > > > > > > > > > Apr 21 11:47:28 deskrune iwd[2298]: Wiphy phy0 will
> > > > > > > > > > only
> > > > > > > > > > use
> > > > > > > > > > the
> > > > > > > > > > default interface
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > ae:53:10:32:ee:8a
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Response
> > > > > > > > > > delivered
> > > > > > > > > > OK
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication
> > > > > > > > > > from
> > > > > > > > > > ae:53:10:32:ee:8a
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication
> > > > > > > > > > frame
> > > > > > > > > > 2
> > > > > > > > > > ACKed
> > > > > > > > > > by STA
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Association
> > > > > > > > > > Request
> > > > > > > > > > from
> > > > > > > > > > ae:53:10:32:ee:8a
> > > > > > > > > > Apr 21 11:47:51 deskrune iwd[2298]: AP (Re)Association
> > > > > > > > > > Response
> > > > > > > > > > ACK
> > > > > > > > > > received
> > > > > > > > > > Apr 21 11:47:52 deskrune iwd[2298]: 4-Way handshake
> > > > > > > > > > failed
> > > > > > > > > > for
> > > > > > > > > > ifindex: 3, reason: 15
> > > > > > > > >
> > > > > > > > > Looks like the station isn't responding to EAPoL
> > > > > > > > > messages. To
> > > > > > > > > confirm
> > > > > > > > > could you run iwmon along side iwd during this and send
> > > > > > > > > the
> > > > > > > > > logs?
> > > > > > > > >
> > > > > > > > > https://iwd.wiki.kernel.org/debugging
> > > > > > > > >
> > > > > > > > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > b0:02:47:cc:83:f9
> > > > > > > > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Response
> > > > > > > > > > delivered
> > > > > > > > > > OK
> > > > > > > > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > b0:02:47:cc:83:f9
> > > > > > > > > > Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > ee:b9:80:a7:13:81
> > > > > > > > > > Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Response
> > > > > > > > > > delivered
> > > > > > > > > > OK
> > > > > > > > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > b8:27:eb:18:74:9c
> > > > > > > > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Response
> > > > > > > > > > delivered
> > > > > > > > > > OK
> > > > > > > > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > b8:27:eb:18:74:9c
> > > > > > > > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request
> > > > > > > > > > from
> > > > > > > > > > b8:27:eb:18:74:9c
> > > > > > > > > > Apr 21 11:48:01 deskrune iwd[2298]: AP Deauthentication
> > > > > > > > > > from
> > > > > > > > > > ae:53:10:32:ee:8a, reason 3
> > > > > > > > > >
> > > > > > > > > > Is this incompatible? It works with hostapd/dnsmasq.
> > > > > > > > > >
> > > > > > > > > > Keith
> > > > > > > > > > _______________________________________________
> > > > > > > > > > iwd mailing list -- iwd(a)lists.01.org
> > > > > > > > > > To unsubscribe send an email to iwd-leave(a)lists.01.org
> >
--===============5600549458594506576==--

