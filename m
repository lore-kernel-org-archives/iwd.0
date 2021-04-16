Content-Type: multipart/mixed; boundary="===============3333064721267773212=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] ft: expose ft_build_authenticate_ies
Date: Fri, 16 Apr 2021 11:32:40 -0500
Message-ID: <328383ee-1c4c-dd34-f200-42325378ed3a@gmail.com>
In-Reply-To: <20210415224508.1823614-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3333064721267773212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/15/21 5:45 PM, James Prestwood wrote:
> The building of the (FT)Authenticate frame will need

FT IEs for Action or Authenticate frame, right?

> to be shared between ft and netdev once FT-over-Air
> is refactored.
> =

> The building was refactored to work off the callers
> buffer rather than internal stack buffers. An argument
> 'new_snonce' was included as FT-over-DS will generate
> a new snonce for the initial action frame, hence the
> handshakes snonce cannot be used.
> ---
>   src/ft.c | 62 +++++++++++++++++++++++++++++++-------------------------
>   src/ft.h |  4 ++++
>   2 files changed, 38 insertions(+), 28 deletions(-)
> =


<snip>

> diff --git a/src/ft.h b/src/ft.h
> index 6f6a7fd5..f24b3b5e 100644
> --- a/src/ft.h
> +++ b/src/ft.h
> @@ -25,6 +25,10 @@ typedef void (*ft_tx_authenticate_func_t)(struct iovec=
 *iov, size_t iov_len,
>   typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov=
_len,
>   					void *user_data);
>   =

> +bool ft_build_authenticate_ies(struct handshake_state *hs,

should this be declared const struct handshake_state ?

> +				const uint8_t *new_snonce, uint8_t *buf,
> +				size_t *len);
> +
>   struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
>   				ft_tx_authenticate_func_t tx_auth,
>   				ft_tx_associate_func_t tx_assoc,
> =


Regards,
-Denis
--===============3333064721267773212==--

