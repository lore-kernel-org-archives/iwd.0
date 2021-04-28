Content-Type: multipart/mixed; boundary="===============9071234351494399604=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/2] station: transition to disconnecting on
 station_free
Date: Wed, 28 Apr 2021 14:32:49 -0500
Message-ID: <796e3c75-8f3e-601d-fdf3-c977117e58e1@gmail.com>
In-Reply-To: <20210428192701.149044-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9071234351494399604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/28/21 2:27 PM, James Prestwood wrote:
> This allows station to gracefully clean up things like the diagnostic
> interface which is directly tied to stations CONNECTED/DISCONNECTING
> states.
> ---
>   src/station.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> v4:
>   * Changed to DISCONNECTING due to new patch.
> =

> diff --git a/src/station.c b/src/station.c
> index 0cee3525..c81c9a45 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -3487,6 +3487,8 @@ static void station_free(struct station *station)
>   	if (station->connected_bss)
>   		netdev_disconnect(station->netdev, NULL, NULL);
>   =

> +	station_enter_state(station, STATION_STATE_DISCONNECTING);
> +

I keep going back and forth on this, but I think it would be safer if we in=
voked =

unregister_interface directly.

>   	if (station->netconfig) {
>   		netconfig_destroy(station->netconfig);
>   		station->netconfig =3D NULL;
> =


Regards,
-Denis
--===============9071234351494399604==--

