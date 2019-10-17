Content-Type: multipart/mixed; boundary="===============2682617053166327683=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] util: add bounds check to util_get_{domain,username}
Date: Wed, 16 Oct 2019 21:15:45 -0500
Message-ID: <e9e278e7-1ab7-2e4b-df3a-aeb78b07b038@gmail.com>
In-Reply-To: <20191016234304.14716-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2682617053166327683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/16/19 6:43 PM, James Prestwood wrote:
> ---
>   src/util.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/util.c b/src/util.c
> index f787ce6b..f1860a33 100644
> --- a/src/util.c
> +++ b/src/util.c
> @@ -176,7 +176,7 @@ const char *util_get_domain(const char *identity)
>   			strncpy(domain, identity, c - identity);
>   			return domain;
>   		case '@':
> -			strcpy(domain, c + 1);
> +			strncpy(domain, c + 1, sizeof(domain));

Ah but the input is guaranteed to be less than 256 bytes anyway.  But in =

general, using strncpy isn't safe like that either as the target won't =

be null terminated in some cases.  Use l_strlcpy instead.

>   			return domain;
>   		default:
>   			continue;

Regards,
-Denis
--===============2682617053166327683==--

