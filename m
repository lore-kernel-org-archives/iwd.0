Content-Type: multipart/mixed; boundary="===============8312487049618548683=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Thu, 10 Sep 2020 04:23:01 +0200
Message-ID: <CAOq732Lxiq5+QnbjF2m=BA2JhWwz1i4_az2oVj55_UNFm1XZFg@mail.gmail.com>
In-Reply-To: <7625e8bb-cfb0-a1e0-ddb5-d821842e0a28@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8312487049618548683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2020 at 03:11, Denis Kenzior <denkenz@gmail.com> wrote:
> >>> +     while ((index =3D l_getrandom_uint32()) >=3D limit);
> >>
> >> So I actually wonder if this should be an ell utility.  I'm not too su=
re I like
> >> the idea of hitting getrandom in a loop.  The chances are pretty small=
 but
> >> still...  Perhaps using rand_r  with a random seed would be better.
> >
> > Do you mean adding something like l_getrandom_range()?
>
> I was thinking:
>
> l_int_distribution_new(min, max);
> l_int_distribution_next();
> l_int_distribution_desroy();
>
> where _new would grab a random seed and after that use rand.  The numbers
> produced should be uniform enough.

They'd be uniform enough for me, but not any better than doing
l_getrandom_uint32() % 62.  Essentially you only get 32 bits of
randomness and regardless of how many times you call rand() you still
end up with a function of those original 32 bits.  Basically your loop
produces a mapping, a lookup table, of 2^32 numbers into 62 numbers.
There's always going to be at least 2 numbers that pop up with a
higher frequency than the other 60 in that set.

>
> >
> > However if we just use a single random seed of say 32 bits, we're
> > guaranteed a non-uniform distribution, unless 1 << 32 is divisible by
> > the size of the set (not the case).  I'm no expert but as far as I
> > know (and googled) there's no way to get uniform distribution with a
> > predefined number of random bits.
>
> You only need log2(max - min + 1) bits of randomness.  If the resulting n=
umber
> is too large, you throw it away and grab the next random bits.  Essential=
ly the
> same as what you have now.

This will work but only with a new call to l_getrandom.

>
> >
> > The difficulty here is really only the "uniform distribution" part
> > which I don't think it super important, as long as it's *nearly*
> > uniform.  I'd have normally sacrificed it to avoid the loop and
> > thinking of it, the way we ended up doing it in
>
> I'm not worried about looping here as much as us wasting resources.  You =
are
> grabbing 32 bits of randomness at a time, and you only need 5.
>
> > l_key_generate_dh_private is completely non-uniform.  However we've
> > also later added l_ecc_scalar_new_random and l_ecdh_generate_key_pair
> > which do loop, with a much higher probability and discard many more
> > random bits in each iteration, so I didn't think you'd care.
>
> Right, I wasn't happy about those either, but had no concrete suggestions=
 at the
> time.  I might need to revisit these.
>
> >
> >>
> >> But if you want to direct code, then in theory you require only 5 bits=
 of
> >> randomness here since the set is 62 long.  You could make due with jus=
t grabbing
> >> a single byte of randomness and you'd have 3 attempts at being in the =
range (low
> >> 5 bits, then 6..1, 7..2)
> >
> > So the idea is to discard just the right-most (or left-most) bit in
> > each iteration and shift the other 4, and if we run out of bits we
> > draw another 8 and continue shifting, right?  This sounds reasonable.
>
> Ah, I was thinking more simply:
>
> - Draw 8 bits of randomness
> - Try the lower 5 bits
> - Try the middle 5 bits
> - Try the upper 5 bits
> - If we're here, go back to the beginning
>
> Assuming the 8 bits are truly random, you basically get 3 tries to get a =
usable
> number.
>
> I think what you're thinking (correct me if I'm wrong) is a 'sliding wind=
ow' of
> sorts.  So you get 8 bits, slide the 5-bit window to the right and try fo=
r a
> number.  If that doesn't work, slide the window 1 bit left, try again.  O=
nce a
> number is found, discard all bits in the scale and to the right.  If you =
run out
> of bits, you grab more randomness and push it to the left.

So I think this produces an uneven distribution, I'll explain why
below.  But we could definitely re-use the 2 bits we didn't use from
the first byte, after we didn't like the first 6-bit window.

>
> >
> > On a second thought though... if our first 5-bit number was >=3D 62, we
> > went into a second iteration and reused bits 5...1, we start favouring
> > some numbers and the uniform distribution goes out the window.  In
> > fact, in this case the first number must have been 62 or 63... we
> > shift right, we get 31 and add a new topmost bit, we can only end up
> > drawing 31 from there on.
>
> Since the bits are truly random, what difference does it make if we take =
bits
> 0..4 or 1..5?

It doesn't, but it does make a difference that we re-use some bits
after we already know something about them.  At that point they're no
longer random.

Our 62 character set is a good example, think about this:

We looked at the bits 0...5.  The value was 62 or 63.  In binary 62
and 63 are 111110 and 111111.  Depending on how you ordered your bits,
bits 1-5 may have been all ones.  Now you try bits 1...6.  You already
know that the value is going to be 011111 or 111111.  If it is the
former, we generated 31.  If it is the latter, we have to loop again,
but again we're starting with 5 ones and one random bit, and we can
only draw 31.

So in effect that is less uniform than l_getrandom_uint32() % 62.

>
> >
> > We probably have to choose between looping and generating independent
> > random bits each time, or doing (random % 62), which is better than
> > the above idea and than what we do in l_key_generate_dh_private.
>
> No, random % 62 would definitely result in an uneven distribution.

Right, but it's not bad enough that it really helps an attacker.

>
> 0 % 62 -> 0
> 1 % 62 -> 1
> ...
> 62 % 62 -> 0
> 63 % 62 -> 1
>
> So you have 2/64 chance for a 0 and 1.  You must loop if the random is ou=
tside
> the limit.

That depends, if you use a full byte % 62, you have a 5/256 chance for
a [0-7] number and 4/256 for a [8-62] number.  If you use
l_getrandom_uint32() % 62 you have a 69273667 / 2^32 chance for [0-3]
and a 69273666 / 2^32 for [4-62].

Best regards
--===============8312487049618548683==--

