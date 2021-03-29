Content-Type: multipart/mixed; boundary="===============5220654363361286952=="
MIME-Version: 1.0
From: Yuri D'Elia <wavexx@thregr.org>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 18:32:07 +0200
Message-ID: <871rbxnci9.fsf@wavexx.thregr.org>
In-Reply-To: <0faae04d-6658-55d8-2d10-20da4e043917@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5220654363361286952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Il 29/03/2021 18:12, Denis Kenzior ha scritto:
>> So in theory this should always be happening.=C2=A0 Once iwd is in
>> 'autoconnect' state (starting state, or when we lose a connection)
>> then any scan results triggered (either internal scanning logic or
>> scans triggered via dbus/iwctl) should then be considered for
>> autoconnect purposes.=C2=A0 You say that 'it's not always the case'.

Indeed. AP disappears. Some time passes. I issue a 'station <net> scan'.
In some cases, iwd immediately connects to a known network. In some
other cases, I can see it with 'station <net> get-networks', but nothing
happens. Issuing a manual 'connect' will bring the network up
immediately.

>> Also, are you running any other network managers on top of iwd or
>> just iwd standalone?

I'm using iwd standalone.

On Mon, Mar 29 2021, Mauro Condarelli wrote:
> I am guessing he needs to re-enter 'autoconnect' state after an explicit
> disconnect.

I didn't explicitly disconnect in this case, but this makes me wonder if
iwd can exit the 'autoconnect' state by itself for some other reason.

> Use case for this would be to disconnect from the currently connected
> net and try to connect to some other, if available.
>
> What would be command sequence for this?

Would be curious about that too.
--===============5220654363361286952==--

