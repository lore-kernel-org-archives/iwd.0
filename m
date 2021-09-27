Content-Type: multipart/mixed; boundary="===============5152451692435547548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Mon, 27 Sep 2021 11:42:21 -0500
Message-ID: <e9b2ee0f-d5ef-4641-b65f-64eb48c09bbf@gmail.com>
In-Reply-To: 163275817333.7.11025781967994364329.14312318@slmail.me

--===============5152451692435547548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On 9/27/21 10:56 AM, 58e33db1-f428-4823-8cc3-d962d0fb8aa8(a)slmail.me wrote:
>> Well, I'm even more stumped then.  Looking at the commits in 1.18, I do =
not
>> believe we changed anything even remotely related to this.  Even more
>> interesting is that this only happens on boot and not in subsequent atte=
mpts
>> which makes this hard to duplicate.
>>
>> I'll poke around some more, but I think a git bisect is the only way to =
narrow
>> this down.
> =

> Well Denis, I've managed to track it down to this commit:
> =


Aha!  Thanks for tracking this down.  I believe the patch I just sent to th=
e =

mailing list should fix.

Regards,
-Denis



--===============5152451692435547548==--

