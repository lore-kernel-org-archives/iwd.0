Content-Type: multipart/mixed; boundary="===============8462319045876270386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 11:12:54 -0500
Message-ID: <7558fe82-2fc7-d448-8eb3-374fb642d1d9@gmail.com>
In-Reply-To: <87blb5o5ro.fsf@wavexx.thregr.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8462319045876270386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On 3/26/21 4:28 PM, Yuri D'Elia wrote:
> Is it possible to force iwd to connect to a known network without
> explicitly giving a network name? That is, to force attempting to
> autoconnect?
> =

> Currently "station <net> connect" requires a ssid. It would be nice if
> that would be made optional, causing iwd to go through the automatic
> connect logic.
> =

> I assumed that issuing a "station <net> scan" *would* attempt to
> autoconnect if a known network is seen and we're currently disconnected,
> but it's not always the case. If we disconnected from a known network
> due to AP disappearing and reappearing sometime later, "scan" will the
> network, but connection is still performed after some longer timeout.

So in theory this should always be happening.  Once iwd is in 'autoconnect' =

state (starting state, or when we lose a connection) then any scan results =

triggered (either internal scanning logic or scans triggered via dbus/iwctl=
) =

should then be considered for autoconnect purposes.  You say that 'it's not =

always the case'.  So this works for you sometimes and not other times?  Ca=
n you =

capture some logs for us?  Also, are you running any other network managers=
 on =

top of iwd or just iwd standalone?

> =

> I want to bind an action to force a scan+connect without having to wait,
> and without having to hardcode a network name. When I'm moving a laptop
> between offices and go through some blind spots (elevator) I end-up in a
> situation where I'm disconnected, and I want to force a connection right
> away.

We set some very conservative scan timeouts, perhaps you can play with more =

aggressive settings to see if iwd's autoconnect logic will work in your cas=
e? =

See 'man 5 iwd.config', InitialPeriodicScanInterval and MaximumPeriodicScan=
Interval.

I think our default for MaximumPeriodicScanInterval is way too high actuall=
y.

Regards,
-Denis

--===============8462319045876270386==--

