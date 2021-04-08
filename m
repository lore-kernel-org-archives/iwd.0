Content-Type: multipart/mixed; boundary="===============4275066013993131551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] station: handle EAP_COMPLETE event
Date: Thu, 08 Apr 2021 15:12:21 -0500
Message-ID: <b58785af-4fe4-a622-ab15-150434712f51@gmail.com>
In-Reply-To: <20210408154646.1182833-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4275066013993131551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/8/21 10:46 AM, James Prestwood wrote:
> Notify netdev via netdev_handshake_set_pmk that EAP has finished.
> ---
>   src/station.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =

> diff --git a/src/station.c b/src/station.c
> index 064872c6..8dda113d 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -740,6 +740,10 @@ static void station_handshake_event(struct handshake=
_state *hs,
>   		l_warn("Unable to securely rekey on this hw/kernel...");
>   		station_reconnect(station);
>   		break;
> +	case HANDSHAKE_EVENT_EAP_COMPLETE:
> +		l_debug("EAP complete");
> +		netdev_handshake_set_pmk(hs);
> +		break;

Why not handle PMK setting just like ptk/gtk/igtk/rekey offload bits?  So m=
aybe =

add __eapol_set_install_pmk_func() and inside the netdev implementation che=
ck =

whether the current connection type is OFFLOAD_8021X.  That would cut out =

station as a middle-man completely.

>   	case HANDSHAKE_EVENT_COMPLETE:
>   	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
>   	case HANDSHAKE_EVENT_EAP_NOTIFY:
> =


Regards,
-Denis
--===============4275066013993131551==--

