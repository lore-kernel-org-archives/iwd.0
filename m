Content-Type: multipart/mixed; boundary="===============0189717090956167128=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap: avoid nested functions
Date: Mon, 17 May 2021 10:42:47 -0500
Message-ID: <8bc27907-7f25-65d0-1ffd-75f6c4029a56@gmail.com>
In-Reply-To: <20210514163414.304860-1-Marc-Antoine@Perennou.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0189717090956167128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marc-Antoine,

On 5/14/21 11:34 AM, Marc-Antoine Perennou wrote:
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>

No Signed-off-by please

> ---
>   src/eap.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> =

> diff --git a/src/eap.c b/src/eap.c
> index 0645be47..53e35b5e 100644
> --- a/src/eap.c
> +++ b/src/eap.c
> @@ -416,6 +416,8 @@ static const char *eap_type_to_str(enum eap_type type=
, uint32_t vendor_id,
>   #define IS_EXPANDED_RESPONSE(id, t) \
>   	(type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) && vendor_type=
 =3D=3D (t))
>   =

> +#define response_is(wanted) ((type =3D=3D wanted) || IS_EXPANDED_RESPONS=
E(0, =


Would it be safer to add '()' around wanted in at least the type =3D=3D com=
parison?

wanted))
> +
>   static void eap_handle_response(struct eap_state *eap, const uint8_t *p=
kt,
>   				size_t len)
>   {
> @@ -428,14 +430,6 @@ static void eap_handle_response(struct eap_state *ea=
p, const uint8_t *pkt,
>   				eap->method->vendor_id[2];
>   	uint32_t our_vendor_type =3D eap->method->vendor_type;
>   =

> -	bool response_is(enum eap_type wanted)
> -	{
> -		if (type =3D=3D wanted)
> -			return true;
> -
> -		return IS_EXPANDED_RESPONSE(0, wanted);
> -	}
> -
>   	if (len < 1)
>   		/* Invalid packets to be ignored */
>   		return;
> =


Regards,
-Denis
--===============0189717090956167128==--

