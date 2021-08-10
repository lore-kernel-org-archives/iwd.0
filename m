Content-Type: multipart/mixed; boundary="===============0894782723791888599=="
MIME-Version: 1.0
From: Altous, Salahaldeen <Salahaldeen.Altous@leica-camera.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Tue, 10 Aug 2021 05:34:36 +0000
Message-ID: <4758091633c1cf9c2920e05072770bd5c84c4ad4.camel@leica-camera.com>
In-Reply-To: <08640727a3dc701404e13fb28211cf7adaedd1f1.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0894782723791888599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,
On Mon, 2021-08-09 at 08:58 -0700, James Prestwood wrote:
> Hi,
>
> On Mon, 2021-08-09 at 07:22 +0000, Altous, Salahaldeen wrote:
> > Hi James,
> >
> > On Fri, 2021-08-06 at 09:32 -0700, James Prestwood wrote:
> > > Hi,
> > >
> > > On Fri, 2021-08-06 at 06:30 +0000,
> > > salahaldeen.altous(a)leica-camera.com
> > > wrote:
> > > > Hi,
> > > >
> > > > I have a device which running as AP point. I would like to know
> > > > every
> > > > time there is a new connection/discounntion for this access
> > > > point.
> > > > Does iwd API support this? DHCP is enable in AP configuration
> > > > (EnableNetworkConfiguration=3DTrue)
> > >
> > > There is an access point API, GetDiagnostics(), which returns an
> > > array
> > > of clients (including some info about each client):
> > >
> > > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/acce=
ss-point-diagnostic-api.txt
> >
> > thanks I will test it. Is there any ready python test script for
> > it?
>
> Unfortunately no. Currently only iwctl uses GetDiagnostics() which
> you
> used below.
>
> > > Unfortunately you cant get notified for this via PropertyChanged
> > > since
> > > its a DBus method rather than properties. This was done because
> > > some
> > > of
> > > the client info can change quite frequently (RSSI, Tx/Rx
> > > rates/modes
> > > etc) and we didn't want to flood DBus with these messages
> > > constantly.
> > >
> > > In iwctl we actually poll this information every second.
> >
> > I was looking for notification via PropertyChanged callback. I am
> > using
> > iwd 1.13. when I run iwctl ap wlan0 show it returns always 0
> > client!!
> > is this a bug in the old version?
> >
> >                              Access Point
> > Interface                           *
> > -----------------------------------------------------------------
> > ----
> > -----------
> >   Settable  Property            Value
> > -----------------------------------------------------------------
> > ----
> > -----------
> >             Started             yes
> >             Name                xxxxx-5587111
> >
> >                                     Client
> > 0
> > -----------------------------------------------------------------
> > ----
> > -----------
> >             Property            Value
> > -----------------------------------------------------------------
> > ----
> > -----------
> >             Address             84:25:3f:9f:c2:54
> >             RxBitrate           0                    Kbit/s
> >             ExpectedThroughput  14722096             Kbit/s
>
> I'll admit this may look somewhat confusing, but this is actually
> printing out the one client that is connected, client 0.
>
I have connected multiple clients at this time but it returns only
client 0
> I will say there is very little information here. What card are you
> using?
>
I am using qualcomm qca9377 chip
> > [iwd]#
> >
> >
> > > Thanks,
> > > James
> >
> > Regards,Salahaldeen
> > > > Regards,
> > > > Salahaldeen Altous
> > > > _______________________________________________
> > > > iwd mailing list -- iwd(a)lists.01.org
> > > > To unsubscribe send an email to iwd-leave(a)lists.01.org
> > Leica Camera AG | Registergericht | District Court of Wetzlar:
> > HRB966
> > Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr.
> > Marita Paasch
> > Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> > Andreas Kaufmann
> >
> > This message may contain confidential and privileged information.
> > If
> > it has been sent to you in error, please notify the sender
> > immediately by replying to the message and please delete it from
> > your
> > computer.
>
> Thanks,
> James
>
Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr. Marita Paa=
sch
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--===============0894782723791888599==--

