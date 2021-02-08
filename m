Content-Type: multipart/mixed; boundary="===============7239638381073999133=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] adhoc: fix missing call to va_end
Date: Mon, 08 Feb 2021 14:25:42 -0600
Message-ID: <54f82db6-b574-0856-af7c-a209c7de7be9@gmail.com>
In-Reply-To: <20210208201958.607049-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7239638381073999133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 2:19 PM, James Prestwood wrote:
> ---
>   src/adhoc.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/src/adhoc.c b/src/adhoc.c
> index 7f9ce765..1263d00a 100644
> --- a/src/adhoc.c
> +++ b/src/adhoc.c
> @@ -228,6 +228,8 @@ static void adhoc_handshake_event(struct handshake_st=
ate *hs,
>   	default:
>   		break;
>   	}
> +
> +	va_end(args);

I don't think this  is correct since there are multiple returns from this =

function.  Perhaps the va_start should be moved to the error cases where it=
 is used.

>   }
>   =

>   static struct eapol_sm *adhoc_new_sm(struct sta_state *sta, bool authen=
ticator,
> =


Regards,
-Denis
--===============7239638381073999133==--

