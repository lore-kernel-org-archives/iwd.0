Content-Type: multipart/mixed; boundary="===============0916120823960808206=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.23 crashes in eapol_handle_pkt_1_of_4()
Date: Wed, 02 Feb 2022 11:16:33 -0600
Message-ID: <c8dcc66d-8241-f31f-3e27-13274792bdaa@gmail.com>
In-Reply-To: 87fsp1cw2j.fsf@toke.dk

--===============0916120823960808206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Toke,

On 2/2/22 06:05, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Hi
> =

> Since updating to iwd 1.23 (from Arch packages), I've started seeing
> periodic crashes. I rebuilt iwd with debug symbols enabled and got the
> following backtrace out of 'coredumpctl gdb':
> =


*hangs his head in shame*.  So I think we screwed up the same macro 2x now.

Can you please try the patch I just sent out?

Regards,
-Denis
--===============0916120823960808206==--

