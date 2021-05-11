Content-Type: multipart/mixed; boundary="===============3028848508469691306=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/2] station: Fix autoconnect loops
Date: Tue, 11 May 2021 09:32:09 -0700
Message-ID: <bdbcc33cb3e86a050778ae0460d5aefe0f301c43.camel@gmail.com>
In-Reply-To: <20210510101204.175551-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3028848508469691306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2021-05-10 at 12:12 +0200, Andrew Zaborowski wrote:
> Make sure we process the result of a connect attempt both in a D-Bus
> triggered connection and during autoconnect.=C2=A0 Until now we'd only
> call
> station_connect_cb() on NETDEV_EVENT_DISCONNECT_BY_{AP,SME} if
> station->connect_pending was non-NULL, i.e. only in the D-Bus method.
> As a result we were never blacklisting BSSes and never calling
> network_connect_failed() (to set ask_passphrase) during autoconnect.

Is the purpose of this to avoid re-trying the same network over and
over? Relying on network_autoconnect() to fail due to ask_passphrase
being true?

Seems like it would be better to re-work autoconnect to actually pop
the list when autoconnect fails, and immediately move onto the next (no
scanning).

> =

> Use station->netdev_connected to keep track of whether the event
> actually happens in the handshake (as opposed to netconfig for
> example)
> to avoid calling network_connect_failed() with the "in_handshake"
> parameter set to true.=C2=A0 Arguably we might want to call
> netdev_connect_failed() or at least temporarily blacklist/downrank
> the bss if the connection breaks during netconfig but I kept the
> current logic in this commit.
> =

> We might also want to call station_reassociate_cb() if we're in a
> reassociation but this wouldn't currently make much difference (and
> we
> don't seem to have any flag to know that we're in a reassociation
> right
> now.)
> ---
> =C2=A0src/station.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> =

> diff --git a/src/station.c b/src/station.c
> index 479f81f5..e503f636 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -113,6 +113,7 @@ struct station {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool ap_directed_roaming =
: 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool scanning : 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool autoconnect : 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool netdev_connected : 1;
> =C2=A0};
> =C2=A0
> =C2=A0struct anqp_entry {
> @@ -1339,6 +1340,7 @@ static void
> station_reset_connection_state(struct station *station)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_queue_insert(station->n=
etworks_sorted, station-
> >connected_network,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0network_rank_compare, NULL);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0station->netdev_connected =3D =
false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0station->connected_bss =
=3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0station->connected_networ=
k =3D NULL;
> =C2=A0
> @@ -1370,7 +1372,9 @@ static void station_disconnect_event(struct
> station *station, void *event_data)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_debug("%u", netdev_get_=
ifindex(station->netdev));
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (station->connect_pending)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (station->connect_pending ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(station-=
>state =3D=3D STATION_STATE_CONNECTING
> &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !station=
->netdev_connected))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0station_connect_cb(station->netdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0NETDEV_RESULT_HANDSHAKE_FAILE
> D,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0event_data, station);
> @@ -2554,6 +2558,7 @@ static void station_connect_cb(struct netdev
> *netdev, enum netdev_result result,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_w=
arn("Could not request neighbor report");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0station->netdev_connected =3D =
true;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0network_connected(station=
->connected_network);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (station->netconfig)


--===============3028848508469691306==--

