Content-Type: multipart/mixed; boundary="===============1967053823183316344=="
MIME-Version: 1.0
From: Jan Palus <jpalus at fastmail.com>
To: iwd at lists.01.org
Subject: segfault after upgrade to iwd 1.22
Date: Wed, 26 Jan 2022 17:42:03 +0100
Message-ID: <20220126164203.dnqmd3kfcqbwthiv@pine.grzadka>

--===============1967053823183316344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

iwd on my raspberry pi zero started to crash after upgrade to iwd 1.22:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000211c4 in netdev_connect_event (msg=3D<optimized out>, netdev=3D0x2=
016940) at src/netdev.c:2915
2915  if (is_offload(hs) && handshake_event(hs, HANDSHAKE_EVENT_SETTING_KEY=
S))
(gdb) bt
#0  0x000211c4 in netdev_connect_event (msg=3D<optimized out>, netdev=3D0x2=
016940) at src/netdev.c:2915
#1  0x76f11220 in process_multicast (nlmsg=3D0x7e8acafc, group=3D<optimized=
 out>, genl=3D<optimized out>) at ell/genl.c:1029
#2  received_data (io=3D<optimized out>, user_data=3D<optimized out>) at el=
l/genl.c:1096
#3  0x76f0da08 in io_callback (fd=3D<optimized out>, events=3D1, user_data=
=3D0x200a560) at ell/io.c:120
#4  0x76f0ca78 in l_main_iterate (timeout=3D<optimized out>) at ell/main.c:=
478
#5  0x76f0cb74 in l_main_run () at ell/main.c:525
#6  l_main_run () at ell/main.c:507
#7  0x76f0cdd4 in l_main_run_with_signal (callback=3Dcallback(a)entry=3D0x1=
8c94 <signal_handler>, user_data=3Duser_data(a)entry=3D0x0)
    at ell/main.c:647
#8  0x00018178 in main (argc=3D<optimized out>, argv=3D<optimized out>) at =
src/main.c:532

I suppose hs being NULL is the reason.

Disabling handshake offloading in brcmfmac fixes crash.
--===============1967053823183316344==--

