Content-Type: multipart/mixed; boundary="===============5016899801583542657=="
MIME-Version: 1.0
From: Mark Hindley <mark at hindley.org.uk>
To: iwd at lists.01.org
Subject: Re: [PATCH] Enable DBus activation on non-systemd systems.
Date: Sat, 13 Nov 2021 07:40:11 +0000
Message-ID: <YY9r2xKMpN2UerTG@hindley.org.uk>
In-Reply-To: CFOFAY8M0DOT.XA6PQ5U1AUOG@mussels

--===============5016899801583542657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=C3=89rico,

On Sat, Nov 13, 2021 at 03:03:56AM -0300, =C3=89rico Nogueira wrote:
> For things like IWD, I feel DBus activation is definitely the wrong
> path. It should be a system service of some sort, so it can connect to a
> network without first being queried by a user manually, and it shouldn't
> be activated automatically.

Thanks, but I find this a confusing statement.

AFAIU iwd does use DBus activation currently. The Debian changelog contains=
 this
entry:

  * Recommend dbus (system bus)
    Interaction with iwd happens via dbus, i.e. as used by the iwctl
    command (or NetworkManager iwd backend).
    Packages using D-Bus usually doesn't describe this in their package
    relationships and implicitly rely on everyone having a bus available.
    People using iwd however seems to be confused about the lack of a
    startup script and fails to realize that "dbus activation" is the
    intended way to start iwd so hopefully making the dbus relationship more
    explicit will give a hint and help people figure this out.

So, given that DBus activation doesn't require systemd (but can make use of=
 it),
I was trying to understand and suggest a fix for why iwd DBus activation do=
esn't
work in the non-systemd case.

Mark
--===============5016899801583542657==--

