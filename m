Content-Type: multipart/mixed; boundary="===============9110372576709374263=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Wed, 09 Sep 2020 14:06:09 -0500
Message-ID: <b5f54c79-9e75-4c4b-c791-b1601c822fde@gmail.com>
In-Reply-To: <20200908234933.301439-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9110372576709374263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> Add a utility to select random characters from the set defined in P2P
> v1.7 Section 3.2.1.
> ---
>   src/p2putil.c | 26 ++++++++++++++++++++++++++
>   src/p2putil.h |  2 ++
>   2 files changed, 28 insertions(+)
> =

> diff --git a/src/p2putil.c b/src/p2putil.c
> index d0f3a444..99ab4ca0 100644
> --- a/src/p2putil.c
> +++ b/src/p2putil.c
> @@ -2611,3 +2611,29 @@ uint8_t *p2p_build_go_disc_req(size_t *out_len)
>   	return p2p_build_action_frame(false, P2P_ACTION_GO_DISCOVERABILITY_REQ,
>   					0, NULL, NULL, NULL, 0, out_len);
>   }
> +
> +/*
> + * Select a random char from the set defined in section 3.2.1:
> + *
> + * "Following "DIRECT-" the SSID shall contain two ASCII characters "xy",
> + * randomly selected with a uniform distribution from the following
> + * character set: upper case letters, lower case letters and numbers."
> + *
> + * "The WPA2-Personal pass-phrase shall contain at least eight ASCII
> + * characters randomly selected with a uniform distribution from the
> + * following character set: upper case letters, lower case letters and
> + * numbers."
> + */
> +char p2p_random_char(void)
> +{
> +#define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz=
" \
> +		"0123456789"

might as well make this static char[]

> +	static const int set_size =3D strlen(CHARSET);
> +	static const uint32_t limit =3D -(0x100000000LL % set_size);

I find this written like:

limit =3D UINT_MAX - UINTMAX % set_size

a bit more clear.

> +	uint32_t index;
> +
> +	while ((index =3D l_getrandom_uint32()) >=3D limit);

So I actually wonder if this should be an ell utility.  I'm not too sure I =
like =

the idea of hitting getrandom in a loop.  The chances are pretty small but =

still...  Perhaps using rand_r  with a random seed would be better.

But if you want to direct code, then in theory you require only 5 bits of =

randomness here since the set is 62 long.  You could make due with just gra=
bbing =

a single byte of randomness and you'd have 3 attempts at being in the range=
 (low =

5 bits, then 6..1, 7..2)

Maybe I'm overthinking this, what do you think?

> +
> +	return CHARSET[index % set_size];

I'm sure this syntax works, but man I find this weird ;)

> +#undef CHARSET
> +}

Regards,
-Denis
--===============9110372576709374263==--

