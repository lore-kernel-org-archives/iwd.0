Content-Type: multipart/mixed; boundary="===============2987312874452803025=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 13:25:48 -0500
Message-ID: <1e259b78-1dc7-36c4-6c6f-8efe28ee1050@gmail.com>
In-Reply-To: 2f87d1e1f09d2d07cf1c23fb62b75b8d@lausen.nl

--===============2987312874452803025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leonard,

On 4/5/22 12:35, Leonard Lausen wrote:
> Hi Denis,
> =

>>> Thank you! Your patch prevents the crash. Whenever I walk towards or aw=
ay from
>>> the router and the router tries to switch me between 2.4G and 5G, I see=
 a
>>> `iwd[29343]: src/station.c:station_ap_directed_roam() roam: unexpected =
AP
>>> directed roam -- ignore` logline. However, my laptop remains on the 2.4=
G / 5G
>>> band respectively and does not switch.
>>
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


interesting that you have 'wlan0' here, but 'wlp58s0' in your NM configurat=
ion. =

  I suspect NM isn't using iwd at all.

Anyway, this confirms iwd thinks it is not connected, which means that...

>> I'm confused why the AP is even sending this. Maybe the kernel crash you=
 reported is confusing
>> everything.
> =

> The kernel crash should be unrelated. I rebooted and verified the iwctl s=
tation
> wlan0 show output remains the same. I'm using NetworkManager with iwd bac=
kend
> and NetworkManager does show me as connected. Maybe that is related?
> =


NM probably starts up wpa_s to manage the connection.

> % sudo cat /etc/NetworkManager/conf.d/backend.conf
> [device]
> match-device=3Dwlp58s0

I'm not sure this directive is actually supported by the iwd backend.  Mayb=
e =

Andrew can comment.

> wifi.backend=3Diwd
> =

> I do see a number of `Unexpected connection related event -- is another s=
upplicant running?`
> in the iwd.service log.

So I bet all your problems result from iwd + wpa_s running at the same time=
. =

Not something we support or test for obviously :)

> =

> Besides, upon reboot I have observed another iwd segfault. Unfortunately I
> wasn't running iwd in debug mode upon reboot. I've changed that now, but =
upon
> the second reboot I didn't get a segfault..

And I think this is related to above as well.

Regards,
-Denis
--===============2987312874452803025==--

