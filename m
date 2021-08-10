Content-Type: multipart/mixed; boundary="===============4225486175885295342=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Tue, 10 Aug 2021 08:55:40 -0700
Message-ID: <2560e85435802d3fadbc4ec125d3316b5bcb7f8a.camel@gmail.com>
In-Reply-To: <4758091633c1cf9c2920e05072770bd5c84c4ad4.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4225486175885295342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

<snip>
> > > =

> > > I was looking for notification via PropertyChanged callback. I am
> > > using
> > > iwd 1.13. when I run iwctl ap wlan0 show it returns always 0
> > > client!!
> > > is this a bug in the old version?
> > > =

> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Access Point
> > > Interface=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
> > > -----------------------------------------------------------------
> > > ----
> > > -----------
> > > =C2=A0 Settable=C2=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value
> > > -----------------------------------------------------------------
> > > ----
> > > -----------
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 St=
arted=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 yes
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Na=
me=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 xxxxx-5587111
> > > =

> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Client
> > > 0
> > > -----------------------------------------------------------------
> > > ----
> > > -----------
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pr=
operty=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Va=
lue
> > > -----------------------------------------------------------------
> > > ----
> > > -----------
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ad=
dress=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 84:25:3f:9f:c2:54
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rx=
Bitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kbit/s
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ex=
pectedThroughput=C2=A0 14722096=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kbit/s
> > =

> > I'll admit this may look somewhat confusing, but this is actually
> > printing out the one client that is connected, client 0.
> > =

> I have connected multiple clients at this time but it returns only
> client 0

Would there be any way you could run iwmon at the same time as "ap
wlan0 show" ? We get all this information from the nl8011 GET_STATION
API so I'm curious to see exactly what that is coming up with.

> > I will say there is very little information here. What card are you
> > using?
> > =

> I am using qualcomm qca9377 chip
> > > [iwd]#
> > > =

> > > =

> > > > Thanks,
> > > > James
> > > =

> > > Regards,Salahaldeen
> > > > > Regards,
> > > > > Salahaldeen Altous
> > > > > _______________________________________________
> > > > > iwd mailing list -- iwd(a)lists.01.org
> > > > > To unsubscribe send an email to iwd-leave(a)lists.01.org
> > > Leica Camera AG | Registergericht | District Court of Wetzlar:
> > > HRB966
> > > Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr.
> > > Marita Paasch
> > > Aufsichtsratsvorsitzender | Chairman of the Supervisory Board:
> > > Dr.
> > > Andreas Kaufmann
> > > =

> > > This message may contain confidential and privileged information.
> > > If
> > > it has been sent to you in error, please notify the sender
> > > immediately by replying to the message and please delete it from
> > > your
> > > computer.
> > =

> > Thanks,
> > James
> > =

> Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr.
> Marita Paasch
> Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> Andreas Kaufmann
> =

> This message may contain confidential and privileged information. If
> it has been sent to you in error, please notify the sender
> immediately by replying to the message and please delete it from your
> computer.


--===============4225486175885295342==--

