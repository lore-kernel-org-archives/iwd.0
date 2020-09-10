Content-Type: multipart/mixed; boundary="===============5028715646841203034=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Thu, 10 Sep 2020 09:21:27 -0500
Message-ID: <b28327a5-1680-a9f3-2bf1-a8c8f3b8676f@gmail.com>
In-Reply-To: <CAOq732JwG=z579h1vtKawjBxM_eNrQNUbJwOouPP18QAbBr6hA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5028715646841203034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> What we're doing if we use a slightly non-uniform random distribution
> is we reduce the strength of the passphrase, but by less than one bit
> over the whole passphrase.  The spec says that the passphrase "shall
> contain at least eight ASCII characters randomly selected with a
> uniform distribution from the following character set: upper case
> letters, lower case letters and numbers."  In the patches I went for a
> 20-char passphrase.  Even if I'd used only hex digits (4 bits per
> char) the passphrase would stlil be stronger than the 8 character
> passphrase generated according to the spec.  Note in

Right, but the 8 char passphrase the spec recommends is basically completel=
y =

inadequate these days.  Since the set is reduced to only numbers / letters,=
 and =

no special or other printable characters, brute-forcing an 8 character =

passphrase is trivial.  So I think your 20 character passphrase is closer t=
o =

what we should shoot for.

> l_key_generate_dh_private we're openly throwing away some bits of the
> key.

So can we do better there?

I'm less concerned about DH because the key is used only once to deliver th=
e =

credentials.  Whereas a passphrase can be brute-forced offline.  This is wh=
ere =

slight bias to the first 8 characters or so can really hurt.

> =

> But the cost of doing exactly what the spec says is low so I'd just do th=
at.
> =


My thinking as well.

>>
>>>>
>>>> 0 % 62 -> 0
>>>> 1 % 62 -> 1
>>>> ...
>>>> 62 % 62 -> 0
>>>> 63 % 62 -> 1
>>>>
>>>> So you have 2/64 chance for a 0 and 1.  You must loop if the random is=
 outside
>>>> the limit.
>>>
>>> That depends, if you use a full byte % 62, you have a 5/256 chance for
>>> a [0-7] number and 4/256 for a [8-62] number.  If you use
>>> l_getrandom_uint32() % 62 you have a 69273667 / 2^32 chance for [0-3]
>>> and a 69273666 / 2^32 for [4-62].
>>
>> I can buy the argument here that with a simple modulus operation, without
>> re-rolling things, the 32 bit block wins in producing a more uniform
>> distribution.  But fundamentally, without re-rolling, the distribution i=
s still
>> skewed.  So to be on the safe side, we need to re-roll regardless.
>>
>> The question then becomes, would we end up using less randomness on aver=
age
>> using 32 bit blocks or smaller ones, and does it matter.  Given that
>> l_getrandom() can block for lack of entropy, I would guess that using le=
ss
>> should be a goal.
> =

> Ok, let me rewrite this using l_getrandom(&byte, 1) I guess.  We could
> optimize it a little by trying to generate multiple characters at once
> but the code gets more complicated, I think it's not worth it?
> =


I'd think just being greedy and generating the entire passphrase in one go =
if =

possible would be the better approach.  We could even just use the first 2 =
chars =

of the generated passphrase as the SSID 'xy' and use the rest as the passph=
rase.

Also, since we have some leeway in how big the passphrase is, why not just =

request one bigger than we need and if it comes out several chars smaller d=
ue to =

re-rolls, then we don't worry about it as long as it is bigger than what we=
 need.

Regards,
-Denis
--===============5028715646841203034==--

