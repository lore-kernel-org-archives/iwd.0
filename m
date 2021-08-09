Content-Type: multipart/mixed; boundary="===============8060360794924778535=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Mon, 09 Aug 2021 08:58:50 -0700
Message-ID: <08640727a3dc701404e13fb28211cf7adaedd1f1.camel@gmail.com>
In-Reply-To: <e2da94d7a788840b30b45cebab451b9f36a54a3e.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8060360794924778535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2021-08-09 at 07:22 +0000, Altous, Salahaldeen wrote:
> Hi James,
> =

> On Fri, 2021-08-06 at 09:32 -0700, James Prestwood wrote:
> > Hi,
> > =

> > On Fri, 2021-08-06 at 06:30 +0000,
> > salahaldeen.altous(a)leica-camera.com
> > wrote:
> > > Hi,
> > > =

> > > I have a device which running as AP point. I would like to know
> > > every
> > > time there is a new connection/discounntion for this access
> > > point.
> > > Does iwd API support this? DHCP is enable in AP configuration
> > > (EnableNetworkConfiguration=3DTrue)
> > =

> > There is an access point API, GetDiagnostics(), which returns an
> > array
> > of clients (including some info about each client):
> > =

> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/access=
-point-diagnostic-api.txt
> =

> thanks I will test it. Is there any ready python test script for it?

Unfortunately no. Currently only iwctl uses GetDiagnostics() which you
used below.

> > =

> > Unfortunately you cant get notified for this via PropertyChanged
> > since
> > its a DBus method rather than properties. This was done because
> > some
> > of
> > the client info can change quite frequently (RSSI, Tx/Rx
> > rates/modes
> > etc) and we didn't want to flood DBus with these messages
> > constantly.
> > =

> > In iwctl we actually poll this information every second.
> =

> =

> I was looking for notification via PropertyChanged callback. I am
> using
> iwd 1.13. when I run iwctl ap wlan0 show it returns always 0 client!!
> is this a bug in the old version?
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Access Point
> Interface=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *
> ---------------------------------------------------------------------
> -----------
> =C2=A0 Settable=C2=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Value
> ---------------------------------------------------------------------
> -----------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Starte=
d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=
es
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 xxxxx-5587111
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Client
> 0
> ---------------------------------------------------------------------
> -----------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Proper=
ty=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value
> ---------------------------------------------------------------------
> -----------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Addres=
s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=
4:25:3f:9f:c2:54
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RxBitr=
ate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kbit/s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expect=
edThroughput=C2=A0 14722096=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Kbit/s

I'll admit this may look somewhat confusing, but this is actually
printing out the one client that is connected, client 0.

I will say there is very little information here. What card are you
using?

> =

> [iwd]#
> =

> =

> > =

> > Thanks,
> > James
> =

> Regards,Salahaldeen
> > =

> > > Regards,
> > > Salahaldeen Altous
> > > _______________________________________________
> > > iwd mailing list -- iwd(a)lists.01.org
> > > To unsubscribe send an email to iwd-leave(a)lists.01.org
> > =

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

Thanks,
James

--===============8060360794924778535==--

