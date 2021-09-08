Content-Type: multipart/mixed; boundary="===============1210220502286384836=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 5/7] ft: change fatal return code to -EPROTO
Date: Wed, 08 Sep 2021 14:33:33 -0500
Message-ID: <6744be99-81a6-861b-e87a-51fa836b4082@gmail.com>
In-Reply-To: <20210908181904.84594-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1210220502286384836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 1:19 PM, James Prestwood wrote:
> This keeps FT consistent with what netdev expects for a fatal
> auth-proto return.
> ---
>   src/ft.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/ft.c b/src/ft.c
> index 13733019..c167f4bc 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -520,7 +520,7 @@ static int ft_process_ies(struct handshake_state *hs,=
 const uint8_t *ies,
>   	return 0;
>   =

>   ft_error:
> -	return -EBADMSG;
> +	return -EPROTO;

The error code from ft_process_ies isn't actually returned to the upper lay=
ers. =

  In fact, ft returns a status_code instead.  So, maybe we should hold off =
on =

this for now.

>   }
>   =

>   int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame=
_len,
> =


Regards,
-Denis
--===============1210220502286384836==--

