Content-Type: multipart/mixed; boundary="===============5849276322757617060=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Wed, 29 Sep 2021 17:46:08 -0500
Message-ID: <ee756069-16b7-d191-3333-c021303c3096@gmail.com>
In-Reply-To: CAOq732L75EHicj1NQQuE_6YLUTcFHP7vo1u0RNXLPBrOKR2W+g@mail.gmail.com

--===============5849276322757617060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> I don't remember what the reasoning was, but station_connect_cb does
> handle some mechanisms that seem desirable here also, like trying the
> next bss from the autoconnect list immediately and blacklisting BSSes.

The connect failed path is generally used if the connection simply fails. =

Either due to an invalid password, or due to handshake timeout, or some oth=
er =

reason where the status_code can be returned by netdev.  Once we're success=
fully =

connected, and the driver/kernel decides to disconnect us due to a firmware =

crash/bug/whatever, then I'm not sure blacklisting the bss should be done. =

Besides, we already sent the dbus message reply, etc.

Now, maybe some elements of what the connect failed path does might be need=
ed in =

this failure case.  But to determine that we would need to know why the =

disconnect happens? How often? Is it every time? Sometimes? Once in a blue =
moon, =

etc.

> In this case it seems the problem was triggered by a driver problem
> (or our misunderstanding on when the radio is free for scanning) but
> if a specific BSS always fails during netconfig then we should
> blacklist it.
> =


Sure, but then these actions should be taken in the station_disassociated p=
ath, =

or a brand new path specifically for this case.

Regards,
-Denis
--===============5849276322757617060==--

