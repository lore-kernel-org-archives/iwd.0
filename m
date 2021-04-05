Content-Type: multipart/mixed; boundary="===============2774130486260473010=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: network_connect crashes
Date: Mon, 05 Apr 2021 20:45:44 +0200
Message-ID: <20210405184544.hckhqfpk7mwz66h2@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2774130486260473010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was hacking on ConnMan and was able to reliable trigger this crash
with the current head:

++++++++ backtrace ++++++++
#0  0x7f4e1504e530 in /lib64/libc.so.6
#1  0x432b54 in network_get_security() at src/network.c:253
#2  0x416e92 in station_handshake_setup() at src/station.c:937
#3  0x41a505 in __station_connect_network() at src/station.c:2551
#4  0x41a683 in station_disconnect_onconnect_cb() at src/station.c:2581
#5  0x40b4ae in netdev_disconnect() at src/netdev.c:3142
#6  0x41a719 in station_disconnect_onconnect() at src/station.c:2603
#7  0x41a89d in station_connect_network() at src/station.c:2652
#8  0x433f1d in network_connect_psk() at src/network.c:886
#9  0x43483a in network_connect() at src/network.c:1183
#10 0x4add11 in _dbus_object_tree_dispatch() at ell/dbus-service.c:1802
#11 0x49ff54 in message_read_handler() at ell/dbus.c:285
#12 0x496d2f in io_callback() at ell/io.c:120
#13 0x495894 in l_main_iterate() at ell/main.c:478
#14 0x49599b in l_main_run() at ell/main.c:521
#15 0x495cb3 in l_main_run_with_signal() at ell/main.c:647
#16 0x404add in main() at src/main.c:490
#17 0x7f4e15038b25 in /lib64/libc.so.6


The sequence which seems to be to trigger it

  - set autoconnect to a known network
  - connnect to this network immediately

I was not sure if setting the autoconnect will trigger the connect or
not. Anyway, crashing seems a a bit harsh to let me know that me I am
doing something wrong ;)

The same crash happened when I blocked the STA from the AP. I've
collected a pcap as well. Not sure if you need it.

  https://www.monom.org/data/blocked.pcap

Thanks,
Daniel

ps: note the above call trace, the pcap and the call trace bellow
are collected from separate crashes.


(gdb) bt full
#0  0x000000000043306e in network_get_security (network=3D0x0) at src/netwo=
rk.c:253
No locals.
#1  0x00000000004172eb in station_handshake_setup (station=3D0x54bf40, netw=
ork=3D0x0, bss=3D0x0) at src/station.c:938
        security =3D 5553984
        settings =3D 0x4e8070 <__func__.14>
        wiphy =3D 0x417de5 <station_enter_state+681>
        hs =3D 0x7fffffffe710
        ssid =3D 0x54d6d0 ""
        eapol_proto_version =3D 0
        value =3D 0x4e71eb "State"
        full_random =3D false
        override =3D false
        new_addr =3D "\177\000\000QwA"
        __func__ =3D "station_handshake_setup"
#2  0x000000000041a9b7 in __station_connect_network (station=3D0x54bf40, ne=
twork=3D0x0, bss=3D0x0) at src/station.c:2553
        extra_ies =3D 0x7fffffffe810
        iov_elems =3D 0
        hs =3D 0x0
        r =3D 0
        __func__ =3D "__station_connect_network"
#3  0x000000000041ab35 in station_disconnect_onconnect_cb (netdev=3D0x54b4a=
0, success=3Dtrue, user_data=3D0x54bf40) at src/station.c:2583
        station =3D 0x54bf40
        err =3D 0
#4  0x000000000040b81e in netdev_disconnect (netdev=3D0x54b4a0, cb=3D0x41aa=
e8 <station_disconnect_onconnect_cb>, user_data=3D0x54bf40)
    at src/netdev.c:3242
        disconnect =3D 0x7fffffffe7d8
        send_disconnect =3D false
#5  0x000000000041abcb in station_disconnect_onconnect (station=3D0x54bf40,=
 network=3D0x558720, bss=3D0x5593e0, message=3D0x557bc0)
    at src/station.c:2605
No locals.
#6  0x000000000041ad60 in station_connect_network (station=3D0x54bf40, netw=
ork=3D0x558720, bss=3D0x5593e0, message=3D0x557bc0)
    at src/station.c:2653
        dbus =3D 0x538d00
        err =3D 2
