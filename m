Content-Type: multipart/mixed; boundary="===============4675727453193014726=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Thu, 10 Sep 2020 01:15:22 +0200
Message-ID: <CAOq732+JfnTyx8CrDByR27BSVfYGK6XV71y6Vgb22NE5mHNFNg@mail.gmail.com>
In-Reply-To: <b5f54c79-9e75-4c4b-c791-b1601c822fde@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4675727453193014726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2020 at 21:16, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> > Add a utility to select random characters from the set defined in P2P
> > v1.7 Section 3.2.1.
> > ---
> >   src/p2putil.c | 26 ++++++++++++++++++++++++++
> >   src/p2putil.h |  2 ++
> >   2 files changed, 28 insertions(+)
> >
> > diff --git a/src/p2putil.c b/src/p2putil.c
> > index d0f3a444..99ab4ca0 100644
> > --- a/src/p2putil.c
> > +++ b/src/p2putil.c
> > @@ -2611,3 +2611,29 @@ uint8_t *p2p_build_go_disc_req(size_t *out_len)
> >       return p2p_build_action_frame(false, P2P_ACTION_GO_DISCOVERABILIT=
Y_REQ,
> >                                       0, NULL, NULL, NULL, 0, out_len);
> >   }
> > +
> > +/*
> > + * Select a random char from the set defined in section 3.2.1:
> > + *
> > + * "Following "DIRECT-" the SSID shall contain two ASCII characters "x=
y",
> > + * randomly selected with a uniform distribution from the following
> > + * character set: upper case letters, lower case letters and numbers."
> > + *
> > + * "The WPA2-Personal pass-phrase shall contain at least eight ASCII
> > + * characters randomly selected with a uniform distribution from the
> > + * following character set: upper case letters, lower case letters and
> > + * numbers."
> > + */
> > +char p2p_random_char(void)
> > +{
> > +#define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwx=
yz" \
> > +             "0123456789"
>
> might as well make this static char[]
>
> > +     static const int set_size =3D strlen(CHARSET);
> > +     static const uint32_t limit =3D -(0x100000000LL % set_size);
>
> I find this written like:
>
> limit =3D UINT_MAX - UINTMAX % set_size
>
> a bit more clear.

Ok, maybe UINT32_MAX to make it clear it's based on 32-bit input.

>
> > +     uint32_t index;
> > +
> > +     while ((index =3D l_getrandom_uint32()) >=3D limit);
>
> So I actually wonder if this should be an ell utility.  I'm not too sure =
I like
> the idea of hitting getrandom in a loop.  The chances are pretty small but
> still...  Perhaps using rand_r  with a random seed would be better.

Do you mean adding something like l_getrandom_range()?

However if we just use a single random seed of say 32 bits, we're
guaranteed a non-uniform distribution, unless 1 << 32 is divisible by
the size of the set (not the case).  I'm no expert but as far as I
know (and googled) there's no way to get uniform distribution with a
predefined number of random bits.

The difficulty here is really only the "uniform distribution" part
which I don't think it super important, as long as it's *nearly*
uniform.  I'd have normally sacrificed it to avoid the loop and
thinking of it, the way we ended up doing it in
l_key_generate_dh_private is completely non-uniform.  However we've
also later added l_ecc_scalar_new_random and l_ecdh_generate_key_pair
which do loop, with a much higher probability and discard many more
random bits in each iteration, so I didn't think you'd care.

>
> But if you want to direct code, then in theory you require only 5 bits of
> randomness here since the set is 62 long.  You could make due with just g=
rabbing
> a single byte of randomness and you'd have 3 attempts at being in the ran=
ge (low
> 5 bits, then 6..1, 7..2)

So the idea is to discard just the right-most (or left-most) bit in
each iteration and shift the other 4, and if we run out of bits we
draw another 8 and continue shifting, right?  This sounds reasonable.

On a second thought though... if our first 5-bit number was >=3D 62, we
went into a second iteration and reused bits 5...1, we start favouring
some numbers and the uniform distribution goes out the window.  In
fact, in this case the first number must have been 62 or 63... we
shift right, we get 31 and add a new topmost bit, we can only end up
drawing 31 from there on.

We probably have to choose between looping and generating independent
random bits each time, or doing (random % 62), which is better than
the above idea and than what we do in l_key_generate_dh_private.

Best regards
--===============4675727453193014726==--

