Content-Type: multipart/mixed; boundary="===============1447025107607519092=="
MIME-Version: 1.0
From: Leonard Lausen <leonard at lausen.nl>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 22:32:39 +0000
Message-ID: <3cca9dfa225332ae782c3bf99ebd5913@lausen.nl>
In-Reply-To: 2f87d1e1f09d2d07cf1c23fb62b75b8d@lausen.nl

--===============1447025107607519092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> I'm not sure what is going on, but according to iwd, you're not even con=
nected!? What does 'iwctl
>> station wlan0 show' say?
> =

> % iwctl station wlan0 show
> Station: wlan0
> -------------------------------------------------------------------------=
-------
> Settable Property Value
> -------------------------------------------------------------------------=
-------
> Scanning no
> State disconnected
> =

>> I'm confused why the AP is even sending this. Maybe the kernel crash you=
 reported is confusing
>> everything.

The NetworkManager "running" with iwd backend was not actually linked to iw=
d,
causing the discrepancy. Thus I think this segfault in parse_neighbor_repor=
t at
src/station.c:1747 is due to my user-error having both iwd (which get's
activated when running iwctl thanks to systemd) as well as NetworkManager
non-iwd backend running. There are still other issues with this router, Int=
el's
AX210 and 801.22ax causing system hangs and kernel crashes, but maybe iwd i=
s not
involved. I'll investigate and update this thread if I can identify any iwd
issues.

Thank you
Leonard
--===============1447025107607519092==--

