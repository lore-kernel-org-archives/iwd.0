Content-Type: multipart/mixed; boundary="===============6568658427948470749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 11:37:38 -0500
Message-ID: <beb7757f-f62c-7d87-da89-a71a65e572b7@gmail.com>
In-Reply-To: <0faae04d-6658-55d8-2d10-20da4e043917@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6568658427948470749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On 3/29/21 11:29 AM, Mauro Condarelli wrote:
>> So in theory this should always be happening.=C2=A0 Once iwd is in
>> 'autoconnect' state (starting state, or when we lose a connection)
>> then any scan results triggered (either internal scanning logic or
>> scans triggered via dbus/iwctl) should then be considered for
>> autoconnect purposes.=C2=A0 You say that 'it's not always the case'. So
>> this works for you sometimes and not other times?=C2=A0 Can you capture
>> some logs for us?=C2=A0 Also, are you running any other network managers=
 on
>> top of iwd or just iwd standalone?
> =

> I am guessing he needs to re-enter 'autoconnect' state after an explicit
> disconnect.
> =


'explicit disconnect' as in 'station wlan0 disconnect'?  That should really =

never be necessary, and in fact it has the side-effect of disabling autocon=
nect. =

  We probably should have never enabled this command in iwctl.

> Use case for this would be to disconnect from the currently connected
> net and try to connect to some other, if available.
> =

> What would be command sequence for this?

So while connected, it should just be 'station wlan0 connect <some other =

network>'.  iwd will gracefully switch networks  (disconnect from old + con=
nect =

to new) for you.

Regards,
-Denis
--===============6568658427948470749==--

