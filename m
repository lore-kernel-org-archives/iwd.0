Content-Type: multipart/mixed; boundary="===============1481637673826853637=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/4] sae: handle force_default_sae_group in scan_bss
Date: Wed, 25 Aug 2021 09:01:57 -0500
Message-ID: <c724e955-0534-1a5a-f179-50e256ba7b56@gmail.com>
In-Reply-To: <20210823234149.610336-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1481637673826853637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/23/21 6:41 PM, James Prestwood wrote:
> Now a scan_bss object is passed to sae_sm_new in order to detect if
> the BSS's vendor OUI matches ones in which SAE group negotiation is
> broken. When an AP like this is found SAE will use group 19
> unconditionally, and fail if group 19 does not work. Other groups
> could be tried upon failure but per the spec group 19 must be supported
> so there isn't much use in trying other, optional groups.
> =

> Note: the check on 'bss' was added in order to make unit testing
> easier to integrate as including scan.c in unit tests opens up a
> can of worms.
> ---
>   src/netdev.c |  2 +-
>   src/sae.c    | 27 +++++++++++++++++++++++++++
>   src/sae.h    |  2 ++
>   3 files changed, 30 insertions(+), 1 deletion(-)
> =

> v2:
>   * Only force group 19 when sae_type is LOOPING
>   * Increment group_retry when forcing group otherwise
>     IWD would continue to try group 19 over and over
> =


<snip>

> diff --git a/src/sae.h b/src/sae.h
> index 668d084f..d8f9f2d7 100644
> --- a/src/sae.h
> +++ b/src/sae.h
> @@ -23,6 +23,7 @@
>   struct auth_proto;
>   struct sae_sm;
>   struct handshake_state;
> +struct scan_bss;
>   =

>   typedef void (*sae_tx_authenticate_func_t)(const uint8_t *data, size_t =
len,
>   						void *user_data);
> @@ -31,6 +32,7 @@ typedef void (*sae_tx_associate_func_t)(void *user_data=
);
>   bool sae_sm_is_h2e(struct auth_proto *ap);
>   =

>   struct auth_proto *sae_sm_new(struct handshake_state *hs,
> +				struct scan_bss *bss,
>   				sae_tx_authenticate_func_t tx_auth,
>   				sae_tx_associate_func_t tx_assoc,
>   				void *user_data);
> =


Looking at this again, I guess we might as well just add:

void sae_sm_set_force_group_19(struct auth_proto *ap);

Which would remove the need for scan_bss dependency and the unit test can r=
emain =

untouched.

Regards,
-Denis
--===============1481637673826853637==--

