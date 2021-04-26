Content-Type: multipart/mixed; boundary="===============8491012591637147631=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 26 Apr 2021 12:24:26 -0700
Message-ID: <3db93300fd75d6f5cb28dadc4b0902a39be1f0e8.camel@gmail.com>
In-Reply-To: <CAG17S_MMCKsoc0dQ0P_OQezwEwWXgMU74eVoXxtbqWkbrNfD_Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8491012591637147631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Mon, 2021-04-26 at 14:03 -0500, KeithG wrote:
> James,
> =

> This is an iwmon report.

Thanks for this. As I thought the station is not responding to the 4-
way handshake. My first thought would be the EAPoL protocol version as
this has caused issues in the past with stations, but I have yet to see
this with IWD in AP mode. Maybe others have?

You had said hostapd worked fine? It would also be nice to have an
iwmon trace with that working. This would tell us for sure if it was an
issue with the protocol version.

AFAIK hostapd uses the same default protcol version as IWD ('2' /
2004).

Thanks,
James

> =

> Keith
> =

> On Mon, Apr 26, 2021 at 1:58 PM KeithG <ys3al35l@gmail.com> wrote:
> > James,
> > =

> > I set iwd -d and collected this log of an attempt to connect.
> > =

> > Keith
> > =

> > =

> > On Wed, Apr 21, 2021 at 2:19 PM James Prestwood <prestwoj@gmail.com
> > > wrote:
> > > Hi Keith,
> > > =

> > > <snip>
> > > > ...
> > > > Apr 21 11:47:28 deskrune iwd[2298]: Wiphy phy0 will only use
> > > > the
> > > > default interface
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Request from
> > > > ae:53:10:32:ee:8a
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Response delivered
> > > > OK
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication from
> > > > ae:53:10:32:ee:8a
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication frame 2
> > > > ACKed
> > > > by STA
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP Association Request from
> > > > ae:53:10:32:ee:8a
> > > > Apr 21 11:47:51 deskrune iwd[2298]: AP (Re)Association Response
> > > > ACK
> > > > received
> > > > Apr 21 11:47:52 deskrune iwd[2298]: 4-Way handshake failed for
> > > > ifindex: 3, reason: 15
> > > =

> > > Looks like the station isn't responding to EAPoL messages. To
> > > confirm
> > > could you run iwmon along side iwd during this and send the logs?
> > > =

> > > https://iwd.wiki.kernel.org/debugging
> > > =

> > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from
> > > > b0:02:47:cc:83:f9
> > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Response delivered
> > > > OK
> > > > Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from
> > > > b0:02:47:cc:83:f9
> > > > Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Request from
> > > > ee:b9:80:a7:13:81
> > > > Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Response delivered
> > > > OK
> > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> > > > b8:27:eb:18:74:9c
> > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Response delivered
> > > > OK
> > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> > > > b8:27:eb:18:74:9c
> > > > Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> > > > b8:27:eb:18:74:9c
> > > > Apr 21 11:48:01 deskrune iwd[2298]: AP Deauthentication from
> > > > ae:53:10:32:ee:8a, reason 3
> > > > =

> > > > Is this incompatible? It works with hostapd/dnsmasq.
> > > > =

> > > > Keith
> > > > _______________________________________________
> > > > iwd mailing list -- iwd(a)lists.01.org
> > > > To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============8491012591637147631==--