#7  0x0000000000434437 in network_connect_psk (network=3D0x558720, bss=3D0x=
5593e0, message=3D0x557bc0) at src/network.c:884
        station =3D 0x54bf40
        need_passphrase =3D false
        __func__ =3D "network_connect_psk"
#8  0x0000000000434d54 in network_connect (dbus=3D0x538d00, message=3D0x557=
bc0, user_data=3D0x558720) at src/network.c:1183
        network =3D 0x558720
        station =3D 0x54bf40
        bss =3D 0x5593e0
        __func__ =3D "network_connect"
#9  0x00000000004ae3f7 in _dbus_object_tree_dispatch (tree=3D0x53bee0, dbus=
=3D0x538d00, message=3D0x557bc0) at ell/dbus-service.c:1802
        path =3D 0x558c38 "/net/connman/iwd/2/39/41636865726f6e_psk"
        interface =3D 0x558c88 "net.connman.iwd.Network"
        member =3D 0x558ca8 "Connect"
        msg_sig =3D 0x4fadd9 ""
        sig =3D 0x5464a5 ""
        node =3D 0x54cd10
        instance =3D 0x551b70
        method =3D 0x546490
        reply =3D 0x0
#10 0x00000000004a063a in message_read_handler (io=3D0x539df0, user_data=3D=
0x538d00) at ell/dbus.c:285
        dbus =3D 0x538d00
        message =3D 0x557bc0
        header =3D 0x558c20
        body =3D 0x0
        header_size =3D 160
        body_size =3D 0
        msgtype =3D DBUS_MESSAGE_TYPE_METHOD_CALL
#11 0x0000000000497415 in io_callback (fd=3D6, events=3D1, user_data=3D0x53=
9df0) at ell/io.c:120
        io =3D 0x539df0
#12 0x0000000000495f7a in l_main_iterate (timeout=3D-1) at ell/main.c:478
        events =3D {{events =3D 1, data =3D {ptr =3D 0x539e70, fd =3D 54800=
48, u32 =3D 5480048, u64 =3D 5480048}}, {events =3D 4, data =3D {ptr =3D 0x=
539e70, =

              fd =3D 5480048, u32 =3D 5480048, u64 =3D 5480048}}, {events =
=3D 4, data =3D {ptr =3D 0x539e70, fd =3D 5480048, u32 =3D 5480048, =

              u64 =3D 5480048}}, {events =3D 5, data =3D {ptr =3D 0x539e70,=
 fd =3D 5480048, u32 =3D 5480048, u64 =3D 5480048}}, {events =3D 1, data =
=3D {
              ptr =3D 0x54ff50, fd =3D 5570384, u32 =3D 5570384, u64 =3D 55=
70384}}, {events =3D 0, data =3D {ptr =3D 0x10, fd =3D 16, u32 =3D 16, =

              u64 =3D 16}}, {events =3D 4294967224, data =3D {ptr =3D 0xfff=
fffff, fd =3D -1, u32 =3D 4294967295, u64 =3D 4294967295}}, {events =3D 0, =

            data =3D {ptr =3D 0x0, fd =3D 0, u32 =3D 0, u64 =3D 0}}, {event=
s =3D 0, data =3D {ptr =3D 0xf7e6334400000000, fd =3D 0, u32 =3D 0, =

              u64 =3D 17863021339162443776}}, {events =3D 32767, data =3D {=
ptr =3D 0x53e6b0, fd =3D 5498544, u32 =3D 5498544, u64 =3D 5498544}}}
        data =3D 0x539e70
        n =3D 0
        nfds =3D 1
#13 0x0000000000496081 in l_main_run () at ell/main.c:525
        timeout =3D -1
#14 0x0000000000496399 in l_main_run_with_signal (callback=3D0x403a2e <sign=
al_handler>, user_data=3D0x0) at ell/main.c:647
        data =3D 0x53e4e0
        sigint =3D 0x53e500
        sigterm =3D 0x53e680
        result =3D 0
#15 0x0000000000404add in main (argc=3D2, argv=3D0x7fffffffec58) at src/mai=
n.c:490
        enable_dbus_debug =3D false
        exit_status =3D 1
        dbus =3D 0x538d00
        config_dir =3D 0x4e3a51 "/etc/iwd"
        config_dirs =3D 0x5347a0
        i =3D 1
        __func__ =3D "main"
--===============2774130486260473010==--

