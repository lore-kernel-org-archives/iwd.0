Content-Type: multipart/mixed; boundary="===============1624052526927994437=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Thu, 30 Sep 2021 01:14:27 +0200
Message-ID: <CAOq732KhfeRcqU1_ss+gSQBgPY_w42s-Ac3dkOp8A2_J75EQFA@mail.gmail.com>
In-Reply-To: ee756069-16b7-d191-3333-c021303c3096@gmail.com

--===============1624052526927994437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Sept 2021 at 00:57, Denis Kenzior <denkenz(a)gmail.com> wrote:
> > I don't remember what the reasoning was, but station_connect_cb does
> > handle some mechanisms that seem desirable here also, like trying the
> > next bss from the autoconnect list immediately and blacklisting BSSes.
>
> The connect failed path is generally used if the connection simply fails.
> Either due to an invalid password, or due to handshake timeout, or some o=
ther
> reason where the status_code can be returned by netdev.  Once we're succe=
ssfully
> connected, and the driver/kernel decides to disconnect us due to a firmwa=
re
> crash/bug/whatever, then I'm not sure blacklisting the bss should be done.
> Besides, we already sent the dbus message reply, etc.
>
> Now, maybe some elements of what the connect failed path does might be ne=
eded in
> this failure case.  But to determine that we would need to know why the
> disconnect happens? How often? Is it every time? Sometimes? Once in a blu=
e moon,
> etc.

Unfortunately this applies to most failure modes in a connection (at
802.11 level or at IP level -- for the user they're the same thing)
and I think the binary blacklisted/not blacklisted model we use
doesn't really work.  IIRC my initial patches used a different model
where the blacklist was a kind of penalty list where BSSes and/or
networks that fail more often are pushed further in the priority list.
In the end when we've tried all the BSSes in range we have nothing to
lose by retrying some of the ones we've already tried, we just don't
want to put them before other BSSes.  This can be done in a way that
over time the list converges to sorted by how often a network/bss
fails.

This also allows you to learn from some very clear cues that we're not
handling, like a user manually switching to another network.

Best regards
--===============1624052526927994437==--

