Content-Type: multipart/mixed; boundary="===============7000006942507980818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: WiFi interface stuck in 'Powered off' (link down) mode after
 suspend
Date: Thu, 28 Apr 2022 11:06:46 -0500
Message-ID: <fad755c3-372c-8aba-9850-f5876ae0a1fc@gmail.com>
In-Reply-To: 871qxkkeqb.fsf@toke.dk

--===============7000006942507980818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Toke,

On 4/25/22 16:58, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Hi everyone
> =


This message somehow went into spam, so only seeing this now.

> I am encountering a strange problem with my WiFi not coming back after a
> suspend. Specifically, after a suspend-resume cycle, iwd will report,
> when issuing a 'station list' in iwctl:
> =

>    No devices in Station mode available.
> =

> But when issuing a 'device list' it shows up:
> =

>    wlan0               7a:e2:f0:31:a5:ae   off        phy0      station
> =

> which is a bit confusing, IMO. Issuing a 'device wlan0 show' gets me:

iwctl just shows the available 'Station' interfaces.  iwd removes the stati=
on =

interfaces when the device is powered off (there's nothing to show).  'devi=
ce =

list' shows the Device interfaces which correspond to the actual netdev.  T=
hat =

is why you're seeing wlan0 in 'device list' but not in 'station list'

> =

>              Name                wlan0
>              Mode                station
>              Powered             off
>              Address             7a:e2:f0:31:a5:ae
>              Adapter             phy0
> =

> And issuing a 'device wlan0 set-property Powered on' restores the device
> to working order and reconnects.

iwd doesn't do anything on suspend, it isn't even aware of suspend.  This l=
ooks =

like a kernel bug to me? Is the driver crashing by any chance?

> =

> I went looking in the iwd source code, and it looks like that 'Powered'
> in iwd lingo translates to 'link up' in the kernel, right? Indeed,
> issuing an 'ip link up' on the wlan device after coming back from
> suspend is enough to get me back online.

Device.Powered means IFF_UP, yes.  But as I said above, this shouldn't be =

necessary if the kernel driver is doing the right thing...

> =

> I'm honestly not really sure if this is a bug in the kernel, or in iwd.
> I mean, it seems like iwd should be able to just set 'link up' and
> continue on its merry way (and indeed if I restart iwd entirely it will
> do this). But am also fairly sure it used to work on previous kernels,
> so maybe the kernel behaviour changed? (I have not had a chance to test
> this as bisecting is a bit cumbersome on my daily driver laptop; so
> figured I'd ask y'all's opinion first).
> =

> This happens on a 5.17 kernel with an Intel AX201 device (using the
> iwlwifi) driver.
> =

> Hoping someone can help me get this fixed, whether that be by fixing iwd
> or telling me to go bisect the kernel :)
> =


There have been no iwd changes in this area in quite some time, so if the k=
ernel =

is the only thing that changed, then I would look there.

Regards,
-Denis
--===============7000006942507980818==--

