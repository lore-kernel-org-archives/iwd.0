Content-Type: multipart/mixed; boundary="===============3142284054747435830=="
MIME-Version: 1.0
From: Altous, Salahaldeen <Salahaldeen.Altous@leica-camera.com>
Subject: Re: iwd as AP "Couldn't connect to network"
Date: Wed, 07 Apr 2021 15:34:14 +0000
Message-ID: <eee7f926c78f3dba582bc527695dad3749970181.camel@leica-camera.com>
In-Reply-To: <f40d0d8e27f8f62fd4f6851ea67b816fe9f26335.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3142284054747435830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

After some try and error I have found the the /etc/iwd/main.conf case
this error, I have deleted it. my main.conf looks like

[General]
EnableNetworkConfiguration=3Dtrue
APRanges=3D192.168.5.1/24
[Network]
RoutePriorityOffset=3D200
NameResolvingService=3Dresolvconf


Now I can start iwd 1.13 without problem but still can not connect to
this ap. I have started iwd-ap and I got [connection to "myssid"
timeout out. connection failed].

AP Probe Request from dc:a6:32:22:5f:ac
../iwd-1.13/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
../iwd-1.13/src/wiphy.c:wiphy_radio_work_next() Starting work item 5
../iwd-1.13/src/netdev.c:netdev_mlme_notify() MLME notification Frame
TX Status(60)
../iwd-1.13/src/frame-xchg.c:frame_xchg_mlme_notify() Received no ACK
../iwd-1.13/src/frame-xchg.c:frame_xchg_tx_cb() err 0
../iwd-1.13/src/frame-xchg.c:frame_xchg_wait_cancel()
Frame tx retry limit reached

I have tried to verify this with iwd-1.13, archlinux and raspberrypi4
and get the same error "connection timeout".

Raspberrypi4 Linux version was "Linux alarm 5.10.13-1-ARCH #1 SMP Thu
Feb 4 17:26:42 MST 2021 aarch64 GNU/Linux
"

Regards,
Salahaldeen

On Wed, 2021-04-07 at 09:29 +0000, Altous, Salahaldeen wrote:
> Hi Denis,
>
> On Tue, 2021-04-06 at 11:23 -0500, Denis Kenzior wrote:
> > Hi Salahaldeen,
> >
> > On 4/6/21 4:41 AM, Altous, Salahaldeen wrote:
> > > Hi everyone!
> > >
> > > I am running iwd 1.9 (dunfell Yocto Project 3.1) with ell 0.33
> > > with
> > > Linux kernel 4.4.236.
> >
> > This version is quite old, can you upgrade to 1.13 ?
> I have tried to update to iwd 1.12 and ell 0.38 but I have problem
> with
> starting iwd (Module ap failed to start: -22). I have not seen this
> error with iwd 1.9.
> Where I can find the known frequency file?
>
> ../git/src/knownnetworks.c:known_network_frequencies_load() No known
> frequency file found.
> Module ap failed to start: -22
> ../git/src/module.c:iwd_modules_exit()
> ../git/src/wsc.c:wsc_exit()
> D-Bus disconnected, quitting...
>
> updating Linux kernel to a new version is not possible but I am using
> the lastest 4.4 LTS updates.
> > > when I try to start iwd in AP mode (ap wlan0 start myssid
> > > mypassword
> > > ) and try to establish a connection to my AP I get the error
> > > "Couldn't
> > > connect to network"
> > >
> >
> > What hardware are you running?  Is it Broadcom by any chance?  If
> > so,
> > you need
> > iwd version >=3D 1.12 for AP mode to work.
> >
> We are using a qualcom chip not broadcom
> > Regards,
> > -Denis
>
> Regards,
> Salahaldeen
> Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr.
> Marita Paasch
> Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> Andreas Kaufmann
>
> This message may contain confidential and privileged information. If
> it has been sent to you in error, please notify the sender
> immediately by replying to the message and please delete it from your
> computer.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--
Mit freundlichen Gruessen / kind regards /=D9=85=D8=B9 =D8=A3=D8=B7=D9=8A=
=D8=A8 =D8=A7=D9=84=D8=AA=D8=AD=D9=8A=D8=A7=D8=AA

M.Sc Salahaldeen Altous
Sr. Embedded Linux Developer

Leica Camera AG / Software Competence Center /
Am Leitzpark 5 / D-35578 Wetzlar /
Telephone +49(0)6441-2080-280
Salahaldeen.altous(a)leica-camera.com  / www.leica-camera.com
Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr. Marita Paa=
sch
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--===============3142284054747435830==--

