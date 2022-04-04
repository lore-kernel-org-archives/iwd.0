Content-Type: multipart/mixed; boundary="===============0237562286581954746=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] network: Hide hidden networks on connection error
Date: Mon, 04 Apr 2022 13:37:51 -0500
Message-ID: <ff9f5280-4204-e9b7-428a-cbbf55f9b1ae@gmail.com>
In-Reply-To: MRZP264MB1544AF0B829E1139AF42680393E59@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM

--===============0237562286581954746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

On 4/4/22 04:16, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> If a user connection fails on a freshly scanned psk hidden network,
> during passphrase request or after, it shall be removed from the network =
list.
> Otherwise, it would be possible to directly connect to that known
> network, which will appear as not hidden.
> =

> Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
> ---
>   src/dbus.c    |  6 ------
>   src/dbus.h    |  2 --
>   src/network.c | 10 ++++++++++
>   src/station.c | 30 ------------------------------
>   4 files changed, 10 insertions(+), 38 deletions(-)
> =

> diff --git a/src/dbus.c b/src/dbus.c
> index 32de1e1a60d8..433dfcf53e45 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -128,12 +128,6 @@ struct l_dbus_message *dbus_error_already_provisione=
d(
>                                          "Already provisioned");
>   }
> =

> -struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg)
> -{
> -       return l_dbus_message_new_error(msg, IWD_SERVICE ".NotHidden",
> -                                       "Not hidden");
> -}
> -
>   struct l_dbus_message *dbus_error_from_errno(int err,
>                                                  struct l_dbus_message *m=
sg)
>   {
> diff --git a/src/dbus.h b/src/dbus.h
> index bbc7660866a1..8fe37576a33a 100644
> --- a/src/dbus.h
> +++ b/src/dbus.h
> @@ -76,8 +76,6 @@ struct l_dbus_message *dbus_error_service_set_overlap(
>                                                  struct l_dbus_message *m=
sg);
>   struct l_dbus_message *dbus_error_already_provisioned(
>                                                  struct l_dbus_message *m=
sg);
> -struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg);
> -
>   struct l_dbus_message *dbus_error_from_errno(int err,
>                                                  struct l_dbus_message *m=
sg);

I think this part is still needed, see below.

> =

> diff --git a/src/network.c b/src/network.c
> index d7f472be97d2..7c596ac31606 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -85,6 +85,7 @@ struct network {
>          bool is_hs20:1;
>          bool anqp_pending:1;    /* Set if there is a pending ANQP reques=
t */
>          bool owe_hidden_pending:1;
> +       bool provisioning_hidden:1;
>          uint8_t transition_disable; /* Temporary cache until info is set=
 */
>          bool have_transition_disable:1;
>          int rank;
> @@ -188,6 +189,8 @@ void network_connected(struct network *network)
>                                  network_secret_check_cacheable, network);
> =

>          l_queue_clear(network->blacklist, NULL);
> +
> +       network->provisioning_hidden =3D false;
>   }
> =

>   void network_disconnected(struct network *network)
> @@ -980,6 +983,9 @@ void network_connect_failed(struct network *network, =
bool in_handshake)
> =

>          l_queue_destroy(network->secrets, eap_secret_info_free);
>          network->secrets =3D NULL;
> +
> +       if (network->provisioning_hidden)
> +               station_hide_network(network->station, network);
>   }
> =

>   static bool hotspot_info_matches(struct network *network,
> @@ -1242,6 +1248,9 @@ static void passphrase_callback(enum agent_result r=
esult,
>          return;
> =

>   err:
> +       if (network->provisioning_hidden)
> +               station_hide_network(station, network);
> +
>          network_settings_close(network);
>   }
> =

> @@ -1661,6 +1670,7 @@ struct l_dbus_message *network_connect_new_hidden_n=
etwork(
> =

>          switch (network_get_security(network)) {
>          case SECURITY_PSK:
> +               network->provisioning_hidden =3D true;
>                  return network_connect_psk(network, bss, message);
>          case SECURITY_NONE:

Is there a reason you only set provisioning_hidden for PSK networks and not=
 open?

>                  station_connect_network(station, network, bss, message);
> diff --git a/src/station.c b/src/station.c
> index f6f0adacd2ad..f3c21a4b48c3 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -3253,36 +3253,6 @@ static struct l_dbus_message *station_dbus_connect=
_hidden_network(
>          if (!network)
>                  network =3D station_network_find(station, ssid, SECURITY=
_NONE);
> =

> -       /*
> -        * This checks for a corner case where the hidden network was alr=
eady
> -        * found and is in our scan results, but the initial connection f=
ailed.
> -        * For example, the password was given incorrectly.  In this case=
 the
> -        * entry will also be found on the hidden bss list.
> -        */
> -       if (network) {
> -               const struct l_queue_entry *entry =3D
> -                       l_queue_get_entries(station->hidden_bss_list_sort=
ed);
> -               struct scan_bss *target =3D network_bss_select(network, t=
rue);
> -
> -               /* Treat OWE transition networks special */
> -               if (target->owe_trans)
> -                       goto not_hidden;
> -
> -               for (; entry; entry =3D entry->next) {
> -                       struct scan_bss *bss =3D entry->data;
> -
> -                       if (!scan_bss_addr_eq(target, bss))
> -                               continue;
> -
> -                       /* We can skip the scan and try to connect right =
away */
> -                       return network_connect_new_hidden_network(network,
> -                                                               message);
> -               }
> -
> -not_hidden:
> -               return dbus_error_not_hidden(message);
> -       }
> -

I'm pretty sure we still need part of this check to remain here (and the =

NotHidden error bits).  See commit
d372d59bea3e ("station: Allow ConnectHiddenNetwork to be retried")

In particular, we should check and see if a PSK or Open network with the sa=
me =

SSID exists in our scan results already.  This would imply it isn't hidden. =

Restoring the logic taken out by that commit would probably be fine.

You also probably need to add station_hide_network() for the two networks =

created in station_hidden_network_scan_results() if a service_set_overlap o=
ccurs.


>          params.ssid =3D (const uint8_t *)ssid;
>          params.ssid_len =3D strlen(ssid);
> =

> --
> 2.25.1
> =

> Hello Denis, I have followed my proposal (1. On a passphrase failure,
> or connect failure wipe it from the scan result cache), which I find clea=
ner.
> =

> Please find the initial formatted patch in attachment.
> =

> Best Regards,
> =

> Emmanuel
> =


Regards,
-Denis

> =

> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>=20

--===============0237562286581954746==--

