Content-Type: multipart/mixed; boundary="===============2362283007768880007=="
MIME-Version: 1.0
From: Mauro Condarelli <mc5686@mclink.it>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 18:29:06 +0200
Message-ID: <0faae04d-6658-55d8-2d10-20da4e043917@mclink.it>
In-Reply-To: <7558fe82-2fc7-d448-8eb3-374fb642d1d9@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2362283007768880007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Il 29/03/2021 18:12, Denis Kenzior ha scritto:
> Hi Yuri,
>
> On 3/26/21 4:28 PM, Yuri D'Elia wrote:
>> Is it possible to force iwd to connect to a known network without
>> explicitly giving a network name? That is, to force attempting to
>> autoconnect?
>>
>> Currently "station <net> connect" requires a ssid. It would be nice if
>> that would be made optional, causing iwd to go through the automatic
>> connect logic.
>>
>> I assumed that issuing a "station <net> scan" *would* attempt to
>> autoconnect if a known network is seen and we're currently disconnected,
>> but it's not always the case. If we disconnected from a known network
>> due to AP disappearing and reappearing sometime later, "scan" will the
>> network, but connection is still performed after some longer timeout.
>
> So in theory this should always be happening.=C2=A0 Once iwd is in =

> 'autoconnect' state (starting state, or when we lose a connection) =

> then any scan results triggered (either internal scanning logic or =

> scans triggered via dbus/iwctl) should then be considered for =

> autoconnect purposes.=C2=A0 You say that 'it's not always the case'. So =

> this works for you sometimes and not other times?=C2=A0 Can you capture =

> some logs for us?=C2=A0 Also, are you running any other network managers =
on =

> top of iwd or just iwd standalone?

I am guessing he needs to re-enter 'autoconnect' state after an explicit =

disconnect.

Use case for this would be to disconnect from the currently connected =

net and try to connect to some other, if available.

What would be command sequence for this?

>
>>
>> I want to bind an action to force a scan+connect without having to wait,
>> and without having to hardcode a network name. When I'm moving a laptop
>> between offices and go through some blind spots (elevator) I end-up in a
>> situation where I'm disconnected, and I want to force a connection right
>> away.
>
> We set some very conservative scan timeouts, perhaps you can play with =

> more aggressive settings to see if iwd's autoconnect logic will work =

> in your case? See 'man 5 iwd.config', InitialPeriodicScanInterval and =

> MaximumPeriodicScanInterval.
>
> I think our default for MaximumPeriodicScanInterval is way too high =

> actually.
>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>
Regards

Mauro

--===============2362283007768880007==--

