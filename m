Content-Type: multipart/mixed; boundary="===============4600767546165946454=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/9] handshake: Add HANDSHAKE_EVENT_IP_REQUEST
Date: Fri, 13 Aug 2021 20:46:37 -0500
Message-ID: <4bca9b33-128d-1aee-ed25-9c73eb847f80@gmail.com>
In-Reply-To: <20210807021048.321664-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4600767546165946454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/6/21 9:10 PM, Andrew Zaborowski wrote:
> Add a handshake event for use by the AP side for mechanisms that
> allocate client IPs during the handshake: P2P address allocation and
> FILS address assignment.  This is emitted only when EAPOL or the
> auth_proto is actually about to send the network configuration data to
> the client so that ap.c can skip allocating a DHCP leases altogether if
> the client doesn't send the required KDE or IE.
> ---
>   src/eapol.c     | 8 ++++++++
>   src/handshake.h | 1 +
>   src/station.c   | 1 +
>   3 files changed, 10 insertions(+)
> =

> diff --git a/src/eapol.c b/src/eapol.c
> index f78bef2f..e2892c0e 100644
> --- a/src/eapol.c
> +++ b/src/eapol.c
> @@ -1350,6 +1350,14 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm =
*sm)
>   		key_data_len +=3D gtk_kde[1] + 2;
>   	}
>   =

> +	if (sm->handshake->support_ip_allocation &&
> +			!sm->handshake->client_ip_addr) {
> +		handshake_event(sm->handshake, HANDSHAKE_EVENT_IP_REQUEST);
> +
> +		if (!sm->handshake->client_ip_addr)

Isn't this condition already checked above?

> +			sm->handshake->support_ip_allocation =3D false;

What happens on retransmissions of PTK 3/4?

> +	}
> +
>   	if (sm->handshake->support_ip_allocation) {
>   		/* Wi-Fi P2P Technical Specification v1.7 Table 59 */
>   		key_data_buf[key_data_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
> diff --git a/src/handshake.h b/src/handshake.h
> index a4c54b5a..1bc1b2fa 100644
> --- a/src/handshake.h
> +++ b/src/handshake.h
> @@ -57,6 +57,7 @@ enum handshake_event {
>   	HANDSHAKE_EVENT_REKEY_FAILED,
>   	HANDSHAKE_EVENT_EAP_NOTIFY,
>   	HANDSHAKE_EVENT_TRANSITION_DISABLE,
> +	HANDSHAKE_EVENT_IP_REQUEST,

Do you want to distinguish between P2P IP request and FILS IP Request?  Mig=
ht =

make things a bit more explicit ?

>   };
>   =


Regards,
-Denis
--===============4600767546165946454==--

