Content-Type: multipart/mixed; boundary="===============4309801975708675826=="
MIME-Version: 1.0
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen_=3Ctoke_at_toke=2Edk=3E?=
To: iwd at lists.01.org
Subject: Re: iwd 1.23 crashes in eapol_handle_pkt_1_of_4()
Date: Thu, 03 Feb 2022 12:35:21 +0100
Message-ID: <871r0kchdy.fsf@toke.dk>
In-Reply-To: 87a6f9c4f5.fsf@toke.dk

--===============4309801975708675826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke(a)toke.dk> writes:

> Denis Kenzior <denkenz(a)gmail.com> writes:
>
>> Hi Toke,
>>
>> On 2/2/22 06:05, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Hi
>>> =

>>> Since updating to iwd 1.23 (from Arch packages), I've started seeing
>>> periodic crashes. I rebuilt iwd with debug symbols enabled and got the
>>> following backtrace out of 'coredumpctl gdb':
>>> =

>>
>> *hangs his head in shame*.  So I think we screwed up the same macro 2x n=
ow.
>
> Heh, yeah, did see there was a commit touching that macro, but didn't
> look closer.
>
>> Can you please try the patch I just sent out?
>
> Can do - thanks! Did a build with it incorporated and am running that
> now. Usually crashes once every hour (with striking regularity); will
> leave it running overnight and see if the crashes are gone by tomorrow
> :)

Alright, so no crashes - thanks for the swift fix!

And just for future reference, in case anyone else runs into the same
issue: The crashes were initially taking the kernel down with them,
which has now also been fixed:
https://lore.kernel.org/r/20220201130951.22093-1-johannes(a)sipsolutions.net

-Toke
--===============4309801975708675826==--

