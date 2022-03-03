Content-Type: multipart/mixed; boundary="===============2463537435699705427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] knownnetworks: update known frequencies maximum to 7115
Date: Thu, 03 Mar 2022 12:57:34 -0600
Message-ID: <20dc4e75-fa02-1d4b-fd92-68e92cd47f36@gmail.com>
In-Reply-To: 20220303172234.3447411-1-prestwoj@gmail.com

--===============2463537435699705427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/3/22 11:22, James Prestwood wrote:
> With the addition of 6GHz '6000' is no longer the maximum frequency
> that could be in .known_network.freq.
> ---
>   src/knownnetworks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index 87df8b4d..fc024333 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -856,7 +856,7 @@ static struct l_queue *known_frequencies_from_string(=
char *freq_set_str)
>   =

>   		t =3D strtoul(freq_set_str, &freq_set_str, 10);
>   =

> -		if (unlikely(errno =3D=3D ERANGE || !t || t > 6000))
> +		if (unlikely(errno =3D=3D ERANGE || !t || t > 7115))

Do you want to use band_freq_to_channel here instead?  That one checks the =
valid =

freqs...

>   			goto error;
>   =

>   		known_freq =3D l_new(struct known_frequency, 1);
> =


Regards,
-Denis
--===============2463537435699705427==--

