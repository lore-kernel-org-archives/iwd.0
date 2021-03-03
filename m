Content-Type: multipart/mixed; boundary="===============5874230975139286597=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] handshake: add offload member
Date: Wed, 03 Mar 2021 14:42:28 -0600
Message-ID: <96920ea6-732e-cca3-1009-bf4a0a37d909@gmail.com>
In-Reply-To: <20210303174730.6738-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5874230975139286597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/3/21 11:47 AM, James Prestwood wrote:
> This flag indicates the handshake is being offloaded to the
> kernel/driver.
> ---
>   src/handshake.h | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/src/handshake.h b/src/handshake.h
> index b738efd9..0468cbd1 100644
> --- a/src/handshake.h
> +++ b/src/handshake.h
> @@ -116,6 +116,7 @@ struct handshake_state {
>   	bool wait_for_gtk : 1;
>   	bool no_rekey : 1;
>   	bool support_fils : 1;
> +	bool offload_psk : 1;

Maybe offloaded_4way would be a more future-proof name?

>   	uint8_t ssid[32];
>   	size_t ssid_len;
>   	char *passphrase;
> =


Regards,
-Denis
--===============5874230975139286597==--

