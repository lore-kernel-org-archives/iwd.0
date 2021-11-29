Content-Type: multipart/mixed; boundary="===============1152219007589312235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 3/6] scan: add scan_freq_set_serialize
Date: Mon, 29 Nov 2021 17:37:28 -0600
Message-ID: <f5b9b2d3-7582-dc09-36ca-d67dcf906309@gmail.com>
In-Reply-To: 20211129231300.108873-3-prestwoj@gmail.com

--===============1152219007589312235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/29/21 5:12 PM, James Prestwood wrote:
> This serializes a scan_freq_set into a uint32_t array.
> ---
>   src/scan.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   src/scan.h |  3 +++
>   2 files changed, 48 insertions(+)
> =

> diff --git a/src/scan.c b/src/scan.c
> index b602c8be..1c80dd65 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -2370,6 +2370,51 @@ void scan_freq_set_constrain(struct scan_freq_set =
*set,
>   	set->channels_2ghz &=3D constraint->channels_2ghz;
>   }
>   =

> +struct scan_freq_get_index_data {
> +	unsigned int target;
> +	unsigned int current;
> +	uint32_t found;
> +};

Whats this for?

> +
> +static void count_foreach(uint32_t freq, void *user_data)
> +{
> +	uint8_t *count =3D user_data;
> +
> +	l_put_u8(*count + 1, count);
> +}

Hmm, I wonder if you can either calculate this directly or book-keep the co=
unt =

in scan_freq_set itself.  In theory the 2g freqs (if not zero) are just =

__builtin_popcount().  For the uintset it is essentially the same.

> +
> +static void add_foreach(uint32_t freq, void *user_data)
> +{
> +	uint32_t **list =3D user_data;
> +
> +	**list =3D freq;
> +
> +	*list =3D *list + 1;
> +}
> +
> +uint32_t *scan_freq_set_serialize(const struct scan_freq_set *set,
> +					size_t *len_out)
> +{
> +	uint8_t count =3D 0;
> +	uint32_t *freqs;
> +
> +	scan_freq_set_foreach(set, count_foreach, &count);
> +
> +	if (!count)
> +		return NULL;
> +
> +	freqs =3D l_new(uint32_t, count);
> +
> +	scan_freq_set_foreach(set, add_foreach, &freqs);
> +
> +	/* Move pointer back to start of list */
> +	freqs -=3D count;
> +
> +	*len_out =3D count;
> +
> +	return freqs;
> +}
> +
>   bool scan_wdev_add(uint64_t wdev_id)
>   {
>   	struct scan_context *sc;
> diff --git a/src/scan.h b/src/scan.h
> index 66e38410..e6eea1c5 100644
> --- a/src/scan.h
> +++ b/src/scan.h
> @@ -191,5 +191,8 @@ void scan_freq_set_constrain(struct scan_freq_set *se=
t,
>   					const struct scan_freq_set *constraint);
>   bool scan_freq_set_isempty(const struct scan_freq_set *set);
>   =

> +uint32_t *scan_freq_set_serialize(const struct scan_freq_set *set,
> +					size_t *len_out);
> +

Can we call this scan_freq_set_to_fixed_array, similar to how l_dbus_messag=
e =

names this.

>   bool scan_wdev_add(uint64_t wdev_id);
>   bool scan_wdev_remove(uint64_t wdev_id);
> =


Regards,
-Denis
--===============1152219007589312235==--

