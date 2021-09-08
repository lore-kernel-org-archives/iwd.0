Content-Type: multipart/mixed; boundary="===============4766461667943010413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/7] auth-proto: document acceptable return values for
 auth-protos
Date: Wed, 08 Sep 2021 14:29:41 -0500
Message-ID: <b36b1a10-c486-ddc0-6113-4fcf5bd2185b@gmail.com>
In-Reply-To: <20210908181904.84594-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4766461667943010413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 1:19 PM, James Prestwood wrote:
> Since all auth-protos are hidden behind an abstraction they need
> to be consisten with the return values as some should be handled
> specially.
> ---
>   src/auth-proto.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> =

> diff --git a/src/auth-proto.h b/src/auth-proto.h
> index d3c4686f..f39c361c 100644
> --- a/src/auth-proto.h
> +++ b/src/auth-proto.h
> @@ -25,6 +25,18 @@
>   struct auth_proto {
>   	bool (*start)(struct auth_proto *ap);
>   	void (*free)(struct auth_proto *ap);
> +	/*
> +	 * Callback to receive an Authenticate frame. auth-protos should
> +	 * return error codes consistent with one another as some are treated
> +	 * specially:
> +	 *
> +	 * 0 indicates success

Also implies a state transition has happened, right?

> +	 * -ENOMSG or -EBADMSG indicates the message should be ignored silently
> +	 * -EAGAIN indicates to try again (handled by auth-proto internally)

Implies a retry is happening and state hasn't changed?

> +	 * -EPROTO indicates a fatal error
> +	 * Any other < 0 return will be treated as a fatal error
> +	 * > 0 indicates a fatal error with status code.

Might want to mention that this is only applicable for non-station cases.

> +	 */
>   	int (*rx_authenticate)(struct auth_proto *driver,
>   					const uint8_t *frame, size_t len);
>   	int (*rx_associate)(struct auth_proto *driver,
> =


Regards,
-Denis
--===============4766461667943010413==--

