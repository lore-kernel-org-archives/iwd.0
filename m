Content-Type: multipart/mixed; boundary="===============1316953993953928608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Wed, 09 Sep 2020 22:56:44 -0500
Message-ID: <628728cd-30b2-8abb-57c2-6ac688845c67@gmail.com>
In-Reply-To: <CAOq732Lxiq5+QnbjF2m=BA2JhWwz1i4_az2oVj55_UNFm1XZFg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1316953993953928608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/9/20 9:23 PM, Andrew Zaborowski wrote:
> On Thu, 10 Sep 2020 at 03:11, Denis Kenzior <denkenz@gmail.com> wrote:
>>>>> +     while ((index =3D l_getrandom_uint32()) >=3D limit);
>>>>
>>>> So I actually wonder if this should be an ell utility.  I'm not too su=
re I like
>>>> the idea of hitting getrandom in a loop.  The chances are pretty small=
 but
>>>> still...  Perhaps using rand_r  with a random seed would be better.
>>>
>>> Do you mean adding something like l_getrandom_range()?
>>
>> I was thinking:
>>
>> l_int_distribution_new(min, max);
>> l_int_distribution_next();
>> l_int_distribution_desroy();
>>
>> where _new would grab a random seed and after that use rand.  The numbers
>> produced should be uniform enough.
> =

> They'd be uniform enough for me, but not any better than doing
> l_getrandom_uint32() % 62.  Essentially you only get 32 bits of
> randomness and regardless of how many times you call rand() you still
> end up with a function of those original 32 bits.  Basically your loop
> produces a mapping, a lookup table, of 2^32 numbers into 62 numbers.
> There's always going to be at least 2 numbers that pop up with a
> higher frequency than the other 60 in that set.

So to re-state it another way, you're saying that the pseudo-random approac=
h is =

not suitable for certain things?  I agree.  We should not generate the =

passphrase using this.  But for generating the SSID or other stuff?

That reminds me, why are we generating the passphrase and not the PSK for P=
2P? =

We could then generate the PSK directly and skip this entirely.

Also the rules for passphrases in 802.11 allow a different set of character=
s =

than what is covered here.  That is also a bit strange.  But I'm getting =

off-topic...

> =

>>
>>>
>>> However if we just use a single random seed of say 32 bits, we're
>>> guaranteed a non-uniform distribution, unless 1 << 32 is divisible by
>>> the size of the set (not the case).  I'm no expert but as far as I
>>> know (and googled) there's no way to get uniform distribution with a
>>> predefined number of random bits.
>>
>> You only need log2(max - min + 1) bits of randomness.  If the resulting =
number
>> is too large, you throw it away and grab the next random bits.  Essentia=
lly the
>> same as what you have now.
> =

> This will work but only with a new call to l_getrandom.

My point here was, you were grabbing 32 bit blocks of randomness at a time =
when =

doing 8 at a time would have been enough.

<snip>

>>>
>>> On a second thought though... if our first 5-bit number was >=3D 62, we
>>> went into a second iteration and reused bits 5...1, we start favouring
>>> some numbers and the uniform distribution goes out the window.  In
>>> fact, in this case the first number must have been 62 or 63... we
>>> shift right, we get 31 and add a new topmost bit, we can only end up
>>> drawing 31 from there on.
>>
>> Since the bits are truly random, what difference does it make if we take=
 bits
>> 0..4 or 1..5?
> =

> It doesn't, but it does make a difference that we re-use some bits
> after we already know something about them.  At that point they're no
> longer random.
> =

> Our 62 character set is a good example, think about this:
> =

> We looked at the bits 0...5.  The value was 62 or 63.  In binary 62
> and 63 are 111110 and 111111.  Depending on how you ordered your bits,
> bits 1-5 may have been all ones.  Now you try bits 1...6.  You already
> know that the value is going to be 011111 or 111111.  If it is the
> former, we generated 31.  If it is the latter, we have to loop again,
> but again we're starting with 5 ones and one random bit, and we can
> only draw 31.
> =

> So in effect that is less uniform than l_getrandom_uint32() % 62.

Not sure I buy that, but I don't have enough background to really argue.  I =

would tend to agree that unless proven otherwise, throwing the bits away is=
 a =

safer approach.  A quick test might be useful though.

> =

>>
>>>
>>> We probably have to choose between looping and generating independent
>>> random bits each time, or doing (random % 62), which is better than
>>> the above idea and than what we do in l_key_generate_dh_private.
>>
>> No, random % 62 would definitely result in an uneven distribution.
> =

> Right, but it's not bad enough that it really helps an attacker.
>

Yeah I dunno if we're qualified to say that ;)

>>
>> 0 % 62 -> 0
>> 1 % 62 -> 1
>> ...
>> 62 % 62 -> 0
>> 63 % 62 -> 1
>>
>> So you have 2/64 chance for a 0 and 1.  You must loop if the random is o=
utside
>> the limit.
> =

> That depends, if you use a full byte % 62, you have a 5/256 chance for
> a [0-7] number and 4/256 for a [8-62] number.  If you use
> l_getrandom_uint32() % 62 you have a 69273667 / 2^32 chance for [0-3]
> and a 69273666 / 2^32 for [4-62].

I can buy the argument here that with a simple modulus operation, without =

re-rolling things, the 32 bit block wins in producing a more uniform =

distribution.  But fundamentally, without re-rolling, the distribution is s=
till =

skewed.  So to be on the safe side, we need to re-roll regardless.

The question then becomes, would we end up using less randomness on average =

using 32 bit blocks or smaller ones, and does it matter.  Given that =

l_getrandom() can block for lack of entropy, I would guess that using less =

should be a goal.

Also, you're probably aware of this, but l_getrandom_uint32 was designed no=
t to =

block and falls back to rand() in case the entropy pool is empty.  It was m=
eant =

more for use by dhcp where crypto randomness is not needed.  So using it he=
re as =

it is implemented right now is probably not a good idea anyway.

Regards,
-Denis
--===============1316953993953928608==--

