Content-Type: multipart/mixed; boundary="===============2575465851557164773=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] util: add bounds check to util_get_{domain,username}
Date: Thu, 17 Oct 2019 11:04:52 -0500
Message-ID: <0b1e4e35-e6a3-57cb-c96a-c40991b41f8f@gmail.com>
In-Reply-To: <20191017154921.15516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2575465851557164773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/17/19 10:49 AM, James Prestwood wrote:
> Two cases were using strcpy, and the other two were using strncpy.
> Instead all cases can use l_strlcpy which guarentees NULL termination.
> ---
>   src/util.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/src/util.c b/src/util.c
> index f787ce6b..1291d9c9 100644
> --- a/src/util.c
> +++ b/src/util.c
> @@ -173,10 +173,10 @@ const char *util_get_domain(const char *identity)
>   	for (c =3D identity; *c; c++) {
>   		switch (*c) {
>   		case '\\':
> -			strncpy(domain, identity, c - identity);
> +			l_strlcpy(domain, identity, c - identity);

Using l_strlcpy here is wrong.  You want to copy a substrict of c - =

identity bytes into domain where identity does not have any embedded =

nulls.  But passing c - identity into l_strlcpy would not work the way =

you think.   Also, the existing code has an inherent assumption that c - =

identity is always <=3D 253 bytes.  So really, nothing here is dangerous...

If anything we should be using memcpy to make this more clear.  If you =

want to be pedantic, then you need to check that c - identity is < =

sizeof(domain).

>   			return domain;
>   		case '@':
> -			strcpy(domain, c + 1);
> +			l_strlcpy(domain, c + 1, sizeof(domain));

Here we do have a terminating NULL, so using l_strlcpy is fine.

>   			return domain;
>   		default:
>   			continue;
> @@ -197,10 +197,10 @@ const char *util_get_username(const char *identity)
>   	for (c =3D identity; *c; c++) {
>   		switch (*c) {
>   		case '\\':
> -			strcpy(username, c + 1);
> +			l_strlcpy(username, c + 1, sizeof(username));

as above

>   			return username;
>   		case '@':
> -			strncpy(username, identity, c - identity);
> +			l_strlcpy(username, identity, c - identity);

The very first comment applies here as well

>   			return username;
>   		default:
>   			continue;
> =


Regards,
-Denis
--===============2575465851557164773==--

