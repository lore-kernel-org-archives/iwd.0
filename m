Content-Type: multipart/mixed; boundary="===============5954646334646903593=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/4] iwd: define a maximum passphrase length
Date: Fri, 06 Mar 2020 09:56:22 -0800
Message-ID: <d0d5e711d0af0dcef2c60c395b21f049d67defee.camel@gmail.com>
In-Reply-To: <20200306174843.26578-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5954646334646903593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 09:48 -0800, James Prestwood wrote:
> ---
>  src/iwd.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> =

> diff --git a/src/iwd.h b/src/iwd.h
> index 22223526..5371d8e5 100644
> --- a/src/iwd.h
> +++ b/src/iwd.h
> @@ -22,6 +22,15 @@
>  =

>  #define uninitialized_var(x) x =3D x
>  =

> +/*
> + * Set a maximum to prevent sending too much data to the kernel when
> hashing
> + * the passphrase (or any other crypto operations involving the
> passphrase).
> + * This will also prevent potential stack overflows if the
> passphrase is put
> + * into EAP packets on the stack (EAP-GTC). This value is not tied
> to IEEE or
> + * any RFC's, just chosen to be long enough to not restrict a normal
> user.
> + */
> +#define IWD_MAX_PASSPHRASE_LEN	2048

Tim pointed out this should really be called IWD_MAX_PASSWORD_LEN since
'PASSPHRASE' implies a WPA passphrase which does have a defined maximum
length of 63 characters. This value is only meant for EAP method
passwords that have no defined maximum.

Will change in v2 if everything else looks fine.

> +
>  struct l_genl;
>  struct l_genl_family;
> =20

--===============5954646334646903593==--

