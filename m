Content-Type: multipart/mixed; boundary="===============0293212984849445184=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 10 May 2021 12:46:24 -0500
Message-ID: <CAG17S_OYzo+EcNoTNcTo=7_zip-HnovwNXjHqwZJ_k4f6TdJRQ@mail.gmail.com>
In-Reply-To: <9607578469c8a0f5d902c3198a3b75df7b8179a4.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0293212984849445184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 11:10 AM James Prestwood <prestwoj@gmail.com> wro=
te:
>
> Hi Keith,
>
> On Mon, 2021-05-10 at 09:47 -0500, KeithG wrote:
> > James,
> >
> > I am on iwd 1.14, now and still get the same error.
>
> Hmm, I just tried with 1.14 checked out and saw no problems. This was
> on a RPi 3 though, not a v1 with wifi dongle. Still, your problem does
> seem to be related to what we fixed previously as you're EAPoL frames
> look suspiciously similar.
>
> Could you run unit/test-eapol and see if that passes.
>
> Also, I'm guessing your using a packaged version of IWD? I would be
> curious to see how exactly this is built (what compile/link options,
> gcc version etc. Ill see if I can find this online somewhere). Our
> 'fix' was a pragma disabling optimization in a specific routine, but
> maybe there are compiler options which undo this? I'm not too familiar
> with the ins and outs of pragmas.
>
> Another route would be to see if you could build IWD from source
> (unless that is what you are doing already).
>
> I've got an old RPi 1 buried somewhere. If I can find it I will give it
> a try.
>
> Thanks,
> James
>
>

James,


I am using a pre-packages Arch Linux iwd package. It reports 1.14-1. I
have built iwd-git, but am trying to use the Arch current if possible.

This is what is said today when I tried to connect:

May 10 11:35:38 deskrune iwd[4565]: AP Probe Request from f8:1f:32:39:fe:32
May 10 11:35:38 deskrune iwd[4565]: AP Probe Response delivered OK
May 10 11:35:38 deskrune iwd[4565]: AP Authentication from f8:1f:32:39:fe:32
May 10 11:35:38 deskrune iwd[4565]: AP Authentication frame 2 ACKed by STA
May 10 11:35:38 deskrune iwd[4565]: AP Association Request from
f8:1f:32:39:fe:32
May 10 11:35:38 deskrune iwd[4565]: AP (Re)Association Response ACK received
May 10 11:35:40 deskrune iwd[4565]: 4-Way handshake failed for
ifindex: 3, reason: 15

When I run the test-eapol, I get:
# ./test-eapol
TEST: /EAPoL Key/Key Frame 1
TEST: /EAPoL Key/Key Frame 2
TEST: /EAPoL Key/Key Frame 3
TEST: /EAPoL Key/Key Frame 4
TEST: /EAPoL Key/Key Frame 5
TEST: /EAPoL Key/Key Frame 6
TEST: /EAPoL Key/Key Frame 7
TEST: /EAPoL Key/Key Frame 8
TEST: /EAPoL Key/Key Frame 9
TEST: /EAPoL Key/Key Frame 10
TEST: /EAPoL Key/Key Frame 11
TEST: /EAPoL Key/Key Frame 12
TEST: /EAPoL Key/Key Frame 13
TEST: /EAPoL Key/Key Frame 14
TEST: /EAPoL Key/Key Frame 15
TEST: /EAPoL Key/Key Frame 16
TEST: /EAPoL Key/Key Frame 17
TEST: /EAPoL Key/Key Frame 18
TEST: /EAPoL Key/Key Frame 19
TEST: /EAPoL Key/Key Frame 20
TEST: /EAPoL Key/Key Frame 21
TEST: /EAPoL Key/Key Frame 22
TEST: /EAPoL Key/Key Frame 23
TEST: /EAPoL Key/Key Frame 24
TEST: /EAPoL Key/Key Frame 25
TEST: /EAPoL Key/Key Frame 26
TEST: /EAPoL Key/Key Frame 27
TEST: /EAPoL Key/Key Frame 28
TEST: /EAPoL Key/Key Frame 29
TEST: /EAPoL Key/Key Frame 30
TEST: /EAPoL Key/Key Frame 31
TEST: /EAPoL Key/Key Frame 32
TEST: /EAPoL Key/MIC Test 1
TEST: /EAPoL Key/MIC Test 2
TEST: /EAPoL Key/Calculate MIC Test 1
TEST: EAPoL/WPA2 4-Way Handshake
TEST: EAPoL/WPA2 4-Way & GTK Handshake
TEST: EAPoL/WPA 4-Way & GTK Handshake
TEST: EAPoL/WPA2 PTK State Machine
TEST: EAPoL IGTK & 4-Way Handshake
TEST: EAPoL/WPA2 PTK & GTK State Machine
TEST: EAPoL/WPA PTK & GTK State Machine Test 1
TEST: EAPoL/WPA PTK & GTK State Machine Test 2
TEST: EAPoL/WPA2 Retransmit Test
TEST: EAPoL/FT-Using-PSK 4-Way Handshake
TEST: EAPoL/Supplicant+Authenticator 4-Way Handshake
test-eapol: unit/test-eapol.c:3698: eapol_ap_sta_handshake_test:
Assertion `s.ap_success && s.sta_success' failed.
Aborted (core dumped)

Regards,

Keith
--===============0293212984849445184==--

