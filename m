Content-Type: multipart/mixed; boundary="===============0303140927141271876=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/16] eap: Simplify sending EAP method responses
Date: Thu, 13 Aug 2020 10:38:07 -0500
Message-ID: <ca0eb487-eafd-b462-ad76-8cb3b65de1b0@gmail.com>
In-Reply-To: <20200813005026.294950-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0303140927141271876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/12/20 7:50 PM, Andrew Zaborowski wrote:
> Replace the usage of eap_send_response() in the method implementations
> with a new eap_method_respond that skips the redundant "type" parameter.
> The new eap_send_packet is used inside eap_method_respond and will be
> reused for sending request packets in authenticator side EAP methods.
> ---
>   src/eap-aka.c        |  8 +++----
>   src/eap-gtc.c        |  2 +-
>   src/eap-md5.c        |  3 +--
>   src/eap-mschapv2.c   |  4 ++--
>   src/eap-private.h    |  5 +---
>   src/eap-pwd.c        |  9 ++++----
>   src/eap-sim.c        |  6 ++---
>   src/eap-tls-common.c |  7 +++---
>   src/eap-wsc.c        | 14 +++++------
>   src/eap.c            | 55 ++++++++++++++++++++++++++------------------
>   src/simutil.c        |  2 +-
>   11 files changed, 59 insertions(+), 56 deletions(-)
> =


<snip>

> @@ -179,7 +169,28 @@ void eap_send_response(struct eap_state *eap, enum e=
ap_type type,
>   		l_put_be32(eap->method->vendor_type, buf + 8);
>   	}
>   =

> -	eap->tx_packet(buf, len, eap->user_data);
> +	eap_send_packet(eap, EAP_CODE_RESPONSE, eap->last_id, buf, len);
> +}
> +
> +/**
> + * eap_send_packet:

I fixed this to be eap_method_respond

> + * @eap: EAP state
> + * @buf: Buffer to send
> + * @len: Size of the buffer
> + *
> + * Sends out a response to a received request.  This method first fills
> + * the EAP header in the buffer based on the method's EAP type being
> + * sent.
> + *
> + * If the method uses an expanded type , then the Vendor-Id and
> + * Vendor-Type fields are filled in automatically.
> + *
> + * The buffer passed in MUST be at least 12 bytes long if method uses
> + * an expanded type and at least 5 bytes for other cases.
> + **/
> +void eap_method_respond(struct eap_state *eap, uint8_t *buf, size_t len)
> +{
> +	eap_send_response(eap, eap->method->request_type, buf, len);
>   }
>   =


Applied, thanks.

Regards,
-Denis
--===============0303140927141271876==--

