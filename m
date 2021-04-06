Content-Type: multipart/mixed; boundary="===============2066707629444396444=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] station: fix crash with disconnect_onconnect
Date: Tue, 06 Apr 2021 09:02:25 +0200
Message-ID: <20210406070225.psvvnmidm3g2ordk@beryllium.lan>
In-Reply-To: <20210405200746.1034297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2066707629444396444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 05, 2021 at 01:07:46PM -0700, James Prestwood wrote:
> If the station has not associated yet netdev will not send a
> disconnect and end up calling the callback immediately. Station
> assumes the callback will happen asynchronously and does not
> set the required network/bss for __station_connect_network
> which results in a crash. The crash can be caused reliably with
> a simple script:
> =

> iwctl station wlan0 disconnect
> iwctl station wlan0 connect <network1> &
> sleep 0.02
> iwctl station wlan0 connect <network2>
> =

> ++++++++ backtrace ++++++++
> 0  0x7f4e1504e530 in /lib64/libc.so.6
> 1  0x432b54 in network_get_security() at src/network.c:253
> 2  0x416e92 in station_handshake_setup() at src/station.c:937
> 3  0x41a505 in __station_connect_network() at src/station.c:2551
> 4  0x41a683 in station_disconnect_onconnect_cb() at src/station.c:2581
> 5  0x40b4ae in netdev_disconnect() at src/netdev.c:3142
> 6  0x41a719 in station_disconnect_onconnect() at src/station.c:2603
> 7  0x41a89d in station_connect_network() at src/station.c:2652
> 8  0x433f1d in network_connect_psk() at src/network.c:886
> 9  0x43483a in network_connect() at src/network.c:1183
> 10 0x4add11 in _dbus_object_tree_dispatch() at ell/dbus-service.c:1802
> 11 0x49ff54 in message_read_handler() at ell/dbus.c:285
> 12 0x496d2f in io_callback() at ell/io.c:120
> 13 0x495894 in l_main_iterate() at ell/main.c:478
> 14 0x49599b in l_main_run() at ell/main.c:521
> 15 0x495cb3 in l_main_run_with_signal() at ell/main.c:647
> 16 0x404add in main() at src/main.c:490
> 17 0x7f4e15038b25 in /lib64/libc.so.6
> =

> To fix this move the disconnect call *after* the network/bss is
> set.

This patch fixes the reported problem.

Thanks for the quick fix!
--===============2066707629444396444==--

