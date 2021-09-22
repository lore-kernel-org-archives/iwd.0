Content-Type: multipart/mixed; boundary="===============5892123111106458921=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Possible bug - DISASSOC_LOW_ACK
Date: Wed, 22 Sep 2021 08:56:34 -0500
Message-ID: <94d5719f-178a-3ca8-40a6-b6f2692934c5@gmail.com>
In-Reply-To: CACsRnHWN8VuaYqvSx_1t1Mx-Cd9A_oPqwyX66o18aHmeLmWiWA@mail.gmail.com

--===============5892123111106458921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 9/22/21 3:59 AM, Michael Johnson wrote:
> Hi everyone,
> =

> In my use case that involves heavy roaming, I've been noticing that
> occasionally `iwd` disconnects completely from the network before
> rejoining which can cause a few seconds of downtime. In addition to
> the downtime it seems to put the network in an odd state which is
> hitting a bunch of corner cases in code that uses the network more
> than just a normal disconnect. Looking at the logs, it seems like iwd
> might be getting locked up somewhere as it also stops reacting to
> threshold notifications?

This is indeed strange.  iwmon would capture this, but maybe it is easier t=
o put =

in a bit more debugging into the CQM paths and see if we get some more clue=
s? =

Maybe the CQM events are propagated correctly but the signal isn't below th=
e =

roaming threshold?

> =

> I'm not sure how to reproduce this as it's relatively rare, happening
> 3 times in about a week. The logs below are from a machine running
> version 1.17.
> I'll see if I can start a rolling iwmon capture to get more info. Is
> there anything else that would be useful?

Might be chasing ghosts, but the only other thing I see is a a few CMD_FRAM=
E =

events (see below) that we receive which are not recognized?  Or at least I =

don't see any logs of them being parsed.  iwmon trace will capture these, b=
ut =

may be easier to log them in your case.

> =

> ```
> Sep 21 15:40:22.138376 p3-683 iwd[425]:
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX
> Status(60)
> Sep 21 15:40:22.140101 p3-683 iwd[425]:
> src/netdev.c:netdev_unicast_notify() Unicast notification 59
> Sep 21 15:40:22.140101 p3-683 iwd[425]:
> src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
> 0()

Did we just roam, or is something else going on?

> Sep 21 15:40:22.140101 p3-683 iwd[425]:
> src/station.c:parse_neighbor_report() Neighbor report received for
> ea:9e:38:78:07:b1: ch 44 (oper class 0), MD not set
> Sep 21 15:40:22.141734 p3-683 iwd[425]:
> src/netdev.c:netdev_unicast_notify() Unicast notification 59

We're getting a CMD_FRAME here

> Sep 21 15:40:22.142298 p3-683 iwd[425]:
> src/netdev.c:netdev_unicast_notify() Unicast notification 59

And here.  Wonder what they are?

> Sep 21 15:40:22.166050 p3-683 kernel: wlan0: Limiting TX power to 27
> (30 - 3) dBm as advertised by ea:9e:38:78:08:71
> Sep 21 15:40:22.473706 p3-683 iwd[425]:
> src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> Sep 21 15:41:12.767433 p3-683 iwd[425]:
> src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)

Two CQM events.  We need to know what they actually contain.

> Sep 21 15:46:41.998639 p3-683 kernel: wlan0: deauthenticated from
> ea:9e:38:78:08:71 (Reason: 34=3DDISASSOC_LOW_ACK)

Hmm, never seen this before.  I wonder if the power limit event the kernel =

prints about earlier has something to do with this?

Regards,
-Denis
--===============5892123111106458921==--

