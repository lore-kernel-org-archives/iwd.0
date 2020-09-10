Content-Type: multipart/mixed; boundary="===============8103945939172207600=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Wed, 09 Sep 2020 20:01:43 -0500
Message-ID: <7625e8bb-cfb0-a1e0-ddb5-d821842e0a28@gmail.com>
In-Reply-To: <CAOq732+JfnTyx8CrDByR27BSVfYGK6XV71y6Vgb22NE5mHNFNg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8103945939172207600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     while ((index =3D l_getrandom_uint32()) >=3D limit);
>>
>> So I actually wonder if this should be an ell utility.  I'm not too sure=
 I like
>> the idea of hitting getrandom in a loop.  The chances are pretty small b=
ut
>> still...  Perhaps using rand_r  with a random seed would be better.
> =

> Do you mean adding something like l_getrandom_range()?

I was thinking:

l_int_distribution_new(min, max);
l_int_distribution_next();
l_int_distribution_desroy();

where _new would grab a random seed and after that use rand.  The numbers =

produced should be uniform enough.

> =

> However if we just use a single random seed of say 32 bits, we're
> guaranteed a non-uniform distribution, unless 1 << 32 is divisible by
> the size of the set (not the case).  I'm no expert but as far as I
> know (and googled) there's no way to get uniform distribution with a
> predefined number of random bits.

You only need log2(max - min + 1) bits of randomness.  If the resulting num=
ber =

is too large, you throw it away and grab the next random bits.  Essentially=
 the =

same as what you have now.

> =

> The difficulty here is really only the "uniform distribution" part
> which I don't think it super important, as long as it's *nearly*
> uniform.  I'd have normally sacrificed it to avoid the loop and
> thinking of it, the way we ended up doing it in

I'm not worried about looping here as much as us wasting resources.  You ar=
e =

grabbing 32 bits of randomness at a time, and you only need 5.

> l_key_generate_dh_private is completely non-uniform.  However we've
> also later added l_ecc_scalar_new_random and l_ecdh_generate_key_pair
> which do loop, with a much higher probability and discard many more
> random bits in each iteration, so I didn't think you'd care.

Right, I wasn't happy about those either, but had no concrete suggestions a=
t the =

time.  I might need to revisit these.

> =

>>
>> But if you want to direct code, then in theory you require only 5 bits of
>> randomness here since the set is 62 long.  You could make due with just =
grabbing
>> a single byte of randomness and you'd have 3 attempts at being in the ra=
nge (low
>> 5 bits, then 6..1, 7..2)
> =

> So the idea is to discard just the right-most (or left-most) bit in
> each iteration and shift the other 4, and if we run out of bits we
> draw another 8 and continue shifting, right?  This sounds reasonable.

Ah, I was thinking more simply:

- Draw 8 bits of randomness
- Try the lower 5 bits
- Try the middle 5 bits
- Try the upper 5 bits
- If we're here, go back to the beginning

Assuming the 8 bits are truly random, you basically get 3 tries to get a us=
able =

number.

I think what you're thinking (correct me if I'm wrong) is a 'sliding window=
' of =

sorts.  So you get 8 bits, slide the 5-bit window to the right and try for =
a =

number.  If that doesn't work, slide the window 1 bit left, try again.  Onc=
e a =

number is found, discard all bits in the scale and to the right.  If you ru=
n out =

of bits, you grab more randomness and push it to the left.

> =

> On a second thought though... if our first 5-bit number was >=3D 62, we
> went into a second iteration and reused bits 5...1, we start favouring
> some numbers and the uniform distribution goes out the window.  In
> fact, in this case the first number must have been 62 or 63... we
> shift right, we get 31 and add a new topmost bit, we can only end up
> drawing 31 from there on.

Since the bits are truly random, what difference does it make if we take bi=
ts =

0..4 or 1..5?

> =

> We probably have to choose between looping and generating independent
> random bits each time, or doing (random % 62), which is better than
> the above idea and than what we do in l_key_generate_dh_private.

No, random % 62 would definitely result in an uneven distribution.

0 % 62 -> 0
1 % 62 -> 1
...
62 % 62 -> 0
63 % 62 -> 1

So you have 2/64 chance for a 0 and 1.  You must loop if the random is outs=
ide =

the limit.

Regards.
-Denis
--===============8103945939172207600==--

