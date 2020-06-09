Content-Type: multipart/mixed; boundary="===============2339138939804505040=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Tue, 09 Jun 2020 15:10:50 -0500
Message-ID: <45a9172a-3bcf-eee5-dcfd-a53bd4bd2e7e@gmail.com>
In-Reply-To: <c5c3d21d-8145-9ddd-afc6-701aa5fa7634@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2339138939804505040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

> I traced the following events leading to a duplicate scan request being s=
ent. =

> The scenario assumes that the scan request queue is empty in the beginnin=
g.
> =

> =

> station_enter_state: disconnected -> autoconnect_quick
>  =C2=A0 -> station_quick_scan_trigger
>  =C2=A0=C2=A0=C2=A0 -> station_scan_trigger: notify cb =3D station_quick_=
scan_results
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_passive
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_common
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_request_s=
end_trigger
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> l_queue_push_t=
ail: scan request queue size =3D 1
> scan_notify: quick scan triggered
> network_connect: requested over dbus
>  =C2=A0 -> network_connect_psk
>  =C2=A0=C2=A0=C2=A0 -> station_connect_network
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> station_enter_state: autoconnect_quick=
 -> connecting
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> periodic_scan_stop
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_periodic_=
stop
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> sc=
an_cancel
> scan_notify: quick scan aborted
>  =C2=A0 -> scan_finished
>  =C2=A0=C2=A0=C2=A0 -> l_queue_remove: scan request queue size =3D 0
>  =C2=A0=C2=A0=C2=A0 -> station_quick_scan_results: quick scan's notify ca=
llback
>  =C2=A0=C2=A0=C2=A0 . -> station_enter_state: connecting -> autoconnect_f=
ull

Aha, so this is the real culprit.  I fixed this as well in commit =

532f6b154e03b5fa222502098b5688a1784cc4e3.

>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0 -> scan_periodic_start
>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_periodic_queue
>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_{active=
_full,passive}: idk which; doesn't matter
>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> =
scan_common
>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -> scan_request_send_trigger
>  =C2=A0=C2=A0=C2=A0 .=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -> l_queue_push_tail: scan request queue size =3D 1

Okay, so we start a periodic scan and in scan_finished call =

start_next_scan_request again.

>  =C2=A0=C2=A0=C2=A0 -> start_next_scan_request: head of queue has already=
 been sent
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> scan_request_send_trigger: send it aga=
in
> =

> =


And since we don't check that one is already going, we issue the trigger ag=
ain. =

Makes sense to me now.  Much appreciated.

Regards,
-Denis
--===============2339138939804505040==--

