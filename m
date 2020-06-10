Content-Type: multipart/mixed; boundary="===============1995471977695837175=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: Change func. signature
Date: Tue, 09 Jun 2020 22:01:20 -0500
Message-ID: <ea9d23b8-5894-6444-9d03-344a4a0b9e8a@gmail.com>
In-Reply-To: <20200610012356.19703-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1995471977695837175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 6/9/20 8:23 PM, Tim Kourt wrote:
> Change signature of network_connect_new_hidden_network to take
> reference to the caller's l_dbus_message struct. This allows to
> set the caller's l_dbus_message struct to NULL after replying in
> the case of a failure.
> =

> =3D=3D201=3D=3D    at 0x467C15: l_dbus_message_unref (dbus-message.c:412)
> =3D=3D201=3D=3D    by 0x412A51: station_hidden_network_scan_results (stat=
ion.c:2504)
> =3D=3D201=3D=3D    by 0x41EAEA: scan_finished (scan.c:1505)
> =3D=3D201=3D=3D    by 0x41EC10: get_scan_done (scan.c:1535)
> =3D=3D201=3D=3D    by 0x462592: destroy_request (genl.c:673)
> =3D=3D201=3D=3D    by 0x462987: process_unicast (genl.c:988)
> =3D=3D201=3D=3D    by 0x462987: received_data (genl.c:1087)
> =3D=3D201=3D=3D    by 0x45F5A2: io_callback (io.c:126)
> =3D=3D201=3D=3D    by 0x45E8FD: l_main_iterate (main.c:474)
> =3D=3D201=3D=3D    by 0x45E9BB: l_main_run (main.c:521)
> =3D=3D201=3D=3D    by 0x45EBCA: l_main_run_with_signal (main.c:643)
> =3D=3D201=3D=3D    by 0x403B15: main (main.c:512)
> ---
>   src/network.c | 12 ++++++------
>   src/network.h |  2 +-
>   src/station.c |  2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)
> =


Applied after rewording the commit header slightly.

Regards,
-Denis

--===============1995471977695837175==--

