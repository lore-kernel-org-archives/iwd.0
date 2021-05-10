Content-Type: multipart/mixed; boundary="===============1980142472525802776=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 10 May 2021 10:56:07 -0700
Message-ID: <a0872cff318c23d5d6383cb2308129283e21b6fc.camel@gmail.com>
In-Reply-To: <CAG17S_OYzo+EcNoTNcTo=7_zip-HnovwNXjHqwZJ_k4f6TdJRQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1980142472525802776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> I am using a pre-packages Arch Linux iwd package. It reports 1.14-1.
> I
> have built iwd-git, but am trying to use the Arch current if
> possible.

Did you notice the same behavior? Or were you referring to some
previous build?

If you are able to build and disable optimization (./configure --
disable-optimization) that would tell us whether this is a compiler
issue or not. Based on what I have seen I am certain it is, but it
would tell us definitively.

Finding out exactly where the compiler has gone awry is the difficult
part since I cannot reproduce. It may require me finding my old RPi and
getting that set up again.

I know the Arch package maintainer is around sometimes (on IRC at
least). Maybe they have some insight into what GCC version is being
used? Ill try finding them on IRC.

> =

> This is what is said today when I tried to connect:
> =

> May 10 11:35:38 deskrune iwd[4565]: AP Probe Request from
> f8:1f:32:39:fe:32
> May 10 11:35:38 deskrune iwd[4565]: AP Probe Response delivered OK
> May 10 11:35:38 deskrune iwd[4565]: AP Authentication from
> f8:1f:32:39:fe:32
> May 10 11:35:38 deskrune iwd[4565]: AP Authentication frame 2 ACKed
> by STA
> May 10 11:35:38 deskrune iwd[4565]: AP Association Request from
> f8:1f:32:39:fe:32
> May 10 11:35:38 deskrune iwd[4565]: AP (Re)Association Response ACK
> received
> May 10 11:35:40 deskrune iwd[4565]: 4-Way handshake failed for
> ifindex: 3, reason: 15
> =

> When I run the test-eapol, I get:
> # ./test-eapol
> TEST: /EAPoL Key/Key Frame 1
> TEST: /EAPoL Key/Key Frame 2
> TEST: /EAPoL Key/Key Frame 3
> TEST: /EAPoL Key/Key Frame 4
> TEST: /EAPoL Key/Key Frame 5
> TEST: /EAPoL Key/Key Frame 6
> TEST: /EAPoL Key/Key Frame 7
> TEST: /EAPoL Key/Key Frame 8
> TEST: /EAPoL Key/Key Frame 9
> TEST: /EAPoL Key/Key Frame 10
> TEST: /EAPoL Key/Key Frame 11
> TEST: /EAPoL Key/Key Frame 12
> TEST: /EAPoL Key/Key Frame 13
> TEST: /EAPoL Key/Key Frame 14
> TEST: /EAPoL Key/Key Frame 15
> TEST: /EAPoL Key/Key Frame 16
> TEST: /EAPoL Key/Key Frame 17
> TEST: /EAPoL Key/Key Frame 18
> TEST: /EAPoL Key/Key Frame 19
> TEST: /EAPoL Key/Key Frame 20
> TEST: /EAPoL Key/Key Frame 21
> TEST: /EAPoL Key/Key Frame 22
> TEST: /EAPoL Key/Key Frame 23
> TEST: /EAPoL Key/Key Frame 24
> TEST: /EAPoL Key/Key Frame 25
> TEST: /EAPoL Key/Key Frame 26
> TEST: /EAPoL Key/Key Frame 27
> TEST: /EAPoL Key/Key Frame 28
> TEST: /EAPoL Key/Key Frame 29
> TEST: /EAPoL Key/Key Frame 30
> TEST: /EAPoL Key/Key Frame 31
> TEST: /EAPoL Key/Key Frame 32
> TEST: /EAPoL Key/MIC Test 1
> TEST: /EAPoL Key/MIC Test 2
> TEST: /EAPoL Key/Calculate MIC Test 1
> TEST: EAPoL/WPA2 4-Way Handshake
> TEST: EAPoL/WPA2 4-Way & GTK Handshake
> TEST: EAPoL/WPA 4-Way & GTK Handshake
> TEST: EAPoL/WPA2 PTK State Machine
> TEST: EAPoL IGTK & 4-Way Handshake
> TEST: EAPoL/WPA2 PTK & GTK State Machine
> TEST: EAPoL/WPA PTK & GTK State Machine Test 1
> TEST: EAPoL/WPA PTK & GTK State Machine Test 2
> TEST: EAPoL/WPA2 Retransmit Test
> TEST: EAPoL/FT-Using-PSK 4-Way Handshake
> TEST: EAPoL/Supplicant+Authenticator 4-Way Handshake
> test-eapol: unit/test-eapol.c:3698: eapol_ap_sta_handshake_test:
> Assertion `s.ap_success && s.sta_success' failed.
> Aborted (core dumped)
> =

> Regards,
> =

> Keith

Thanks,
James


--===============1980142472525802776==--

