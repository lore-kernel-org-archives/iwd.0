Content-Type: multipart/mixed; boundary="===============6331992428800081960=="
MIME-Version: 1.0
From: 58e33db1-f428-4823-8cc3-d962d0fb8aa8 at slmail.me
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Mon, 27 Sep 2021 15:56:13 +0000
Message-ID: <163275817340.7.1055592251905783155.14312319@slmail.me>
In-Reply-To: 163250896849.8.5078574600708407940.14148610@simplelogin.co

--===============6331992428800081960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Well, I'm even more stumped then.  Looking at the commits in 1.18, I do n=
ot =

> believe we changed anything even remotely related to this.  Even more =

> interesting is that this only happens on boot and not in subsequent attem=
pts =

> which makes this hard to duplicate.
> =

> I'll poke around some more, but I think a git bisect is the only way to n=
arrow =

> this down.

Well Denis, I've managed to track it down to this commit:

commit ad228461abbfe1875e15624b2be0c1535e623307
Date:   Fri Aug 27 05:02:03 2021 +0200

    netconfig: Move loading settings to new method, refactor
    =

    Split loading settings out of network_configure into a new method,
    network_load_settings.  Make sure both consistently handle errors by
    printing messages and informing the caller.

 src/netconfig.c | 236 +++++++++++++++++++++++++++++++++++-----------------=
----
 src/netconfig.h |   5 +-
 src/p2p.c       |  12 ++-
 src/station.c   |  20 +++--
 4 files changed, 175 insertions(+), 98 deletions(-)

I've done all the testing with AddressRandomization=3Dnetwork in main.conf.

Cheers.


--===============6331992428800081960==--

